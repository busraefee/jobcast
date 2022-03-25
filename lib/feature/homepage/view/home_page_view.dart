import 'package:flutter/material.dart';
import 'package:jobjob/product/models/jobmodel.dart';
import '../../../product/widgets/custom_button_navigation.dart';
import '../../../product/widgets/custom_card.dart';
import '../../../services/cloud_service.dart';

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

  @override
  void initState() {
    super.initState();
    _getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: isLoading
          ? RefreshIndicator(
              onRefresh: _getJobs,
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.reorder)))
                  ],
                  centerTitle: true,
                  pinned: true,
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                        "https://img.freepik.com/free-photo/excited-asian-woman-showing-smartphone-app-triumphing-celebrating-mobile-phone-standing-yellow-background-copy-space_1258-93105.jpg?t=st=1648155565~exp=1648156165~hmac=25592b82ec8cfc719ad833513569c4feef7525d68570425c6dedfe3af8f10d44&w=1380"),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    JobsModel job = _jobsList[index];

                    return Padding(
                      padding: const EdgeInsets.all(4),
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
