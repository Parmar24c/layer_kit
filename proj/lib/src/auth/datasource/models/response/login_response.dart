//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class LoginResponse {
  final bool status;
  final String message;
  final List<dynamic>? data;

  LoginResponse({required this.status, required this.message, required this.data});

  /// THIS IS fromJson METHOD THAT IS ONLY REQUIRED IN RESPONSE
  /// IF YOU WANT TO STORE DATA OFFLINE THAN YOU NEED TO toJson METHOD

  factory LoginResponse.fromJson(Map<String, dynamic>? json) => LoginResponse(
        status: json?['status'] ?? false,
        message: json?['message'] ?? "Something went wrong.!",
        data: json?['data'],
      );
}
