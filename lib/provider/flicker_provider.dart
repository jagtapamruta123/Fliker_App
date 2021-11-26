import 'package:flickr_image/model/flicker_model.dart';
import 'package:flutter/material.dart';

class FlickrDetailsProvider extends ChangeNotifier {
  List<FlickrData> flickerLst = [];
  List<FlickrData> get getFlickerList => this.flickerLst;
  double ratings = 0;
  String? ratingProvider;
  String? ratingReason;
  get getRatings => this.ratings;
  get getRatingBy => this.ratingProvider;
  get getReason => this.ratingReason;
  setRatings(double val, {String? provider, String? reason}) {
    ratings = val;
    ratingProvider = provider;
    ratingReason = reason;
    notifyListeners();
  }

  clearData() {
    ratings = 0;
    ratingProvider = " ";
    ratingReason = " ";
    notifyListeners();
  }
}
