import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/product/components/app_color.dart';
import '../../../models/homemodel.dart';
import '../../../models/usermodel.dart';
import '../../../product/components/app_string.dart';
import '../../../services/cloud_service.dart';
import 'package:kartal/kartal.dart';

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
        appBar: AppBar(backgroundColor: AppColor.orange),
        body: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.dynamicHeight(0.4),
                          child: Image.network(
                            widget.job.jobImage ?? "",
                          ),
                        ),
                        Text(widget.job.jobName ?? "",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end),
                        SizedBox(
                          height: context.lowValue,
                        ),
                        Text(widget.job.jobDetail ?? "",
                            style: TextStyle(fontSize: 15)),
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
                        SizedBox(
                          height: context.lowValue * 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${AppString.ucret} ${widget.job.cost}"),
                                Text(
                                  "${_user?.userName} ${_user?.userSurname}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(widget.job.address ?? ""),
                                Text("${AppString.cep} ${_user?.phoneNumber}")
                              ],
                            )
                            //profilden gelicek

                            //profilden gelicek
                            ,
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
