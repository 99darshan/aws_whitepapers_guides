// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additionalFields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalFields _$AdditionalFieldsFromJson(Map<String, dynamic> json) {
  return AdditionalFields()
    ..featureFlag = json['featureFlag'] as String
    ..datePublished = json['datePublished'] as String
    ..publishedText = json['publishedText'] as String
    ..description = json['description'] as String
    ..docTitle = json['docTitle'] as String
    ..sortDate = json['sortDate'] as String
    ..enableShare = json['enableShare'] as String
    ..contentType = json['contentType'] as String
    ..primaryURL = json['primaryURL'] as String;
}

Map<String, dynamic> _$AdditionalFieldsToJson(AdditionalFields instance) =>
    <String, dynamic>{
      'featureFlag': instance.featureFlag,
      'datePublished': instance.datePublished,
      'publishedText': instance.publishedText,
      'description': instance.description,
      'docTitle': instance.docTitle,
      'sortDate': instance.sortDate,
      'enableShare': instance.enableShare,
      'contentType': instance.contentType,
      'primaryURL': instance.primaryURL
    };
