import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/product/components/app_string.dart';
import 'package:jobjob/services/cloud_service.dart';

class DescriptionPageView extends StatefulWidget {
  final JobsModel job;
  DescriptionPageView({Key? key, required this.job}) : super(key: key);

  @override
  State<DescriptionPageView> createState() => _DescriptionPageViewState();
}

class _DescriptionPageViewState extends State<DescriptionPageView> {
  bool isLoading = false;
  UserModel? _user;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> getUser() async {
    UserModel user =
        await FireStoreServisi().getUser(widget.job.jobCreator ?? "");
    setState(() {
      _user = user;
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.job.jobImage ?? "",
                          fit: BoxFit.cover,
                        ),
                        Text(widget.job.jobName ?? "",
                            textAlign: TextAlign.end),
                        Text(widget.job.jobDetail ?? ""),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              AppString.ilanDetaylari,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.job.jobDate != null
                                ? Text(
                                    "${AppString.ilanTarihi} ${widget.job.jobDate}")
                                : Text(AppString.ilanTarihiGirilmedi)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                    "${_user?.userName} ${_user?.userSurname}"), //profilden gelicek
                                Text("${AppString.ucret} ${widget.job.cost}"),
                                Text(
                                    "${AppString.cep} ${_user?.phoneNumber}"), //profilden gelicek
                                Text(widget.job.address ?? ""),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
