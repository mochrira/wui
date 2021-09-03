import 'dart:convert';

import 'package:example/models/kontak.dart';
import 'package:example/services/http_service.dart';
import 'package:wui/wui.dart';
import 'package:http/http.dart' as http;

class KontakResult {

  int? count;
  List<Kontak>? data;

  KontakResult({
    this.count,
    this.data
  });

}

class KontakService {

  String _apiURL = WuiConfig.getValue('apiURL');
  HttpService _httpService = HttpService();

  Future<KontakResult> result({Map<String, dynamic>? params}) async {
    http.Response res = await _httpService.get(_apiURL + 'kontak', params: params);
    Map<String, dynamic> resJson = jsonDecode(res.body);
    return KontakResult(
      data: List<Kontak>.from((resJson['data'] ?? []).map((item) => Kontak.fromJson(item))),
      count: resJson['count']
    );
  }

  Future<Kontak> row(int idKontak) async {
    http.Response res = await _httpService.get(_apiURL + 'kontak/' + idKontak.toString());
    return Kontak.fromJson(jsonDecode(res.body));
  }

  Future<int> insert(Kontak kontak) async {
    http.Response res = await _httpService.post(_apiURL + 'kontak', body: kontak.toJson());
    Map<String, dynamic> resJson = jsonDecode(res.body);
    return resJson['idKontak'] as int;
  }

  Future<void> update(int idKontak, Kontak kontak) async {
    await _httpService.patch(_apiURL + 'kontak/' + idKontak.toString(), body: kontak.toJson());
  }

  Future<void> delete(int idKontak) async {
    await _httpService.delete(_apiURL + 'kontak/' + idKontak.toString());
  }

}