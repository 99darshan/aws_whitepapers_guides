import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
import "whitepaper.dart";
part 'whitepaperData.g.dart';

@JsonSerializable()
class WhitepaperData {
    WhitepaperData();

    List<Tag> tags;
    Whitepaper item;
    
    factory WhitepaperData.fromJson(Map<String,dynamic> json) => _$WhitepaperDataFromJson(json);
    Map<String, dynamic> toJson() => _$WhitepaperDataToJson(this);
}
