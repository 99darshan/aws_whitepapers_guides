// TODO: use constants for filtering api requests
// map the filter chip text to  request url filter text

enum FilterBy { Types, Categories, Industries, Products }

class TypesFilter {
  static const whitepaper = "Whitepaper";
  static const technicalGuide = "Technical Guide";
  static const referenceMaterial = "Reference Material";
  static const architectureDiagram = "Architecture Diagram";

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
  static const couldAdoptationFramework = "Cloud Adoptation Framework";
}

class IndustriesFilter {
  static const financialServices = "Financial Services";
  static const government = "Government";
  static const healthcare = "Healthcare";
  static const lifeSciences = "Life Sciences";
  static const manufacturing = "Manufacturing";
  static const mediaEntertainment = "Media & Entertainment";
  static const telecommunications = "Telecommunications";
  static const travel = "Travel";
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
}
