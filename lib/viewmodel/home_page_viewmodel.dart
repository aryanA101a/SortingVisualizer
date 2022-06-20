import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:sorting_visualizer/constants.dart';
import 'package:sorting_visualizer/repository/sorting/sorting_impl.dart';

enum Sorting { bubble, selection, insertion, quick ,merge}

class HomePageViewModel with ChangeNotifier {
  late List<int> _y;
  late List<int> _x;

  late List<ScatterSpot> _scatterSpots;
  List<ScatterSpot> get scatterSpots => _scatterSpots;

  Timer? _timer;
  Timer? get timer => _timer;
  setTimer(void Function(Timer) callback) {
    _timer = Timer.periodic(Duration.zero, (timer) {
      callback(timer);
    });
  }

  HomePageViewModel() {
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
        SortingImpl.bubbleSort(_scatterSpots, notifyListeners);
        break;
      case Sorting.selection:
        SortingImpl.selectionSort(_scatterSpots, notifyListeners);
        break;
      case Sorting.insertion:
        SortingImpl.insertionSort(_scatterSpots, notifyListeners);
        break;
         case Sorting.quick:
        SortingImpl.quickSort(_scatterSpots, notifyListeners);
        break;
        case Sorting.merge:
        SortingImpl.mergeSort(_scatterSpots, notifyListeners);
        break;
      default:
    }
  }
}
