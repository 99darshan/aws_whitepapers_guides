class Methodology {
  static const wellArchitectedFramework = "Well-Architected Framework";
  static const cloudAdoptionFramework = "Cloud Adoption Framework";

  static const Map<String, String> mapQueryString = {
    wellArchitectedFramework: 'well-arch-framework',
    cloudAdoptionFramework: 'cloud-adoption-framework'
  };

  static List<String> all = mapQueryString.keys.toList();
}
