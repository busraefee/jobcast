import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/services/cloud_service.dart';

import '../../../product/widgets/profile_custom_elevated_button.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: const [Icon(Icons.settings)],
        ),
        body: isLoading
            ? Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

                    SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          //child: Image.network(''),
                          backgroundImage: NetworkImage("${_user?.userPhoto}"),
                          maxRadius: 50,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfileElevatedButton(),
                    /*IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle),
                        tooltip: "Fotoğraf Ekle",
                      ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${_user?.name} ${_user?.surname}",
                      style: TextStyle(fontSize: 20),
                    ),
                    //Text("İstanbul/Beykoz/Rüzgarlıbahçe Mah."),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        //primary: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.red,
                            child: Column(
                              children: [
                                Text("Kuzey Tekinoğlu"),
                                Text("Kaliteli Bir Köpek gezdiricir kendisi"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    //Spacer(),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
