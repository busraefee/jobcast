import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobjob/product/models/usermodel.dart';
import '../../../product/components/app_color.dart';
import '../../../services/cloud_service.dart';
import '../../../services/storage_service.dart';

import '../../../product/widgets/profile_text_form_fiel.dart';

class EditProfileView extends StatefulWidget {
  final UserModel user;
  const EditProfileView({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  File? file;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _surnameNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.userName!;
    _surnameController.text = widget.user.userSurname!;
    _phoneNumberController.text = widget.user.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        automaticallyImplyLeading: _isLoading,
        title: const Text("Profili Düzenle"),
      ),
      body: _isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    //color: Colors.red,
                    height: 200,
                    width: 200,
                    child: file != null
                        ? Image.file(file!)
                        : Image.network(widget.user.userPhoto != null &&
                                widget.user.userPhoto != ""
                            ? widget.user.userPhoto!
                            : "https://eurorot.com/wp-content/uploads/2020/11/no-imagen.png"),
                  ),
                  IconButton(
                      color: AppColor.darkgreen,
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
                                formFieldController: _nameController,
                                hintText: "İsmi Güncelle",
                                focusNode: _nameNode),
                            ProfileCustomTextFormField(
                                formFieldController: _surnameController,
                                hintText: "E-posta Güncelle",
                                focusNode: _surnameNode),
                            ProfileCustomTextFormField(
                                formFieldController: _phoneNumberController,
                                hintText: "Telefon Numarası Güncelle",
                                focusNode: _phoneNumberNode),
                            ElevatedButton(
                                onPressed: () {
                                  updateProfile();
                                },
                                child: const Text("Kaydet"),
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.darkgreen,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))))
                          ],
                        )),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  fromGalery() async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 800,
            maxHeight: 600,
            imageQuality: 80)
        .then((value) {
      setState(() {
        file = File(value?.path ?? "");
      });
    }).catchError((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Fotoğrafınıza Ulaşamadık.")));
    });
  }

  updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = false;
      });
      String profilePhotoUrl;
      if (file == null) {
        profilePhotoUrl = widget.user.userPhoto ?? "";
      } else {
        profilePhotoUrl = await StorageService().uploadProfileImage(file!);
      }
      FireStoreServisi().updateUser(
        userId: widget.user.id,
        userName: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        userSurname: _surnameController.text,
        userPhoto: profilePhotoUrl == "" || profilePhotoUrl == null
            ? ""
            : profilePhotoUrl,
      );
      setState(() {
        _isLoading = true;
      });
    }
  }
}
