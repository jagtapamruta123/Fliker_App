// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flickr_image/api/api.dart';
import 'package:flickr_image/model/flicker_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataServices {
  static Future dataService(BuildContext context, String page) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        var queryparams = {
          'tagmode': 'any',
          'format': 'json',
          'nojsoncallback': 1,
          "tags": 'food'
        };
        String url =
            "https://api.flickr.com/services/feeds/photos_public.gne?tagmode=any&format=json&nojsoncallback=2&tags=food";

        final response = await http.get(
          Uri.parse(url),
        );
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Data jsonResponse = dataFromJson(response.body);

          return jsonResponse;
        } else {
          // return response.body;
        }
      } catch (e) {
        // print(e.toString());
      }
    } else {}
  }
}
