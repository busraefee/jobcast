import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/feature/profil/view/edit_profile_view.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/services/cloud_service.dart';

import '../../feature/addJob/add_job_view.dart';
import '../../feature/favoritePage/favorite_page_view.dart';
import '../../feature/profil/view/profil_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
    return BottomAppBar(
        color: Colors.yellow,
        shape: const CircularNotchedRectangle(),
        child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.grade,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteView(),
                        ));
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (_user?.phoneNumber != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddJobView(),
                          ));
                    } else {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Telefon Ekle",
                        desc:
                            "İlan oluşturabilmek için telefon numarası ekleyin!",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Numara Ekle",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileView(),
                                  ));
                            },
                            width: 120,
                          ),
                          DialogButton(
                            color: Colors.red,
                            child: const Text(
                              "Vazgeç",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                    Icons.account_circle,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilView(),
                        ));
                  },
                ),
              ],
            )));
  }
}
