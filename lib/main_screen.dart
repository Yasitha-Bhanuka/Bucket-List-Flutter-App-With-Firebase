import 'package:bucketlist/add_bucket_list.dart';
import 'package:bucketlist/view_item.dart';
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
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Get the data from the API
      Response response = await Dio().get(
          "https://flutterapitesing-default-rtdb.firebaseio.com/bucketlist.json");

      if (response.data is List) {
        bucketListData = response.data;
      } else {
        bucketListData = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  Widget ListDataWidget() {
    return ListView.builder(
        itemCount: bucketListData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: (bucketListData[index] is Map)
                ? ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewItemScreen(
                          title: bucketListData[index]["item"] ?? "",
                          image: bucketListData[index]["image"] ?? "",
                        );
                      }));
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(bucketListData[index]?["image"] ?? ""),
                    ),
                    title: Text(bucketListData[index]?["item"] ?? ""),
                    trailing:
                        Text(bucketListData[index]?["cost"].toString() ?? ""),
                  )
                : SizedBox(),
          );
        });
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(onPressed: () {}, child: Text("Try Again"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddBucketListScreen();
            }));
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Bucket List'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: getData,
                child: const Icon(Icons.refresh),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getData();
          },
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : isError
                  ? errorWidget(errorText: "Error Getting Bucket List Data")
                  : bucketListData.length < 1
                      ? Text("No data in bucket list")
                      : ListDataWidget(),
        ));
  }
}
