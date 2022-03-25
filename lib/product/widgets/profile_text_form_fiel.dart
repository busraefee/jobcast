import 'package:flutter/material.dart';
import '../components/app_color.dart';

class ProfileCustomTextFormField extends StatefulWidget {
  final TextEditingController formFieldController;
  final String hintText;
  final FocusNode focusNode;

  const ProfileCustomTextFormField({
    Key? key,
    required this.formFieldController,
    required this.hintText,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<ProfileCustomTextFormField> createState() =>
      _ProfileCustomTextFormFieldState();
}

class _ProfileCustomTextFormFieldState
    extends State<ProfileCustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: widget.formFieldController,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: AppColor.darkgreen,
              ),
            ),
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
          ),
        ));
  }
}
