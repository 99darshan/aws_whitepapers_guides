class Industries {
  static const aerospace = "Aerospace";
  static const agriculture = "Agriculture";
  static const automotive = "Automotive";
  static const consumerPackagedGoods = "ConsumerPackagedGoods";
  static const defense = "Defense";
  static const education = "Education";
  static const electronics = "Electronics";
  static const financialServices = "Financial Services";
  static const gameTech = "Game Tech";
  static const healthcare = "Healthcare";
  static const hospitality = "Hospitality";
  static const lifeSciences = "Life Sciences";
  static const manufacturing = "Manufacturing";
  static const manufacturingSemiconductors = "Manufacturing (Semiconductors)";
  static const mediaEntertainment = "Media & Entertainment";
  static const powerUtilities = "Power & Utilities";
  static const retailWholesale = "Retail & Wholesale";
  static const telecommunications = "Telecommunications";
  static const transportationLogistics = "Transportation & Logistics";
  static const travel = "Travel";

  static const Map<String, String> mapQueryString = {
    aerospace: 'aerospace',
    agriculture: 'agriculture',
    automotive: 'automotive',
    consumerPackagedGoods: 'cpg',
    defense: 'defense',
    education: 'education',
    electronics: 'electronics',
    financialServices: 'financial-services',
    gameTech: 'gaming',
    healthcare: 'healthcare',
    hospitality: 'hospitality',
    lifeSciences: 'life-sciences',
    manufacturing: 'manufacturing',
    manufacturingSemiconductors: 'semiconductors',
    mediaEntertainment: 'media-entertainment',
    powerUtilities: 'power-utilities',
    retailWholesale: 'retail',
    telecommunications: 'telecommunications',
    transportationLogistics: 'transport-logistics',
    travel: 'travel'
  };

  static List<String> all = mapQueryString.keys.toList();
}
