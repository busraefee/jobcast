import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/services/cloud_service.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  bool isLoading = false;
  List<JobsModel> _favList = [];

  Future<void> getFavs() async {
    List<JobsModel> favList = await FireStoreServisi().getFav();
    setState(() {
      _favList = favList;
      //isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoriler"),
      ),
      body: ListView.builder(
        itemCount: _favList.length,
        itemBuilder: (BuildContext context, int index) {
          JobsModel job = _favList[index];
          return Card(
            color: Colors.grey,
            child: ListTile(
              leading: SizedBox(child: Image.network(job.jobImage ?? "")),
              title: Text(job.jobName ?? ""),
              subtitle: Text(job.jobDetail ?? ""),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.star)),
            ),
          );
        },
      ),
    );
  }
}
