// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kontak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kontak _$KontakFromJson(Map<String, dynamic> json) {
  return Kontak(
    idKontak: json['idKontak'] as int?,
    nmKontak: json['nmKontak'] as String?,
    alamat: json['alamat'] as String?,
    kota: json['kota'] as String?,
    nomor: Kontak._nomorFromJson(json['nomor']),
  );
}

Map<String, dynamic> _$KontakToJson(Kontak instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('idKontak', instance.idKontak);
  writeNotNull('nmKontak', instance.nmKontak);
  writeNotNull('alamat', instance.alamat);
  writeNotNull('kota', instance.kota);
  writeNotNull('nomor', instance.nomor);
  return val;
}
