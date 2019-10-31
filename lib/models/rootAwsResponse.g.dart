// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rootAwsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RootAwsResponse _$RootAwsResponseFromJson(Map<String, dynamic> json) {
  return RootAwsResponse()
    ..metadata = json['metadata'] == null
        ? null
        : Metadata.fromJson(json['metadata'] as Map<String, dynamic>)
    ..fieldTypes = json['fieldTypes'] == null
        ? null
        : FieldTypes.fromJson(json['fieldTypes'] as Map<String, dynamic>)
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : WhitepaperData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RootAwsResponseToJson(RootAwsResponse instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'fieldTypes': instance.fieldTypes,
      'items': instance.items
    };
