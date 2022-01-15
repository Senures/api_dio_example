import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:game_story_dio/detay_model.dart';
import 'package:game_story_dio/model.dart';
import 'package:game_story_dio/randomuser_model.dart';
import 'package:game_story_dio/yorum_model.dart';

class GameListModel{
  Model? gameModel; 
   bool isFavori;
  GameListModel({required this.gameModel,required this.isFavori});
}
class BenzerListeModel{
  Model? benzerModel;
  bool isFavoriMi;
  BenzerListeModel({required this.benzerModel,required this.isFavoriMi});
}

class Service {
  Dio dio = Dio();

  Future<List<Model>?> apiyiGetir() async {
    String url = "https://www.gamerpower.com/api/giveaways";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable gelenveriler = response.data;
      return gelenveriler.map((e) => Model.fromJson(e)).toList();
    }
  }

  Future<List<Model>?> drawerItemGetir(String kelime) async {
    String word = kelime;

    List<String> wordlist = word.split(", ");

    String url =
        "https://www.gamerpower.com/api/giveaways?platform=${wordlist[0].toLowerCase()}";
    print(url);
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable gelenveriler = response.data;
      return gelenveriler.map((e) => Model.fromJson(e)).toList();
    }
  }

  Future<List<Model>?> popupApiGetir(String popups) async {
    String url = "https://www.gamerpower.com/api/giveaways?sort-by=$popups";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable gelenveriler = response.data;
      return gelenveriler.map((e) => Model.fromJson(e)).toList();
    }
  }

  Future<DetayModel?> idApiGetir(String id) async {
    String url = "https://www.gamerpower.com/api/giveaway?id=$id";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return DetayModel.fromJson(response.data);
    }
  }

  Future<List<Model>?> detayListBuilder(String benzerplatform) async {
    String url =
        "https://www.gamerpower.com/api/giveaways?platform=$benzerplatform";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable gelenveriler = response.data;
      return gelenveriler.map((e) => Model.fromJson(e)).toList();
    }
  }

  Future<List<YorumModel>?> yorumlariIndexeGoreGetir(String postid) async {
    String gelenindeks = (int.parse(postid) + 1).toString();

    String url =
        "https://jsonplaceholder.typicode.com/comments?postId=$gelenindeks";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable gelenveriler = response.data;
      print("service yorumlarrrrrrrr" + gelenveriler.toString());
      return gelenveriler.map((e) => YorumModel.fromJson(e)).toList();
    }
  }

  Future<RandomModel?> randomuserGetir(String yorumsayisi) async {
    String url = "https://randomuser.me/api/?results=$yorumsayisi&nat=tr";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      print("serviceeeeeeeeeee" + response.data.toString());
      return RandomModel.fromJson(response.data);
    }
  }
}
