import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/core/constants/constants.dart';
import 'package:wallet/core/data_local/image_local.dart';
import 'package:wallet/login_model.dart';


class SharePreferUtils {
  static Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.ACCESS_TOKEN)??"";
  }

  static Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.ACCESS_TOKEN, accessToken);
  }

  static Future<void> saveStateRememberPass(bool isRememberPass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.REMEMBERPASS, isRememberPass.toString());
  }

  static Future<bool> getStateRememberPass() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String remember = pref.getString(Constants.REMEMBERPASS) ?? "false";
    return remember == "true";
  }

  // start theme app
  static Future<void> saveTheme(String themeName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.THEME, themeName);
  }

  static Future<String?> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Constants.THEME);
  }

  static Future<String> getCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String code = pref.getString(Constants.CODE)??"";
    return code;
  }

  static Future<void> saveCode(String code) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.CODE, code);
  }
  // end theme app

  static Future<String> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String username = pref.getString(Constants.USERNAME)??"";
    return username;
  }

  static Future<void> saveUsername(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.USERNAME, username);
  }

  static Future<void> removeUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(Constants.USERNAME);
  }

  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String password = pref.getString(Constants.PASSWORD)??"";
    return password;
  }

  static Future<void> savePassword({required String password}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.PASSWORD, password);
  }

  static Future<void> saveFCMToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token" + Constants.TOKEN, token). then((value) => print("token_push 1= $value") );
    return;
  }

  static Future<String> getFCMToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String fcmToken = pref.getString("token" + Constants.TOKEN) ?? "";
    print("token_push 2= $fcmToken");
    return fcmToken;
  }

  static Future<void> saveUserInfo(Map userInfo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userInfo);
    await pref.setString(Constants.USER_INFO, user);
  }

  static Future<LoginResponse?> getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? data = pref.getString(Constants.USER_INFO);
    print(data);
    if (data != null && data.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(data);
      final userInfo = LoginResponse.fromJson(userMap);

      return userInfo;
    }
    return null;
  }

  static Future<void> saveUserInfoFinger(Map userInfo, String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userInfo);
    await pref.setString(userName, user);
  }

  static Future<void> saveUserWithQuickMenu(
      List<Map> quickMenu, String username) async {
    SharedPreferences preferUtils = await SharedPreferences.getInstance();
      await preferUtils.setString(username + "quickMenu", json.encode(quickMenu));
  }

  static Future<List<dynamic>> getUserWithQuickMenu(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(username + "quickMenu");
    // print("preferences ${preferences.getKeys()}");
    List<dynamic> quickMenu = [];
    // print("dataaa $data");
    if (data != null && data.isNotEmpty) {
      quickMenu = json.decode(data);
    }

    return quickMenu;
  }
  //
  // static Future<LoginResponse?> getUserInfoFinger(String userName) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? data = pref.getString(userName);
  //   if (data != null && data.isNotEmpty) {
  //     Map<String, dynamic> userMap = jsonDecode(data);
  //     final userInfo = LoginResponse.fromJson(userMap);
  //     return userInfo;
  //   }
  //   return null;
  // }

  //
  // static void saveListItemHomePage(
  //     List<DetailMainMenuModel> list) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var json = await jsonEncode(list.map((e) => e.toJson()).toList());
  //     await pref.setString(Const.LISTITEMHOMEPAGE, json);
  // }
  //
  // static Future<List<DetailMainMenuModel>> getListItemHomePage() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String data = pref.getString(Const.LISTITEMHOMEPAGE ?? null);
  //   if (data != null) {
  //     Iterable i = jsonDecode(data);
  //     List<DetailMainMenuModel> list = i.map((model) =>
  //         DetailMainMenuModel.fromJson(model)).toList();
  //     return list;
  //   }
  //   return null;
  // }
  //
  // static void saveEKYCListCreateAccount(
  //     List<CreateAccountModel> list) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var json = await jsonEncode(list.map((e) => e.toJson()).toList());
  //   print(json);
  //   await pref.setString(Const.EKYCLISTCREATEACCOUNT, json);
  // }
  //
  // static Future<List<CreateAccountModel>> getEKYCListCreateAccount() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String data = pref.getString(Const.EKYCLISTCREATEACCOUNT ?? null);
  //   if (data != null) {
  //     Iterable i = jsonDecode(data);
  //     List<CreateAccountModel> list = i.map((model) =>
  //         CreateAccountModel.fromJson(model)).toList();
  //     return list;
  //   }
  //   return null;
  // }
  //
  // static void saveEKYCListGetMoney(
  //     List<RegisterMoneyModel> list) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var json = await jsonEncode(list.map((e) => e.toJson()).toList());
  //   print(json);
  //   await pref.setString(Const.EKYCLISTGETMONEY, json);
  // }
  //
  // static Future<List<RegisterMoneyModel>> getEKYCListGetMoney() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String data = pref.getString(Const.EKYCLISTGETMONEY ?? null);
  //   if (data != null) {
  //     Iterable i = jsonDecode(data);
  //     List<RegisterMoneyModel> list = i.map((model) =>
  //         RegisterMoneyModel.fromJson(model)).toList();
  //     return list;
  //   }
  //   return null;
  // }

  static Future<String> getAvatar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? avatar = pref.getString(Constants.Avatar);
    return avatar??"";
  }

  static Future<void> saveAvatar(String avartar) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.Avatar, avartar);
  }

  static Future<void> removeCachedWhenLogOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(Constants.emailKey);
    await preferences.remove(Constants.ACCESS_TOKEN);
    await preferences.remove(Constants.USER_INFO);
    await preferences.setString(Constants.REMEMBERPASS, "false");
    await preferences.remove(Constants.LISTITEMHOMEPAGE);
    await preferences.remove(Constants.USER_INFO);
    await preferences.remove(Constants.TOKEN);
    await preferences.remove(Constants.LISTITEMHOMEPAGE);
    await preferences.remove(Constants.PASSWORD);
    //await preferences.remove(Constants.USERNAME);
    await preferences.remove(Constants.Avatar);
    await preferences.remove(Constants.THONG_TIN_DKT_MODEL);
  }

