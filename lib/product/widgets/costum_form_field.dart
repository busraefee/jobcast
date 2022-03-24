import 'package:flutter/material.dart';
import 'package:jobjob/product/components/app_color.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {Key? key,
      required this.controller,
      required this.inputType,
      required this.name,
      this.obscureText,
      required this.focusnode,
      this.validator,
      this.suffixIcon,
      this.visible})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType inputType;
  final String name;
  final bool? obscureText;
  final FocusNode focusnode;
  final String? Function(String?)? validator;
  final IconButton? suffixIcon;
  final bool? visible;

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.visible ?? false,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        labelText: widget.name,
        labelStyle: const TextStyle(color: AppColor.loginText),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColor.darkBlue,
              width: 5,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2.5,
              color: AppColor.darkBlue,
            )),
      ),
    );
  }
}
