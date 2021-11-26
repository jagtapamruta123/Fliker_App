import 'package:flutter/material.dart';

class ReusableButtonWidget extends StatelessWidget {
  final Function()? onTap;
  const ReusableButtonWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue,
        ),
        child: Text('Submit'),
      ),
    );
  }
}
