import 'package:flutter/material.dart';
import 'package:shopping/constants.dart';
import 'package:shopping/widgets/custom_btn.dart';
import 'package:shopping/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Build an alert dialog to display some error

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text('Close Dialog'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // Create new account

  Future<String> _createNewAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  
  //Submit form

  void _submitForm () async {

  //set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });

  //run the create account method

    String _createAccountFeedback = await _createNewAccount();

  //if string is not null we got error  
    if(_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback); 

  //setting the form to regular state
      setState(() {
      _registerFormLoading = false;
    });
    }else{
      Navigator.pop(context);
    }

  }


  //Default Form Loading State

  bool _registerFormLoading = false;

  //Form input field Values

  String _registerEmail = "";
  String _registerPassword = "";

  //Focus Node for input field

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text('Create New Account',
                    textAlign: TextAlign.center, style: Constants.boldheading),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email...',
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                      hintText: 'Password...',
                      onChanged: (value) {
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value){
                        _submitForm();
                      },
                      ),
                      
                  CustomBtn(
                    text: 'Create Account',
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: 'Back To Login',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
