import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';

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
                      "İlan Detayları",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    job.jobDate != null
                        ? Text("İlan Tarihi: ${job.jobDate}")
                        : Text("İlan Tarihi Girilmedi")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                            "${user.name} ${user.surname}"), //profilden gelicek
                        Text("Fiyat : ${job.cost}"),
                        Text("Cep: ${user.phoneNumber}"), //profilden gelicek
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
