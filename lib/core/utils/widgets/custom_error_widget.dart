import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomErrorMessage extends StatelessWidget {
  const CustomErrorMessage({super.key, required this.errMessage});
  final String errMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.circleExclamation, size: 40, color: Colors.redAccent),
          SizedBox(height: 12),
          Text(
            errMessage,
            style: Styles.textStyle18,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
