import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
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
    var addFrom = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Bucket List"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: addFrom,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This must not be empty";
                    }
                    return null;
                  },
                  controller: itemText,
                  decoration: const InputDecoration(label: Text("Item")),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This must not be empty";
                    }
                    if (value.toString().length < 3) {
                      return "Must be more than 3 characters";
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: costText,
                  decoration:
                      const InputDecoration(label: Text("Estimated Cost")),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This must not be empty";
                    }
                    if (value.toString().length < 3) {
                      return "Must be more than 3 characters";
                    }
                    return null;
                  },
                  controller: imageUrlText,
                  decoration: const InputDecoration(label: Text("Image Url")),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (addFrom.currentState!.validate()) {
                                addData();
                              }
                            },
                            child: const Text("Add Item"))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
