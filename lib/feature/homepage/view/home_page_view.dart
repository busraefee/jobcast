import 'package:flutter/material.dart';

import '../../../product/widgets/custom_button_navigation.dart';
import '../../../product/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      //floatingActionButton: CustomFloatingActionButton(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text("İŞ BUL"),
          actions: [Padding(padding: EdgeInsets.only(right: 4), child: IconButton(onPressed: () {}, icon: Icon(Icons.reorder)))],
          centerTitle: true,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network("https://picsum.photos/400/200"),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 100,
                child: CustomCard(),
              ),
            );
          }, childCount: 5),
        )
      ]),
    );
  }
}
