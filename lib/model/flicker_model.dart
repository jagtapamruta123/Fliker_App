import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    required this.flickerList,
  });

  List<FlickrData> flickerList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        flickerList: List<FlickrData>.from(
            json["items"].map((x) => FlickrData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(flickerList.map((x) => x.toJson())),
      };
}

class FlickrData {
  FlickrData({
    required this.title,
    required this.description,
    this.ratings,
    this.ratingsProvidedBy,
    this.ratingsReason,
    this.media,
  });

  String title;
  String description;
  double? ratings;
  String? ratingsProvidedBy;
  String? ratingsReason;

  MediaData? media;

  factory FlickrData.fromJson(Map<String, dynamic> json) => FlickrData(
        description: json["description"] == null ? null : json["description"],
        title: json["title"],
        media: MediaData.fromJson(json['media']) == null
            ? null
            : MediaData.fromJson(json['media']),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "formats": media!.toJson(),
        "title": title,
      };
}

class MediaData {
  MediaData({
    required this.imageUrl,
  });

  String imageUrl;

  factory MediaData.fromJson(Map<String, dynamic> json) => MediaData(
        imageUrl: json["m"] == null ? null : json["m"],
      );

  Map<String, dynamic> toJson() => {
        "name": imageUrl,
      };
}
