class TechnologyCategories {
  static const analyticsBigData = "Analytics & Big Data";
  static const applicationIntegration = "Application Integration";
  static const cloudFinancialManagement = "Cloud Financial Management";
  static const compute = "Compute";
  static const containers = "Containers";
  static const databases = "Databases";
  static const developerTools = "Developer Tools";
  static const endUserComputing = "End-User Computing";
  static const fontEndWebAndMobile = "Front-End Web & Mobile";
  static const internetOfThings = "Internet of Things (IOT)";
  static const machineLearningAI = "Machine Learning & AI";
  static const managementGovernance = "Management & Governance";
  static const mediaServices = "Media Services";
  static const migration = "Migration";
  static const networkingContentDelivery = "Networking & Content Delivery";
  static const securityIdentityCompliance = "Security, Identity & Compliance";
  static const spatialComputing = "Spatial Computing";
  static const storage = "Storage";

  static const Map<String, String> mapQueryString = {
    analyticsBigData: 'analytics',
    applicationIntegration: 'app-integration',
    cloudFinancialManagement: 'cost-mgmt',
    compute: 'compute',
    containers: 'containers',
    databases: 'databases',
    developerTools: 'devtools',
    endUserComputing: 'euc',
    internetOfThings: 'iot',
    machineLearningAI: 'ai-ml',
    managementGovernance: 'mgmt-govern',
    mediaServices: 'media-services',
    migration: 'migration',
    networkingContentDelivery: 'network',
    securityIdentityCompliance: 'security-identity-compliance',
    spatialComputing: 'ar-vr',
    storage: 'storage'
  };

  static List<String> all = mapQueryString.keys.toList();
}
