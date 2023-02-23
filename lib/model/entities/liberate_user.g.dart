// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liberate_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiberateUser _$LiberateUserFromJson(Map<String, dynamic> json) => LiberateUser()
  ..email = json['email'] as String
  ..name = json['name'] as String
  ..uid = json['uid'] as String
  ..creationDate = DateTime.parse(json['creationDate'] as String);

Map<String, dynamic> _$LiberateUserToJson(LiberateUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'uid': instance.uid,
      'creationDate': instance.creationDate.toIso8601String(),
    };
