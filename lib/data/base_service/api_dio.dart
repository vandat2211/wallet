import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:wallet/core/data_local/share_prefer_utils.dart';
import 'package:wallet/core/utils.dart';

import '../config/root_api.dart';
import 'base_service.dart';

class ApiDio {
  static ApiDio? instance;
  static BaseServices? baseService;

  ApiDio() {
    var options = BaseOptions(
      baseUrl: SERVER_BASE,
      connectTimeout: Duration(milliseconds: TIME_OUT),
      receiveTimeout: Duration(milliseconds: TIME_OUT),
    );
    Dio dio = Dio(options);
    // ignore: avoid_single_cascade_in_expression_statements, cascade_invocations
    dio..interceptors.add(AuthInterceptor()); // add token
    // ignore: avoid_single_cascade_in_expression_statements
   
    dio
      // ignore: cascade_invocations, cascade_invocations
      ..interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          )); //Add a log
    baseService = BaseServices(dio);

  }

  static BaseServices? getInstance() {
    instance ??= ApiDio();
    return _getBaseService();
  }

  static BaseServices? _getBaseService() {
    return baseService;
  }


 static  Future<dynamic> loadAsset(String linkFile) async {
    return jsonDecode(await rootBundle.loadString(linkFile));
  }
}

/// AuthInterceptor
///
/// Add header authentication
class AuthInterceptor extends Interceptor {
  String PLATFORM = "android"; // can be judged according to the code
  String CLIENT = "store";

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String> headers = new Map();
    headers['content-type'] = 'application/json';
    await SharePreferUtils.getAccessToken().then((String token) async => {
          if (token != null)
            // ignore: always_specify_types
            {
              await SharePreferUtils.getUserInfo().then((value) => {
                if(value != null){
                  headers['Authorization'] =
                  '${Utils.getCurrentTimeStringRequest()}|${value.userName}|X-AUTH-TOKEN $token|DEVICE_ID ${value.deviceId}'
                }

                  })
            }
        });

    options.headers = headers;
    print(headers);
    return super.onRequest(options, handler);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${DateTime.now().weekday}.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }
}
