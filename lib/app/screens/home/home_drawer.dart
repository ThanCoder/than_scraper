import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        spacing: 5,
        children: [
          DrawerHeader(child: TImageFile(path: '')),
          ListTile(
            title: Text('Fetcher'),
          ),
        ],
      ),
    );
  }
}
