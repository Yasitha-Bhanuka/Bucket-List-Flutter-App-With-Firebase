import 'package:bucketlist/add_bucket_list.dart';
import 'package:bucketlist/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/home": (context) {
            return const MainScreen();
          },
          "/add": (context) {
            return const AddBucketListScreen();
          }
        },
        initialRoute: "/home",
        theme: ThemeData.light(
          useMaterial3: true,
        ));
  }
}
