class StatusApi {
// Error

  static const String SERVE_RESPONSE_TEXT_ERROR500 = 'ERROR500';

//* TODO module login
  static const STATUS_LOGIN_AUTHENTICATION_AUTH00 = 'AUTH00';

  static const STATUS_LOGIN_AUTHENTICATION_AUTH01 = 'AUTH01';
  static const STATUS_LOGIN_AUTHENTICATION_AUTH02 = 'AUTH02';
  static const STATUS_LOGIN_AUTHORIZED_EXPIRE_WARNING = 'AUTH12';
  static const STATUS_LOGIN_AUTHORIZED_EXPIRED = 'AUTH09';
  static const STATUS_LOGIN_AUTHORIZED_FIRST = 'OTP00';
  static const STATUS_LOGIN_AUTHORIZED_LOCKED = 'AUTH05';
  static const STATUS_LOGIN_NOT_ACTIVE = 'AUTH06';
  static const STATUS_LOGIN_AUTHORIZED_SWITCH_DEVICE = 'AUTH13';
  static const STATUS_LOGIN_LOCK_ACCOUNT = 'AUTH16';
  static const STATUS_LOGIN_DELETE_ACCOUNT = 'AUTH17';
  static const STATUS_LOGIN_ACCOUNT_ALREADY_EXIST = 'AUTH18';
  static const STATUS_LOGIN_AUTHORIZED_FAIL_OTP = 'OTP02';
  static const STATUS_LOGIN_AUTHORIZED_OLD_VERSION = 'AUTH15';
  static const STATUS_LOGIN_NOT_VERIFY = 'SECT10';
  static const STATUS_TOKEN_NOT_INVALID = 'SECT02';
  static const STATUS_UNIT_TOKEN_NOT_INVALID = 'SECT03';
  static const STATUS_USER_TOKEN_NOT_INVALID = 'SECT04';
  static const STATUS_ACCESS_TIME_NOT_INVALID = 'SECT05';
  static const STATUS_CANT_VERIFY = 'SECT06';
  static const STATUS_FINGER_REGISTER_ERROR = 'FR01';
  static const STATUS_FINGER_REGISTER_INVALID = 'FR02';
  static const STATUS_FINGER_LOGIN_ERROR = 'FL001';

  static const STATUS_LOGIN_VERSION_UPFATE = "AUTH15";

// Nguyên
// Trạng thái số dư tài khoản
  static const STATUS_GET_ACCOUNT_BALANCE = "ACCB00";

// Trạng thái tên người thụ hưởng
  static const BENEF_ACCOUNT_NAME_INQUIRY = 'ACCN00';

  static const VERIFY_INTERNAL_TRANSFER_SUCCESSFULL = 'RTR00';

// Trạng thái truy vấn hạn mức giao dịch
  static const TRANSFER_LIMITED = 'TRLM00';

  // Trạng thái truy vấn danh sách dịch và nhà cung cấp (của chức năng nạp tiền) vụ thành công.
  static const INQUIRY_RECHARGE_SERVICE = 'SPL00';

  /// Danh loc

  // Acount
  static const STATUS_INVALID_REQUEST_PARAMETER_SECT01 = "SECT01";
  static const STATUS_INVALID_REQUEST_PARAMETER_SECT07 = "SECT07";
  static const STATUS_INVALID_REQUEST_PARAMETER_SECT08 = "SECT08";
  static const STATUS_SUCCESS = "ACCT00";
  static const CHANGE_PASSWORD_SUCCESSFULL = 'CPWD00';
  static const STATUS_INQUIRY_FX_RATE = 'FXRTR00';

  // Chuyển khoản
  static const STATUS_GET_ACCOUNT_NAPAS = 'NPS001';

