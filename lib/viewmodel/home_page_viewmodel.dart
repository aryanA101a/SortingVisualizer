import 'dart:async';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:sorting_visualizer/constants.dart';
import 'package:sorting_visualizer/repository/sorting/sorting_impl.dart';

enum Sorting { bubble, selection, insertion, quick, merge }

class HomePageViewModel with ChangeNotifier {
  late List<int> _y;
  late List<int> _x;

  late List<ScatterSpot> _scatterSpots;
  List<ScatterSpot> get scatterSpots => _scatterSpots;

  late Sorting _currentSort;
  setCurrenSort(int sort) {
    _currentSort = Sorting.values[sort];
  }

  late bool _isRunning;
  bool get isRunning => _isRunning;

  late bool _isSorted;
  bool get isSorted => _isSorted;


  start() {
    _isRunning = true;
    notifyListeners();
    log("start");
    sort();
  }

  stop() {
    log("stop");

    _isRunning = false;
    notifyListeners();
  }

  reset() {
    init();
    notifyListeners();
  }

  HomePageViewModel() {
    _currentSort = Sorting.bubble;
    
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

    _isRunning = false;
    _isSorted = false;
  }

  void sort() async {
    log("sort");
    switch (_currentSort) {
      case Sorting.bubble:
        await SortingImpl.bubbleSort(_scatterSpots, notifyListeners);
        break;
      case Sorting.selection:
        await SortingImpl.selectionSort(_scatterSpots, notifyListeners);
        break;
      case Sorting.insertion:
        await SortingImpl.insertionSort(_scatterSpots, notifyListeners);
        break;
      case Sorting.quick:
        await SortingImpl.quickSort(_scatterSpots, notifyListeners);
        break;
      case Sorting.merge:
        await SortingImpl.mergeSort(_scatterSpots, notifyListeners);
        break;
      default:
    }
    if(_isRunning){
      _isSorted = true;
    }
    stop();
  }
}
