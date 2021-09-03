import 'package:json_annotation/json_annotation.dart';

part 'kontak.g.dart';

@JsonSerializable(includeIfNull: false)
class Kontak {

  int? idKontak;
  String? nmKontak;
  String? alamat;
  String? kota;

  @JsonKey(fromJson: _nomorFromJson)
  String? nomor;
  static _nomorFromJson(dynamic value) => value.toString();

  Kontak({
    this.idKontak,
    this.nmKontak,
    this.alamat,
    this.kota,
    this.nomor
  });

  static fromJson(Map<String, dynamic> json) => _$KontakFromJson(json);
  toJson() => _$KontakToJson(this);

}