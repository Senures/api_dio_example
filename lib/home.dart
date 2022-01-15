import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:game_story_dio/detay.dart';
import 'package:game_story_dio/detay_model.dart';
import 'package:game_story_dio/favori.dart';
import 'package:game_story_dio/model.dart';
import 'package:game_story_dio/randomuser_model.dart';
import 'package:game_story_dio/sepet.dart';
import 'package:game_story_dio/service.dart';
import 'package:game_story_dio/yorum_model.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int seciliIcon = 0;
  bool yukleniyorMu = false;
  List<Model>? listem = [];
  String kelime = "Game stories";
  String? popup;
  RandomModel? uservalue;
  TextEditingController controller = TextEditingController();
  bool icon = false;
  List<GameListModel> homelist = [];
  List<DetayModel?> sepetlist = [];

  List<String> drawerList = [
    "pc",
    "steam",
    "epic-games-store",
    "ubisoft",
    "ps4",
    "ps5",
    "x-box-one",
    "android",
    "ios",
    "vr",
  ];

  sayfayiAc(int secilen) {
    if (secilen == 0) {
      return anaSayfaYapi();
    }
    if (secilen == 1) {
      return FavoriSayfasi(
       
        homelist: homelist,
      );
    }
    if (secilen == 2) {
      return Sepet(sepetlist: sepetlist);
    }

    if (secilen == 3) {
      return userSayfasi();
    }
  }

  @override
  void initState() {
    setState(() {
      yukleniyorMu = true;
    });
    Service().apiyiGetir().then((value) {
      setState(() {
        yukleniyorMu = false;
        listem = value!;
        for (int i = 0; i < listem!.length; i++) {
          homelist.add(GameListModel(gameModel: listem![i], isFavori: false));
        }
      });
    });
    Service().randomuserGetir(1.toString()).then((value) {
      setState(() {
        uservalue = value;
        yukleniyorMu = false;
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
            : sayfayiAc(seciliIcon),
        bottomNavigationBar: SnakeNavigationBar.color(
          backgroundColor: Colors.red,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          snakeViewColor: Colors.white,
          behaviour: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          showSelectedLabels: true,
          currentIndex: seciliIcon,
          onTap: (value) {
            setState(() {
              seciliIcon = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'microphone'),
          ],
        ));
  }

  userSayfasi() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 280.0,
          decoration: BoxDecoration(
              color: uservalue!.results[0].gender == "female"
                  ? Colors.red.shade900
                  : Colors.blue.shade900),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            maxRadius: 16.0,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 22.0,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              uservalue!.results[0].picture.large))),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20,
          ),
          child: TextFormField(
              enabled: false,
              initialValue: uservalue!.results[0].name.first +
                  " " +
                  uservalue!.results[0].name.last,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text("Username"),
              )),
        ),
        Divider(
          indent: 15.0,
          endIndent: 15.0,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20,
          ),
          child: TextFormField(
              enabled: false,
              initialValue: uservalue!.results[0].email,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text("Email"),
              )),
        ),
        Divider(
          indent: 15.0,
          endIndent: 15.0,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20,
          ),
          child: TextFormField(
              enabled: false,
              initialValue: uservalue!.results[0].phone,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text("Phone"),
              )),
        ),
        Divider(
          indent: 15.0,
          endIndent: 15.0,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20,
          ),
          child: TextFormField(
              enabled: false,
              initialValue: uservalue!.results[0].gender,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text("Gender"),
              )),
        ),
        Divider(
          indent: 15.0,
          endIndent: 15.0,
          color: Colors.grey,
        )
      ],
    );
  }

  anaSayfaYapi() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(kelime + "(" + homelist.length.toString() + ")"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: const Text("Date"),
                        value: 1,
                        onTap: () {
                          popup = "date";
                          Service().popupApiGetir(popup!).then((value) {
                            setState(() {
                              listem = value;
                              kelime = popup!;
                            });
                          });
                        }),
                    PopupMenuItem(
                      child: const Text("Value"),
                      value: 2,
                      onTap: () {
                        popup = "value";
                        Service().popupApiGetir(popup!).then((value) {
                          setState(() {
                            listem = value;
                            kelime = popup!;
                          });
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("Popularity"),
                      value: 3,
                      onTap: () {
                        popup = "popularity";
                        Service().popupApiGetir(popup!).then((value) {
                          setState(() {
                            listem = value;
                            kelime = popup!;
                          });
                        });
                      },
                    )
                  ])
        ],
      ),
      drawer: Drawer(
          child: ListView.builder(
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      setState(() {
                        kelime = drawerList[index];

                        Service().drawerItemGetir(kelime).then((value) {
                          setState(() {
                            listem = value;
                          });
                        });
                      });
                    },
                    title: Text(drawerList[index]));
              })),
      body: ListView.builder(
          itemCount: homelist.length,
          itemBuilder: (context, index) {
            var item = homelist[index];
            // print("kaçıncı indeks" + index.toString());
            print("kaçıncı favori " +
                index.toString() +
                " " +
                item.isFavori.toString());

            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detay(
                              detayId: item.gameModel!.id,
                              index: index,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 250.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.amber,
                      image: DecorationImage(
                          image: NetworkImage(item.gameModel!.image),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 20,
                          right: 10,
                          child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      item.isFavori = !item.isFavori;
                                    });
                                  },
                                  icon: item.isFavori == false
                                      ? Icon(Icons.favorite_border)
                                      : Icon(Icons.favorite)))),
                      Positioned(
                          top: 30.0,
                          left: 20.0,
                          child: Container(
                            alignment: Alignment.center,
                            width: 80.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              item.gameModel!.type,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(color: Colors.black45),
                            child: Text(
                              item.gameModel!.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                          )),
                      /* Positioned(
                        bottom: 40.0,
                        left: 20.0,
                        child: Text(
                          item.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                      ),*/
                      Positioned(
                          top: 65.0,
                          left: 20.0,
                          child: Container(
                            alignment: Alignment.center,
                            width: 200.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              item.gameModel!.platforms,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
