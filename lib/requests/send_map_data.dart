import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:scp682/headers/headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> sendMapData(Map<String,String> headers,String command,Map<String, dynamic> body ) async {
  //final jsonString = json.encode(toJson());
  final uri = Uri.parse('http://sbeusilent.space:6321/'+command);
  final response = await http.post(uri, headers: headers, body: body);
  //print(response.statusCode);
  //print(response.body);
  if(response.statusCode==200)
  {
    return response.body;
  }
  return "NO_RESULT_SEND";
  //print(response.statusCode);
  //print(response.body);
}

Future sendMapDataWithoutHeaders(String command,Map<String, dynamic> body ,Map<String,String> headers,) async {
  //final jsonString = json.encode(toJson());
  final uri = Uri.parse('http://sbeusilent.space:6321/'+command);
  //print(jsonEncode(body));
  //print(body);
  //print(jsonEncode(body));
  final response = await http.post(uri, headers: headers ,body: jsonEncode(body));
  //print(response.statusCode);
  //print(response.body);
  return response;
  //print(response.statusCode);
  //print(response.body);
}

Future getCoor(Map<String, dynamic> body) async {
  //final jsonString = json.encode(toJson());
  final uri = Uri.parse('http://sbeusilent.space:6321/user/updatecoordinates');
  //print(jsonEncode(body));
  //print(body);
  //print(jsonEncode(body));
  final response = await http.patch(uri, headers: registrationHeaders ,body: jsonEncode(body));
  //print(response.statusCode);
  //print(response.body);
  var sh = await SharedPreferences.getInstance();
  //debugPrint(sh.getString("familyID"));
  //debugPrint(sh.getString('phone'));
  return response;
  //print(response.statusCode);
  //print(response.body);
}

Future getFamily(String phone)async{

  final uri = Uri.parse("http://sbeusilent.space:6321/user/family?phone="+phone);
  final response = await http.get(uri);
  //debugPrint(response.body);
  return response;
}