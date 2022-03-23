import 'package:flutter/material.dart';
import 'package:jobjob/product/components/app_color.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {Key? key,
      required this.controller,
      required this.inputType,
      required this.name,
      this.obscureText,
      required this.focusnode})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType inputType;
  final String name;
  final bool? obscureText;
  final FocusNode focusnode;

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        labelText: widget.name,
        labelStyle: const TextStyle(color: AppColor.loginText),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: AppColor.loginFormField, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              width: 3,
              color: AppColor.loginFormField,
            )),
      ),
    );
  }
}
