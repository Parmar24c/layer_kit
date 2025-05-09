//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class FeatureResponse {
  final bool status;
  final String message;
  final List<dynamic>? data;

  FeatureResponse({required this.status, required this.message, required this.data});

  /// THIS IS fromJson METHOD THAT IS ONLY REQUIRED IN RESPONSE
  /// IF YOU WANT TO STORE DATA OFFLINE THAN YOU NEED TO toJson METHOD

  factory FeatureResponse.fromJson(Map<String, dynamic>? json) => FeatureResponse(
        status: json?['status'] ?? false,
        message: json?['message'] ?? "Something went wrong.!",
        data: json?['data'],
      );
}
