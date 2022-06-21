import 'dart:async';
import 'dart:developer';
import 'dart:io';

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

          if (!getIt<HomePageViewModel>().isRunning) {
            return;
          }
          notifyListnersCallback();
          sleep(Duration.zero);
          await Future.delayed(Duration.zero);
        }
      }
    }
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

        if (!getIt<HomePageViewModel>().isRunning) {
          return;
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

        if (!getIt<HomePageViewModel>().isRunning) {
          return;
        }
        await Future.delayed(Duration.zero);
        notifyListnersCallback();
      }
      scatterSpots[j + 1] = scatterSpots[j + 1].copyWith(y: temp.y);
    }
  }

  static quickSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) async{
    void swap(List<ScatterSpot> list, int i, int j) {
      ScatterSpot temp = list[i];
      list[i] = list[i].copyWith(y: list[j].y);

      list[j] = list[j].copyWith(y: temp.y);
    }

    Future<int> partition(
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
          swap(list, i, j);

          await Future.delayed(Duration.zero);
          notifyListnersCallback();
          i++;
        }
      }

      swap(list, i, high);
      await Future.delayed(Duration.zero);
      notifyListnersCallback();
      return i;
    }

    qSort(
      List<ScatterSpot> list,
      int low,
      int high,
      Function notifyListnersCallback,
    ) async {
      if (!getIt<HomePageViewModel>().isRunning) {
        return;
      }
      if (low < high) {
        int pi = await partition(list, low, high, notifyListnersCallback);

        await qSort(list, low, pi - 1, notifyListnersCallback);
        await qSort(list, pi + 1, high, notifyListnersCallback);
      }
    }

    var n = scatterSpots.length;
    await qSort(scatterSpots, 0, n - 1, notifyListnersCallback);
  }

  static mergeSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) async{
    merge(
      List<ScatterSpot> list,
      int leftIndex,
      int middleIndex,
      int rightIndex,
      Function notifyListnersCallback,
    ) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List<ScatterSpot> leftList = [];
      List<ScatterSpot> rightList = [];

      for (int i = 0; i < leftSize; i++) {
        leftList.add(list[leftIndex + i]);
      }
      for (int j = 0; j < rightSize; j++) {
        rightList.add(list[middleIndex + j + 1]);
      }

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i].y <= rightList[j].y) {
          list[k] = leftList[i].copyWith(x: double.parse(k.toString()));
          i++;
        } else {
          list[k] = rightList[j].copyWith(x: double.parse(k.toString()));
          j++;
        }
        k++;
        await Future.delayed(Duration.zero, (() {
          notifyListnersCallback();
        }));
      }

      while (i < leftSize) {
        list[k] = leftList[i].copyWith(x: double.parse(k.toString()));
        i++;
        k++;
        await Future.delayed(Duration.zero, (() {
          notifyListnersCallback();
        }));
      }

      while (j < rightSize) {
        list[k] = rightList[j].copyWith(x: double.parse(k.toString()));
        j++;
        k++;
        await Future.delayed(Duration.zero, (() {
          notifyListnersCallback();
        }));
        
      }
    }

    mSort(
      List<ScatterSpot> list,
      int leftIndex,
      int rightIndex,
      Function notifyListnersCallback,
    ) async {
      // if (!getIt<HomePageViewModel>().isRunning) {
      //       return;
      //     }
      if (leftIndex < rightIndex) {
        int middleIndex = (rightIndex + leftIndex) ~/ 2;

        await mSort(list, leftIndex, middleIndex, notifyListnersCallback);
        await mSort(list, middleIndex + 1, rightIndex, notifyListnersCallback);
        if (!getIt<HomePageViewModel>().isRunning) {
          return;
        }
        await merge(
            list, leftIndex, middleIndex, rightIndex, notifyListnersCallback);
      }
    }

    await mSort(scatterSpots, 0, scatterSpots.length - 1, notifyListnersCallback);
  }
}
