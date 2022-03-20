// ignore_for_file: constant_identifier_names

class ApiUtil {
// Define Api Routes
// static means i dont need to make copy of class
// i can access it immediately

// LOCAL URLS
// CHANGE TO IT REAL URLs IN THE RELEASE

  static const String MAIN_API_URL = 'https://de39-102-42-93-152.ngrok.io/api/';

  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register/';

  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login/';
}
