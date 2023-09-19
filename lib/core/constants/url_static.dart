
class UrlStatic {
  static const String API_AUTHENTICATION = '/api/authentication';
  static const String API_AUTHENTICATION_FINGER = '/api/loginFinger';
  static const String API_AUTHENTICATION_BCA = '/api/authenticationBCA';
  static const String API_LOGIN_BCA = '/api/loginBCA';
  static const String API_MENULIST = '/api/inquiryMenuList';

  // tra cuu thong bao
  static const URI_DANHMUCTBAO = "/api/dmucTBao";
  static const URI_TRACUU_THONGBAO = "/api/lookupTBao";
  static const URI_TRACUU_CHITIET_THONGBAO = "/api/lookupdetailTBao";
  static const URI_TRACUU_PDF_THONGBAO = "/api/downloadTBao";
  static const URI_DANHMUC_COQUANTHUE_THONGBAO = "/api/DmucTBaoNoThueChamNop";
  static const URI_TRACUU_COQUANTHUE_THONGBAO = "/api/lookupTBaoNoThueChamNop";
  static const URI_DOWNLOAD_THONGBAO_COQUANTHUE = "/api/downloadTBaoNoThueChamNop";

  //tra cuu nop thua
  static const URI_TRACUU_CHUNG_TU_NO_THUE = "/api/lookupChungTuXLNT";

  static const URI_TIEP_TUC_CHUNG_TU_XLNT = "/api/HoanThanhChungTuXLNT";
  static const URI_CHUNG_TU_XLNT_OTP = "/api/checkOtp";
  static const URI_UPLOAD_FILE_GTBS = "/api/UploadGTBS";
  static const URI_CHECK_CHAPTER = "/api/kiemTraChuong";
  static const URI_CHI_TIET_KHOAN_NOP = "/api/buildPdf";

  // register notification
  static const URI_REGISTER_NOTIFICATION = "/api/registerPush";

  // so thue truoc ba nha dat
  static const URI_TRACUU_SOTHUE_TRUOCBA_NHADAT = "/api/taxserviceLPTBND";

  //so thue truoc ba o to xe may
  static const URI_TRACUU_TRUOCBA_OTOXEMAY = "/api/taxserviceLPTBOto";

  // tra cuu dia chi CQT
  static const URI_TRACUU_DIACHI_CQT = "/api/diachiCQT";
  static const URI_TRACUU_CUCTHUE = "/api/dmucCucThue";
  static const URI_TRACUU_CHICUCTHUE = "/api/dmucChiCucThue";
  static const URI_TRACUU_CHICUCTHUE_DNXLNT = "/api/dmucChiCucThueDNXLNT";

  // tra cuu ho so de nghi bu tru
  static const URI_TRACUU_HOSO_DENGHI_BUTRU = "/api/DsachBtruNthua";
  static const URI_GET_TRANGTHAI_BUTRU = "/api/getTthaiBtru";
  static const URI_GET_DETAIL_HS_BUTRU = "/api/lookupdetailDNXLNT";


  //ĐỔI MẬT KHẨU
  static const String URI_CHANGE_PASSWORD = '/api/changePassNNT';
  static const String URI_CHANGE_SECRET_CODE = '/api/changeSecretCode';
  static const String URI_STOP_SERVICE = '/api/stopService';

  //api tra cứu tờ khai đăng ký thuế
  static const String URI_GET_LOOKUP_TKDKT = "/api/lookupTKDKT";
  //api tra cứu tờ khai chi tiết thuế
  static const String URI_GET_LOOKUP_DETAIL_TKDKT = "/api/lookupdetailTKDKT";
  //api lấy danh mục tờ khai
  static const String URI_GET_LIST_TK = "/api/dmucTK";

  static const String URI_GET_LOOKUP_TKLPTB = "/api/lookupTKLPTB";
  static const String URI_GET_LOOKUP_DETAIL_TKLPTB = "/api/lookupdetailTKLPTB";
  // api to tra cứu hồ sơ tờ khai quyết toán thuế
  static const String URI_GET_LOOKUP_TKQTT = "/api/lookupTKQTT";
  static const String URI_GET_LOOKUP_DETAIL_TKQTT = "/api/lookupdetailTKQTT";
  // api tra cứu phiên bản HTTK và phiên bản itakviewer
  static const String URL_GET_LOOKUP_TCPBHTTK = "/api/downloadVerItaxviewer";
  // api tra tin tức
  static const String URI_GET_LOOKUP_TT = "/api/lookupNews";
  //api chi tiết tin tức
  static const String URI_GET_LOOKUP_DETAIL_TT = "/api/lookupNewsDetail";

  static const String URI_GET_DMUCTK_API = "/api/dmucTK";
  static const String URI_GET_LOOKUP_TK = "/api/lookupTK";
  static const String URI_TRACUU_CHITIET_TK = "/api/lookupdetailTK";
  static const String URI_THONGTIN_HOTRO = "/api/userinfo";

