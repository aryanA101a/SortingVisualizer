import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sorting_visualizer/di/locator.dart';
import 'package:sorting_visualizer/home_page.dart';
import 'package:sorting_visualizer/home_page_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageViewModel(),
        )
      ],
      child: MaterialApp(
        home: const HomePage(),
      ),
    );
  }
}
