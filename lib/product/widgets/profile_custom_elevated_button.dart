import 'package:flutter/material.dart';

import '../../feature/profil/view/edit_profile_view.dart';

class CustomProfileElevatedButton extends StatelessWidget {
  const CustomProfileElevatedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileView(),
            ));
      },
      child: Text("Profili Düzenle"),
      style: ElevatedButton.styleFrom(
          maximumSize: MediaQuery.of(context).size * 0.8, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
