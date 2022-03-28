import 'package:redditech/constants.dart';

import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedditAuth {
  Reddit? reddit;

  final String _redirectUri = configAuthPierre['redirectUri']!;
  final String _callbackScheme = configAuthPierre['callbackScheme']!;
  final String _userAgent = configAuthPierre['userAgent']!;
  final String _clientId = configAuthPierre['clientId']!;

  late SharedPreferences _prefs;

  void initPrefs(SharedPreferences prefs) {
    _prefs = prefs;
  }

  Future<bool> firstLogin() async {
    reddit = Reddit.createInstalledFlowInstance(
      clientId: _clientId,
      userAgent: _userAgent,
      redirectUri: Uri.parse(_redirectUri),
    );

    final authUrl = reddit!.auth.url(
      ['*'],
      _userAgent,
      compactLogin: true,
    );

    final result = await FlutterWebAuth.authenticate(url: authUrl.toString(), callbackUrlScheme: _callbackScheme);

    final code = Uri.parse(result).queryParameters['code'];

    await reddit!.auth.authorize(code!);

    saveCredentialsLocalStorage(reddit!.auth.credentials.toJson());

    return true;
  }

  bool loginLocalStorage() {
    String? credentialsJson;

    if ((credentialsJson = getCredentialsLocalStorage()) != null) {
      reddit = Reddit.restoreInstalledAuthenticatedInstance(
        credentialsJson!,
        clientId: _clientId,
        userAgent: _userAgent,
        redirectUri: Uri.parse(_redirectUri),
      );

      return true;
    }

    return false;
  }

  logout() {
    _prefs.remove('credentials');
  }

  void saveCredentialsLocalStorage(String credentialsJson) {
    _prefs.setString('credentials', credentialsJson);
  }

  String? getCredentialsLocalStorage() {
    return _prefs.getString('credentials');
  }
}