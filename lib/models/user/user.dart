import 'package:amuse_flutter/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class User extends Equatable {
  final UserData data;
  final UserMeta meta;

  const User({
    this.data,
    this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [];

}
