// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whitepaperData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WhitepaperData _$WhitepaperDataFromJson(Map<String, dynamic> json) {
  return WhitepaperData()
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..item = json['item'] == null
        ? null
        : Whitepaper.fromJson(json['item'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WhitepaperDataToJson(WhitepaperData instance) =>
    <String, dynamic>{'tags': instance.tags, 'item': instance.item};
