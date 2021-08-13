import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_user.g.dart';

@JsonSerializable()
class GoogleUser {
  final String displayName;
  final String email;
  final String photoUrl;
  final String uid;

  GoogleUser(
      {required this.displayName,
      required this.email,
      required this.photoUrl,
      required this.uid});

  factory GoogleUser.fromJson(Map<String, dynamic> json) =>
      _$GoogleUserFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleUserToJson(this);
}
