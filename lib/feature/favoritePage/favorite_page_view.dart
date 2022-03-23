import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoriler"),),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.grey,
            child: ListTile(
              leading: SizedBox(child: Image.network("https://picsum.photos/400/300")),
              title: Text("Köpek Gezdirme"),
              subtitle: Text("Golden cinsi köpeğimi gezdirecek birini arıyorum."),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.star)),
            ),
          );
        },
      ),
    );
  }
}
