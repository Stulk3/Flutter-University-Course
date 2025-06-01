import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  final String name;
  final String photoUrl;
  final String company;
  final String phone;
  final String email;
  final String github;

  CardModel({
    required this.name,
    required this.photoUrl,
    required this.company,
    required this.phone,
    required this.email,
    required this.github,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);
  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}