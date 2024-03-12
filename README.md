# flutter_carousellistview


This Flutter plugin a carousel listview widget with snap scrolling and onChange Callback

## Platform Support

| Android | iOS | MacOS | Web  | Linux | Windows |
|:-------:|:---:|:-----:|:----:|:-----:|:-------:|
|    ✅    |  ✅  |       |      |       |         |

## Usage

You can use the package by importing it and initialize with a list of widget

```dart
import 'package:carousel_listview/carousel_listview.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  /// Track the current index in the carousel_listview 
  int curr = 0;
  /// Onscroll callback
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
                          Text("Widget1"),
                          Text("Widget2"),
                          Text("Widget3"),
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

```