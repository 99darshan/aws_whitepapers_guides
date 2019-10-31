// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whitepaper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Whitepaper _$WhitepaperFromJson(Map<String, dynamic> json) {
  return Whitepaper()
    ..createdBy = json['createdBy'] as String
    ..locale = json['locale'] as String
    ..author = json['author'] as String
    ..dateUpdated = json['dateUpdated'] as String
    ..score = json['score'] as num
    ..name = json['name'] as String
    ..numImpressions = json['numImpressions'] as num
    ..dateCreated = json['dateCreated'] as String
    ..additionalFields = json['additionalFields'] == null
        ? null
        : AdditionalFields.fromJson(
            json['additionalFields'] as Map<String, dynamic>)
    ..id = json['id'] as String
    ..directoryId = json['directoryId'] as String
    ..lastUpdatedBy = json['lastUpdatedBy'] as String;
}

Map<String, dynamic> _$WhitepaperToJson(Whitepaper instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'locale': instance.locale,
      'author': instance.author,
      'dateUpdated': instance.dateUpdated,
      'score': instance.score,
      'name': instance.name,
      'numImpressions': instance.numImpressions,
      'dateCreated': instance.dateCreated,
      'additionalFields': instance.additionalFields,
      'id': instance.id,
      'directoryId': instance.directoryId,
      'lastUpdatedBy': instance.lastUpdatedBy
    };
