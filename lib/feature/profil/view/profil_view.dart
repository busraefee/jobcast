import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/product/components/app_color.dart';
import '../../login/view/login_view.dart';
import '../../../models/usermodel.dart';
import '../../../services/auth_service.dart';
import '../../../services/cloud_service.dart';

import '../../../product/widgets/profile_custom_elevated_button.dart';

class ProfilView extends StatefulWidget {
  final UserModel user;
  const ProfilView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  //UserModel? _user;
  bool isLoading = false;
  /*Future<void> getUser() async {
    UserModel user = await FireStoreServisi().getUser(firebaseUser!.uid);
    setState(() {
      _user = user;
      isLoading = true;
    });
  }*/

  @override
  void initState() {
    super.initState();
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.orange,
          title: Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  Authentication().signOut().then((value) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginView()));
                  });
                },
                icon: Icon(Icons.outbond))
          ],
        ),
        body: Center(
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
                    backgroundImage: widget.user.userPhoto != null &&
                            widget.user.userPhoto != ""
                        ? NetworkImage("${widget.user.userPhoto}")
                        : NetworkImage(
                            "https://eurorot.com/wp-content/uploads/2020/11/no-imagen.png"),
                    maxRadius: 50,
                  )),
              SizedBox(
                height: 20,
              ),
              CustomProfileElevatedButton(
                user: widget.user,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${widget.user.userName} ${widget.user.userSurname}",
                style: TextStyle(fontSize: 20),
              ),
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
                      elevation: 8,
                      color: AppColor.orange,
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          const Text(
                            "Kuzey Tekinoğlu",
                            style:
                                TextStyle(fontSize: 18, color: AppColor.white),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const Icon(Icons.star),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                          const Text("Kaliteli Bir Köpek gezdiricir kendisi"),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }
}
