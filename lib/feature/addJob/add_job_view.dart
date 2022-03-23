import 'package:flutter/material.dart';

import '../../product/widgets/profile_text_form_fiel.dart';

class AddJobView extends StatelessWidget {
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _jobDetailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _jobNameNode = FocusNode();
  final FocusNode _jobDetailNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _districtNode = FocusNode();
  final FocusNode _addressNode = FocusNode();

  AddJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İŞ OLUŞTUR"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 200,
              width: 200,
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.add_circle,size: 30,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  ProfileCustomTextFormField(formFieldController: _jobNameController, hintText: "İş Tanımı", focusNode: _jobNameNode),
                  ProfileCustomTextFormField(formFieldController: _jobDetailController, hintText: "İş Detayı", focusNode: _jobDetailNode),
                  ProfileCustomTextFormField(formFieldController: _cityController, hintText: "İL", focusNode: _cityNode),
                  ProfileCustomTextFormField(formFieldController: _districtController, hintText: "SEMT", focusNode: _districtNode),
                  ProfileCustomTextFormField(formFieldController: _addressController, hintText: "ADRES", focusNode: _addressNode),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Oluştur"),
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
