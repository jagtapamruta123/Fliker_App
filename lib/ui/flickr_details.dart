// ignore_for_file: prefer_const_constructors

import 'package:flickr_image/controller/flickr_details_controller.dart';
import 'package:flickr_image/model/flicker_model.dart';
import 'package:flickr_image/provider/flicker_provider.dart';
import 'package:flickr_image/ui/componants/banner_widget.dart';
import 'package:flickr_image/ui/componants/reusable_button_widget.dart';
import 'package:flickr_image/utility/alert_widget.dart';
import 'package:flickr_image/utility/html_parser.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'componants/reusable_textform_widget.dart';

class FlickrImageDetails extends StatefulWidget {
  final FlickrData data;
  const FlickrImageDetails({Key? key, required this.data}) : super(key: key);

  @override
  _FlickrImageDetailsState createState() => _FlickrImageDetailsState();
}

class _FlickrImageDetailsState extends StateMVC<FlickrImageDetails> {
  FlickrController _con = FlickrController();

  _FlickrImageDetailsState() : super(FlickrController()) {
    _con = controller as FlickrController;
  }

  @override
  void initState() {
    _con.providedBy = TextEditingController();
    _con.reason = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _con.providedBy.dispose();
    _con.reason.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlickrDetailsProvider>(context, listen: false);
    return ScaffoldMessenger(
      key: _con.globalKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: const Text(
            "Details",
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 2),
          ),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       (Icons.clear),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                border: new Border.all(
                    color: Colors
                        .transparent), //color is transparent so that it does not blend with the actual color specified

                color: Colors
                    .black, // Specifies the background color and the opacity
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerImageWidget(
                      url: widget.data.media!.imageUrl,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.data.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Utility.parseHtmlString(widget.data.description),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please Enter Review :',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _con.providedBy,
                      hint: 'Review By',
                      onChanged: (val) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      glow: true,
                      unratedColor: Colors.white,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 50.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        _con.selectedIcon ?? Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        provider.setRatings(rating);
                        setState(() {
                          print(rating);
                          _con.ratings = rating;
                        });
                      },
                      updateOnDrag: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _con.reason,
                      hint: 'Review Reason',
                      onChanged: (val) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReusableButtonWidget(
                      onTap: () {
                        print(_con.ratings);
                        print("object");
                        if (_con.ratings == 0) {
                          Alert.showSnackBar(
                              context, "Enter rating", _con.globalKey);
                        } else {
                          print("object");
                          _con.setData(context);
                          Navigator.of(context).pop();
                        }

                        //  if(_con.providedBy.text.isEmpty){

                        //  }else if(_con.reason.text.isEmpty){

                        //  }else if(_con.ratings==0){

                        //  }else {

                        //  }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
