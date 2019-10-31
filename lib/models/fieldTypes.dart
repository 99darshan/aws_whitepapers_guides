import 'package:json_annotation/json_annotation.dart';

part 'fieldTypes.g.dart';

@JsonSerializable()
class FieldTypes {
    FieldTypes();

    String datePublished;
    String updateDate;
    String featureFlag;
    String publishedText;
    String description;
    String sortDate;
    String docTitle;
    String enableShare;
    String contentType;
    String primaryURL;
    
    factory FieldTypes.fromJson(Map<String,dynamic> json) => _$FieldTypesFromJson(json);
    Map<String, dynamic> toJson() => _$FieldTypesToJson(this);
}
