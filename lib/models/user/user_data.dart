import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class UserData extends Equatable {
  final int id;
  final String name;
  final String avatar;
  final String email;

  const UserData({
    this.id,
    this.name,
    this.avatar,
    this.email,

  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'UserData { id: $id }';
}
