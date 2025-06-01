// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      company: json['company'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      github: json['github'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'company': instance.company,
      'phone': instance.phone,
      'email': instance.email,
      'github': instance.github,
    };
