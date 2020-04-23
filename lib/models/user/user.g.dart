// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    data: json['data'] == null
        ? null
        : UserData.fromJson(json['data'] as Map<String, dynamic>),
    meta: json['meta'] == null
        ? null
        : UserMeta.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'data': instance.data?.toJson(),
      'meta': instance.meta?.toJson(),
    };
