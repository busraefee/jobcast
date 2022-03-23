import 'package:flutter/material.dart';

import '../../../product/widgets/profile_custom_elevated_button.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: const [Icon(Icons.settings)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  maxRadius: 50,
                )),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle),
              tooltip: "Fotoğraf Ekle",
            ),
            Text("Furkan Can Altunbaş"),
            Text("İstanbul/Beykoz/Rüzgarlıbahçe Mah."),
            Text("Informationss"),
            Spacer(),
            CustomProfileElevatedButton()
          ],
        ),
      ),
    );
  }
}
