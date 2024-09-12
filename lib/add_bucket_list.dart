import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBucketListScreen extends StatefulWidget {
  int newIndex;
  AddBucketListScreen({super.key, required this.newIndex});

  @override
  State<AddBucketListScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<AddBucketListScreen> {
  TextEditingController itemText = TextEditingController();
  TextEditingController costText = TextEditingController();
  TextEditingController imageUrlText = TextEditingController();

  Future<void> addData() async {
    // Delete the item from the API
    try {
      Map<String, dynamic> data = {
        "completed": false,
        "item": itemText.text,
        "cost": costText.text,
        "image": imageUrlText.text
      };

      // Get the data from the API
      // ignore: unused_local_variable
      Response response = await Dio().patch(
          "https://flutterapitesing-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
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
          title: const Text("Add Bucket List"),
        ),
        body: Column(
          children: [
            TextField(
              controller: itemText,
              decoration: InputDecoration(label: Text("Item")),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: costText,
              decoration: InputDecoration(label: Text("Estimated Cost")),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: imageUrlText,
              decoration: InputDecoration(label: Text("Image Url")),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: addData, child: Text("Add Item"))),
              ],
            )
          ],
        ));
  }
}
