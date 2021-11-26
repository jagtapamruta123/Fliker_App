import 'package:flickr_image/provider/flicker_provider.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class FlickrController extends ControllerMVC {
  factory FlickrController([StateMVC? state]) =>
      _this ??= FlickrController._(state);
  FlickrController._(StateMVC? state) : super(state);
  static FlickrController? _this;
  IconData? selectedIcon;
  GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();
  TextEditingController providedBy = TextEditingController();
  TextEditingController reason = TextEditingController();
  double ratings = 0;
  setData(BuildContext context) {
    final provider = Provider.of<FlickrDetailsProvider>(context, listen: false);

    provider.setRatings(ratings,
        provider: providedBy.text, reason: reason.text);
    print("data" + provider.getRatingBy);
  }
}
