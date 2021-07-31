class BusinessCategories {
  static const CustomerEngagement = "Customer Engagement";
  static const EnterpriseApps = "Enterprise Apps";

  static const Map<String, String> mapQueryString = {
    CustomerEngagement: 'cust-engagement',
    EnterpriseApps: 'general-enterprise'
  };

  static List<String> all = mapQueryString.keys.toList();
}
