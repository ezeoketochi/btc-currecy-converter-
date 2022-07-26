import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Networking {
  Networking({
    required this.url,
  });

  String url;

  getURL() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      debugPrint("fetch was successful");

      var responseBody = response.body;
      var data = await json.decode(responseBody);

      return data;
    } else {
      debugPrint("call unsuccessful");
    }
  }
}
