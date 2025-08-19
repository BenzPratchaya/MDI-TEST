import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

import 'container_widget.dart';

class ContainerScrollWidget extends StatelessWidget {
  ContainerScrollWidget(
      {super.key,
      // this.tableHorizontalScrollController,
      // this.tableVerticalScrollController,
      required this.child,
      this.background,
      this.borderRadius,
      this.width,
      this.height,
      this.alignment});
  final tableHorizontalScrollController = ScrollController();
  final tableVerticalScrollController = ScrollController();
  final Widget child;
  final Color? background;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Alignment? alignment;
  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      borderRadius: borderRadius,
      background: background,
      child: AdaptiveScrollbar(
        controller: tableHorizontalScrollController,
        width: 15,
        position: ScrollbarPosition.bottom,
        sliderActiveDecoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        sliderDecoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
            controller: tableHorizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                controller: tableVerticalScrollController,
                scrollDirection: Axis.vertical,
                child: Container(
                  child: child,
                ))),
      ),
    );
  }
}
