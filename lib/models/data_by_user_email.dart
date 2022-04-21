class DataUserByEmail {
  int? status;
  String? message;
  Data? data;

  DataUserByEmail({this.status, this.message, this.data});

  DataUserByEmail.fromJson(Map<String, dynamic> json) {
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
  String? iduser;
  String? userName;
  String? userEmail;
  String? userWhatsapp;
  String? userFoto;
  String? userPropinsi;
  String? userKabupaten;
  String? sosmed;
  String? userPropSekolah;
  String? userKabSekolah;
  String? userAsalSekolah;
  String? kelas;
  String? uniqcode;
  String? referral;
  String? dateCreate;
  String? jenjang;
  String? userGender;
  String? userPropinsiId;
  String? userPropSekolahId;
  String? userKabSekolahId;
  String? userToken;
  String? verifiedPhone;
  String? userStatus;
  String? appleId;

  Data(
      {this.iduser,
      this.userName,
      this.userEmail,
      this.userWhatsapp,
      this.userFoto,
      this.userPropinsi,
      this.userKabupaten,
      this.sosmed,
      this.userPropSekolah,
      this.userKabSekolah,
      this.userAsalSekolah,
      this.kelas,
      this.uniqcode,
      this.referral,
      this.dateCreate,
      this.jenjang,
      this.userGender,
      this.userPropinsiId,
      this.userPropSekolahId,
      this.userKabSekolahId,
      this.userToken,
      this.verifiedPhone,
      this.userStatus,
      this.appleId});

  Data.fromJson(Map<String, dynamic> json) {
    this.iduser = json["iduser"];
    this.userName = json["user_name"];
    this.userEmail = json["user_email"];
    this.userWhatsapp = json["user_whatsapp"];
    this.userFoto = json["user_foto"];
    this.userPropinsi = json["user_propinsi"];
    this.userKabupaten = json["user_kabupaten"];
    this.sosmed = json["sosmed"];
    this.userPropSekolah = json["user_prop_sekolah"];
    this.userKabSekolah = json["user_kab_sekolah"];
    this.userAsalSekolah = json["user_asal_sekolah"];
    this.kelas = json["kelas"];
    this.uniqcode = json["uniqcode"];
    this.referral = json["referral"];
    this.dateCreate = json["date_create"];
    this.jenjang = json["jenjang"];
    this.userGender = json["user_gender"];
    this.userPropinsiId = json["user_propinsi_id"];
    this.userPropSekolahId = json["user_prop_sekolah_id"];
    this.userKabSekolahId = json["user_kab_sekolah_id"];
    this.userToken = json["user_token"];
    this.verifiedPhone = json["verified_phone"];
    this.userStatus = json["user_status"];
    this.appleId = json["apple_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["iduser"] = this.iduser;
    data["user_name"] = this.userName;
    data["user_email"] = this.userEmail;
    data["user_whatsapp"] = this.userWhatsapp;
    data["user_foto"] = this.userFoto;
    data["user_propinsi"] = this.userPropinsi;
    data["user_kabupaten"] = this.userKabupaten;
    data["sosmed"] = this.sosmed;
    data["user_prop_sekolah"] = this.userPropSekolah;
    data["user_kab_sekolah"] = this.userKabSekolah;
    data["user_asal_sekolah"] = this.userAsalSekolah;
    data["kelas"] = this.kelas;
    data["uniqcode"] = this.uniqcode;
    data["referral"] = this.referral;
    data["date_create"] = this.dateCreate;
    data["jenjang"] = this.jenjang;
    data["user_gender"] = this.userGender;
    data["user_propinsi_id"] = this.userPropinsiId;
    data["user_prop_sekolah_id"] = this.userPropSekolahId;
    data["user_kab_sekolah_id"] = this.userKabSekolahId;
    data["user_token"] = this.userToken;
    data["verified_phone"] = this.verifiedPhone;
    data["user_status"] = this.userStatus;
    data["apple_id"] = this.appleId;
    return data;
  }
}
