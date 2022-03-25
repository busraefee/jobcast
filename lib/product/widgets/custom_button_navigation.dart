import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../feature/addJob/add_job_view.dart';
import '../../feature/favoritePage/favorite_page_view.dart';
import '../../feature/profil/view/edit_profile_view.dart';
import '../../feature/profil/view/profil_view.dart';
import '../../models/usermodel.dart';
import '../../services/cloud_service.dart';
import '../components/app_color.dart';
import '../components/app_string.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  UserModel? _user;
  bool isLoading = false;
  Future<void> getUser() async {
    UserModel user = await FireStoreServisi().getUser(firebaseUser!.uid);
    setState(() {
      _user = user;
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BottomAppBar(
            color: AppColor.orange,
            shape: const CircularNotchedRectangle(),
            child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.grade,
                        size: 30,
                        color: AppColor.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoriteView(),
                            ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_sharp,
                        size: 40,
                        color: AppColor.white,
                      ),
                      onPressed: () {
                        if (_user?.phoneNumber != null &&
                            _user?.phoneNumber != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddJobView(),
                              ));
                        } else {
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: AppString.telefonEkle,
                            desc: AppString.noAllert,
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  AppString.noEkle,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileView(user: _user!),
                                      ));
                                },
                                width: 120,
                              ),
                              DialogButton(
                                color: Colors.red,
                                child: const Text(
                                  AppString.vazgec,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.person,
                        size: 30,
                        color: AppColor.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilView(
                                user: _user!,
                              ),
                            ));
                      },
                    ),
                  ],
                )))
        : const Center(child: CircularProgressIndicator());
  }
}
