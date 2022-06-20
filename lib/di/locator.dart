import 'package:get_it/get_it.dart';
import 'package:sorting_visualizer/viewmodel/home_page_viewmodel.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HomePageViewModel>(HomePageViewModel());
}
