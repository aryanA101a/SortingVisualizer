import 'dart:async';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorting_visualizer/home_page_viewmodel.dart';
import 'package:sorting_visualizer/widgets.dart';

import 'constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HomePageViewModel homePageViewModel = context.watch<HomePageViewModel>();

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Consumer<HomePageViewModel>(
                  builder: (context, value, child) {
                    return SortingScatterChart(
                        scatterSpots: value.scatterSpots);
                  },
                ),
                decoration: BoxDecoration(
                    color: plotBgColor,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SortButton(
                    text: "BubbleSort",
                    onPressed: () {
                      context.read<HomePageViewModel>().sort(Sorting.bubble);
                    },
                  ),
                  SortButton(
                    text: "SelectionSort",
                    onPressed: () {
                      context.read<HomePageViewModel>().sort(Sorting.selection);
                    },
                  ),
                   SortButton(
                    text: "InsertionSort",
                    onPressed: () {
                      context.read<HomePageViewModel>().sort(Sorting.insertion);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
