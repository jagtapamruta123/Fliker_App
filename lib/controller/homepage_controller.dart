import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flickr_image/api/api.dart';
import 'package:flickr_image/model/flicker_model.dart';
import 'package:flickr_image/service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';

class HomePageController extends ControllerMVC {
  factory HomePageController([StateMVC? state]) =>
      _this ??= HomePageController._(state);
  HomePageController._(StateMVC? state) : super(state);
  static HomePageController? _this;

  late StreamSubscription<ConnectivityResult> subscription;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final globalKey = GlobalKey<ScaffoldMessengerState>();

  int page = 1;
  List<FlickrData> data = [];

  makeApiRequest(BuildContext context) async {
    final Data dataItems =
        await DataServices.dataService(context, page.toString());
    setState(() {
      data.addAll(dataItems.flickerList);
    });
  }

  refreshIndicator(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      makeApiRequest(context);
    });
  }
}
