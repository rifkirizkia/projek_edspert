class ResultResponse {
  int? status;
  String? message;
  Data? data;

  ResultResponse({this.status, this.message, this.data});

  ResultResponse.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.message = json["message"];
    this.data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["message"] = this.message;
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  Exercise? exercise;
  Result? result;

  Data({this.exercise, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    this.exercise =
        json["exercise"] == null ? null : Exercise.fromJson(json["exercise"]);
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exercise != null) data["exercise"] = this.exercise?.toJson();
    if (this.result != null) data["result"] = this.result?.toJson();
    return data;
  }
}

class Result {
  String? jumlahBenar;
  String? jumlahSalah;
  String? jumlahTidak;
  String? jumlahScore;

  Result(
      {this.jumlahBenar, this.jumlahSalah, this.jumlahTidak, this.jumlahScore});

  Result.fromJson(Map<String, dynamic> json) {
    this.jumlahBenar = json["jumlah_benar"];
    this.jumlahSalah = json["jumlah_salah"];
    this.jumlahTidak = json["jumlah_tidak"];
    this.jumlahScore = json["jumlah_score"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["jumlah_benar"] = this.jumlahBenar;
    data["jumlah_salah"] = this.jumlahSalah;
    data["jumlah_tidak"] = this.jumlahTidak;
    data["jumlah_score"] = this.jumlahScore;
    return data;
  }
}

class Exercise {
  String? exerciseId;
  String? exerciseCode;
  String? fileCourse;
  String? icon;
  String? exerciseTitle;
  String? exerciseDescription;
  String? exerciseInstruction;
  String? countQuestion;
  String? classFk;
  String? courseFk;
  String? courseContentFk;
  String? subCourseContentFk;
  String? creatorId;
  String? creatorName;
  String? examFrom;
  String? accessType;
  String? exerciseOrder;
  String? exerciseStatus;
  String? dateCreate;
  String? dateUpdate;

  Exercise(
      {this.exerciseId,
      this.exerciseCode,
      this.fileCourse,
      this.icon,
      this.exerciseTitle,
      this.exerciseDescription,
      this.exerciseInstruction,
      this.countQuestion,
      this.classFk,
      this.courseFk,
      this.courseContentFk,
      this.subCourseContentFk,
      this.creatorId,
      this.creatorName,
      this.examFrom,
      this.accessType,
      this.exerciseOrder,
      this.exerciseStatus,
      this.dateCreate,
      this.dateUpdate});

  Exercise.fromJson(Map<String, dynamic> json) {
    this.exerciseId = json["exercise_id"];
    this.exerciseCode = json["exercise_code"];
    this.fileCourse = json["file_course"];
    this.icon = json["icon"];
    this.exerciseTitle = json["exercise_title"];
    this.exerciseDescription = json["exercise_description"];
    this.exerciseInstruction = json["exercise_instruction"];
    this.countQuestion = json["count_question"];
    this.classFk = json["class_fk"];
    this.courseFk = json["course_fk"];
    this.courseContentFk = json["course_content_fk"];
    this.subCourseContentFk = json["sub_course_content_fk"];
    this.creatorId = json["creator_id"];
    this.creatorName = json["creator_name"];
    this.examFrom = json["exam_from"];
    this.accessType = json["access_type"];
    this.exerciseOrder = json["exercise_order"];
    this.exerciseStatus = json["exercise_status"];
    this.dateCreate = json["date_create"];
    this.dateUpdate = json["date_update"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["exercise_id"] = this.exerciseId;
    data["exercise_code"] = this.exerciseCode;
    data["file_course"] = this.fileCourse;
    data["icon"] = this.icon;
    data["exercise_title"] = this.exerciseTitle;
    data["exercise_description"] = this.exerciseDescription;
    data["exercise_instruction"] = this.exerciseInstruction;
    data["count_question"] = this.countQuestion;
    data["class_fk"] = this.classFk;
    data["course_fk"] = this.courseFk;
    data["course_content_fk"] = this.courseContentFk;
    data["sub_course_content_fk"] = this.subCourseContentFk;
    data["creator_id"] = this.creatorId;
    data["creator_name"] = this.creatorName;
    data["exam_from"] = this.examFrom;
    data["access_type"] = this.accessType;
    data["exercise_order"] = this.exerciseOrder;
    data["exercise_status"] = this.exerciseStatus;
    data["date_create"] = this.dateCreate;
    data["date_update"] = this.dateUpdate;
    return data;
  }
}
