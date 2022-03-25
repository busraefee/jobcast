import 'package:flutter/material.dart';
import 'package:jobjob/product/models/jobmodel.dart';
import '../../product/components/app_color.dart';
import '../../product/components/app_string.dart';
import '../../services/cloud_service.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  bool isLoading = false;
  bool starLight = false;
  List<JobsModel> _favList = [];

  Future<void> getFavList() async {
    List<JobsModel> favList = await FireStoreServisi().getFav();
    setState(() {
      _favList = favList;
      //isLoading = true;
    });
  }

  getFav(JobsModel job) async {
    await FireStoreServisi().addFav(job);
    getFavList();
    //checkFav(job.id ?? "");
  }

  /*checkFav(String jobId) async {
    bool isFav = await FireStoreServisi().checkStar(jobId);
    setState(() {
      starLight = isFav;
    });
    return isFav;
  }*/

  @override
  void initState() {
    super.initState();
    getFavList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        title: const Text(AppString.favoriler),
      ),
      body: RefreshIndicator(
        onRefresh: getFavList,
        child: ListView.builder(
          itemCount: _favList.length,
          itemBuilder: (BuildContext context, int index) {
            JobsModel job = _favList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: SizedBox(child: Image.network(job.jobImage ?? "")),
                  title: Text(job.jobName ?? ""),
                  subtitle: Text(job.jobDetail ?? ""),
                  trailing: IconButton(
                    onPressed: () {
                      getFav(job);
                    },
                    icon: const Icon(Icons.star),
                  ),
                  iconColor: Colors.yellow,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
