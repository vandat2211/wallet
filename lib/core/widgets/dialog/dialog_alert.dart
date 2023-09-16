import 'dart:async';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_autofill/otp_autofill.dart';

import 'package:path_provider/path_provider.dart';

import 'package:wallet/core/styles.dart';
import 'package:wallet/core/widgets/core_toast.dart';


typedef ValueOtp<String> = String Function(String);

class DialogAlert {
  // ignore: inference_failure_on_function_return_type
  static showMLoadding(BuildContext context) {
    // ignore: inference_failure_on_function_return_type
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ],
            ),
          );
        });
  }
  // ignore: inference_failure_on_function_return_type
  static dissmissLoadingDialog(BuildContext context, GlobalKey key) {
    Navigator.of(context).pop();
  }
  static showMLoaddingDelay(BuildContext context) {
    // ignore: inference_failure_on_function_return_type
    new Future.delayed(new Duration(seconds: 3), () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ],
              ),
            );
          });
    });
  }
  static showMDialogOTP(
      String messanger, BuildContext context, ValueOtp valueOtp,
      {bool visibleInput = false}) {
    OTPTextEditController controller = OTPTextEditController(
      codeLength: 8,
      onCodeReceive: (code) => print('Your Application receive code - $code'),
    )..startListenUserConsent(
          (code) {//Chỗ này đang regex chuỗi có 3 ký tự là số (test để 3, thật để 8)
        final exp = RegExp(r'(\d{8})');
        return exp.stringMatch(code ?? '') ?? '';
      },
    );
    final otpController = controller ?? TextEditingController();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)), //this right here
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  Padding(
                      padding: EdgeInsets.only(top: 8),
                      // child: Container(
                      //   height: height_100,
                      child: Center(
                        child: Text(
                              'Vui lòng nhập mã OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.black, fontSize: 14,fontWeight: FontWeight.bold)),
                      )),
                  // ),
                  visibleInput == true
                      ? Expanded(
                    child: Container(
                        child: Center(
                          child: Text(
                            messanger,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  )
                      : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      // margin: EdgeInsets.only(bottom: 30.h),
                      child: TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9,-]'))
                        ],
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          labelText: "OTP",
                          fillColor: AppColors.white,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.accent,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.accent,
                              width: 0.5,
                            ),
                          ),
                          labelStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 14),
                        ),
                        controller: otpController,
                        keyboardType: TextInputType.number,
                      )),

                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: TextButton(
                                // color: blueAccent,
                                  onPressed: () {
                                    controller.stopListen();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancle",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  )),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: TextButton(
                            // color: blueAccent,
                              onPressed: () {
                                if (visibleInput == false) {
                                  if (otpController.text != "") {
                                    valueOtp(otpController.text);
                                    Navigator.of(context)
                                        .pop({otpController.text});
                                  } else {
                                    Toast.showLong('Vui lòng nhập mã OTP');
                                  }
                                } else {
                                  controller.stopListen();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                 "Ok",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }


//  alert dành cho nhập otp login
  // ignore: inference_failure_on_function_return_type
  // static showMDialogMST(
  //     String messanger, BuildContext context, ValueOtp valueOtp, List<String> list) {
  //   var mstSelected = "";
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           // backgroundColor: Colors.blue,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)), //this right here
  //           child: Container(
  //             // height: MediaQuery.of(context).size.height * 0.25,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: <Widget>[
  //                 Padding(
  //                     padding: EdgeInsets.only(top: height_32, bottom: height_32),
  //                     // child: Container(
  //                     //   height: height_100,
  //                     child: Center(
  //                       child: Text(
  //                           Public().languageCustom(
  //                             'Vui lòng chọn mã số thuế',
  //                           ),
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(color: colorBlack, fontSize: fontSize_38sp,fontWeight: FontWeight.bold)),
  //                     )),
  //                 // DropdownSearch()
  //                 DropdownSearch<String>(
  //                   // hint: "Chọn mã số thuế",
  //                   // mode: Mode.MENU,
  //                   // showSelectedItem: true,
  //                   // dropdownSearchDecoration: InputDecoration(border: InputBorder.none),
  //                   items: list,
  //                   onChanged: (values) {
  //                     print("++++++++++values: $values}");
  //                     mstSelected = values!;
  //                   },
  //                 ),
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Colors.grey),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       Container(
  //                         child: Flexible(
  //                           flex: 1,
  //                           fit: FlexFit.tight,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 right: BorderSide(color: Colors.grey),
  //                               ),
  //                             ),
  //                             child: TextButton(
  //                               // color: blueAccent,
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 child: Text(
  //                                   AppTranslate.of(context)
  //                                       .translate('common.cancel'),
  //                                   style: TextStyle(
  //                                       fontSize: fontSize_38sp,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Theme.of(context).primaryColor),
  //                                 )),
  //                           ),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                           // color: blueAccent,
  //                             onPressed: () {
  //                               if (mstSelected != "") {
  //                                 valueOtp(mstSelected);
  //                                 Navigator.of(context)
  //                                     .pop({mstSelected});
  //                               } else {
  //                                 Toast.showLong(AppTranslate.of(context)
  //                                     .translate('Vui lòng chọn mã số thuế'));
  //                               }
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  //
  // static showMDialogOtpMOMO(BuildContext context, ValueOtp valueOtp, {Function? onCancel}) {
  //   final otpController = TextEditingController();
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           // backgroundColor: Colors.blue,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)), //this right here
  //           child: Container(
  //             // height: MediaQuery.of(context).size.height * 0.25,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: <Widget>[
  //                 // SizedBox(
  //                 //   height: 20.h,
  //                 // ),
  //                 Padding(
  //                     padding: EdgeInsets.only(top: 8),
  //                     // child: Container(
  //                     //   height: height_100,
  //                     child: Center(
  //                       child: Text(
  //                           Public().languageCustom(
  //                             'Vui lòng nhập mã OTP',
  //                           ),
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(color: colorBlack, fontSize: fontSize_38sp,fontWeight: FontWeight.bold)),
  //                     )),
  //                 // ),
  //                 Padding(
  //                     padding: EdgeInsets.symmetric(
  //                         vertical: height_16, horizontal: width24),
  //                     // margin: EdgeInsets.only(bottom: 30.h),
  //                     child: TextField(
  //                       inputFormatters: <TextInputFormatter>[
  //                         FilteringTextInputFormatter.allow(
  //                             RegExp(r'[0-9,-]'))
  //                       ],
  //                       style: TextStyle(color: Colors.black, fontSize: fontSize_38sp),
  //                       decoration: InputDecoration(
  //                         labelText: "Nhập OTP",
  //                         fillColor: colorPrimaryLogin,
  //                         enabledBorder: const UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                             color: colorPrimaryLogin,
  //                             width: 0.5,
  //                           ),
  //                         ),
  //                         focusedBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                             color: colorPrimaryLogin,
  //                             width: 0.5,
  //                           ),
  //                         ),
  //                         labelStyle: TextStyle(
  //                             color: colorBlack,
  //                             fontSize: fontSize_38sp),
  //                       ),
  //                       controller: otpController,
  //                       keyboardType: TextInputType.number,
  //                     )),
  //
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Colors.grey),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       // ignore: avoid_unnecessary_containers
  //                       Container(
  //                         child: Flexible(
  //                           flex: 1,
  //                           fit: FlexFit.tight,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 right: BorderSide(color: Colors.grey),
  //                               ),
  //                             ),
  //                             child: TextButton(
  //                               // color: blueAccent,
  //                                 onPressed: (){
  //                                   Navigator.of(context).pop();
  //                                   onCancel!();
  //                                 },
  //                                 child: Text(
  //                                   AppTranslate.of(context)
  //                                       .translate('common.cancel'),
  //                                   style: TextStyle(
  //                                       fontSize: fontSize_38sp,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Theme.of(context).primaryColor),
  //                                 )),
  //                           ),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                           // color: blueAccent,
  //                             onPressed: () {
  //                               if (otpController.text != "") {
  //                                 Navigator.of(context)
  //                                     .pop({otpController.text});
  //                                 valueOtp(otpController.text);
  //                               } else {
  //                                 Toast.showLong(AppTranslate.of(context)
  //                                     .translate('Vui lòng nhập mã OTP'));
  //                               }
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static logOut(BuildContext context) {
  //   // ignore: inference_failure_on_function_return_type
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           // backgroundColor: Colors.blue,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)), //this right here
  //           child: Container(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: height_24,
  //                 ),
  //                 Container(
  //                     // margin: EdgeInsets.symmetric(horizontal: 100.w),
  //                     child: Center(
  //                         child: Column(children: <Widget>[
  //                   Text(
  //                     "Bạn muốn đăng xuất tài khoản này ?",
  //                     textAlign: TextAlign.center,
  //                     style: text_big_bold_black,
  //                   ),
  //                   SizedBox(
  //                     height: height36,
  //                   ),
  //                   Text(
  //                     "Đăng xuất !",
  //                     textAlign: TextAlign.center,
  //                     style: text_default_black,
  //                   ),
  //                 ]))),
  //                 SizedBox(
  //                   height: height_50,
  //                 ),
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Theme.of(context).primaryColor),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       // ignore: avoid_unnecessary_containers
  //                       Container(
  //                         child: Flexible(
  //                           flex: 1,
  //                           fit: FlexFit.tight,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 right: BorderSide(
  //                                     color: Theme.of(context).primaryColor),
  //                               ),
  //                             ),
  //                             child: TextButton(
  //                                 // color: blueAccent,
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 child: Text(
  //                                   AppTranslate.of(context)
  //                                       .translate('common.cancel'),
  //                                   style: TextStyle(
  //                                       fontSize: fontSize_38sp,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Theme.of(context).primaryColor),
  //                                 )),
  //                           ),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                             onPressed: () {
  //                               // menu cũng phai update lại về là menu ngoài login
  //
  //                               SharePreferUtils.logOutApp();
  //                               //  đồng ý thoát app xóa các trang cũ đi
  //                               Phoenix.rebirth(context);
  //                               // if(Platform.isAndroid){
  //                               //   Phoenix.rebirth(context);
  //                               // }else {
  //                               //   NavigatesApp.pushReplacementNamed(context, LoginScreen.routeName);
  //                               // }
  //                               Provider.of<MenuNotifier>(context,
  //                                       listen: false)
  //                                   .setListMenu([]);
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static void showDialogAuthenticateFinger(
  //   BuildContext context, {
  //   String? title,
  //   String? message,
  //   bool? haveButton,
  //   TextStyle? styleTitle,
  //   bool? fingerPrintDisable,
  // }) {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: Container(
  //           margin: EdgeInsets.only(left: 27.w, right: 27.h),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               SizedBox(
  //                 height: ScreenUtil().setHeight(36.8),
  //               ),
  //               Image.asset(
  //                 fingerPrintDisable??false
  //                     ? "asset/images/ic_finger_disable.png"
  //                     : "asset/images/ic_finger_enable.png",
  //                 width: 171.2.w,
  //                 height: 171.2.h,
  //               ),
  //               SizedBox(
  //                 height: ScreenUtil().setHeight(4.0),
  //               ),
  //               Text(
  //                 title??"",
  //                 style: styleTitle,
  //               ),
  //               SizedBox(
  //                 height: ScreenUtil().setHeight(18.0),
  //               ),
  //               Container(
  //                 child: Text(
  //                   message??"",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: fontSize_38sp,
  //                       // ScreenUtil().setSp(40.0),
  //                       fontWeight: FontWeight.normal),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: ScreenUtil().setHeight(54.6),
  //               ),
  //               haveButton??false
  //                   ? Container(
  //                       height: ScreenUtil().setHeight(1.0),
  //                       width: ScreenUtil().setWidth(889.0),
  //                       color: Color(0xff0959ca7),
  //                     )
  //                   : Container(),
  //               haveButton??false
  //                   ? Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: <Widget>[
  //                         Expanded(
  //                           child: InkWell(
  //                             child: Container(
  //                               height: 187.5.h,
  //                               child: Center(
  //                                 child: Text(
  //                                   "Hủy",
  //                                   style: TextStyle(
  //                                       color: Color(0xff959ca7),
  //                                       fontSize: ScreenUtil().setSp(50.0),
  //                                       fontWeight: FontWeight.normal),
  //                                   textAlign: TextAlign.center,
  //                                 ),
  //                               ),
  //                             ),
  //                             onTap: () {
  //                               Navigator.of(context).pop();
  //                             },
  //                           ),
  //                         )
  //                       ],
  //                     )
  //                   : Container(
  //                       height: 90.h,
  //                     ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // static void showDialogAuthenticateFingerprint(
  //     BuildContext context, bool statusFingerPrintKey, String currenPage) {
  //   showDialog(
  //       barrierDismissible: true,
  //       context: context,
  //       builder: (buildContext) {
  //         return Dialog(
  //           insetAnimationCurve: Curves.bounceIn,
  //           backgroundColor: Colors.white,
  //           child: FingerprintWidget(
  //               loginNotifier: Provider.of<LoginNotifier>(context),
  //               pageCurrent: currenPage),
  //         );
  //       });
  // }
  //
  static void showDialogAlertCancel(BuildContext context, String content) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)), //this right here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Center(
                    child: Text(
                        "Thoong bao",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Center(
                    child: Text(
                     content,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.black, fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(
                                "OK",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
  //
  // static void showDialogAlertPaymentSuccess(BuildContext context, String content, {Function? onOk,  bool? disable}) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width_40)), //this right here
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               // SizedBox(
  //               //   height: 5.h,
  //               // ),
  //               Padding(
  //                 padding: EdgeInsets.only(top: 8),
  //                 child: Center(
  //                   child: Text(
  //                       Public().languageCustom(
  //                         'fingerprint.notif',
  //                       ),
  //                       style: TextStyle(
  //                         fontSize: fontSize_38sp,
  //                         fontWeight: FontWeight.bold,
  //                       )),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 25.h,
  //               ),
  //               Container(
  //                 margin: EdgeInsets.symmetric(horizontal: 16),
  //                 child: Center(
  //                   child: Text(
  //                     Public().languageCustom(
  //                       content,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                     style: text_default_black,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 25.h,
  //               ),
  //               Container(
  //                 height: height_100,
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                     top: BorderSide(color: Colors.grey),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: <Widget>[
  //                     Flexible(
  //                       flex: 1,
  //                       fit: FlexFit.tight,
  //                       child: TextButton(
  //                           onPressed: () {
  //                             NavigatesApp.pop(context);
  //                             onOk!();
  //                           },
  //                           child: Text(
  //                               AppTranslate.of(context)
  //                                   .translate('common.ok'),
  //                               style: TextStyle(
  //                                   fontSize: fontSize_38sp,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Theme.of(context).primaryColor))),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
  //
  // static void showDialogStatusFinger(BuildContext context, String content) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8.w)), //this right here
  //           child: SizedBox(
  //             height: 500.h,
  //             width: MediaQuery.of(context).size.width,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Text(
  //                     Public().languageCustom(
  //                       'fingerprint.title_popup',
  //                     ),
  //                     style: TextStyle(
  //                         fontSize: 50.sp, fontWeight: FontWeight.bold)),
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 100.w),
  //                   child: Center(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(100),
  //                               color: Colors.blueGrey,
  //                               // boxShadow: [
  //                               //   BoxShadow(
  //                               //       color: Colors.green, spreadRadius: 3),
  //                               // ],
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(40.w),
  //                               child: Icon(
  //                                 Icons.fingerprint,
  //                                 size: 150.sp,
  //                                 color: Colors.white,
  //                               ),
  //                             )),
  //                         SizedBox(
  //                           height: 20.h,
  //                         ),
  //                         // Text(Public().languageCustom(content, context)),
  //                         Text('van tay chua dung '),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Container(
  //                   height: height_100,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             border: Border(
  //                               top: BorderSide(color: Colors.grey),
  //                             ),
  //                           ),
  //                           child: TextButton(
  //                               onPressed: () {
  //                                 NavigatesApp.pop(context);
  //                               },
  //                               child: Text(
  //                                   AppTranslate.of(context)
  //                                       .translate('fingerprint.cancel_bt'),
  //                                   style: TextStyle(
  //                                       fontSize: 50.sp,
  //                                       fontWeight: FontWeight.bold,
  //                                       color:
  //                                           Theme.of(context).primaryColor))),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static void showDialogAlertCancelBackHome(
  //     BuildContext context, String content) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(40.w)), //this right here
  //           child: SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.3,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Text(
  //                     Public().languageCustom(
  //                       'fingerprint.notif',
  //                     ),
  //                     style: TextStyle(
  //                       fontSize: fontSize_38sp,
  //                       fontWeight: FontWeight.bold,
  //                     )),
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 100.w),
  //                   child: Center(
  //                     child: Text(
  //                       Public().languageCustom(
  //                         content,
  //                       ),
  //                       style: text_default_black,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 30.h,
  //                 ),
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Colors.grey),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                             onPressed: () {
  //                               Navigator.pushNamed(
  //                                   context, LoginScreen.routeName);
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static Future<void> showDialogUtil(String alert, BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           // backgroundColor: Colors.blue,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)),
  //           //this right here
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               SizedBox(
  //                 height: 10.h,
  //               ),
  //               Container(
  //                 // margin: EdgeInsets.symmetric(horizontal: 100.w),
  //                   child: Center(
  //                       child: Column(children: <Widget>[
  //                         Text(
  //                           "Thông báo",
  //                           textAlign: TextAlign.center,
  //                           style: text_big_bold_black,
  //                         ),
  //                         SizedBox(
  //                           height: width_40,
  //                         ),
  //                         Text(
  //                           alert,
  //                           textAlign: TextAlign.center,
  //                           style: text_default_red_normal_size,
  //                         ),
  //                       ]))),
  //               SizedBox(
  //                 height: 20.h,
  //               ),
  //               Container(
  //                 height: height_100,
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                     top: BorderSide(
  //                         color: Theme.of(context).primaryColor),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: <Widget>[
  //                     // ignore: avoid_unnecessary_containers
  //                     Container(
  //                       child: Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: Container(
  //                           child: TextButton(
  //                             // color: blueAccent,
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                               child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.cancel'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context)
  //                                         .primaryColor),
  //                               )),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
  //
  //
  // static showDialogAction(BuildContext context, String linkUrl, String maThamChieu, String type) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           // backgroundColor: Colors.blue,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)), //this right here
  //           child: Container(
  //             height: height_350,
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: width_40,
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     // margin: EdgeInsets.symmetric(horizontal: 100.w),
  //                       child: Center(
  //                           child: Column(children: <Widget>[
  //                             Text(type == 'VERSION' ? "Yêu cầu cập nhật" :
  //                               "Bạn có muốn tải tập tin?",
  //                               textAlign: TextAlign.center,
  //                               style: text_big_bold_black,
  //                             ),
  //                             SizedBox(
  //                               height: width_40,
  //                             ),
  //                             Text(type == 'VERSION' ? "Cập nhật phiên bản mới để khám phá & trải nghiệm những tính năng mới trên eTax Mobile" :
  //                               "Tải ngay!",
  //                               textAlign: TextAlign.center,
  //                               style: text_default_black,
  //                             ),
  //                           ]))),
  //                 ),
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Theme.of(context).primaryColor),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       // ignore: avoid_unnecessary_containers
  //                       Container(
  //                         child: Flexible(
  //                           flex: 1,
  //                           fit: FlexFit.tight,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 right: BorderSide(
  //                                     color: Theme.of(context).primaryColor),
  //                               ),
  //                             ),
  //                             child: TextButton(
  //                               // color: blueAccent,
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 child: Text(
  //                                   AppTranslate.of(context)
  //                                       .translate('common.cancel'),
  //                                   style: TextStyle(
  //                                       fontSize: fontSize_38sp,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Theme.of(context).primaryColor),
  //                                 )),
  //                           ),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                             onPressed: () async {
  //                               if(type == 'VERSION'){
  //                                 StoreRedirect.redirect(
  //                                     androidAppId: linkUrl,
  //                                     iOSAppId: '1589750682');
  //                                 // await launch("https://play.google.com/store/apps/details?id=$link_url");
  //                                 // Navigator.of(context).pop();
  //                               }else
  //                                 DialogAlert.showMLoadding(context);
  //                                 downloadFileOfPdfUrl(context, linkUrl, maThamChieu);
  //
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static showDialogActionRequired(BuildContext context, String linkUrl) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)),
  //           child: Container(
  //             height: height_350,
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: width_40,
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                       child: Center(
  //                           child: Column(children: <Widget>[
  //                             Text("Yêu cầu cập nhật",
  //                               textAlign: TextAlign.center,
  //                               style: text_big_bold_black,
  //                             ),
  //                             SizedBox(
  //                               height: width_40,
  //                             ),
  //                             Text("Cập nhật phiên bản mới để khám phá & trải nghiệm những tính năng mới trên eTax Mobile",
  //                               textAlign: TextAlign.center,
  //                               style: text_default_black,
  //                             ),
  //                           ]))),
  //                 ),
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Theme.of(context).primaryColor),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                             onPressed: () async {
  //                               print("======link_url: $linkUrl");
  //                               StoreRedirect.redirect(
  //                                   androidAppId: linkUrl,
  //                                   iOSAppId: '1589750682');
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static Future<File> downloadFileOfPdfUrl(BuildContext context, String linkUrl, String maThamChieu) async {
  //   Completer<File> completer = Completer();
  //   print("Start download file from internet!");
  //   try {
  //     final url = linkUrl;
  //     // final filename = url.substring(url.lastIndexOf("/") + 1);
  //     var request = await HttpClient().getUrl(Uri.parse(url));
  //     var response = await request.close();
  //     var bytes = await consolidateHttpClientResponseBytes(response);
  //     Directory? directory;
  //     if (Platform.isAndroid) {
  //       directory=await getExternalStorageDirectory();
  //     } else if (Platform.isIOS) {
  //       directory=await getApplicationDocumentsDirectory();
  //     }
  //     // var dir = await getExternalStorageDirectory();
  //     File file = File("${directory?.path}/$maThamChieu.pdf");
  //     await file.writeAsBytes(bytes, flush: true);
  //     OpenFile.open(file.path);
  //     // completer.complete(file);
  //     DialogAlert.dissmissLoadingDialog(context, GlobalKey());
  //     Navigator.of(context).pop();
  //   } catch (e) {
  //     DialogAlert.dissmissLoadingDialog(context, GlobalKey());
  //     Navigator.of(context).pop();
  //     throw Exception('Error parsing asset file!');
  //   }
  //
  //   return completer.future;
  // }
  //
  //
  // static void showDialogAlertConfirm(BuildContext context, String content, {Function? onOk, Function? onCancel}) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width_40)), //this right here
  //           child: SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.2,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 // SizedBox(
  //                 //   height: 5.h,
  //                 // ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 8),
  //                   child: Center(
  //                     child: Text(
  //                         Public().languageCustom(
  //                           'fingerprint.notif',
  //                         ),
  //                         style: TextStyle(
  //                           fontSize: fontSize_38sp,
  //                           fontWeight: FontWeight.bold,
  //                         )),
  //                   ),
  //                 ),
  //                 // SizedBox(
  //                 //   height: 20.h,
  //                 // ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 16),
  //                   child: Center(
  //                     child: Text(
  //                       Public().languageCustom(
  //                         content,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                       style: text_default_black,
  //                     ),
  //                   ),
  //                 ),
  //                 // SizedBox(
  //                 //   height: 30.h,
  //                 // ),
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Colors.grey),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             border: Border(
  //                               right: BorderSide(
  //                                   color: Theme.of(context).primaryColor),
  //                             ),
  //                           ),
  //                           child: TextButton(
  //                             // color: blueAccent,
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                                 onCancel!();
  //                               },
  //                               child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.cancel'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor),
  //                               )),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                             onPressed: () {
  //                               NavigatesApp.pop(context);
  //                               onOk!();
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  //
  // static showMDialogDeleteAccount(BuildContext context, String content, ValueOtp valueOtp) {
  //   final otpController = TextEditingController();
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           // backgroundColor: Colors.blue,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(width24)), //this right here
  //           child: Container(
  //             // height: MediaQuery.of(context).size.height * 0.25,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: <Widget>[
  //
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 8, bottom: 8),
  //                   child: Center(
  //                     child: Text(
  //                         Public().languageCustom(
  //                           'fingerprint.notif',
  //                         ),
  //                         style: TextStyle(
  //                           fontSize: fontSize_38sp,
  //                           fontWeight: FontWeight.bold,
  //                         )),
  //                   ),
  //                 ),
  //
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 16),
  //                   child: Center(
  //                     child: Text(
  //                       Public().languageCustom(
  //                         content,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                       style: text_default_black,
  //                     ),
  //                   ),
  //                 ),
  //
  //                 Padding(
  //                     padding: EdgeInsets.symmetric(
  //                         vertical: 16.w, horizontal: 16.h),
  //                     // margin: EdgeInsets.only(bottom: 30.h),
  //                     child: TextField(
  //                       style: TextStyle(color: Colors.black, fontSize: fontSize_38sp),
  //                       decoration: InputDecoration(
  //                         labelText: "Nhập lý do",
  //                         fillColor: colorPrimaryLogin,
  //                         enabledBorder: const UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                             color: colorPrimaryLogin,
  //                             width: 0.5,
  //                           ),
  //                         ),
  //                         focusedBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                             color: colorPrimaryLogin,
  //                             width: 0.5,
  //                           ),
  //                         ),
  //                         labelStyle: TextStyle(
  //                             color: colorBlack,
  //                             fontSize: fontSize_38sp),
  //                       ),
  //                       controller: otpController,
  //                       keyboardType: TextInputType.text,
  //                     )),
  //
  //                 Container(
  //                   height: height_100,
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(color: Colors.grey),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       // ignore: avoid_unnecessary_containers
  //                       Container(
  //                         child: Flexible(
  //                           flex: 1,
  //                           fit: FlexFit.tight,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               border: Border(
  //                                 right: BorderSide(color: Colors.grey),
  //                               ),
  //                             ),
  //                             child: TextButton(
  //                               // color: blueAccent,
  //                                 onPressed: (){
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 child: Text(
  //                                   AppTranslate.of(context)
  //                                       .translate('common.cancel'),
  //                                   style: TextStyle(
  //                                       fontSize: fontSize_38sp,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Theme.of(context).primaryColor),
  //                                 )),
  //                           ),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: TextButton(
  //                           // color: blueAccent,
  //                             onPressed: () {
  //                               if (otpController.text != "") {
  //                                 Navigator.of(context)
  //                                     .pop({otpController.text});
  //                                 valueOtp(otpController.text);
  //                               } else {
  //                                 Toast.showLongTop(AppTranslate.of(context)
  //                                     .translate('Vui lòng nhập lý do'));
  //                               }
  //                             },
  //                             child: Text(
  //                                 AppTranslate.of(context)
  //                                     .translate('common.ok'),
  //                                 style: TextStyle(
  //                                     fontSize: fontSize_38sp,
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Theme.of(context).primaryColor))),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
