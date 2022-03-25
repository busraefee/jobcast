import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? userName;
  final String? userSurname;
  final String? phoneNumber;
  final String? userPhoto;

  UserModel({
    required this.id,
    required this.userName,
    required this.userSurname,
    required this.phoneNumber,
    required this.userPhoto,
  });

  factory UserModel.dokumandanUret(DocumentSnapshot<dynamic> documentSnapshot) {
    var docData = documentSnapshot.data();
    return UserModel(
      id: documentSnapshot.id,
      userName: docData['userName'],
      userPhoto: docData['userPhoto'],
      userSurname: docData['userSurname'],
      phoneNumber: docData!['phoneNumber'],
    );
  }
}
