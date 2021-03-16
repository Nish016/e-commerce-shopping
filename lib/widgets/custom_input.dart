import 'package:flutter/material.dart';
import 'package:shopping/constants.dart';

class CustomInput extends StatelessWidget {

  final String hintText;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final FocusNode focusNode;
  
  //for next button
  final TextInputAction textInputAction;
  final bool isPasswordField;

  CustomInput({this.hintText,this.onChanged,this.onSubmitted, this.focusNode,this.textInputAction,this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(horizontal : 20.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(18.0)
      ),
      
      child: TextField(
        obscureText: _isPasswordField,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        textInputAction: textInputAction,


        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint Text" ,
          contentPadding: EdgeInsets.symmetric(vertical: 14.0 , horizontal: 14.0)
          ),
          style: Constants.regularDarkText,
      ),
      
    );
  }
}