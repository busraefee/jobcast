import 'package:flutter/material.dart';
import '../components/app_color.dart';
import '../../models/usermodel.dart';

import '../../feature/profil/view/edit_profile_view.dart';

class CustomProfileElevatedButton extends StatelessWidget {
  final UserModel user;
  const CustomProfileElevatedButton({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileView(
                user: user,
              ),
            ));
      },
      child: const Text("Profili Düzenle"),
      style: ElevatedButton.styleFrom(
          primary: AppColor.darkgreen,
          maximumSize: MediaQuery.of(context).size * 0.8,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
