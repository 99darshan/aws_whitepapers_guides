import 'package:json_annotation/json_annotation.dart';

part 'additionalFields.g.dart';

@JsonSerializable()
class AdditionalFields {
    AdditionalFields();

    String datePublished;
    String publishedText;
    String description;
    String docTitle;
    String sortDate;
    String enableShare;
    String contentType;
    String primaryURL;
    
    factory AdditionalFields.fromJson(Map<String,dynamic> json) => _$AdditionalFieldsFromJson(json);
    Map<String, dynamic> toJson() => _$AdditionalFieldsToJson(this);
}
