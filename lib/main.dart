import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/homepage.dart';
import 'widgets/responsive_layout_wrapper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Burmese Lottery App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: ResponsiveLayoutWrapper(
            maxWidth: 500, // Smaller width for mobile-like experience on web
           // maxHeight: 800,
            child: child!,
          ),
        );
      },
      home: const HomePage(),
    );
  }
}
