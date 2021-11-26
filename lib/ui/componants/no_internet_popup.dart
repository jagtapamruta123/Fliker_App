import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flickr_image/controller/homepage_controller.dart';
import 'package:flutter/material.dart';

class NoInternetPopup extends StatelessWidget {
  const NoInternetPopup({
    Key? key,
    required HomePageController con,
  })  : _con = con,
        super(key: key);

  final HomePageController _con;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _con.connectionStatus == ConnectivityResult.none,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: const Center(
              child: Text(
                "No Internet!",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
