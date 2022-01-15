import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_story_dio/detay_model.dart';
import 'package:game_story_dio/favori.dart';
import 'package:game_story_dio/model.dart';
import 'package:game_story_dio/randomuser_model.dart';
import 'package:game_story_dio/sepet.dart';
import 'package:game_story_dio/service.dart';
import 'package:game_story_dio/yorum_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Detay extends StatefulWidget {
  final int detayId;
  final int index;
 

  Detay({Key? key, required this.detayId, required this.index,})
      : super(key: key);

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  DetayModel? degisken;
  String url = "";
  String platform = "";
  List<Model>? benzerplatform = [];
  bool yukleniyorMu = false;
  List<YorumModel>? yorumliste = [];
  List<Result> userList = [];
  List<DetayModel?> sepetlist = [];
  List<BenzerListeModel> benzerfavorileme = [];

  @override
  void initState() {
    yukleniyorMu = true;
    Service().idApiGetir(widget.detayId.toString()).then((value) {
      setState(() {
        degisken = value;

        Service().drawerItemGetir(degisken!.platforms).then((value) {
          setState(() {
            benzerplatform = value;
            for (int i = 0; i < benzerplatform!.length; i++) {
              benzerfavorileme.add(BenzerListeModel(
                  benzerModel: benzerplatform![i], isFavoriMi: false));
            }
          });
        });
      });
    });

    Service().yorumlariIndexeGoreGetir(widget.index.toString()).then((value) {
      setState(() {
        yorumliste = value;
        Service().randomuserGetir(yorumliste!.length.toString()).then((value) {
          setState(() {
            yukleniyorMu = false;
            userList = value!.results;
          });
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: yukleniyorMu
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  primary: true,
                  child: Column(
                    children: [
                      Arc(
                        height: 40.0,
                        arcType: ArcType.CONVEX,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 280.0,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: NetworkImage(degisken!.thumbnail),
                                  fit: BoxFit.cover)),
                          child: SafeArea(
                            child: Stack(
                              children: [
                                Positioned(
                                    left: 20,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 30.0,
                                          ),
                                        ))),
                                Positioned(
                                    right: 20,
                                    child: IconButton(
                                        onPressed: () async {
                                          String url = degisken!.gamerpowerUrl;
                                          await launch(url);
                                        },
                                        icon: const CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            )))),
                                Positioned(
                                    bottom: 30.0,
                                    right: 20,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 150.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        degisken!.platforms,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          degisken!.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(degisken!.description),
                      ),
                      Text(degisken!.type),
                      Container(
                        width: double.infinity,
                        height: 250.0,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: benzerfavorileme.length,
                            itemBuilder: (context, index) {
                              var item = benzerfavorileme[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  width: 250.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              item.benzerModel!.image),
                                          fit: BoxFit.cover)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          bottom: 40.0,
                                          right: 10.0,
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 80.0,
                                              height: 20.0,
                                              color: Colors.black,
                                              child: item.benzerModel!.worth ==
                                                      "N/A"
                                                  ? Text(
                                                      "\$0.00",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      item.benzerModel!.worth,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 30.0,
                                          color: Colors.black45,
                                          child: Text(
                                            item.benzerModel!.title,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 20.0,
                                          left: 20.0,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            alignment: Alignment.center,
                                            width: 150.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Colors.green),
                                            child: Text(
                                              item.benzerModel!.platforms,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                      Positioned(
                                          top: 10.0,
                                          right: 10.0,
                                          child: Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    
                                                    item.isFavoriMi =
                                                        !item.isFavoriMi;
                                                  });
                                                },
                                                icon: item.isFavoriMi == false
                                                    ? Icon(
                                                        Icons.favorite_border)
                                                    :
                                                     Icon(Icons.favorite)),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: MediaQuery.removePadding(
                          removeTop: true, //toptaki bosluk kaldırır
                          context: context,
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: yorumliste!.length,
                              itemBuilder: (context, index) {
                                var yorum = yorumliste![index];
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            minRadius: 30.0,
                                            child: Container(
                                              width: 80.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          userList[index]
                                                              .picture
                                                              .large))),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(userList[index].name.first +
                                                " " +
                                                userList[index].name.last),
                                            Text("/" +
                                                "(" +
                                                userList[index]
                                                    .dob
                                                    .age
                                                    .toString() +
                                                ")"),
                                            Text("/" +
                                                userList[index].location.city)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        // height: 200.0,
                                        decoration: BoxDecoration(
                                            color:
                                                userList[index].gender == "male"
                                                    ? Colors.blue.shade100
                                                    : Colors.red.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                yorum.body,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Divider(
                                              indent: 10.0,
                                              endIndent: 10.0,
                                              color: Colors.black,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                userList[index].email,
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              degisken!.worth,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                alignment: Alignment.center,
                                width: 250.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        sepetlist.add(degisken);
                                        print("listenin uzunluğu " +
                                            sepetlist.length.toString());
                                      });
                                      print("semanurrrrrrr " +
                                          degisken!.title.toString());
                                    },
                                    child: Text(
                                      "Sepete Ekle",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ))),
                          )
                        ],
                      ),
                    ))
              ],
            ),
    );
  }
}
