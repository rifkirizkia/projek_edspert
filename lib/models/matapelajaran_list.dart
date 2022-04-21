class MataPelajaranList {
  int? status;
  String? message;
  List<Data>? data;

  MataPelajaranList({this.status, this.message, this.data});

  MataPelajaranList.fromJson(Map<String, dynamic> json) {
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
  String? courseId;
  String? majorName;
  String? courseCategory;
  String? courseName;
  String? urlCover;
  int? jumlahMateri;
  int? jumlahDone;
  int? progress;

  Data(
      {this.courseId,
      this.majorName,
      this.courseCategory,
      this.courseName,
      this.urlCover,
      this.jumlahMateri,
      this.jumlahDone,
      this.progress});

  Data.fromJson(Map<String, dynamic> json) {
    this.courseId = json["course_id"];
    this.majorName = json["major_name"];
    this.courseCategory = json["course_category"];
    this.courseName = json["course_name"];
    this.urlCover = json["url_cover"];
    this.jumlahMateri = json["jumlah_materi"];
    this.jumlahDone = json["jumlah_done"];
    this.progress = json["progress"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["course_id"] = this.courseId;
    data["major_name"] = this.majorName;
    data["course_category"] = this.courseCategory;
    data["course_name"] = this.courseName;
    data["url_cover"] = this.urlCover;
    data["jumlah_materi"] = this.jumlahMateri;
    data["jumlah_done"] = this.jumlahDone;
    data["progress"] = this.progress;
    return data;
  }
}
