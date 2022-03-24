import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';

class FireStoreServisi {
  final _firestore = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final DateTime time = DateTime.now();

  Future<List<JobsModel>> anasayfaGet() async {
    QuerySnapshot snapshot = await _firestore
        .collection("jobs")
        .orderBy('jobCreateDate', descending: true)
        .get();
    List<JobsModel> jobList =
        snapshot.docs.map((doc) => JobsModel.dokumandanUret(doc)).toList();
    return jobList;
  }

  Future<void> createJob(
      {jobName,
      jobCreator,
      jobDetail,
      city,
      district,
      jobTime,
      address,
      cost,
      jobImage,
      jobDate}) async {
    await _firestore.collection('jobs').add({
      'jobName': jobName,
      'jobDetail': jobDetail,
      'city': city,
      'jobCreator': firebaseUser?.uid,
      'district': district,
      'address': address,
      'cost': cost,
      'jobTime': jobTime,
      'jobImage': jobImage,
      'jobDate': jobDate,
      'jobCreateDate': time,
    });
  }

  Future<UserModel> getUser(String id) async {
    DocumentSnapshot doc = await _firestore.collection("Person").doc(id).get();
    UserModel user = UserModel.dokumandanUret(doc);
    return user;
  }

  /*Future<void> isOlustur2(
      {jobName, jobDetail, city, district, address, cost, jobImage}) async {
    await _firestore.collection('jobs').add({
      'jobName': "Köpek Gezdirmek ",
      'jobDetail': "Köpeğimi gezdirmek için uygun fiyata birini arıyorum",
      'city': "İstanbul",
      'district': "Etiler",
      'address': "Tarabya Villası",
      'cost': cost,
      'jobImage': jobImage,
    });
  }*/
}
