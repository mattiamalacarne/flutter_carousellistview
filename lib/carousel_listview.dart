library carousel_listview;

import 'package:carousel_listview/carousel_listview_controller.dart';
import 'package:flutter/material.dart';

class CarouselListView extends StatefulWidget {

  /// Funzione esterna chiamata dopo ogni scorrimento completato
  /// Necessita int come parametro in modo da poter ottenere l'index del widget che verrà mostrato
  final Function(int)? onElementChange;
  /// Definisce se una volta raggiunto il massimo o il minimo widget del carousel si deve ricominciare
  final bool infiniteScroll;
  /// Lista di widget da mostrare nel carousel
  final List<Widget> children;
  /// Durata dell'animazione di scroll
  Duration? scrollDuration;
  /// Definisce il comportamento del gesture detector
  HitTestBehavior? hitTestBehavior;
  Axis scrollDirection;

  CarouselListView({
    super.key,
    this.onElementChange,
    this.infiniteScroll = false,
    required this.children,
    this.scrollDuration,
    this.hitTestBehavior,
    this.scrollDirection = Axis.horizontal
  });

  @override
  State<CarouselListView> createState() => _CarouselListViewState();
}

class _CarouselListViewState extends State<CarouselListView> {

  final ScrollController _scrollController = ScrollController();

  bool _infiniteScroll = false;
  List<Widget> _children = [];
  Duration? _scrollDuration;

  int _currentIndex = 0;

  @override
  void initState() {
    _infiniteScroll = widget.infiniteScroll;
    _children = widget.children;
    _scrollDuration = widget.scrollDuration;
    super.initState();
  }

  /// Aggiorna lo stato dell'index corrente e se disponibile invoca il callback
  void _onElementChange(int index) {
    setState(() {
      _currentIndex = index;
    });
    if(widget.onElementChange != null) widget.onElementChange!(index);

  }

  @override
  Widget build(BuildContext context) {

    CarouselListViewController _carouselListViewController = CarouselListViewController(context,
      scrollController: _scrollController,
      infiniteScroll: _infiniteScroll,
      numOfChildren: _children.length,
      onElementChange: _onElementChange,
      scrollDuration: _scrollDuration,
      currentIndex: _currentIndex
    );

    return GestureDetector(
      behavior: widget.hitTestBehavior ?? HitTestBehavior.opaque,
      onHorizontalDragEnd: _carouselListViewController.HandleScroll,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: widget.scrollDirection,
        child: Row(
          children: _carouselListViewController.formatWidgets(_children),
        ),
      ),
    );
  }
}