  /// start mauld
  static const STATUS_INQUIRY_USER_INFO = 'USRI00';
  static const STATUS_SUSPEND_SERVICE = 'SUSR00';
  static const STATUS_UPDATE_NOTIFICATION_SUCCESS = 'NTS000';
  static const STATUS_UPDATE_DEBT_NOTIFICATION_SUCCESS = 'NDR00';
  static const STATUS_UNIT_INSURANCE = 'INS003';
  static const STATUS_INSURANCE_PROMOTION = 'INS002';
  static const STATUS_INSURANCE_PACKAGE = 'INS001';
  static const STATUS_CREATE_HEALTH_INSURANCE = 'HI000';
  /**
   * end mauld
   */
  /// Cường
  static const STATUS_INQUIRY_RATE = "INRTR00";
  static const STATUS_SAVING_RATE = "SVI001";

  /// Linh
//Error
  static const LOGIN_SECTION_EXPIRED_SECT01 = "SECT01"; //HẾT HẠN PHIÊN ĐĂNG NHẬP
  static const LOGIN_SECTION_EXPIRED_SECT02 = "SECT02"; //HẾT HẠN PHIÊN ĐĂNG NHẬP
  static const LOGIN_SECTION_EXPIRED_SECT03 = "SECT03"; //HẾT HẠN PHIÊN ĐĂNG NHẬP
  static const LOGIN_SECTION_EXPIRED_SECT04 = "SECT04"; //HẾT HẠN PHIÊN ĐĂNG NHẬP
  static const LOGIN_SECTION_EXPIRED_SECT05 = "SECT05"; //HẾT HẠN PHIÊN ĐĂNG NHẬP
  static const LOGIN_SECTION_EXPIRED_SECT06 = "SECT06"; //HẾT HẠN PHIÊN ĐĂNG NHẬP
  static const LOGIN_SECTION_EXPIRED_SECT11 = "SECT11"; //HỆ THỐNG NGOẠI TUYẾN
  static const LOGIN_SECTION_EXPIRED_SECT12 = "SECT12"; //KHÔNG CÓ QUYỀN TRUY CẬP CHỨC NĂNG NÀY
  static const LOGIN_SECTION_EXPIRED_SECT13 = "SECT13"; //KIỂU DỨ LIỆU KHÔNG ĐƯỢC HỖ TRỢ
  static const LOGIN_SECTION_EXPIRED_SECT14 = "SECT14"; //YÊU CẦU ĐÃ BỊ TỪ CHỐI
  static const ACCOUNT_NOT_EXISTS = "ACCB01"; // TÀI KHOẢN KHÔNG TỒN TẠI

//Success

