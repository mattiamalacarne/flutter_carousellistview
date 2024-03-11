import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_listview/carousel_listview.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  int curr = 0;

  void setCurr(int index) {
    setState(() {
      curr = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: CarouselListView(
                        onElementChange: setCurr,
                        infiniteScroll: true,
                        children: [
                          Text("data1"),
                          Text("data2"),
                          Text("data3"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text("Index: $curr")
            ]
          ),
        ),
      ),
    );
  }
}