  //get thong tin user
  static const String URI_GET_USER_API = "/api/userinfo";
  //lay pdf chi tiet to khai
  static const String URI_DOWLOAD_TK = "/api/downloadTK";
  static const String URI_GET_NNT_API = "/api/lookupTinGip";
  static const String URI_GET_PDF_BK_API = "/api/downloadBKe";
  static const String URI_GET_PDF_TK_API = "/api/downloadTK";
  static const String URI_GET_PDF_TB_API = "/api/downloadTBao";
  static const String URI_GET_SO_THUE_CANHAN = "/api/taxserviceSoThueCN";
  static const String URI_GET_SO_THUE_NVT = "/api/taxserviceSoThueNVT";
  //tra cuu nguoi phu thuoc
  static const String URI_GET_NGUOI_PHU_THUOC = "/api/nptinfo";

  //tra cuu ho so dat
  static const String URI_GET_HO_SO_DAT_DAI = "/api/lookupHSoDat";
  static const String URI_LAY_OTP_DK_VAN_TAY = "/api/registerFinger";
  static const String URI_XNHAN_DK_VAN_TAY = "/api/confirmRegisterFinger";
  // quên mật khẩu
  static const String URI_LAY_OTP_QUEN_MK = "/api/initResetPassNNT";
  static const String URI_QUEN_MK = "/api/resetPassNNT";
  // hòm thư
  static const String PUSH_INFO = "/api/pushInfo";
  static const String PUSH_DETAIL_INFO = "/api/pushDetailInfo";
  //danh sách ngân hàng nộp thuế
  static const String SHOW_LIST_BANK = "/api/dmucNganHang";
  static const String URI_NGANHANG_NTDT = "/api/dmucNganHangNTDT";

  //dang ky moi
  static const String URI_REGISTER_B1 = "/api/initRegister";
  static const String URI_REGISTER_B2 = "/api/confirmRegister";
  static const String URI_REGISTER_B3 = "/api/finalRegister";
  static const String URI_VIEW_DETAIL_REGISTER = "/api/getContentFile";
  static const String URI_DMUC_NH_AuthExt = "/api/dmucNHAuthExt";

  //dang ky moi thay doi thong tin
  static const String URI_REGISTER_B1_TDTT = "/api/initRegisterAndTdttDKT";
  static const String URI_REGISTER_B2_TDTT = "/api/confirmRegisterTDTT";
  static const String URI_REGISTER_B3_TDTT = "/api/finalRegister";

  //danh muc ngan hang UNT
  static const String URI_NGANHANG_UNT = "/api/dmucNganHangUNT";
  static const String URI_DMUCTINH = "/api/dmucTinh";
  static const String URI_SHOW_NGANHANG_UNT = "/api/lookupNHangUNT";
  static const String URI_SHOW_CQT = "/api/dmucCoQuanThue";

  //api chức năng lập giấy nộp tiền
  static const String URI_DANH_MUC_CHON = "/api/dmucChon";
  static const String URI_DANH_MUC_TO_KHAI = "/api/dmucTK";
  static const String URI_DANH_MUC_KHO_BAC = "/api/dmucKhoBac";
  static const String URI_CHECK_SO_THUE = "/api/checkSoThue";
  static const String URI_CHECK_SO_THUE_NOP_THAY = "/api/checkSoThueNopThay";

  static const String URI_GET_DMUC_CCTNT = "/api/dmucChiCucThueNT";
  static const String URI_GET_DMUC_TK_NOP_THUE = "/api/dmucTKNopThue";
  static const String URI_GET_TDTN = "/api/taxserviceTDTN";
  static const String URI_GET_ID_KNOP = "/api/taxserviceSoThueNopThay";
  static const String URI_GET_DMUC_THEO_TO_KHAI = "/api/dmucMaMucNT";
  static const String URI_GET_TMUC_THEO_TO_KHAI = "/api/dmucTieuMucNT";

  //Thay đổi thông tin đăng ký thuế

  static const String URI_INIT_TMAU05 = "/api/init08MSTmau05";
  static const String URI_SUCCES_TMAU05 = "/api/hoanthanh08MSTmau05";

  static const String URI_GET_OTP_TMAU05 = "/api/getOTP08MST";
  static const String URI_SEND_OTP_TMAU05 = "/api/noptokhai08MSTmau05";
  static const String URI_GET_TTIN_BCA = "/api/getTtinBca08MST";
  // phan hoi hkd
  static const String URI_GET_LAY_THONG_TIN_HKD = "/api/layThongTinHKD";
  static const String URI_GET_DMUC_NGANH_NGHE = "/api/getDmucNngheCNKD";
  static const String URI_SEND_PHAN_HOI = "/api/guiPhanHoiHKD";

  static const String URI_GET_TTIN_BCA_MAU03 = "/api/getTtinBca08MSTmau03";

  // Thay đổi thông tin đăng ký thuế hộ kinh doanh.

  static const String URI_INIT_TMAU03 = "/api/init08MSTmau03";
  static const String URI_SUCCES_TMAU03 = "/api/hoanthanh08MSTmau03";
  static const String URI_GET_OTP_TMAU03 = "/api/getOTP08MST";
  static const String URI_NOP_TK_MAU03 = "/api/noptokhai08MSTmau03";

  static const String URI_DMUC_NGHANH_NGHE = "/api/getDmucnnghe";
  static const String URI_DMUC_QUOC_GIA = "/api/dmucQuocGia";
  static const String pokemon = "?offset=0&limit=40";
}
