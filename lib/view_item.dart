import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  ViewItemScreen({super.key, required this.title, required this.image});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
          actions: [
            PopupMenuButton(
              onSelected: (value) => {
                if (value == 1)
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert"),
                            content: Text("Are you sure to delete?"),
                            actions: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No")),
                              Text("Yes"),
                            ],
                          );
                        })
                  }
                else
                  {print(value)}
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Delete"),
                  ),
                  PopupMenuItem(
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
