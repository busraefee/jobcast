import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/feature/login/view/login_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late User user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      )),
    );
  }
}
