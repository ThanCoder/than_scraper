import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_scraper/my_libs/clean_cache/cache_component.dart';
import 'package:than_scraper/my_libs/general_server/current_version_component.dart';
import 'package:than_scraper/my_libs/setting/app_setting_screen.dart';
import 'package:than_scraper/my_libs/setting/theme_component.dart';



class AppMorePage extends StatelessWidget {
  const AppMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //theme
            ThemeComponent(),
            //version
            TListTileWithDesc(
              leading: Icon(Icons.settings),
              title: 'Setting',
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppSettingScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            CurrentVersionComponent(),
            //Clean Cache
            CacheComponent(),
          ],
        ),
      ),
    );
  }
}
