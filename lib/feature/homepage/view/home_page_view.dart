import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/product/components/app_color.dart';
import 'package:jobjob/product/components/app_string.dart';
import '../../../models/homemodel.dart';
import '../../../models/usermodel.dart';
import '../../../services/cloud_service.dart';

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

  Future<void> _getJobs() async {
    List<JobsModel> jobList = await FireStoreServisi().anasayfaGet();
    setState(() {
      _jobsList = jobList;
      isLoading = true;
    });
  }

  Future<void> _getJobsFilter() async {
    List<JobsModel> jobList = await FireStoreServisi().anasayfaGet();
    setState(() {
      _jobsList = jobList;
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      //floatingActionButton: CustomFloatingActionButton(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: isLoading
          ? RefreshIndicator(
              onRefresh: _getJobs,
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: const Text(AppString.homeTitle),
                  actions: [
                    Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.reorder)))
                  ],
                  centerTitle: true,
                  pinned: true,
                  expandedHeight: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                        "https://img.freepik.com/free-photo/excited-asian-woman-showing-smartphone-app-triumphing-celebrating-mobile-phone-standing-yellow-background-copy-space_1258-93105.jpg?t=st=1648155565~exp=1648156165~hmac=25592b82ec8cfc719ad833513569c4feef7525d68570425c6dedfe3af8f10d44&w=1380"),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    JobsModel job = _jobsList[index];

                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: SizedBox(
                        height: 120,
                        child: CustomCard(job: job),
                      ),
                    );
                  }, childCount: _jobsList.length),
                )
              ]),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
