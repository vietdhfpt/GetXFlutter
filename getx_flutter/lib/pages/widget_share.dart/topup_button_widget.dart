import 'package:flutter/material.dart';
import 'package:getx_flutter/constants.dart';

class TopupButtonWidget extends StatelessWidget {
  final title;
  final Function onTap;

  const TopupButtonWidget({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
