import 'dart:convert';

import 'package:wallet/core/constants/constants.dart';



class LoginRequest {
  String requestId;
  String userName;
  String passWord;
  String passwordUpperCase;
  String lang;
  String otpNo;
  String version;
  String tokenPush;
  String isFingerLogin;
  String isNotification;
  String operatingSystem;
  String serialNo;
  String token;
  String deviceId;
  String sodinhdanh;
  String code;

  LoginRequest({
    this.requestId="",
    this.userName="",
    this.passWord="",
    this.passwordUpperCase="",
    this.lang="",
    this.otpNo="",
    this.version="",
    this.tokenPush="",
    this.isFingerLogin="",
    this.isNotification="",
    this.operatingSystem="",
    this.serialNo="",
    this.token="",
    this.deviceId="",
    this.sodinhdanh="",
    this.code="",
  }) {
    // this.lang = GlobalUtils.LANGUAGE;
    // this.version = Constants.VERSION_APP;
  }

  String get getRequestId => requestId;

  set setRequestId(String requestId) => this.requestId = requestId;

  String get getUserName => userName;

  set setUserName(String username) => this.userName = username;

  String get getPassWord => passWord;

  set setPassWord(String password) => this.passWord = password;

  String get getLang => lang;

  set setLang(String lang) => this.lang = lang;

  String get getOtpNo => otpNo;

  set setOtpNo(String otpNo) => this.otpNo = otpNo;

  String get getVersion => version;

  set setVersion(String version) => this.version = version;

  String get getTokenPush => tokenPush;

  set setTokenPush(String tokenPush) => this.tokenPush = tokenPush;

  String get getIsFingerLogin => isFingerLogin;

  set setIsFingerLogin(String value) => isFingerLogin = value;

  String get getIsNotification => isNotification;

  set setIsNotification(String isNotification) =>
  this.isNotification = isNotification;

  String get getOperatingSystem => operatingSystem;

  set setOperatingSystem(String operatingSystem) =>
  this.operatingSystem = operatingSystem;

  String get getSerialNo => serialNo;

  set setSerialNo(String serialNo) => this.serialNo = serialNo;

  String get getToken => token;

  set setToken(String token) => this.token = token;

  String get getDeviceId => deviceId;

  set setDeviceId(String deviceId) => this.deviceId = deviceId;

  String get getCode => code;

  set setCode(String code) => this.code = code;

  String get getSodinhdanh => sodinhdanh;

  set setSodinhdanh(String sodinhdanh) => this.sodinhdanh = sodinhdanh;


  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'userName': userName,
      'passWord': passWord,
      //  'passwordUpperCase': passwordUpperCase,
      //  'lang': lang,
      'otpNo': otpNo,
      'version': version,
      // 'isFingerLogin': isFingerLogin,
      // 'isNotification': isNotification,
      'operatingSystem': operatingSystem,
      //   'serialNo': serialNo,
      'token': token,
      'deviceId': deviceId,
      'code': code,
      'tokenPush': tokenPush,
      'sodinhdanh': sodinhdanh,
    };
  }

  Map<String, dynamic> toMapFinger() {
    return {
      'requestId': requestId,
      'userName': userName,
      'passWord': passWord,
      'version': version,
      'isFingerLogin': isFingerLogin,
      // 'isNotification': isNotification,
      // 'operatingSystem': operatingSystem,
      //   'serialNo': serialNo,
      // 'tokenPush': tokenPush,
      'deviceId': deviceId,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return LoginRequest();

    return LoginRequest(
      requestId: map['requestId']??"",
      userName: map['userName'] ??"",
      passWord: map['passWord'] ??"",
      passwordUpperCase: map['passwordUpperCase']??"",
      lang: map['lang'] ??"",
      otpNo: map['otpNo'] ??"",
      version: map['version'] ??"",
      isFingerLogin: map['isFingerLogin'] ??"",
      isNotification: map['isNotification'] ??"",
      operatingSystem: map['operatingSystem'] ??"",
      serialNo: map['serialNo'] ??"",
      token: map['token'] ??"",
      tokenPush: map['tokenPush'] ??"",
      deviceId: map['deviceId'] ??"",
      code: map['code'] ??"",
      sodinhdanh: map['sodinhdanh'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));
}

class LoginResponse {
  String ccyFormat;
  String fullName;
  String isFingerLogin;
  String isNoti;
  String isDebtNoti;
  String lastLoginTime;
  String menuList;
  String message;
  String responseCode;
  String ruleMessage;
  String rulePass;
  String serialNo;
  String timeOut;
  String token;
  String userId;
  String corpId;
  String versionAppMobile;
  String userName;
  String email;
  String phoneNumber;
  String deviceId;
  String pass;
  String addr;
  String loaiNNT;
  String status;
  String isNC;
  String maCqt;
  String tel;
  // ignore: sort_constructors_first
  LoginResponse(
      {this.ccyFormat ="",
      this.fullName ="",
      this.isFingerLogin ="",
      this.isNoti ="",
      this.isDebtNoti ="",
      this.lastLoginTime ="",
      this.menuList ="",
      this.message ="",
      this.userName ="",
      this.email ="",
      this.phoneNumber ="",
      this.responseCode ="",
      this.ruleMessage ="",
      this.rulePass ="",
      this.serialNo ="",
      this.timeOut ="",
      this.token ="",
      this.userId ="",
      this.corpId ="",
      this.versionAppMobile ="",
      this.deviceId ="",
      this.pass ="",
      this.addr ="",
      this.loaiNNT ="",
      this.status ="",
      this.isNC ="",
      this.maCqt ="",
      this.tel ="",
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      ccyFormat: json['ccyFormat'] ??"",
      fullName: json['fullName'] ??"",
      isFingerLogin: json['isFingerLogin'] ??"",
      isNoti: json['isNoti'] ??"",
      isDebtNoti: json['isDebtNoti'] ??"",
      lastLoginTime: json['lastLoginTime'] ??"",
      menuList: json['menuList'] ??"",
      message: json['message'] ??"",
      responseCode: json['responseCode'] ??"",
      ruleMessage: json['ruleMessage'] ??"",
      rulePass: json['rulePass'] ??"",
      serialNo: json['serialNo'] ??"",
      timeOut: json['timeOut'] ??"",
      userName: json['userName']??"",
      email: json['email']??"",
      phoneNumber: json['tel']??"",
      token: json['token'] ??"",
      userId: json['userId'] ??"",
      corpId: json['corpId'] ??"",
      versionAppMobile: json['versionAppMobile'] ??"",
      deviceId: json['deviceId']??"",
      pass: json['pass'] ??"",
      addr: json['addr'] ??"",
      loaiNNT: json['loaiNNT'] ??"",
      status: json['status'] ??"",
      isNC: json['isNC'] ??"",
      maCqt: json['maCqt'] ??"",
      tel: json['tel'] ??"",
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'isFingerLogin': isFingerLogin,
      'isNoti': isNoti,
      'menuList': menuList,
      'message': message,
      'responseCode': responseCode,
      'ruleMessage': ruleMessage,
      'rulePass': rulePass,
      'serialNo': serialNo,
      'timeOut': timeOut,
      'token': token,
      'userId': userId,
      'versionAppMobile': versionAppMobile,
      'userName': userName,
      'email': email,
      'tel': phoneNumber,
      'deviceId': deviceId,
      'pass': pass,
      'loaiNNT': loaiNNT,
      'status': status,
      'isNC': isNC,
      'maCqt': maCqt,
      'tel': tel,
    };
  }
}
