class WuiConfig {

  // static WuiConfig _instance = WuiConfig._internal();
  // WuiConfig._internal();
  // factory WuiConfig() {
  //   return _instance;
  // }

  static Map<String, dynamic> _config = Map();

  static addValue(String key, dynamic value) {
    _config[key] = value;
  }

  static getValue(String key) {
    return _config[key];
  }

}