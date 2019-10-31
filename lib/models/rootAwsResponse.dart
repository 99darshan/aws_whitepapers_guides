import 'package:json_annotation/json_annotation.dart';
import "metadata.dart";
import "fieldTypes.dart";
import "whitepaperData.dart";
part 'rootAwsResponse.g.dart';

@JsonSerializable()
class RootAwsResponse {
    RootAwsResponse();

    Metadata metadata;
    FieldTypes fieldTypes;
    List<WhitepaperData> items;
    
    factory RootAwsResponse.fromJson(Map<String,dynamic> json) => _$RootAwsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$RootAwsResponseToJson(this);
}
