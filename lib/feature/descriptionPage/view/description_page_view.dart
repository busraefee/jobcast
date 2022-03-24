import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:jobjob/product/components/app_string.dart';

class DescriptionPageView extends StatelessWidget {
  final JobsModel job;
  final UserModel user;
  DescriptionPageView({Key? key, required this.job, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  job.jobImage ?? "",
                  fit: BoxFit.cover,
                ),
                Text(job.jobName ?? "", textAlign: TextAlign.end),
                Text(job.jobDetail ?? ""),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppString.ilanDetaylari,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    job.jobDate != null
                        ? Text("${AppString.ilanTarihi} ${job.jobDate}")
                        : Text(AppString.ilanTarihiGirilmedi)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                            "${user.name} ${user.surname}"), //profilden gelicek
                        Text("${AppString.ucret} ${job.cost}"),
                        Text(
                            "${AppString.cep} ${user.phoneNumber}"), //profilden gelicek
                        Text(job.address ?? ""),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
