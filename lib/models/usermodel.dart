import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? surname;
  final String? phoneNumber;
  final String? userPhoto;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.userPhoto,
  });

  factory UserModel.dokumandanUret(DocumentSnapshot<dynamic> documentSnapshot) {
    var docData = documentSnapshot.data();
    return UserModel(
      id: documentSnapshot.id,
      name: docData['name'],
      userPhoto: docData['userPhoto'],
      surname: docData['surname'],
      phoneNumber: docData!['phoneNumber'],
    );
  }
}
