import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../helpers/responsive.dart';

class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget(
      {super.key, required this.title, required this.onTap, this.maxWidth});
  final String title;
  final Function() onTap;
  final double? maxWidth;
  @override
  Widget build(BuildContext context) {
    var width = maxWidth ?? EnvisionSize.defaultInputWidth;
    return InkWell(
      onTap: onTap,
      child: Responsive.isDesktop(context)
          ? Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              decoration: BoxDecoration(
                  color: EnvisionColor.secondaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                softWrap: true,
                title,
                style: const TextStyle(
                  fontSize: EnvisionSize.mediumFontSize,
                  // fontWeight: FontWeight.w800,
                  color: EnvisionColor.defaultFontColor,
                ),
              ),
            )
          : Container(
              height: 50,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: EnvisionColor.primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: EnvisionSize.mediumFontSize,
                  // fontWeight: FontWeight.w800,
                  color: EnvisionColor.defaultFontColor,
                ),
              ),
            ),
    );
  }
}
