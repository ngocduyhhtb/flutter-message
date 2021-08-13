// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleUser _$GoogleUserFromJson(Map<String, dynamic> json) => GoogleUser(
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$GoogleUserToJson(GoogleUser instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'uid': instance.uid,
    };
