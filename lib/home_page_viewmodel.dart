import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:sorting_visualizer/constants.dart';
import 'package:sorting_visualizer/repository/sorting/sorting_impl.dart';

enum Sorting { bubble, selection, insertion, quick }

class HomePageViewModel with ChangeNotifier {
  late List<int> _y;
  late List<int> _x;
  late List<ScatterSpot> _scatterSpots;
  List<ScatterSpot> get scatterSpots => _scatterSpots;

  late SortingImpl _sortingImpl;

  HomePageViewModel() {
    _sortingImpl = SortingImpl();
    init();
  }

  init() {
    _y = List.generate(elements, (index) => index)..shuffle();
    _x = List.generate(elements, (index) => index);

    _scatterSpots = List.generate(
        elements,
        (index) => ScatterSpot(
              double.parse(_x[index].toString()),
              double.parse(_y[index].toString()),
              color: spotColor,
              radius: 3,
            ));
  }

  sort(Sorting sorting) {
    switch (sorting) {
      case Sorting.bubble:
        _sortingImpl.bubbleSort(_scatterSpots, notifyListeners);
        break;
      default:
    }
  }
}
