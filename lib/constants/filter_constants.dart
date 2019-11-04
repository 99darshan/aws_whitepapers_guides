// TODO: use constants for filtering api requests
// map the filter chip text to  request url filter text

enum FilterBy { Types, Categories, Industries, Products }

class TypesFilter {
  static const whitepaper = "Whitepaper";
  static const technicalGuide = "Technical Guide";
  static const referenceMaterial = "Reference Material";
  static const architectureDiagram = "Architecture Diagram";

  static const List<String> types = [
    TypesFilter.whitepaper,
    TypesFilter.technicalGuide,
    TypesFilter.referenceMaterial,
    TypesFilter.architectureDiagram
  ];

  static const Map<String, String> mapTypesFilterToQueryString = {
    TypesFilter.whitepaper: 'whitepaper',
    TypesFilter.technicalGuide: 'tech-guide',
    TypesFilter.referenceMaterial: 'reference',
    TypesFilter.architectureDiagram: 'arch-diagram'
  };
}

class CategoriesFilter {
  static const introduction = "Introduction to AWS";
  static const wellArchFramework = "Well-Architected Framework";
  static const cloudAdoptationFramework = "Cloud Adoptation Framework";

  static const List<String> categories = [
    CategoriesFilter.introduction,
    CategoriesFilter.wellArchFramework,
    CategoriesFilter.cloudAdoptationFramework
  ];

  static const Map<String, String> mapCategoriesFilterToQueryString = {
    CategoriesFilter.introduction: '',
    CategoriesFilter.wellArchFramework: '',
    CategoriesFilter.cloudAdoptationFramework: ''
  };
}

class IndustriesFilter {
  static const education = "Education";
  static const financialServices = "Financial Services";
  static const gameTech = "Game Tech";
  static const government = "Government";
  static const healthcare = "Healthcare";
  static const lifeSciences = "Life Sciences";
  static const manufacturing = "Manufacturing";
  static const mediaEntertainment = "Media & Entertainment";
  static const telecommunications = "Telecommunications";
  static const travel = "Travel";

  static const List<String> industries = [
    IndustriesFilter.education,
    IndustriesFilter.financialServices,
    IndustriesFilter.gameTech,
    IndustriesFilter.government,
    IndustriesFilter.healthcare,
    IndustriesFilter.lifeSciences,
    IndustriesFilter.manufacturing,
    IndustriesFilter.mediaEntertainment,
    IndustriesFilter.telecommunications,
    IndustriesFilter.travel
  ];

  static const Map<String, String> mapIndustriesFilterToQueryString = {
    IndustriesFilter.education: 'education',
    IndustriesFilter.financialServices: 'financial-services',
    IndustriesFilter.gameTech: 'gaming',
    IndustriesFilter.government: 'government',
    IndustriesFilter.healthcare: 'healthcare',
    IndustriesFilter.lifeSciences: 'life-sciences',
    IndustriesFilter.manufacturing: 'manufacturing',
    IndustriesFilter.mediaEntertainment: 'media-entertainment',
    IndustriesFilter.telecommunications: 'telecommunications',
    IndustriesFilter.travel: 'travel'
  };
}

class ProductsFilter {
  static const analyticsBigData = "Analytics & Big Data";
  static const applicationIntegration = "Application Integration";
  static const compute = "Compute";
  static const containers = "Containers";
  static const costManagement = "Cost Management";
  static const customerEngagement = "Customer Engagement";
  static const databases = "Databases";
  static const developerTools = "Developer Tools";
  static const endUserComputing = "End-User Computing";
  static const enterpriseApplications = "Enterprise Applications";
  static const internetOfThings = "Internet of Things (IOT)";
  static const machineLearningAI = "Machine Learning & AI";
  static const managementGovernance = "Management & Governance";
  static const mediaServices = "Media Services";
  static const mobile = "Mobile";
  static const networkingContentDelivery = "Networking & Content Delivery";
  static const securityIdentityCompliance = "Security, Identity & Compliance";
  static const serverless = "Serverless";
  static const storage = "Storage";

  static const List<String> products = [
    ProductsFilter.analyticsBigData,
    ProductsFilter.applicationIntegration,
    ProductsFilter.compute,
    ProductsFilter.containers,
    ProductsFilter.costManagement,
    ProductsFilter.customerEngagement,
    ProductsFilter.databases,
    ProductsFilter.developerTools,
    ProductsFilter.endUserComputing,
    ProductsFilter.enterpriseApplications,
    ProductsFilter.internetOfThings,
    ProductsFilter.machineLearningAI,
    ProductsFilter.managementGovernance,
    ProductsFilter.mediaServices,
    ProductsFilter.mobile,
    ProductsFilter.networkingContentDelivery,
    ProductsFilter.securityIdentityCompliance,
    ProductsFilter.serverless,
    ProductsFilter.storage
  ];

  static const Map<String, String> mapProductsFilterToQueryString = {
    ProductsFilter.analyticsBigData: 'analytics',
    ProductsFilter.applicationIntegration: 'app-integration',
    ProductsFilter.compute: 'compute',
    ProductsFilter.containers: 'containers',
    ProductsFilter.costManagement: 'cost-mgmt',
    ProductsFilter.customerEngagement: 'customer-engage',
    ProductsFilter.databases: 'databases',
    ProductsFilter.developerTools: 'devtools',
    ProductsFilter.endUserComputing: 'euc',
    ProductsFilter.enterpriseApplications: 'enterprise-app',
    ProductsFilter.internetOfThings: 'iot',
    ProductsFilter.machineLearningAI: 'ai-ml',
    ProductsFilter.managementGovernance: 'mgmt-govern',
    ProductsFilter.mediaServices: 'media-services',
    ProductsFilter.mobile: 'mobile',
    ProductsFilter.networkingContentDelivery: 'network',
    ProductsFilter.securityIdentityCompliance: 'security-identity-compliance',
    ProductsFilter.serverless: 'serverless',
    ProductsFilter.storage: 'storage'
  };
}
