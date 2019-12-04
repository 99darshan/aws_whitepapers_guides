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

  // TODO: think of a better way ?? will throw exception if split fails,
  // sample example fo description field: Build serverless real-time analytics pipelines for mobile gaming.<p><a href=\"https://d1.awsstatic.com/architecture-diagrams/ArchitectureDiagrams/serverless-analytics-for-mobile-gaming.pdf?did=wp_card&trk=wp_card\" target=\"_blank\">PDF</a></p><p class=\"m-subheadline\">Serverless | Game Tech</p>
  String getDescriptionText() {
    try {
      var doc = htmlParser.parse(this.description);
      //print('desc text: ' + doc.querySelectorAll('p')[0].text);
      print('html parser output: ' + doc.querySelector('a').text);
      print('html parser output: ' + doc.querySelector('a').attributes['href']);

      return this.description.split('<p>')[0];
    } catch (e) {
      return '';
    }
  }
}
