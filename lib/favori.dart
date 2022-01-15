import 'package:flutter/material.dart';
import 'package:game_story_dio/service.dart';

class FavoriSayfasi extends StatefulWidget {
  List<GameListModel> homelist = [];
  List<BenzerListeModel> benzerlistemfav=[];
  List<GameListModel> favorilistem = [];
  FavoriSayfasi({Key? key, required this.homelist,}) : super(key: key);

  @override
  _FavoriSayfasiState createState() => _FavoriSayfasiState();
}

class _FavoriSayfasiState extends State<FavoriSayfasi> {
  @override
  void initState() {
    for (int i = 0; i < widget.homelist.length; i++) {
      if (widget.homelist[i].isFavori == true) {
        widget.favorilistem.add(widget.homelist[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Favorilerim"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.favorilistem.length,
          itemBuilder: (context, index) {
            var item = widget.favorilistem[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 175.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(blurRadius: 5.0)],
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: NetworkImage(item.gameModel!.image),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                alignment: Alignment.center,
                                width: 180.0,
                                height: 40.0,
                                color: Colors.red,
                                child: Text(
                                  item.gameModel!.title,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 120.0,
                            height: 30.0,
                            color: Colors.black,
                            child: Text(
                              item.gameModel!.worth,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, left: 10.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 180.0,
                              height: 40.0,
                              child: Text(
                                "Sepete Ekle",
                                style: TextStyle(color: Colors.red),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                border: Border.all(color: Colors.red),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
