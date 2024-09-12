import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  int index;
  ViewItemScreen(
      {super.key,
      required this.index,
      required this.title,
      required this.image});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    // Delete the item from the API
    try {
      // Get the data from the API
      // ignore: unused_local_variable
      Response response = await Dio().delete(
          "https://flutterapitesing-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json");
      Navigator.pop(context, "refresh");
    } catch (e) {
      print(e);
    }
  }

  Future<void> markAsComplete() async {
    // Delete the item from the API
    try {
      Map<String, dynamic> data = {"completed": true};

      // Get the data from the API
      // ignore: unused_local_variable
      Response response = await Dio().patch(
          "https://flutterapitesing-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
          data: data);
      Navigator.pop(context, "refresh");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            PopupMenuButton(
              onSelected: (value) => {
                if (value == 1)
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Alert"),
                            content: const Text("Are you sure to delete?"),
                            actions: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No")),
                              InkWell(
                                  onTap: deleteData, child: const Text("Yes")),
                            ],
                          );
                        })
                  },
                if (value == 2) {markAsComplete()}
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Delete"),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Text("Mark as done"),
                  )
                ];
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.image))),
            ),
          ],
        ));
  }
}
