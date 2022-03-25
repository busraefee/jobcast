import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobjob/product/models/jobmodel.dart';
import 'package:jobjob/product/models/usermodel.dart';
import '../../../product/components/app_color.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: AppColor.orange),
        body: isLoading
            ? Column(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: context.height * .4,
                    width: context.width * .8,
                    child: Image.network(
                      widget.job.jobImage ?? "",
                    ),
                  ),
                ),
                Padding(
                  padding: context.paddingMedium,
                  child: Column(
                    children: [
                      Text(widget.job.jobName ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end),
                      SizedBox(
                        height: context.lowValue,
                      ),
                      Text(widget.job.jobDetail ?? "",
                          style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                DataTable(
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Text(
                        "İsim: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text("${_user?.userName} ${_user?.userSurname}"),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(
                          Text("Ücret: "),
                        ),
                        DataCell(Text("${widget.job.cost}")),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(
                          Text(AppString.cep),
                        ),
                        DataCell(Text("${_user?.phoneNumber}")),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(
                          Text("Adres: "),
                        ),
                        DataCell(Text("${widget.job.address}")),
                      ],
                    ),
                  ],
                )
              ])
            : const Center(child: CircularProgressIndicator()));
  }
}
