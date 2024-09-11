import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];

  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Get the data from the API
      Response response = await Dio().get(
          "https://flutterapitesing-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Server Error"),
              content: const Text("An error occurred while fetching data."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bucket List'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getData();
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: bucketListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              bucketListData[index]["image"] ?? ""),
                        ),
                        title: Text(bucketListData[index]["item"] ?? ""),
                        trailing: Text(
                            bucketListData[index]["cost"].toString() ?? ""),
                      ),
                    );
                  }),
        ));
  }
}
