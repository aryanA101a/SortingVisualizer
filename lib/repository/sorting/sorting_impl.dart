import 'dart:async';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:sorting_visualizer/di/locator.dart';
import 'package:sorting_visualizer/pages/home_page.dart';
import 'package:sorting_visualizer/viewmodel/home_page_viewmodel.dart';

class SortingImpl {
  static bubbleSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) async {
    var n = scatterSpots.length;

    for (var i = 0; i < n; i++) {
      for (var j = 0; j < n - i - 1; j++) {
        if (scatterSpots[j].y > scatterSpots[j + 1].y) {
          var temp = scatterSpots[j];
          scatterSpots[j] = scatterSpots[j].copyWith(y: scatterSpots[j + 1].y);
          scatterSpots[j + 1] = scatterSpots[j + 1].copyWith(y: temp.y);

          notifyListnersCallback();
          await Future.delayed(Duration.zero);
        }
      }
    }
    log(scatterSpots.toString());
  }

  static selectionSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) async {
    var n = scatterSpots.length;

    for (var i = 0; i < n - 1; i++) {
      var indexMin = i;
      for (var j = i + 1; j < n; j++) {
        if (scatterSpots[j].y < scatterSpots[indexMin].y) {
          indexMin = j;
        }
        await Future.delayed(Duration.zero);
        notifyListnersCallback();
      }
      if (indexMin != i) {
        var temp = scatterSpots[i];
        scatterSpots[i] = scatterSpots[i].copyWith(y: scatterSpots[indexMin].y);
        scatterSpots[indexMin] = scatterSpots[indexMin].copyWith(y: temp.y);
      }
    }
  }

  static insertionSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) async {
    var n = scatterSpots.length;
    int i, j;
    ScatterSpot temp;

    for (i = 1; i < n; i++) {
      temp = scatterSpots[i];
      j = i - 1;
      while (j >= 0 && temp.y < scatterSpots[j].y) {
        scatterSpots[j + 1] =
            scatterSpots[j + 1].copyWith(y: scatterSpots[j].y);
        --j;
        await Future.delayed(Duration.zero);
        notifyListnersCallback();
      }
      scatterSpots[j + 1] = scatterSpots[j + 1].copyWith(y: temp.y);
    }
  }

  static quickSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) {
    var n = scatterSpots.length;
    _qSort(scatterSpots, 0, scatterSpots.length - 1, notifyListnersCallback);
  }

  static _qSort(
    List<ScatterSpot> list,
    int low,
    int high,
    Function notifyListnersCallback,
  ) async {
    if (low < high) {
      int pi = await _partition(list, low, high, notifyListnersCallback);

      _qSort(list, low, pi - 1, notifyListnersCallback);
      _qSort(list, pi + 1, high, notifyListnersCallback);
    }
  }

  static Future<int> _partition(
    List<ScatterSpot> list,
    low,
    high,
    Function notifyListnersCallback,
  ) async {
    if (list.isEmpty) {
      return 0;
    }

    num pivot = list[high].y;

    int i = low;

    for (int j = low; j < high; j++) {
      if (list[j].y < pivot) {
        _swap(list, i, j);
        await Future.delayed(Duration(milliseconds: 1));
        notifyListnersCallback();
        i++;
      }
    }

    _swap(list, i, high);
    await Future.delayed(Duration(milliseconds: 1));
    notifyListnersCallback();
    return i;
  }

  static void _swap(List<ScatterSpot> list, int i, int j) {
    ScatterSpot temp = list[i];
    list[i] = list[i].copyWith(y: list[j].y);

    list[j] = list[j].copyWith(y: temp.y);
  }

  static mergeSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) {


    // log(scatterSpots.toString());
    // mSort(scatterSpots, 0, scatterSpots.length - 1,notifyListnersCallback);

    // // Future.delayed(Duration(seconds: 2));
    // log(scatterSpots.toString());
    // notifyListnersCallback();
  }
  // static merge(List<ScatterSpot> list, int leftIndex, int middleIndex,
  //     int rightIndex, Function notifyListnersCallback,) {
  //   int leftSize = middleIndex - leftIndex + 1;
  //   int rightSize = rightIndex - middleIndex;

  //   List<ScatterSpot> leftList = [];
  //   List<ScatterSpot> rightList = [];

  //   for (int i = 0; i < leftSize; i++) {
  //     leftList.add(list[leftIndex + i]);
  //   }
  //   for (int j = 0; j < rightSize; j++) {
  //     rightList.add(list[middleIndex + j + 1]);
  //   }

  //   int i = 0, j = 0;
  //   int k = leftIndex;

  //   while (i < leftSize && j < rightSize) {
  //     if (leftList[i].y <= rightList[j].y) {
  //       list[k] = leftList[i].copyWith(x: double.parse(k.toString()));
  //       i++;
  //     } else {
  //       list[k] = rightList[j].copyWith(x: double.parse(k.toString()));
  //       j++;
  //     }
  //     k++;
  //     Timer(Duration(seconds: 1), (() {
  //       notifyListnersCallback();
  //     }));
  //   }
  //   log("while1");
  //   while (i < leftSize) {
  //     list[k] = leftList[i].copyWith(x: double.parse(k.toString()));
  //     i++;
  //     k++;
  //     Timer(Duration(seconds: 1), (() {
  //       notifyListnersCallback();
  //     }));
  //   }
  //   log("while2");

  //   while (j < rightSize) {
  //     list[k] = rightList[j].copyWith(x: double.parse(k.toString()));
  //     j++;
  //     k++;
  //     Timer(Duration(seconds: 1), (() {
  //       notifyListnersCallback();
  //     }));
  //   }
  //   log("while3");
  // }

  // static mSort(List<ScatterSpot> list, int leftIndex, int rightIndex, Function notifyListnersCallback,) {
  //   if (leftIndex < rightIndex) {
  //     int middleIndex = (rightIndex + leftIndex) ~/ 2;

  //     mSort(list, leftIndex, middleIndex,notifyListnersCallback);
  //     mSort(list, middleIndex + 1, rightIndex,notifyListnersCallback);

  //     merge(list, leftIndex, middleIndex, rightIndex,notifyListnersCallback);
  //     log("merge");
  //   }
  // }
}
