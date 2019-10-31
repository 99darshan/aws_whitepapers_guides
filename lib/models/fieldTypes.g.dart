// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fieldTypes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldTypes _$FieldTypesFromJson(Map<String, dynamic> json) {
  return FieldTypes()
    ..datePublished = json['datePublished'] as String
    ..updateDate = json['updateDate'] as String
    ..featureFlag = json['featureFlag'] as String
    ..publishedText = json['publishedText'] as String
    ..description = json['description'] as String
    ..sortDate = json['sortDate'] as String
    ..docTitle = json['docTitle'] as String
    ..enableShare = json['enableShare'] as String
    ..contentType = json['contentType'] as String
    ..primaryURL = json['primaryURL'] as String;
}

Map<String, dynamic> _$FieldTypesToJson(FieldTypes instance) =>
    <String, dynamic>{
      'datePublished': instance.datePublished,
      'updateDate': instance.updateDate,
      'featureFlag': instance.featureFlag,
      'publishedText': instance.publishedText,
      'description': instance.description,
      'sortDate': instance.sortDate,
      'docTitle': instance.docTitle,
      'enableShare': instance.enableShare,
      'contentType': instance.contentType,
      'primaryURL': instance.primaryURL
    };
