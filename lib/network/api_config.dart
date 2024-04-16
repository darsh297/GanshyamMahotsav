import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/widgets.dart';

import 'api_strings.dart';

class ApiBaseHelper {
  ApiBaseHelper._();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final ApiBaseHelper _instance = ApiBaseHelper._();

  factory ApiBaseHelper() {
    return _instance;
  }

  dynamic responseJson;
  Future<dynamic> getData({required String leadAPI}) async {
    debugPrint('getDataAPI api ======== $leadAPI');

    try {
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.userTokenKey)}',
      };
      final response = await http.get(Uri.parse(ApiStrings.kBaseAPI + leadAPI), headers: headers);
      debugPrint("response=====> $response");
      responseJson = _returnResponse(response);
    } catch (e) {
      toastValidation(msg: 'Action can not perform : $e');
    }
    return responseJson;
  }

  Future<dynamic> putDataAPI({required String leadAPI, Object? jsonObjectBody}) async {
    debugPrint('putDataAPI ======= [${json.encode(jsonObjectBody)}]= URL :[$leadAPI]]=> ');

    try {
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.userTokenKey)}',
      };
      var body = json.encode(jsonObjectBody);

      final response = await http.put(
        Uri.parse(ApiStrings.kBaseAPI + leadAPI),
        body: body,
        headers: headers,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postDataAPI({required String leadAPI, Object? jsonObjectBody, bool isLogin = false}) async {
    debugPrint('request ===> ${json.encode(jsonObjectBody)}');
    debugPrint('api ===> :$leadAPI, isLoggedIn = $isLogin  ');

    try {
      var headers = isLogin
          ? {
              'Content-Type': 'application/json',
            }
          : {
              'Content-Type': 'application/json',
              // 'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.userTokenKey)}',
            };

      var body = json.encode(jsonObjectBody);

      final response = await http.post(
        Uri.parse(ApiStrings.kBaseAPI + leadAPI),
        headers: headers,
        body: body,
      );
      log("response ===> ${response.statusCode}");
      log("response body ===> ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteDataAPI({required String leadAPI, Object? jsonObjectBody}) async {
    debugPrint('deleteDataAPI ======== URL = $leadAPI');

    try {
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.userTokenKey)}',
      };
      var body = jsonObjectBody != null ? json.encode(jsonObjectBody) : null;
      final response = await http.delete(
        Uri.parse(ApiStrings.kBaseAPI + leadAPI),
        headers: headers,
        body: body,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body.toString());
      // debugPrint('Success==> $responseJson');
      return responseJson;
    } else {
      if (response.statusCode == 403) {
        var responseJson = json.decode(response.body.toString());
        debugPrint('403 error ===> $responseJson');
        return responseJson;
      }
      toastValidation(msg: '${json.decode(response.body.toString())['message']}');
      // print(FetchDataException(
      //     'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${json.decode(response.body.toString())['message']} '));
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    }
  }
}
