import 'package:ChatUI/libs.dart';

List<Alie> alies = [];
List<Alie> searchResultUsers = [];
String myid = '';

class StaticDataStore {
  static const String HOST = "http://192.168.59.1:8080/";
 //static const String HOST = "http://10.9.216.182:8080/";
  static String ID = "";
}


enum WS_CONNECTION_STATUS {
  connecting , 
  connected  , 
  not_connected  , 
  closed  , 
}