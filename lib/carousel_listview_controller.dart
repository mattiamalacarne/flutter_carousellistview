import 'package:flutter/material.dart';
import 'package:carousel_listview/carousel_listview_fullwcard.dart';

/// Controlla il carousel_listview, ne gestisce lo scroll e il widget visualizzato
class CarouselListViewController {

  BuildContext? _context;

  /// Index corrente dell'elemento da mostrare
  int currentIndex;
  /// Lock, impedisce lo scorrimento verso il prossimo elemento se gia in corso
  bool _isScrollLocked = false;
  /// Numero di elementi presenti nel carousel
  int numOfChildren;
  /// Abilita lo scorrimento indifinito
  bool infiniteScroll;

  /// Funzione esterna chiamata dopo ogni scorrimento completato
  /// Necessita int come parametro in modo da poter ottenere l'index del widget che verrà mostrato
  final Function(int)? onElementChange;
  /// Durata dell'animazione di scroll
  Duration? scrollDuration;

  final ScrollController scrollController;


  /// Scorri di un elemento nella direzione determinata dallo swipe
  /// Se overflow controlla che sia disponibile lo scroll infinit
  void scrollToIndex(int i)
  {
    if(_isScrollLocked) return;
    if((i < 0 || i >= numOfChildren) && !infiniteScroll) return;

    if(i < 0 && infiniteScroll) {
      i = numOfChildren - 1;
    }
    if(i >= numOfChildren && infiniteScroll) {
      i = 0;
    }

    _isScrollLocked = true;
    final double sWidth = MediaQuery.of(_context!).size.width ?? 0;
    final double offset = i * sWidth;
    currentIndex = i;
    scrollController.animateTo(offset, duration: scrollDuration ?? Duration(milliseconds: 400), curve: Curves.easeInOut);
    _isScrollLocked = false;

    if(onElementChange != null) onElementChange!(i);
  }

  CarouselListViewController(BuildContext context, {
    this.onElementChange,
    required this.scrollController,
    required this.numOfChildren,
    required this.infiniteScroll,
    this.scrollDuration,
    required this.currentIndex
  }) {
    _context = context;
  }

  /// Get all children in formatted specific way
  List<CarouselListViewFullWidthCard> formatWidgets(List<Widget> children) {
    return children.map((e) => CarouselListViewFullWidthCard(child: e)).toList();
  }

  /// On drag action, invia a scroll la direzione in cui scorrere
  void HandleScroll(DragEndDetails d) {
    final double dir = d.primaryVelocity ?? 0;
    if(dir > 0) scrollToIndex(currentIndex - 1);
    else if( dir < 0) scrollToIndex(currentIndex + 1);
  }



}