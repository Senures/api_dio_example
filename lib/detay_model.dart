// To parse this JSON data, do
//
//     final detayModel = detayModelFromJson(jsonString);

import 'dart:convert';

DetayModel detayModelFromJson(String str) => DetayModel.fromJson(json.decode(str));

String detayModelToJson(DetayModel data) => json.encode(data.toJson());

class DetayModel {
    DetayModel({
        required this.id,
        required this.title,
        required this.worth,
        required this.thumbnail,
        required this.description,
        required this.instructions,
        required this.openGiveawayUrl,
        required this.type,
        required this.platforms,
        required this.endDate,
        required this.users,
        required this.status,
        required this.gamerpowerUrl,
    });

    int id;
    String title;
    String worth;
    String thumbnail;
    String description;
    String instructions;
    String openGiveawayUrl;
    String type;
    String platforms;
    String endDate;
    int users;
    String status;
    String gamerpowerUrl;

    factory DetayModel.fromJson(Map<String, dynamic> json) => DetayModel(
        id: json["id"],
        title: json["title"],
        worth: json["worth"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        instructions: json["instructions"],
        openGiveawayUrl: json["open_giveaway_url"],
        type: json["type"],
        platforms: json["platforms"],
        endDate: json["end_date"],
        users: json["users"],
        status: json["status"],
        gamerpowerUrl: json["gamerpower_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "worth": worth,
        "thumbnail": thumbnail,
        "description": description,
        "instructions": instructions,
        "open_giveaway_url": openGiveawayUrl,
        "type": type,
        "platforms": platforms,
        "end_date": endDate,
        "users": users,
        "status": status,
        "gamerpower_url": gamerpowerUrl,
    };
}