  static const STATUS_INQUIRY_ACCOUNT_HISTORY_SUCCESS =
      "TRHI00"; //GỌI API LỊCH SỬ THÀNH CÔNG
  static const STATUS_GET_LIST_BENEFICARY_SUCCESS =
      "BENE00"; //GỌI API DANH SACH TAI KHOAN THU HUONG THANH CONG
  static const DELETE_BENEFICARY_SUCCESS =
      "UBAC00"; //XÓA TÀI KHOẢN THỤ HƯỞNG THÀNH CÔNG
  static const ACCOUNT_BENEFICARY_INVALID = "UBAC06"; //TÀI KHOẢN KHÔNG HỢP LỆ
  static const GET_LIST_BANK_SUCCESS =
      "BINL00"; //LẤY RA DANH SÁCH NGÂN HÀNG THÀNH CÔNG
  static const GET_LIST_COUNTRY_SUCCESS = "EIL00"; //LẤY RA QUỐC GIA THÀNH CÔNG
  static const GET_SERVICE_PAYMENT_BILL_AUTO_SUCCESS =
      "SPL00"; //LẤY DANH SÁCH DỊCH VỤ Ở MÀN THANH TOÁN TỰ ĐỘNG
  static const GET_LIST_PROVINCE_SUCCESS =
      "ORGL00"; //LẤY RA DANH SÁCH TỈNH THÀNH PHỐ
  static const GET_LIST_TYPE_CARD_SUCCESS =
      "RESP00"; //LẤY RA DANH SÁCH LOẠI THẺ THÀNH CÔGN
  static const GET_LIST_BRANCH_SUCCESS =
      "ORGL00"; //LẤY RA DANH SÁCH CHI NHÁNH LIÊN HỆ
  static const CREATE_CARD_SERVICE_SUCCESS =
      "RESP00"; //TẠO DỊCH VỤ ĐĂNG KÝ THẺ THÀNH CÔNG
  static const CREATE_LOAN_SUCCESS = "RESP00"; //TẠO DỊCH VỤ VAY VỐN THÀNH CÔNG
  static const CREATE_PAYMENT_ACCOUNT_SUCCESS =
      "RESP00"; //TẠO TÀI KHOẢN THANH TOÁN THÀNH CÔNG
  static const CREATE_INTERNET_BANKING_SUCCESS =
      "RESP00"; //TẠO TÀI KHOẢN INTERNET BANKING THÀNH CÔNG
  static const CREATE_MPOS_SUCCESS = "RESP00"; //TẠO MPOS THÀNH CÔNG
  static const GET_INFO_STEP2_REGISTER_LOAN_SUCCESS =
      "EIL00"; // LẤY THÔNG TIN ĐĂNG KÝ VAY VỐN THÀNH CÔNG
  static const GET_INFO_STEP1_REGISTER_PAYMENT_ACCOUNT_SUCCESS =
      "EIL00"; // LẤY THÔNG TIN ĐĂNG KÝ TÀI KHOẢN THANH TOÁN THÀNH CÔNG

  static const CREATE_CARD_SERVICE =
      "EIL00"; //TẠO DỊCH VỤ ĐĂNG KÝ THẺ THÀNH CÔNG
  static const GET_LIST_PRODUCT = "RID001"; //TẠO DỊCH VỤ VAY VỐN THÀNH CÔNG
  static const GET_BALANCE_SUCCESS = "ACCB00"; //LẤY SỐ DƯ KHẢ DỤNG THÀNH CÔNG
  static const GET_LIST_SERVICE_RECHARGE_SUCCESS =
      "SPL00"; //LẤY DANH SÁCH DỊCH VỤ NẠP TIỀN THÀNH CÔNG
  static const CHECK_FEE_SUCCESS = "BPI00"; //KIỂM TRA PHÍ THÀNH CÔNG
  static const RECURRING_BILL_PAYMENT_VERIFY_SUCCESS =
      "ABP00"; //THANH TOÁN HOÁ ĐƠN TỰ ĐỘNG THÀNH CÔNG
  static const BILL_PAYMENT_VERIFY_SUCCESSFULL =
      "BP00"; //VERIFY HOÁ ĐƠN THÀNH CÔNG
  static const RECHARE_VERIFY_SUCCESSFULL = "BP00"; //VERIFY NẠP TIÈN THÀNH CÔNG
  static const BILL_USER_INFORMATION_SUCCESSFULL =
      "USRI00"; //LẤY THÔNG TIN NGƯỜI DÙNG THÀNH CÔNG
  static const BILL_PAYMENT_CREATE_SUCCESSFULL =
      "BP00"; //CREATE HOÁ ĐƠN THÀNH CÔNG
  static const CREATE_BILL_PAYMENT_VERIFY_SUCCESS =
      "ABP00"; // TẠO THANH TOÁN HOÁ ĐƠN TỰ ĐỘNG THÀNH CÔNG
  //doi mat khau
  static const CHANGE_PASSWORD_SUCCESS = "CPWD00"; // ĐỔI MẬT KHẨU THÀNH CÔNG
  static const CHANGE_PASSWORD_OLD_NOTCORRECT = "CPWD04";
  static const CHANGE_PASSWORD_NEW_ERROR = "CPWD02";
  static const CHANGE_PASSWORD_CONFIRM_NEW_ERROR = "CPWD03";
  static const CHANGE_PASSWORD_NEW_CONFIRM_NEW = "CPWD05";
  static const CHANGE_PASSWORD_ERROR = "CPWD99";
  static const CHANGE_PASSWORD_NOTCORRECT = "CPWD07";
  static const CHANGE_PASSWORD_SPACE = "CPWD08";

