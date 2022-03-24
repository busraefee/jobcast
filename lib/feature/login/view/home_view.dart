import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_view.dart';
import '../../../models/homemodel.dart';
import '../../../services/cloud_service.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late User user;
  bool yukleniyor = false;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: yukleniyor
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('name:${user.displayName}'),
                Text('email:${user.email}'),
                Text('token:${user.uid}'),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      print('${FirebaseAuth.instance.currentUser.toString()}');
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Text('SIGN OUT'))
              ],
            ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
