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
}
