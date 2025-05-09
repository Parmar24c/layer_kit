//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class MovieReq {
  final String data1;
  final String data2;

  MovieReq({required this.data1, required this.data2});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
        'data1': data1,
        'data2': data2,
      };

  /// CREATE toFormData() METHOD HERE IF YOUR REQUEST CONTAINS FILE
  /// AND IT HAVE TO CONVERT TO MULTIPART FILE TO PASS DATA IN API
  /// FOR THAT HERE IS DEMO
  ///
  //  Future<FormData> toFormData() async {
  //     final imagee = await MultipartFile.fromFile(image?.path ?? "", contentType: MediaType.parse(getMimeType(filePath: image?.path ?? "")));
  //     return FormData.fromMap({
  //       'name': name,
  //       'image': imagee,
  //       'status': status ? 1 : 0,
  //     });
  //   }
}
