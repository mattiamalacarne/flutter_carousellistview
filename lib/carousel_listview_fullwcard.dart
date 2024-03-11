import 'package:flutter/material.dart';


class CarouselListViewFullWidthCard extends StatelessWidget {
  Color? bg;
  Widget child;
  CarouselListViewFullWidthCard({Key? key, required this.child, this.bg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bg ?? Colors.transparent
      ),
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: child,
    );
  }
}
