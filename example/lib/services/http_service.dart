import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpException {

  String? code;
  String? msg;
  dynamic data;

  HttpException({
    this.code,
    this.msg,
    this.data
  });

  String toString() {
    return msg ?? "";
  }

}

class HttpService {

  static final HttpService _instance = HttpService._internal();
  HttpService._internal();
  factory HttpService() => _instance;

  Uri parseUrl(url, Map<String, dynamic>? params) {
    String paramStr = '';
    if(params != null) {
      paramStr = List<String>.from(params.entries.map((e) => e.key + '=' + e.value.toString())).toList().join('&');
    }
    return Uri.parse(url + (paramStr.length > 0 ? '?' + paramStr : ''));
  }

  Future<http.Response> get(String url, {Map<String, dynamic>? params}) async {
    http.Response res = await http.get(parseUrl(url, params));
    if(res.statusCode >= 400) {
      Map<String, dynamic> data = jsonDecode(res.body);
      throw HttpException(code: data["code"], msg: data["msg"]);
    }
    return res;
  }

  Future<http.Response> post(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    http.Response res = await http.post(parseUrl(url, params), body: jsonEncode(body));
    if(res.statusCode >= 400) {
      Map<String, dynamic> data = jsonDecode(res.body);
      throw HttpException(code: data["code"], msg: data["msg"]);
    }
    return res;
  }

  Future<http.Response> patch(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    http.Response res = await http.patch(parseUrl(url, params), body: jsonEncode(body));
    if(res.statusCode >= 400) {
      Map<String, dynamic> data = jsonDecode(res.body);
      throw HttpException(code: data["code"], msg: data["msg"]);
    }
    return res;
  }

  Future<http.Response> delete(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params}) async {
    http.Response res = await http.delete(parseUrl(url, params), body: jsonEncode(body));
    if(res.statusCode >= 400) {
      Map<String, dynamic> data = jsonDecode(res.body);
      throw HttpException(code: data["code"], msg: data["msg"]);
    }
    return res;
  }

}