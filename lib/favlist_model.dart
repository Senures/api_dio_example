import 'package:game_story_dio/service.dart';
import 'package:hive/hive.dart';

@HiveType(typeId:0)
class FavlistModel extends HiveObject{

@HiveField(0)
GameListModel model;
FavlistModel({required this.model});
}