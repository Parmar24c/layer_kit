//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class FeatureModel {
  final String property1;
  final String property2;
  final String property3;

  const FeatureModel(this.property1, this.property2, this.property3);

  static List<FeatureModel> get listData => [
        FeatureModel("propertya1", "propertya2", "propertya3"),
        FeatureModel("propertyb1", "propertyb2", "propertyb3"),
        FeatureModel("propertyc1", "propertyc2", "propertyc3"),
      ];
}
