import 'package:flutter/material.dart';

import '../../../product/widgets/profile_text_form_fiel.dart';

class EditProfileView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordAgainController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _mailNode = FocusNode();

  final FocusNode _addressNode = FocusNode();
  final FocusNode _oldPasswordNode = FocusNode();
  final FocusNode _newPasswordNode = FocusNode();
  final FocusNode _newPasswordAgainNode = FocusNode();

  EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profili Düzenle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  ProfileCustomTextFormField(formFieldController: _nameController, hintText: "İsmi Güncelle", focusNode: _nameNode),
                  ProfileCustomTextFormField(formFieldController: _mailController, hintText: "E-posta Güncelle", focusNode: _mailNode),
                  ProfileCustomTextFormField(formFieldController: _addressController, hintText: "E-posta Güncelle", focusNode: _addressNode),
                  ProfileCustomTextFormField(formFieldController: _oldPasswordController, hintText: "E-posta Güncelle", focusNode: _oldPasswordNode),
                  ProfileCustomTextFormField(formFieldController: _newPasswordController, hintText: "E-posta Güncelle", focusNode: _newPasswordNode),
                  ProfileCustomTextFormField(
                      formFieldController: _newPasswordAgainController, hintText: "E-posta Güncelle", focusNode: _newPasswordAgainNode),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Kaydet"),
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))))
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
