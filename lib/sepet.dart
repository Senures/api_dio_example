import 'package:flutter/material.dart';
import 'package:game_story_dio/detay_model.dart';

class Sepet extends StatefulWidget {
  List<DetayModel?> sepetlist = [];
  Sepet({Key? key, required this.sepetlist}) : super(key: key);

  @override
  _SepetState createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sepetim"),
        ),
        body: ListView.builder(
            itemCount: widget.sepetlist.length,
            itemBuilder: (context, index) {
              var item = widget.sepetlist[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 175.0,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    children: [
                      Container(
                        width: 180.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(item!.thumbnail))),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
