// To parse this JSON data, do
//
//     final yorumModel = yorumModelFromJson(jsonString);

import 'dart:convert';

List<YorumModel> yorumModelFromJson(String str) => List<YorumModel>.from(json.decode(str).map((x) => YorumModel.fromJson(x)));

String yorumModelToJson(List<YorumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YorumModel {
    YorumModel({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });

    int postId;
    int id;
    String name;
    String email;
    String body;

    factory YorumModel.fromJson(Map<String, dynamic> json) => YorumModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
