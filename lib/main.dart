import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/feature/login/view/login_view.dart';
import 'package:jobjob/feature/login/view/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: RegisterView(),
    );
  }
}
