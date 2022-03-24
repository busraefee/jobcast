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
                  automaticallyImplyLeading: false,
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

                    return Padding(
                      padding: EdgeInsets.all(8),
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
