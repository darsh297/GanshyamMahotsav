import 'dart:convert';
import 'dart:developer';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:io';
import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';
import '../widgets/widgets.dart';
import 'api_strings.dart';

class ApiBaseHelper {
  ApiBaseHelper._();
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final ApiBaseHelper _instance = ApiBaseHelper._();

  factory ApiBaseHelper() {
    return _instance;
  }

  dynamic responseJson;
  Future<dynamic> getData({required String leadAPI}) async {
    log('getDataAPI api ======== $leadAPI \n Token = ${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}',
      };
      final response = await http.get(Uri.parse(ApiStrings.kBaseAPI + leadAPI), headers: headers);
      log("response=====> ${response.body}");
      responseJson = _returnResponse(response);
    } catch (e) {
      print('$e');
      CustomWidgets.toastValidation(msg: 'Action can not perform : $e');
    }
    return responseJson;
  }

  Future<dynamic> putDataAPI({required String leadAPI, Object? jsonObjectBody}) async {
    debugPrint('putDataAPI ======= [${json.encode(jsonObjectBody)}]= URL :[$leadAPI]]=> ');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}',
      };
      var body = json.encode(jsonObjectBody);

      final response = await http.put(
        Uri.parse(ApiStrings.kBaseAPI + leadAPI),
        body: body,
        headers: headers,
      );

      responseJson = _returnResponse(response);
    } catch (e) {
      CustomWidgets.toastValidation(msg: '$e');
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
              'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}',
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
    } catch (e) {
      CustomWidgets.toastValidation(msg: '$e');
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> uploadFiles({String filePath = '', String language = '', String leadAPI = ''}) async {
    try {
      var headers = {'Authorization': '${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}'};
      // var headers = {
      //   'Authorization':
      //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjIyNWVjOGE4ODU2Mjc0OTQyY2I3MGYiLCJwaG9uZU51bWJlciI6IjEyMzQ1Njc4OTAiLCJjb3VudHJ5Q29kZSI6Iis5MSIsImZ1bGxOYW1lIjoiQWRtaW4gVXNlciIsImlzQWRtaW4iOnRydWUsImNyZWRpdENvdW50Ijo0LCJjcmVhdGVkQXQiOiIyMDI0LTA0LTE5VDEyOjA4OjQwLjczNFoiLCJfX3YiOjAsImlhdCI6MTcxMzcxMjc1MCwiZXhwIjoxNzQ1MjQ4NzUwfQ.kg6nuD65_9qtzT9JWS5WLtJSwCUbY3vbZ8pr78K-txI'
      // };

      var request = http.MultipartRequest('POST', Uri.parse(ApiStrings.kBaseAPI + leadAPI));
      request.fields.addAll({'lang': language});
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String responseBody = await response.stream.bytesToString();

      return json.decode(responseBody);
    } catch (e) {
      CustomWidgets.toastValidation(msg: 'PDf can not uploaded:$e');
    }
  }

  Future<dynamic> deleteDataAPI({required String leadAPI, Object? jsonObjectBody}) async {
    debugPrint('deleteDataAPI ======== URL = $leadAPI');

    try {
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}',
      };
      var body = jsonObjectBody != null ? json.encode(jsonObjectBody) : null;
      final response = await http.delete(
        Uri.parse(ApiStrings.kBaseAPI + leadAPI),
        headers: headers,
        body: body,
      );

      responseJson = _returnResponse(response);
    } catch (e) {
      CustomWidgets.toastValidation(msg: '$e');
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
      CustomWidgets.toastValidation(msg: '${json.decode(response.body.toString())['message']}');
      // print(FetchDataException(
      //     'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${json.decode(response.body.toString())['message']} '));
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    }
  }
}
