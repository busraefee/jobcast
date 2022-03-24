import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/services/cloud_service.dart';

import '../../../product/widgets/custom_button_navigation.dart';
import '../../../product/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<JobsModel> _jobsList = [];
  UserModel? _user;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> getJobs() async {
    List<JobsModel> jobList = await FireStoreServisi().anasayfaGet();
    setState(() {
      _jobsList = jobList;
      //isLoading = true;
    });
  }

  Future<void> getUser() async {
    UserModel user = await FireStoreServisi().getUser(firebaseUser!.uid);
    setState(() {
      _user = user;
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getJobs();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      //floatingActionButton: CustomFloatingActionButton(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: isLoading
          ? CustomScrollView(slivers: [
              SliverAppBar(
                title: const Text("İŞ BUL"),
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.reorder)))
                ],
                centerTitle: true,
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network("https://picsum.photos/400/200"),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  JobsModel job = _jobsList[index];
                  UserModel user = _user!;
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 100,
                      child: CustomCard(job: job, user: user),
                    ),
                  );
                }, childCount: _jobsList.length),
              )
            ])
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
