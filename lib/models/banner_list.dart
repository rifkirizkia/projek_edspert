class BannerList {
  int? status;
  String? message;
  List<Data>? data;

  BannerList({this.status, this.message, this.data});

  BannerList.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.message = json["message"];
    this.data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null)
      data["data"] = this.data?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  String? eventId;
  String? eventTitle;
  String? eventDescription;
  String? eventImage;
  String? eventUrl;

  Data(
      {this.eventId,
      this.eventTitle,
      this.eventDescription,
      this.eventImage,
      this.eventUrl});

  Data.fromJson(Map<String, dynamic> json) {
    this.eventId = json["event_id"];
    this.eventTitle = json["event_title"];
    this.eventDescription = json["event_description"];
    this.eventImage = json["event_image"];
    this.eventUrl = json["event_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["event_id"] = this.eventId;
    data["event_title"] = this.eventTitle;
    data["event_description"] = this.eventDescription;
    data["event_image"] = this.eventImage;
    data["event_url"] = this.eventUrl;
    return data;
  }
}
