import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Profile{
  const Profile({this.id, required this.name, required this.email,});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  final String? id;
  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}