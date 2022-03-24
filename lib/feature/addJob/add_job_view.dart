import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/services/cloud_service.dart';
import 'package:jobjob/services/storage_service.dart';

import '../../product/components/app_string.dart';
import '../../product/widgets/profile_text_form_fiel.dart';
import 'package:image_picker/image_picker.dart';

class AddJobView extends StatefulWidget {
  AddJobView({Key? key}) : super(key: key);

  @override
  State<AddJobView> createState() => _AddJobViewState();
}

class _AddJobViewState extends State<AddJobView> {
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _jobDetailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _jobTimeController = TextEditingController();
  TextEditingController _jobImageController = TextEditingController();

  final FocusNode _jobNameNode = FocusNode();
  final FocusNode _jobDetailNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _districtNode = FocusNode();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _costNode = FocusNode();
  final FocusNode _jobTimeNode = FocusNode();
  final FocusNode _jobImageNode = FocusNode();

  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: _isLoading,
          title: Text(AppString.jobAdd),
        ),
        body: _isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //color: Colors.red,
                      height: 200,
                      width: 200,
                      child: file != null
                          ? Image.file(file!)
                          : Image.network("https://picsum.photos/400/300"),
                    ),
                    IconButton(
                        onPressed: () {
                          fromGalery();
                        },
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
                                  hintText: AppString.isTanimi,
                                  focusNode: _jobNameNode),
                              ProfileCustomTextFormField(
                                  formFieldController: _jobDetailController,
                                  hintText: AppString.isDetayi,
                                  focusNode: _jobDetailNode),
                              ProfileCustomTextFormField(
                                  formFieldController: _cityController,
                                  hintText: AppString.il,
                                  focusNode: _cityNode),
                              ProfileCustomTextFormField(
                                  formFieldController: _districtController,
                                  hintText: AppString.semt,
                                  focusNode: _districtNode),
                              ProfileCustomTextFormField(
                                  formFieldController: _addressController,
                                  hintText: AppString.adres,
                                  focusNode: _addressNode),
                              ProfileCustomTextFormField(
                                  formFieldController: _costController,
                                  hintText: AppString.ucret,
                                  focusNode: _costNode),
                              ProfileCustomTextFormField(
                                  formFieldController: _jobTimeController,
                                  hintText: AppString.jobTime,
                                  focusNode: _jobTimeNode),
                              ElevatedButton(
                                  onPressed: () {
                                    _isOlustur();
                                  },
                                  child: const Text(AppString.jobAdd),
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))))
                            ],
                          )),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _isOlustur() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = false;
      });
      file != null
          ? _jobImageController.text =
              await StorageService().uploadJobImage(file!)
          : _jobImageController.text = "";
      await FireStoreServisi()
          .createJob(
        jobName: _jobNameController.text,
        jobDetail: _jobDetailController.text,
        city: _cityController.text,
        district: _districtController.text,
        address: _addressController.text,
        jobTime: _jobTimeController.text,
        cost: _costController.text,
        jobImage: _jobImageController.text,
      )
          .catchError((err) {
        print(err);
      });
    }
    setState(() {
      _isLoading = true;
    });
  }

  fromGalery() async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 800,
            maxHeight: 600,
            imageQuality: 80)
        .then((value) {
      if (mounted) {
        setState(() {
          file = File(value?.path ?? "");
        });
      }
    }).catchError((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Fotoğrafınıza Ulaşamadık.")));
    });
  }
}
