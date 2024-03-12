import 'package:flutter/material.dart';


class CarouselListViewFullWidthCard extends StatelessWidget {
  final Color? bg;
  final Widget child;
  CarouselListViewFullWidthCard({super.key, required this.child, this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bg ?? Colors.transparent
      ),
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}
