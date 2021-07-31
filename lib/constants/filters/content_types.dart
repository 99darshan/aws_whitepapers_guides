class ContentTypes {
  static const whitepaper = "Whitepaper";
  static const technicalGuide = "Technical Guide";
  static const complianceGuide = "Compliance Guide";
  static const architectureDiagram = "Architecture Diagram";

  static const Map<String, String> mapQueryString = {
    whitepaper: 'whitepaper',
    technicalGuide: 'tech-guide',
    complianceGuide: 'reference-material',
    architectureDiagram: 'reference-arch-diagram'
  };

  static List<String> all = mapQueryString.keys.toList();
}