  //OTP
  static const SENT_OTP_SUCCESS = "OTP00"; //GỬI OTP THÀNH CÔNG
  static const SENT_OTP_ERROR = "OTP01"; //gui otp loi
  static const SENT_OTP_UNCORECT = "OTP02"; //GUI OTP KHONG DUNG
  static const SENT_OTP_END_TIME = "OTP03"; //GUI OTP HET THOI GIAN;
  //Mật khẩu
  static const CHANGE_PASS_ERROR = "CPWD99"; //Loi doi mat khau
//18-03-21
  static const MENU_SUCCESSFUL = "MENU00";

  //tra cuu
  static const TRA_CUU_THANH_CONG = "TRACUU00";
  static const TRA_CUU_LOI_HE_THONG = "TRACUU01";
  static const TRA_CUU_KHONG_TIM_THAY_DL = "TRACUU02";
  static const TRA_CUU_YC_NHAP_DK_NGAY = "TRACUU03";
  //tra cuu chi tiet du lieu

  static const TRA_CUU_CT_THANH_CONG = "CTTCUU00";
  static const TRA_CUU_CT_LOI_HE_THONG = "CTTCUU01";
  static const TRA_CUU_CT_KHONG_TIM_THAY_DL = "CTTCUU02";

  static const TRA_CUU_DANH_MUC_THANH_CONG = "DMUC00";
  static const TRA_CUU_DANH_MUC_KO_DL = "DMUC02";
  static const TRA_CUU_DANH_MUC_LOI_HT = "DMUC01";
  // tra cuu thong tin nnt
  static const TRA_CUU_THONG_TIN_NNT_NON_DL = "CUST01";
  static const TRA_CUU_THONG_TIN_NNT_AUTH_DL = "AUTH02";

  //dang ky moi
  static const DANG_KY_THANH_CONG = "REAC00";
  static const DANG_KY_THANH_CONG_OTP = "REACMMOTP00";
  static const REGISTER_FILE_SUCCESSFUL = "REACFILE00";
  static const DANG_KY_EROR_OTP = "REACMMOTP01";
  static const DANG_KY_DMUC_NH = "DMUC00";
  static const DANG_KY_DA_SU_DUNG = "REAC01";
  static const DANG_KY_CHO_PHE_DUYET = "REAC02";
  static const DANG_KY_KHONG_SEARCH_MST = "REAC03";
  static const DANG_KY_KHONG_CA_NHAN = "REAC04";
  static const DANG_KY_DIA_BAN_CHUA_ACTIVE = "REAC05";
  static const DANG_KY_MA_LOI = "REAC06";
  static const DANG_KY_DATONTAI_MA_LOI = "REAC07";
  static const DANG_KY_MOBILE_NULL_MA_LOI = "REAC08";
  static const DANG_KY_EMAIL_ULL_MA_LOI = "REAC09";
  // liên kết ngân hàng

  static const ACCOUNT_LINK_SUCCESS = "ACCLINK00";
  static const ACCOUNT_LINK_OTP_SUCCESS = "ACCLINKOTP00";
  static const STATUS_CONFIRM_OTP_FAIL = "REACDIFNEW01";

  static const STATUS_TEMP_INSERT = "INSERT00";
  static const STATUS_CHECK_MST_DN = "CHECKETAX00";
  static const STATUS_BUILDFILE = "BUILDFILE00";

  //check trang thai ke khai
  static const CHECK_KE_KHAI_SUCCESS = "CHECK00";
  static const CHECK_KE_KHAI_FAIL = "CHECK01";

}
