import 'dart:io';
import 'dart:math';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:wallet/core/constants/status.dart';
import 'package:wallet/core/data_local/share_prefer_utils.dart';
import 'package:wallet/core/widgets/core_toast.dart';
import 'package:wallet/core/widgets/dialog/dialog_alert.dart';

import '../config/root_api.dart';

class BaseServices {
  BaseServices(this.dio);

  Dio dio;

  Future<dynamic> isCheckInternet() async {
    try {
      final result = await InternetAddress.lookup(SERVER_BASE);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Toast.showLongTop("");
      }
    } on SocketException catch (_) {
      Toast.showLongTop("Mất kết nối mạng!");
    }
  }
  // ignore: strict_raw_type
  String errorApiCallback(
      // ignore: strict_raw_type
      // ignore: strict_raw_type
      {Response? response,
      String? errorModel}) {
    if (response != null) {
      Toast.showLongTop(errorModel??'');
    } else {
      isCheckInternet();
// lỗi này là gọi serve sai đường link  lên bị null
//  ***: Request ***
// //  *** DioError ***
//  onError catch + DioError [DioErrorType.DEFAULT]: RangeError (index): Invalid value: Only valid value is 0: 1
//       Toast.showLongTop(Public().languageCustom("common.network"));
    }
    return '';
  }

  // ignore: inference_failure_on_function_return_type, always_declare_return_types
  Future<dynamic> createPost(
    String subUri, {
    // ignore: avoid_positional_boolean_parameters
    bool showLoading = false,
    Map<String, dynamic>? body,
    // ignore: avoid_positional_boolean_parameters
     BuildContext? context,
    String method = 'GET'
      }) async {
    if (showLoading) {
      DialogAlert.showMLoadding(context!);
    }
     Response<dynamic> response = Response(requestOptions: RequestOptions());
    try {
      if(method == "GET"){
        response = await dio.get(subUri, data: body ?? {});
      } else if (method == 'POST') {
    response = await dio.post(subUri, data: body ?? {});
    } else if (method == 'DELETE') {
    response = await dio.delete(subUri, data: body ?? {});
    } else {
    // Handle other HTTP methods here (PUT, PATCH, etc.)
    // Thêm xử lý cho các phương thức HTTP khác ở đây (PUT, PATCH, vv.)
    }

      print("response:${response}");
      if (showLoading) {
        // Navigator.of(context).pop(true);
        Navigator.pop(context!);
      }
      if (response.statusCode != null) {
        if (response.data == StatusApi.SERVE_RESPONSE_TEXT_ERROR500) {
          //! Check Lúc DEV môi trường thật chạy không dc lỗi này(có lỗi là do serve)
          final Map<dynamic, dynamic> data = {
            'responseCode': StatusApi.SERVE_RESPONSE_TEXT_ERROR500,
            'message':
                'LỖI Hệ thống vui lòng quay lại sau! (ERROR500 $subUri)'
          };

          Toast.showLongTop(data['message']);
          // NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          return;
        } else if (response.data['responseCode'] ==
                StatusApi.STATUS_INVALID_REQUEST_PARAMETER_SECT07 ||
            response.data['responseCode'] ==
                StatusApi.STATUS_INVALID_REQUEST_PARAMETER_SECT08) {
          //* Sai param chuyển lên
          final Map<dynamic, dynamic> data = {
            'message': 'Dữ liệu truy vấn không hợp lệ, vui lòng thử lại!'
          };
          Toast.showLongTop(data['message']);
          return;
        } else if (response.data['responseCode'] ==
                StatusApi.LOGIN_SECTION_EXPIRED_SECT01 ||
            response.data['responseCode'] ==
                StatusApi.LOGIN_SECTION_EXPIRED_SECT02 ||
            response.data['responseCode'] ==
                StatusApi.LOGIN_SECTION_EXPIRED_SECT03 ||
            response.data['responseCode'] ==
                StatusApi.LOGIN_SECTION_EXPIRED_SECT04 ||
            response.data['responseCode'] ==
                StatusApi.LOGIN_SECTION_EXPIRED_SECT05 ||
            response.data['responseCode'] ==
                StatusApi.LOGIN_SECTION_EXPIRED_SECT06) {
          //* HẾT HẠN PHIÊN ĐĂNG NHẬP
          Toast.showLongTop("Hết phiên giao dịch, vui lòng đăng nhập lại!");

          SharePreferUtils.logOutApp();
          //  đồng ý thoát app xóa các trang cũ đi
          Phoenix.rebirth(context!);
          // if(Platform.isAndroid){
          //   Phoenix.rebirth(context);
          // }else {
          //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          // }
          // Provider.of<MenuNotifier>(context, listen: false).setListMenu([]);
          return;
        } else if (response.data['responseCode'] ==
            StatusApi.LOGIN_SECTION_EXPIRED_SECT11) {
          Toast.showLongTop(
             "Hệ thống hiện tại đã ngoại tuyến.");
          return;
        } else if (response.data['responseCode'] ==
            StatusApi.LOGIN_SECTION_EXPIRED_SECT12) {
          Toast.showLongTop("Không có quyền truy cập chức năng này.");
          return;
        } else if (response.data['responseCode'] ==
            StatusApi.LOGIN_SECTION_EXPIRED_SECT13) {
          Toast.showLongTop(
              "Kiểu dữ liệu không được hỗ trợ.");
          return;
        } else if (response.data['responseCode'] ==
            StatusApi.LOGIN_SECTION_EXPIRED_SECT14) {
          Toast.showLongTop("Yêu cầu đã bị từ chối.");
          return;
        } else if (response.data['responseCode'] == "AUTH01") {
          Toast.showLongTop(
              "Thông tin đăng nhập không đúng, vui lòng kiểm tra lại tên đăng nhập và mật khẩu!");
          SharePreferUtils.logOutApp();
          //  đồng ý thoát app xóa các trang cũ đi
          Phoenix.rebirth(context!);
          // if(Platform.isAndroid){
          //   Phoenix.rebirth(context);
          // }else {
          //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          // }
          // Provider.of<MenuNotifier>(context, listen: false).setListMenu([]);
          return;
        } else if (response.data['responseCode'] == "AUTH06") {
          //* HẾT HẠN PHIÊN ĐĂNG NHẬP
          Toast.showLongTop(
              "Tài khoản chưa đăng ký dịch vụ.");
          SharePreferUtils.logOutApp();
          //  đồng ý thoát app xóa các trang cũ đi
          Phoenix.rebirth(context!);
          // if(Platform.isAndroid){
          //   Phoenix.rebirth(context);
          // }else {
          //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          // }
          // Provider.of<MenuNotifier>(context, listen: false).setListMenu([]);
          return;
        } else if (response.data['responseCode'] == "AUTH13") {
          //* HẾT HẠN PHIÊN ĐĂNG NHẬP
          Toast.showLongTop(
              "Không gửi được OTP, vui lòng thử lại!");
          SharePreferUtils.logOutApp();
          //  đồng ý thoát app xóa các trang cũ đi
          Phoenix.rebirth(context!);
          // if(Platform.isAndroid){
          //   Phoenix.rebirth(context);
          // }else {
          //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          // }
          // Provider.of<MenuNotifier>(context, listen: false).setListMenu([]);
          return;
        } else if (response.data['responseCode'] == "AUTH16") {
          //* HẾT HẠN PHIÊN ĐĂNG NHẬP
          Toast.showLongTop("Tài khoản đã được đăng nhập bằng thiết bị khác");
          SharePreferUtils.logOutApp();
          //  đồng ý thoát app xóa các trang cũ đi
          Phoenix.rebirth(context!);
          // if(Platform.isAndroid){
          //   Phoenix.rebirth(context);
          // }else {
          //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          // }
          // Provider.of<MenuNotifier>(context, listen: false).setListMenu([]);
          return;
        } else if (response.data['responseCode'] == "AUTH15") {
          //* HẾT HẠN PHIÊN ĐĂNG NHẬP
          Toast.showLongTop("Phiên bản cần cập nhật");
          SharePreferUtils.logOutApp();
          //  đồng ý thoát app xóa các trang cũ đi
          Phoenix.rebirth(context!);
          // if(Platform.isAndroid){
          //   Phoenix.rebirth(context);
          // }else {
          //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
          // }
          // Provider.of<MenuNotifier>(context, listen: false).setListMenu([]);
          return;
        } else {
          return response.data;
        }



      }
    } catch (onError) {
      print('onError catch + $onError');
      if (context != null) {
        DialogAlert.dissmissLoadingDialog(context, GlobalKey());
      } else {
      }
      if (onError is DioError) {
          switch (onError.type) {
            case DioErrorType.connectionTimeout:
              errorApiCallback(
                  response: onError.response, errorModel: ErrorModel.timeOutError);
              break;

            case DioErrorType.badResponse:
              if (onError.response!.statusCode == 401) {
                errorApiCallback(
                    response: onError.response,
                    errorModel: ErrorModel.unAuthorized);
              } else if (onError.response!.statusCode == 404) {
                errorApiCallback(
                    response: onError.response, errorModel: ErrorModel.notFound);
              } else if (onError.response!.statusCode == 403) {
                errorApiCallback(
                    response: onError.response, errorModel: ErrorModel.banned);
              } else if (onError.response!.statusCode == 405) {
                errorApiCallback(
                    response: onError.response,
                    errorModel: ErrorModel.methodNotAllowed);
              } else {
                errorApiCallback(
                    response: onError.response, errorModel: ErrorModel.unknown);
              }
              break;
            default:
              errorApiCallback(
                  response: onError.response, errorModel: onError.message);
              break;
          }
      }

    }
  }
}

///[errorType] == [ErrorType.DATA_ERROR] => [errorType] có dữ liệu trả về



class ErrorModel {
  // ignore: avoid_classes_with_only_static_members
  static String netError =
      'Kết nối mạng không ổn định hoặc cần được gia hạn. Vui lòng kiểm tra kết nối của bạn và thử lại';
  static String unAuthorized = 'Thông tin xác thực không chính xác.';
  static String banned = 'Bạn không đủ quyền hạn thực hiện hành động này.';
  static String notFindPackageInfo =
      'Không tìm thấy thông tin khóa học. Vui lòng thử lại';
  static String userInvailid =
      'Thông tin xác thực không đúng, Vui lòng liên hệ bộ phận hỗ trợ để nhận được hướng dẫn!';
  static String otherError = 'Đã xảy ra lỗi bất ngờ. Xin vui lòng thử lại sau.';
  static String timeOutError = 'Mất kết nối';
  static String notFound =
      'Giao dịch không thực hiện được, vui lòng thử lại!'; // Đường dẫn api sai
  static String unknown = 'Giao dịch không thực hiện được, vui lòng thử lại!';
  static String methodNotAllowed = 'Method Not Allowed'; // phương thức sai

}
