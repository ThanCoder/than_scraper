import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_scraper/my_libs/fetcher/services/dio_services.dart';
import 'package:than_scraper/my_libs/setting/app_notifier.dart';
import 'package:than_scraper/my_libs/setting/setting.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThanPkg.instance.init();
  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/logo.png',
    getDarkMode: () => appConfigNotifier.value.isDarkTheme,
    onDownloadCacheImage: (url, savePath) async {
      await DioServices.instance.downloadCover(url: url, savePath: savePath);
    },
  );

  //init config
  await Setting.initAppConfigService();

  runApp(const MyApp());
}
