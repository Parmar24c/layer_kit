//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class MovieResponse {
  final bool status;
  final String message;
  final List<dynamic>? data;

  MovieResponse(
      {required this.status, required this.message, required this.data});

  /// THIS IS fromJson METHOD THAT IS ONLY REQUIRED IN RESPONSE
  /// IF YOU WANT TO STORE DATA OFFLINE THAN YOU NEED TO toJson METHOD

  factory MovieResponse.fromJson(Map<String, dynamic>? json) => MovieResponse(
        status: json?['status'] ?? false,
        message: json?['message'] ?? "Something went wrong.!",
        data: json?['data'],
      );
}
