class CurrentUser {
  static String currentUser = 'mediLocker';
  static String firstName = 'NIL';
  static String lastName = 'NIL';
  static String gender = 'NIL';
  static String user;
  static String phone = '9999999999';
  static String dob = '1900/01/01';
  static String address = 'NIL';
  static String allergy = 'NIL';
  static String blood_grp = 'NIL';
  static String height = '150';
  static String weight = '65';

  static Map<String, String> getProfile() {
    Map<String, String> data = {
      'firstName': firstName,
      'lastName': lastName,
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
