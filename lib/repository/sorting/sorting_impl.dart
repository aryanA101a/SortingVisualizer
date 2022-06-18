import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:sorting_visualizer/di/locator.dart';
import 'package:sorting_visualizer/home_page.dart';
import 'package:sorting_visualizer/home_page_viewmodel.dart';

class SortingImpl {
  static bubbleSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) {
    var n = scatterSpots.length;

    var i = 0;
    var j = 0;

    Timer? timer = getIt<HomePageViewModel>().timer;
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    getIt<HomePageViewModel>().setTimer((timer) {
      if (i < n) {
        if (j < n - i - 1) {
          if (scatterSpots[j].y > scatterSpots[j + 1].y) {
            var temp = scatterSpots[j];
            scatterSpots[j] =
                scatterSpots[j].copyWith(y: scatterSpots[j + 1].y);
            scatterSpots[j + 1] = scatterSpots[j + 1].copyWith(y: temp.y);

            notifyListnersCallback();
          }
          j++;
        } else {
          j = 0;
          i++;
        }
      } else {
        timer.cancel();
      }
    });
  }

  static selectionSort(
    List<ScatterSpot> scatterSpots,
    Function notifyListnersCallback,
  ) {
    var n = scatterSpots.length;

    var i = 0;
    var j = i + 1;
    var index_min = i;

    Timer? timer = getIt<HomePageViewModel>().timer;
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    getIt<HomePageViewModel>().setTimer((timer) {
      if (i < n - 1) {
        if (j < n) {
          if (scatterSpots[j].y < scatterSpots[index_min].y) {
            index_min = j;
          }
          j++;
        } else {
          j = i + 1;

          if (index_min != i) {
            var temp = scatterSpots[i];
            scatterSpots[i] =
                scatterSpots[i].copyWith(y: scatterSpots[index_min].y);
            scatterSpots[index_min] =
                scatterSpots[index_min].copyWith(y: temp.y);
                
            notifyListnersCallback();
          }
          i++;
          index_min = i;
        }
      } else {
        timer.cancel();
      }
    });
  }
}
