import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_user.g.dart';

@JsonSerializable()
class GoogleUser {
  late final String displayName;
  late final String email;
  late final String photoUrl;
  late final String uid;

  GoogleUser(
      {required this.displayName,
      required this.email,
      required this.photoUrl,
      required this.uid});
  // GoogleUser(){
  //   displayName = "";
  //   email = "";
  //   photoUrl = "";
  //   uid = "";
  // }
  factory GoogleUser.init(
          String displayName, String email, String photoUrl, String uid) =>
      GoogleUser(
          displayName: displayName, email: email, photoUrl: photoUrl, uid: uid);

  factory GoogleUser.fromJson(Map<String, dynamic> json) =>
      _$GoogleUserFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleUserToJson(this);
}
