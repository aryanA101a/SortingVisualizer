import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorting_visualizer/viewmodel/home_page_viewmodel.dart';
import 'package:sorting_visualizer/widgets.dart';

import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HomePageViewModel homePageViewModel = context.watch<HomePageViewModel>();
    bool isRunning =
        context.select<HomePageViewModel, bool>((value) => value.isRunning);
    bool isSorted =
        context.select<HomePageViewModel, bool>((value) => value.isSorted);
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 9,
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
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          enlargeCenterPage: true,
                          viewportFraction: .6,
                          onPageChanged: (page, reason) {
                            context
                                .read<HomePageViewModel>()
                                .setCurrenSort(page);
                          }),
                      items: [
                        "BubbleSort",
                        "SelectionSort",
                        "InsertionSort",
                        "QuickSort",
                        "MergeSort"
                      ].map((sort) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: btnColor),
                                child: Text(
                                  sort,
                                  style: TextStyle(
                                      fontSize: 16.0, color: btnTextColor),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    MaterialButton(
                      height: MediaQuery.of(context).size.height * .12,
                      elevation: 0,
                      color: btnColor,
                      onPressed: isSorted
                          ? null
                          : () {
                              isRunning
                                  ? context.read<HomePageViewModel>().stop()
                                  : context.read<HomePageViewModel>().start();
                            },
                      child: Icon(
                        isRunning
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: btnTextColor,
                      ),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      height: MediaQuery.of(context).size.height * .12,
                      elevation: 0,
                      color: btnColor,
                      textColor: btnTextColor,
                      onPressed: context.read<HomePageViewModel>().reset,
                      child: Icon(
                        Icons.replay_rounded,
                        color: btnTextColor,
                      ),
                      shape: CircleBorder(),
                    )
                    // SortButton(
                    //   text: "BubbleSort",
                    //   onPressed: () {
                    //     context.read<HomePageViewModel>().sort(Sorting.bubble);
                    //   },
                    // ),
                    // SortButton(
                    //   text: "SelectionSort",
                    //   onPressed: () {
                    //     context.read<HomePageViewModel>().sort(Sorting.selection);
                    //   },
                    // ),
                    // SortButton(
                    //   text: "InsertionSort",
                    //   onPressed: () {
                    //     context.read<HomePageViewModel>().sort(Sorting.insertion);
                    //   },
                    // ),
                    // SortButton(
                    //   text: "QuickSort",
                    //   onPressed: () {
                    //     context.read<HomePageViewModel>().sort(Sorting.quick);
                    //   },
                    // ),
                    // SortButton(
                    //   text: "MergeSort",
                    //   onPressed: () {
                    //     context.read<HomePageViewModel>().sort(Sorting.merge);
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
