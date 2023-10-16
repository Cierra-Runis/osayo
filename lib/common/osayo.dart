import 'dart:developer' as devtools show log;

class Osayo {
  static const appName = 'Osayo';
  static const database = 'OsayoDatabase';
  static const apiBaseUrl = 'https://api.sayobot.cn';
  static const apiStaticUrl = 'https://a.sayobot.cn';
  static const fontFamily = 'MinecraftAE';

  static void printLog(dynamic log) =>
      devtools.log('$log', time: DateTime.now(), name: appName);
}
