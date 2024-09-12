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
    List<dynamic> filteredList = bucketListData
        .where((element) => !(element?["completed"] ?? false))
        .toList();

    return filteredList.isEmpty
        ? const Center(child: Text("No Data On Bucket List"))
        : ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return (bucketListData[index] is Map &&
                      (!(bucketListData[index]?["completed"]) ?? false))
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewItemScreen(
                              index: index,
                              title: bucketListData[index]["item"] ?? "",
                              image: bucketListData[index]["image"] ?? "",
                            );
                          })).then((value) {
                            if (value == "refresh") {
                              getData();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              bucketListData[index]?["image"] ?? ""),
                        ),
                        title: Text(bucketListData[index]?["item"] ?? ""),
                        trailing: Text(
                            bucketListData[index]?["cost"].toString() ?? ""),
                      ),
                    )
                  : const SizedBox();
            });
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(onPressed: () {}, child: const Text("Try Again"))
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
              return AddBucketListScreen(newIndex: bucketListData.length);
            })).then((value) {
              if (value == "refresh") {
                getData();
              }
            });
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
                  : ListDataWidget(),
        ));
  }
}
