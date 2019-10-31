import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
    Tag();

    String tagNamespaceId;
    String createdBy;
    String name;
    String dateUpdated;
    String locale;
    String lastUpdatedBy;
    String dateCreated;
    String description;
    String id;
    
    factory Tag.fromJson(Map<String,dynamic> json) => _$TagFromJson(json);
    Map<String, dynamic> toJson() => _$TagToJson(this);
}
