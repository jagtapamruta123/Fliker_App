import 'package:flutter/material.dart';

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 200,
      width: MediaQuery.of(context).size.width,
    );
  }
}
