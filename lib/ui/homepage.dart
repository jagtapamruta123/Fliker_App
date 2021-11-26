// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flickr_image/controller/homepage_controller.dart';
import 'package:flickr_image/provider/flicker_provider.dart';
import 'package:flickr_image/ui/componants/cerosal_widget.dart';
import 'package:flickr_image/ui/componants/no_internet_popup.dart';
import 'package:flickr_image/ui/componants/shimmer_view.dart';
import 'package:flickr_image/ui/flickr_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import 'package:flutter_html/flutter_html.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  HomePageController _con = HomePageController();

  _HomePageState() : super(HomePageController()) {
    _con = controller as HomePageController;
  }
  IconData? _selectedIcon;
  @override
  void initState() {
    _con.makeApiRequest(context);
    setState(() {});
    _con.subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _con.connectionStatus = result;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlickrDetailsProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.search,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Flickr",
          style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              letterSpacing: 2),
        ),
      ),
      bottomNavigationBar: NoInternetPopup(con: _con),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: () => _con.refreshIndicator(context),
                    child: _con.data.isEmpty
                        ? ShimmerView()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CarouselSlider.builder(
                                options: CarouselOptions(
                                    height: 200,
                                    enableInfiniteScroll: false,
                                    //does not reverse scroll
                                    enlargeCenterPage: true,
                                    onPageChanged: (val, reason) {
                                      print(val);
                                    },
                                    disableCenter: false,
                                    onScrolled: (val) {
                                      // print(val);
                                      provider.clearData();
                                      setState(() {});
                                    }),
                                itemCount: _con.data.length,

                                //_con.data.length > 10
                                //   ? 10
                                //   : _con.data.length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    CarosaulWidget(
                                  imageUrl:
                                      _con.data[itemIndex].media!.imageUrl,
                                  onTap: () async {
                                    provider.clearData();
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FlickrImageDetails(
                                                data: _con.data[itemIndex]),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ratings :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: provider.getRatings,
                                    // minRating: 0,
                                    glow: true,
                                    ignoreGestures: true,
                                    unratedColor: Colors.amberAccent[50],
                                    direction: Axis.horizontal,
                                    // allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 25.0,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      _selectedIcon ?? Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                    updateOnDrag: false,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                provider.getRatingBy != null &&
                                        provider.getRatingBy != " "
                                    ? "Ratings by : ${provider.getRatingBy}"
                                    : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                ),
                              ),
                              Text(
                                provider.getReason != null &&
                                        provider.getReason != " "
                                    ? "Ratings Reason : ${provider.getReason}"
                                    : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
