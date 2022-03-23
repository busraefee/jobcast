import 'package:flutter/material.dart';


import '../../feature/descriptionPage/view/description_page_view.dart';
import '../../feature/favoritePage/favorite_page_view.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionPageView(),
            ));
      },
      child: Card(
        child: ListTile(
          leading: SizedBox(child: Image.network("https://picsum.photos/400/300")),
          title: Text("Köpek Gezdirme"),
          subtitle: Text("Golden cinsi köpeğimi gezdirecek birini arıyorum."),
          trailing: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteView(),
                    ));
              },
              icon: Icon(Icons.star)),
        ),
      ),
    );
  }
}
