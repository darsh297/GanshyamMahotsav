import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';
import '../widgets/widgets.dart';
import 'api_strings.dart';

class ApiBaseHelper {
  ApiBaseHelper._();
  static final ApiBaseHelper _instance = ApiBaseHelper._();

  factory ApiBaseHelper() {
    return _instance;
  }

  dynamic responseJson;
  Future<dynamic> getData({required String leadAPI}) async {
    if (await CustomWidgets.isNetworkAvailable()) {
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
        print(e);
        CustomWidgets.toastValidation(msg: 'Something is wrong , Please is refresh the tab');
      }
      return responseJson;
    } else {
      CustomWidgets.toastValidation(msg: 'Please connect to internet');
    }
  }

  Future<dynamic> postDataAPI({required String leadAPI, Object? jsonObjectBody, bool isLogin = false}) async {
    debugPrint('request ===> ${json.encode(jsonObjectBody)} api ===> :${ApiStrings.kBaseAPI + leadAPI}, isLoggedIn = $isLogin ');
    if (await CustomWidgets.isNetworkAvailable()) {
      try {
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}',
        };

        var body = json.encode(jsonObjectBody);
        final response = await http.post(
          Uri.parse(ApiStrings.kBaseAPI + leadAPI),
          headers: headers,
          body: body,
        );
        log("response ===> ${response.statusCode} response body ===> ${response.body}");
        responseJson = _returnResponse(response);
      } catch (e) {
        print(e);
        CustomWidgets.toastValidation(msg: 'Something is wrong , Please is refresh the tab');
        // throw FetchDataException('No Internet connection');
      }
      return responseJson;
    } else {
      CustomWidgets.toastValidation(msg: 'Please connect to internet');
    }
  }

  Future<dynamic> uploadFiles({
    String filePath = '',
    String language = '',
    String leadAPI = '',
    String description = '',
    String imagePath = '',
  }) async {
    if (await CustomWidgets.isNetworkAvailable()) {
      try {
        var headers = {'Authorization': '${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}'};
        print('${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}');
        // var headers = {
        //   'Authorization':
        //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjIyNWVjOGE4ODU2Mjc0OTQyY2I3MGYiLCJwaG9uZU51bWJlciI6IjEyMzQ1Njc4OTAiLCJjb3VudHJ5Q29kZSI6Iis5MSIsImZ1bGxOYW1lIjoiQWRtaW4gVXNlciIsImlzQWRtaW4iOnRydWUsImNyZWRpdENvdW50Ijo0LCJjcmVhdGVkQXQiOiIyMDI0LTA0LTE5VDEyOjA4OjQwLjczNFoiLCJfX3YiOjAsImlhdCI6MTcxMzcxMjc1MCwiZXhwIjoxNzQ1MjQ4NzUwfQ.kg6nuD65_9qtzT9JWS5WLtJSwCUbY3vbZ8pr78K-txI'
        // };

        var request = http.MultipartRequest('POST', Uri.parse(ApiStrings.kBaseAPI + leadAPI));
        request.fields.addAll({'lang': language});
        request.fields.addAll({'desc': description});
        request.files.add(await http.MultipartFile.fromPath('file', filePath, contentType: MediaType.parse('application/pdf')));
        request.files.add(await http.MultipartFile.fromPath('file', imagePath, contentType: MediaType.parse('image/jpeg')));
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();

        String responseBody = await response.stream.bytesToString();

        return json.decode(responseBody);
      } catch (e) {
        print('$e');
        CustomWidgets.toastValidation(msg: 'Book can not uploaded:$e');
      }
    } else {
      CustomWidgets.toastValidation(msg: 'Please connect to internet');
    }
  }

  Future<dynamic> deleteDataAPI({required String leadAPI, Object? jsonObjectBody}) async {
    debugPrint('deleteDataAPI ======== URL = $leadAPI');
    if (await CustomWidgets.isNetworkAvailable()) {
      try {
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': '${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}',
        };
        var body = jsonObjectBody != null ? json.encode(jsonObjectBody) : null;
        final response = await http.delete(
          Uri.parse(ApiStrings.kBaseAPI + leadAPI),
          headers: headers,
          body: body,
        );
        print('====delete book=== ${response.body}');
        responseJson = _returnResponse(response);
      } catch (e) {
        print('$e');
        CustomWidgets.toastValidation(msg: 'Book can not deleted:$e');
      }
      return responseJson;
    } else {
      CustomWidgets.toastValidation(msg: 'Please connect to internet');
    }
  }

  Future<dynamic> downloadFile() async {
    // print('111111');
    // String url = "${ApiStrings.kBaseAPI}/user/exportAllUsers";
    // String token = '${await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey)}';
    // print('2222222 $url');
    //
    // try {
    //   http.Response response = await http.get(
    //     Uri.parse(url),
    //     headers: {
    //       HttpHeaders.authorizationHeader: token,
    //     },
    //   );
    //   print('333333');
    //
    //   String dirtyFileName = response.headers["content-disposition"] ?? "";
    //   print('444444');
    //
    //   String fileName = "Userfile";
    //
    //   Directory? downloadsDirectory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first;
    //   String filePath = '${downloadsDirectory?.path}/$fileName.xlsx';
    //   print('55555 $filePath');
    //
    //   File file = File(filePath);
    //   await file.writeAsBytes(response.bodyBytes);
    //   // Check if the file exists
    //   File downloadedFile = File('${downloadsDirectory?.path}/$fileName.xlsx');
    //   if (await downloadedFile.exists()) {
    //     print("File downloaded successfully at:");
    //     return true;
    //   } else {
    //     print("File download failed.");
    //
    //     return false;
    //   }
    // } catch (e) {
    //   print("Error: $e");
    //   CustomWidgets.toastValidation(msg: 'Something is wrong , Please is refresh the tab');
    // }
    // print('111111');
    // String url1 = "https://sea-lion-app-pnyik.ondigitalocean.app/api/user/exportAllUsers";
    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjNjNWQ5ZmRjYWExNDNiMTJmODJhOGEiLCJwaG9uZU51bWJlciI6IjEyMzQ1Njc4OTAiLCJjb3VudHJ5Q29kZSI6Iis5MSIsImZ1bGxOYW1lIjoiQWRtaW4gVXNlciIsImlzQWRtaW4iOnRydWUsImNyZWRpdENvdW50Ijo0NCwiY3JlYXRlZEF0IjoiMjAyNC0wNS0wOVQwNToyMjozOS44NDRaIiwiX192IjowLCJpYXQiOjE3MTU2Njk3ODcsImV4cCI6MTc0NzIwNTc4N30.pkl3gDepJTKoy5wsejTE4796GK4YktvlSrrV8LWFwAo';
    // print('2222222 $url1');
    //
    // try {
    //   var url = Uri.parse(url1);
    //   var headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    //   var response = await http.get(url, headers: headers);
    //   print('${response.bodyBytes} ||${response.body}');
    //   // var fileName = 'UserList.pdf';
    //   // Directory directory = Directory("");
    //   // if (Platform.isAndroid) {
    //   //   // Redirects it to download folder in android
    //   //   directory = Directory("/storage/emulated/0/Download");
    //   // } else {
    //   //   directory = await getApplicationDocumentsDirectory();
    //   // }
    //   // print('||| ${directory.path}/$fileName');
    //   // var file = File('${directory.path}/$fileName');
    //   // await file.writeAsBytes(response.bodyBytes);
    //
    //   // Optionally, you can show a notification or toast indicating the file download.
    // } catch (e) {
    //   print("Error: $e");
    //   CustomWidgets.toastValidation(msg: 'Something is wrong , Please is refresh the tab');
    // }

    var headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjNjNWQ5ZmRjYWExNDNiMTJmODJhOGEiLCJwaG9uZU51bWJlciI6IjEyMzQ1Njc4OTAiLCJjb3VudHJ5Q29kZSI6Iis5MSIsImZ1bGxOYW1lIjoiQWRtaW4gVXNlciIsImlzQWRtaW4iOnRydWUsImNyZWRpdENvdW50Ijo0NCwiY3JlYXRlZEF0IjoiMjAyNC0wNS0wOVQwNToyMjozOS44NDRaIiwiX192IjowLCJpYXQiOjE3MTU2Njk3ODcsImV4cCI6MTc0NzIwNTc4N30.pkl3gDepJTKoy5wsejTE4796GK4YktvlSrrV8LWFwAo',
      // 'Cookie':
      //     '__cf_bm=_oRNEfwQ8KB0jbGpeQo1A8bz1lGJUArjIbMuii6fj_4-1715670643-1.0.1.1-bAFmQDj1JwL8So3nH1bRHgOhqBC0v.qL64vWNMxWqaYPu8L1GIBIZw5LCepqvM.7rlDIX8FXKrI.uQr7K4SnAg',
    };

    var request = http.Request(
      'GET',
      Uri.parse('https://sea-lion-app-pnyik.ondigitalocean.app/api/user/exportAllUsers'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Directory directory = Directory("");
      if (Platform.isAndroid) {
        directory = Directory("/storage/emulated/0/Download");
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      var filePath = '${directory.path}/User Data.xlsx'; // Replace with your desired file path
      var file = File(filePath);
      await file.writeAsBytes(await response.stream.toBytes());
      print('File saved successfully: $filePath');
    } else {
      print('Failed to download file: ${response.reasonPhrase}');
    }
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
