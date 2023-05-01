// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liberate_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiberateUser _$LiberateUserFromJson(Map<String, dynamic> json) => LiberateUser()
  ..email = json['email'] as String
  ..nombre = json['nombre'] as String
  ..uid = json['uid'] as String
  ..creationDate = DateTime.parse(json['creationDate'] as String)
  ..isAdmin = json['isAdmin'] as bool;

Map<String, dynamic> _$LiberateUserToJson(LiberateUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nombre': instance.nombre,
      'uid': instance.uid,
      'creationDate': instance.creationDate.toIso8601String(),
      'isAdmin': instance.isAdmin,
    };
