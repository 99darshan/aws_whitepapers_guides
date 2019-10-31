// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..tagNamespaceId = json['tagNamespaceId'] as String
    ..createdBy = json['createdBy'] as String
    ..name = json['name'] as String
    ..dateUpdated = json['dateUpdated'] as String
    ..locale = json['locale'] as String
    ..lastUpdatedBy = json['lastUpdatedBy'] as String
    ..dateCreated = json['dateCreated'] as String
    ..description = json['description'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'tagNamespaceId': instance.tagNamespaceId,
      'createdBy': instance.createdBy,
      'name': instance.name,
      'dateUpdated': instance.dateUpdated,
      'locale': instance.locale,
      'lastUpdatedBy': instance.lastUpdatedBy,
      'dateCreated': instance.dateCreated,
      'description': instance.description,
      'id': instance.id
    };
