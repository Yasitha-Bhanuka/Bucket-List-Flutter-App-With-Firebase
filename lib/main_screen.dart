import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> getData() async {
    // Get the data from the API
    Response response = await Dio().get(
        "https://flutterapitesing-default-rtdb.firebaseio.com/bucketlist.json");

    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bucket List'),
        ),
        body: ElevatedButton(onPressed: getData, child: Text("Get Data")));
  }
}
