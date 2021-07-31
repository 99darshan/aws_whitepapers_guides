import 'package:json_annotation/json_annotation.dart';
import 'package:html/parser.dart' as htmlParser;
part 'additionalFields.g.dart';

@JsonSerializable()
class AdditionalFields {
  AdditionalFields();

  String featureFlag;
  String datePublished;
  String publishedText;
  String description;
  String docTitle;
  String sortDate;
  String enableShare;
  String contentType;
  String primaryURL;

  factory AdditionalFields.fromJson(Map<String, dynamic> json) =>
      _$AdditionalFieldsFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalFieldsToJson(this);

  // sample example fo description field: Build serverless real-time analytics pipelines for mobile gaming.<p><a href=\"https://d1.awsstatic.com/architecture-diagrams/ArchitectureDiagrams/serverless-analytics-for-mobile-gaming.pdf?did=wp_card&trk=wp_card\" target=\"_blank\">PDF</a></p><p class=\"m-subheadline\">Serverless | Game Tech</p>
  // This is a hack :( | Think of a better approach of extracting description and tags
  String getDescriptionText() {
    try {
      var doc = htmlParser.parse(this.description);

      if (this.description.startsWith('<p>')) {
        return doc.querySelectorAll('p')[0].text;
      } else {
        return this.description.split('<p>')[0];
      }
    } catch (e) {
      return '';
    }
  }

  List<String> getIndustriesProductsTags() {
    try {
      print('description...' + this.description.toString());
      var doc = htmlParser.parse(this.description);
      print('html parser p tags: ' + doc.querySelectorAll('p')[1].text);

      if (this.description.startsWith('<p>')) {
        return doc.querySelectorAll('p')[2].text.split('|');
      } else {
        return doc.querySelectorAll('p')[1].text.split('|');
      }
    } catch (e) {
      return [];
    }
  }
}
