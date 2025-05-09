//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class StatusMessageResponse {
  final bool status;
  final String message;

  StatusMessageResponse({
    this.status = false,
    this.message = "Error while getting response",
  });

  factory StatusMessageResponse.fromJson(Map<String, dynamic> json) {
    return StatusMessageResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? "Error while getting response",
    );
  }
}
