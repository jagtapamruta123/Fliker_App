import 'package:flutter/material.dart';

class CarosaulWidget extends StatelessWidget {
  final Function()? onTap;
  final String imageUrl;

  const CarosaulWidget({
    required this.onTap,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            imageErrorBuilder: (context, url, error) => new Icon(Icons.error),
            placeholder: AssetImage("assets/spinner.gif"),
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
