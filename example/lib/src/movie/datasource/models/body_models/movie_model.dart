//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class MovieModel {
  final String property1;
  final String property2;
  final String property3;

  const MovieModel(this.property1, this.property2, this.property3);

  static List<MovieModel> get listData => [
        MovieModel("propertya1", "propertya2", "propertya3"),
        MovieModel("propertyb1", "propertyb2", "propertyb3"),
        MovieModel("propertyc1", "propertyc2", "propertyc3"),
      ];
}
