import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Predict {
  
 static Future<String> predictimg(File img) async {
  String url =
      "https://us-central1-dogwood-sprite-375309.cloudfunctions.net/predict";

    var request = http.MultipartRequest('POST', Uri.parse(url))..files.add(await http.MultipartFile.fromPath('file',img.path));

var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    // print(responseData['class']);
    return responseData['class'];
  }
}
