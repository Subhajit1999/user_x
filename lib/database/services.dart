import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_x/database/models.dart';
import 'package:http/http.dart' as http;
import 'package:user_x/utils.dart';

class RemoteServices {

  Future<List<User>> fetchRandomUsers() async {
    var client = http.Client();

    try {
      var response = await client.get(Uri.parse('$BASE_URL?results=$RESULT_COUNT')).catchError(debugPrint);

      debugPrint(response.statusCode.toString());
      if(response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        return List<User>.from(data.map((x) => User.fromJson(x)).toList());
      }else {
        var error = json.decode(response.body);
        debugPrint(error.containsKey('error')? error['error'] : "Unknown Error!");
      }
    }catch(e) {
      debugPrint(e.toString());
    }
    return [];
  }
}