// start Serial no
  static Future<void> saveSerialNo(String serialNo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.SERIAL_NO, serialNo);
  }

  // ignore: missing_return
  static Future<String> getSerialNo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? data = pref.getString(Constants.SERIAL_NO);
    return data ?? '';
  }

// end Serial no

  static Future<void> saveReadNo(int readNo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(Constants.READ_NO, readNo);
    return;
  }

  static Future<int> getReadNo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int data = pref.getInt(Constants.READ_NO)??0;
      return data;
  }

  static logOutApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(Constants.ACCESS_TOKEN);
    await preferences.remove(Constants.USER_INFO);
    await preferences.remove(Utility.KEY);
    // await preferences.remove(Utility.KEY_CHECK);
    await preferences.remove(Constants.THONG_TIN_DKT_MODEL);
  }
  static LogOut() {

    SharePreferUtils.logOutApp();

  }
  static logOutAppRemoveToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(Constants.emailKey);
    await preferences.remove(Constants.ACCESS_TOKEN);
    await preferences.remove(Constants.USER_INFO);
    await preferences.setString(Constants.REMEMBERPASS, "false");
    await preferences.remove(Constants.LISTITEMHOMEPAGE);
    await preferences.remove(Constants.USER_INFO);
    await preferences.remove(Constants.TOKEN);
    await preferences.remove(Constants.LISTITEMHOMEPAGE);
    await preferences.remove(Constants.PASSWORD);
    await preferences.remove(Constants.USERNAME);
    await preferences.remove(Constants.Avatar);
  }

  static Future<void> saveInit05(Map thongTinDkTModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = jsonEncode(thongTinDkTModel);
    await pref.setString(Constants.THONG_TIN_DKT_MODEL, user);
  }
  //
  // static Future<ThongTinDkTModel?> getInit05() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String data = pref.getString(Constants.THONG_TIN_DKT_MODEL)??"";
  //   if(data.isNotEmpty){
  //     print(data);
  //     Map<String,dynamic> thongTinDKTMap = jsonDecode(data);
  //     final thongTinDkTModel = ThongTinDkTModel.fromJson(thongTinDKTMap);
  //     return thongTinDkTModel;
  //   }
  //  return null;
  // }
}
