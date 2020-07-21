class CurrentUser {
  static String currentUser = 'mediLocker';
  static String name = 'NIL';
  static String gender = 'NIL';
  static String user;
  static String phone = 'None';
  static String dob = '1900/01/01';
  static String address = 'NIL';
  static String allergy = 'NIL';
  static String blood_grp = 'NIL';
  static String height = 'NIL';
  static String weight = 'NIL';

  static Map<String, String> getProfile() {
    Map<String, String> data = {
      'user': currentUser,
      'phone': phone,
      'dob': dob,
      'address': address,
      'allergy': allergy,
      'gender': gender,
      'blood_grp': blood_grp,
      'height': height,
      'weight': weight
    };

    return data;
  }
}

class Common {
  static String baseURL = 'http://134.209.158.239:8000/';
}
