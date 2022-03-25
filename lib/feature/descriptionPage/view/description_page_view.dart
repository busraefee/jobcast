import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../product/components/app_color.dart';
import '../../../models/homemodel.dart';
import '../../../models/usermodel.dart';
import '../../../product/components/app_string.dart';
import '../../../services/cloud_service.dart';
import 'package:kartal/kartal.dart';

class DescriptionPageView extends StatefulWidget {
  final JobsModel job;
  const DescriptionPageView({Key? key, required this.job}) : super(key: key);

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
        backgroundColor: AppColor.white,
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
                          Card(
                            elevation: 7,
                            child: Column(
                              children: [
                                Container(
                                    child: Column(
                                      children: [
                                        Text(widget.job.jobName ?? "",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.end),
                                        SizedBox(
                                          height: context.lowValue,
                                        ),
                                        Text(widget.job.jobDetail ?? "",
                                            style:
                                                const TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    color: AppColor.white),
                                const SizedBox(height: 40),
                                Container(
                                  color: AppColor.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        AppString.ilanDetaylari,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      widget.job.jobDate != null
                                          ? Text(
                                              "${AppString.ilanTarihi} ${widget.job.jobDate}")
                                          : const Text(
                                              AppString.ilanTarihiGirilmedi)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: context.lowValue * 2,
                                ),
                                Container(
                                  color: AppColor.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${_user?.userName} ${_user?.userSurname}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${AppString.ucret} ${widget.job.cost}"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: context.lowValue * 2,
                                ),
                                Container(
                                  color: AppColor.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(widget.job.address ?? ""),
                                      Text(
                                          "${AppString.cep} ${_user?.phoneNumber}")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
