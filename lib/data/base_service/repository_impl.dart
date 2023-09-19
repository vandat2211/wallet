
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallet/core/constants/constants.dart';
import 'package:wallet/core/constants/status.dart';
import 'package:wallet/core/constants/url_static.dart';
import 'package:wallet/core/data_local/share_prefer_utils.dart';
import 'package:wallet/core/data_local/sql_lite.dart';
import 'package:wallet/core/widgets/core_toast.dart';
import 'package:wallet/core/widgets/dialog/dialog_alert.dart';
import 'package:wallet/data/base_service/api_dio.dart';
import 'package:wallet/data/base_service/repository.dart';
import 'package:wallet/login_model.dart';

import '../../core/data.dart';
class ListData{
  ListData({
    required this.listData,
  });
  List<Data> listData;
  factory ListData.fromJson(Map<String, dynamic> json) {
    return ListData(
      listData: List<Data>.from(json["results"].map((x) => Data.fromJson(x))),
    );
  }
}
class Data{
   Data({
   required this.namee,
     required this.url
  });
  String namee;
  String url;
   factory Data.fromJson(Map<String, dynamic> json) {
     return Data(
       namee: json["name"]??"",
       url: json["url"]??"",
     );
   }
}
class Image{
  Image({
    required this.urlImage,
  });
  String urlImage;
  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      urlImage: json['sprites']['other']['dream_world']['front_default']??"",
    );
  }
}
class RepositoryImpl implements Repository{
  final imageDb = ImageDatabase();
  @override
  Future<void> getData(BuildContext context) async {
       var result = await ApiDio.getInstance()?.createPost(
            UrlStatic.pokemon,
            showLoading: false,
            body: {},
            context: context);
       ListData list = ListData.fromJson(result);
       list.listData.forEach((element) async {
         var result2 = await ApiDio.getInstance()?.createPost(
             "/${element.namee}",
             showLoading: false,
             body: {},
             context: context);
         Image image = Image.fromJson(result2);
         await imageDb.insertImage(CreditCardData(name: element.namee, imagePath: image.urlImage, imagePath2: image.urlImage));
       });
  }
  // @override
  // Future<void> login(LoginRequest request, BuildContext context, String auth) async {
  //   await SharePreferUtils.getUserName().then((value) async => {
  //     if (value.isNotEmpty)
  //       {
  //         if (value != request.userName)
  //           {SharePreferUtils.LogOut()}
  //         else
  //           {
  //             // check xem là user cũ hay mới là một máy hay máy khác để gửi request lên khác nhau
  //             await SharePreferUtils.getUserInfo().then((dataLocal) => {
  //               if (dataLocal != null)
  //                 {
  //                   request.setSerialNo = dataLocal.serialNo,
  //                   request.setToken = dataLocal.token
  //                 }
  //             })
  //           }
  //       }
  //     else
  //       {SharePreferUtils.LogOut()}
  //   });
  //   var result;
  //   if (Constants.FINGERPRINT_Y == auth) {
  //     result = await ApiDio.getInstance()?.createPost(
  //         UrlStatic.API_AUTHENTICATION_FINGER,
  //         showLoading: true,
  //         body: request.toMapFinger(),
  //         context: context);
  //   } else {
  //     result = await ApiDio.getInstance()?.createPost(
  //         UrlStatic.API_AUTHENTICATION,
  //         showLoading: true,
  //         body: request.toMap(),
  //         context: context);
  //   }
  //   print("result:${result}");
  //   LoginResponse loginResponse = LoginResponse.fromJson(result);
  //   // tiếp đến gọi verifyAuthentication
  //   verifyAuthentication(
  //       request, loginResponse, result, context);
  // }
  // void verifyAuthentication(LoginRequest request, LoginResponse result,
  //     Map<dynamic, dynamic> resultMap, BuildContext context) async {
  //   switch (result.responseCode) {
  //     case StatusApi.STATUS_LOGIN_AUTHORIZED_FIRST: // login lan dau
  //       showOtpInput(result, context, request);
  //       break;
  //     case StatusApi
  //         .STATUS_LOGIN_AUTHORIZED_SWITCH_DEVICE: // login bang may khac
  //       await SharePreferUtils.getSerialNo().then((seriesNo) => {
  //         if (seriesNo == '')
  //           {showOtpInput(result, context, request)}
  //       });
  //
  //       break;
  //     case StatusApi
  //         .STATUS_LOGIN_LOCK_ACCOUNT: // tài khoản bị khóa do nhập sai nhiều lần
  //     // authStream.notify(AuthenticationModel(AuthState.CHANGE_PASSWORD, null));
  //       Toast.showLongTop(result.message??"");
  //       break;
  //
  //     case StatusApi
  //         .STATUS_LOGIN_AUTHORIZED_EXPIRED: // login co them popup canh bao xong login luon
  //       Toast.showLongTop(result.message??"");
  //
  //       break;
  //
  //     case StatusApi.STATUS_LOGIN_AUTHENTICATION_AUTH00: // login thanh coong
  //       // loginStep2VerifyOtp(result, resultMap, context, request.userName,
  //       //     request.deviceId, request.passWord);
  //       Toast.showLongTop("Đăng nhập thành công");
  //       break;
  //
  //     case StatusApi.STATUS_LOGIN_AUTHENTICATION_AUTH01: // sai tk mk
  //       Toast.showLongTop(
  //           "Thông tin đăng nhập không đúng, vui lòng kiểm tra lại tên đăng nhập và mật khẩu.");
  //
  //       break;
  //     case StatusApi.STATUS_LOGIN_AUTHENTICATION_AUTH02: // sai tk mk
  //       Toast.showLongTop("Không tìm thấy thông tin NNT.");
  //
  //       break;
  //     case StatusApi.STATUS_LOGIN_NOT_VERIFY: // sai tk mk
  //       Toast.showLongTop("Lỗi xác thực người dùng.");
  //
  //       break;
  //     case StatusApi.STATUS_LOGIN_NOT_ACTIVE: // sai tk mk
  //       Toast.showLongTop("Tài khoản chưa đăng ký dịch vụ.");
  //
  //       break;
  //
  //     case StatusApi
  //         .STATUS_LOGIN_VERSION_UPFATE: // có phiên bản mơi của app yêu cầu update
  //       Toast.showLongTop(result.message??"");
  //       // Dialogs.showMDialogUpdateApp(result.message, context);
  //       break;
  //     case StatusApi.STATUS_LOGIN_AUTHORIZED_FAIL_OTP: // sai nhập lại otp
  //       Toast.showLongTop("NNT nhập sai OTP.");
  //       break;
  //     case StatusApi.SENT_OTP_END_TIME: // sai nhập lại otp
  //       Toast.showLongTop("Mã OTP hết thời gian sử dụng.");
  //       break;
  //     case "OTP01":
  //       Toast.showLongTop("Không gửi được OTP, vui lòng thử lại!");
  //
  //       break;
  //     case "FL999":
  //       DialogAlert.showDialogAlertCancel(
  //           context, 'fingerprint.ALERT_REGISTER');
  //       break;
  //
  //     case StatusApi
  //         .STATUS_LOGIN_AUTHORIZED_OLD_VERSION: // AUTH15  thông báo phiên bản đã cũ
  //       Toast.showLongTop(result.message??"");
  //       break;
  //     case StatusApi.STATUS_LOGIN_ACCOUNT_ALREADY_EXIST: // MST đã có tài khoản bên Etax
  //       String messageToShow = result.message ?? "MST đã có tài khoản bên Etax";
  //       Toast.showLongTop(messageToShow);
  //       break;
  //
  //     default:
  //     //  thoong bao retset pass ve trong do nhập sai pass hoặc user na
  //       String messageToShow = result.message ?? "Lỗi đăng nhập!";
  //       Toast.showLongTop(messageToShow);
  //       // appBloc.homeBloc.layoutNoAppBarStream
  //       //     .notify(LayoutNoAppBarModel(state: LayoutNoAppBarState.LOADING));
  //       break;
  //   }
  // }
  // void showOtpInput(
  //     LoginResponse data, BuildContext context, LoginRequest request) {
  //   // if (data.responseCode == StatusApi.STATUS_LOGIN_AUTHORIZED_FIRST) {
  //   //   data.message = data.message;
  //   // } else if (data.responseCode == StatusApi.STATUS_LOGIN_LOCK_ACCOUNT) {
  //   //   data.message =
  //   //       AppTranslate.of(context).translate('loginScreen.otp.title3');
  //   // } else if (data.responseCode ==
  //   //     StatusApi.STATUS_LOGIN_AUTHORIZED_SWITCH_DEVICE) {
  //   //   data.message =
  //   //       AppTranslate.of(context).translate('loginScreen.otp.title2');
  //   // }
  //
  //   DialogAlert.showMDialogOTP(
  //     'Nhập OTP',
  //     context,
  //         (otpValue) {
  //       request.setOtpNo = otpValue;
  //       login(request, context, Constants.FINGERPRINT_N);
  //     },
  //   );
  // }

}