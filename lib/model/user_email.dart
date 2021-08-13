import 'package:json_annotation/json_annotation.dart';

part 'user_email.g.dart';

@JsonSerializable()
class UserEmail {
  const UserEmail({required this.email, required this.password});

  final String email;
  final String password;

  factory UserEmail.fromJson(Map<String, dynamic> json) =>
      _$UserEmailFromJson(json);

  Map<String, dynamic> toJson() => _$UserEmailToJson(this);
}
