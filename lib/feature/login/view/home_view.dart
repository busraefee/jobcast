import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.user}) : super(key: key);
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

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginView()));
                    },
                    child: const Text('SIGN OUT'))
              ],
            ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
