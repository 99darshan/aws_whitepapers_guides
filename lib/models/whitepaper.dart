import 'package:json_annotation/json_annotation.dart';
import "additionalFields.dart";
part 'whitepaper.g.dart';

@JsonSerializable()
class Whitepaper {
    Whitepaper();

    String createdBy;
    String locale;
    String author;
    String dateUpdated;
    num score;
    String name;
    num numImpressions;
    String dateCreated;
    AdditionalFields additionalFields;
    String id;
    String directoryId;
    String lastUpdatedBy;
    
    factory Whitepaper.fromJson(Map<String,dynamic> json) => _$WhitepaperFromJson(json);
    Map<String, dynamic> toJson() => _$WhitepaperToJson(this);
}
