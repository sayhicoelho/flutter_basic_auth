import 'package:flutter/material.dart';
import 'package:flutter_basic_auth/screens/home_screen.dart';
import 'package:flutter_basic_auth/screens/login_screen.dart';
import 'package:flutter_basic_auth/services/auth_service.dart';
import 'package:flutter_basic_auth/services/http_service.dart';
import 'package:flutter_basic_auth/config/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpService.setTimeouts();
  HttpService.setBaseUrl(Config.BASE_URL);
  var home = await AuthService.check()
    ? HomeScreen()
    : LoginScreen();

  runApp(MaterialApp(
    title: Config.APP_NAME,
    home: home,
  ));
}
