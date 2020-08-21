class CurrentUser {
  static String currentUser = 'BitMedi';
  static String firstName = ' ';
  static String lastName = ' ';
  static String gender = ' ';
  static String user;
  static String phone = ' ';
  static String dob = ' ';
  static String address = ' ';
  static String allergy = ' ';
  static String blood_grp = '';
  static String height = '';
  static String weight = '';

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
