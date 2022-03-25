import 'package:cloud_firestore/cloud_firestore.dart';

class JobsModel {
  final String? id;
  final String? jobDetail;
  final String? jobName;
  final String? city;
  final String? jobCreator;
  final String? district;
  final String? address;
  final String? cost;
  final String? jobTime; //işin süresi
  final String? jobImage;
  final String? jobDate; //işin yapılacağı tarih
  final Timestamp? jobCreateDate;

  JobsModel({
    required this.id,
    required this.jobDetail,
    required this.jobName,
    required this.jobTime,
    required this.city,
    required this.jobCreator,
    required this.district,
    required this.address,
    required this.cost,
    required this.jobImage,
    required this.jobDate,
    required this.jobCreateDate,
  });

  factory JobsModel.dokumandanUret(DocumentSnapshot<dynamic> documentSnapshot) {
    var docData = documentSnapshot.data();
    return JobsModel(
      id: documentSnapshot.id,
      jobDetail: docData['jobDetail'],
      jobName: docData['jobName'],
      city: docData['city'],
      jobTime: docData['jobTime'],
      district: docData['district'],
      address: docData['address'],
      cost: docData['cost'],
      jobCreator: docData['jobCreator'],
      jobImage: docData['jobImage'],
      jobDate: docData['jobDate'],
      jobCreateDate: docData['jobCreateDate'],
    );
  }
}
