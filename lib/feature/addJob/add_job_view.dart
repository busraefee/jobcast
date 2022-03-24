import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/services/cloud_service.dart';

import '../../product/widgets/profile_text_form_fiel.dart';

class AddJobView extends StatefulWidget {
  AddJobView({Key? key}) : super(key: key);

  @override
  State<AddJobView> createState() => _AddJobViewState();
}

class _AddJobViewState extends State<AddJobView> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("İŞ OLUŞTUR"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: 200,
                width: 200,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_circle,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ProfileCustomTextFormField(
                            formFieldController: _jobNameController,
                            hintText: "İş Tanımı",
                            focusNode: _jobNameNode),
                        ProfileCustomTextFormField(
                            formFieldController: _jobDetailController,
                            hintText: "İş Detayı",
                            focusNode: _jobDetailNode),
                        ProfileCustomTextFormField(
                            formFieldController: _cityController,
                            hintText: "İL",
                            focusNode: _cityNode),
                        ProfileCustomTextFormField(
                            formFieldController: _districtController,
                            hintText: "SEMT",
                            focusNode: _districtNode),
                        ProfileCustomTextFormField(
                            formFieldController: _addressController,
                            hintText: "ADRES",
                            focusNode: _addressNode),
                        ElevatedButton(
                            onPressed: () {
                              _isOlustur();
                            },
                            child: const Text("Oluştur"),
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))))
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  void _isOlustur() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FireStoreServisi()
          .createJob(
        jobName: _jobNameController.text,
        jobDetail: _jobDetailController.text,
        city: _cityController.text,
        district: _districtController.text,
        address: _addressController.text,
        jobTime: "50",
        cost: "100",
        jobImage:
            "https://petsurfer.com/inc/thumb/phpThumb.php?src=https://petsurfer.com/upload/blog/3b202c4a5e.jpg&w=691&iar=1&q=100&f=jpg",
      )
          .catchError((err) {
        print(err);
      });
    }
  }
}
