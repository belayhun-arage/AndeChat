import 'dart:convert';

import 'package:ChatUI/libs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  static WebSocketChannel _channel;
  static WebSocketService _service;
  static const String WSHOST = 'ws://10.0.3.2:8080/chat/';
  static OnlineFriends onlineBloc;

  WebSocketService();
  get channel {
    return _channel;
  }

  static WebSocketService getInstance() {
    onlineBloc = OnlineFriends.instance;
    if (_channel == null) {
      _channel = new IOWebSocketChannel.connect(WSHOST);
      _channel.stream.listen((event) {});
    }
    if (_service == null) {
      _service = WebSocketService();
    }
    return _service;
  }

  bool sendEEMessage(EEMessage message) {
    _channel.sink.add(jsonEncode(message));
  }

    
}
