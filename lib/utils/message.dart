import 'dart:async';

class WuiStreamMessage {

  final String? name;
  final dynamic value;
  WuiStreamMessage({
    this.name,
    this.value
  });

}

class WuiMessage {

  static StreamController<WuiStreamMessage> _streamController = StreamController.broadcast();
  static Stream<WuiStreamMessage> stream(List<String> streamNames) {
    return _streamController.stream.where((msg) => streamNames.contains(msg.name));
  }

  static void broadcast(String name, dynamic value) {
    _streamController.add(WuiStreamMessage(
      name: name,
      value: value
    ));
  }

}