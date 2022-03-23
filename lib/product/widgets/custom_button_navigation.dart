import 'package:flutter/material.dart';

import '../../feature/addJob/add_job_view.dart';
import '../../feature/favoritePage/favorite_page_view.dart';
import '../../feature/profil/view/profil_view.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddJobView(),
                        ));
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
                          builder: (context) => ProfilView(),
                        ));
                  },
                ),
              ],
            )));
  }
}
