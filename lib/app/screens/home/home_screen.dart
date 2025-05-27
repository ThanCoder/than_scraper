import 'package:flutter/material.dart';
import 'package:than_scraper/my_libs/fetcher/screens/fetcher_content_bookmark_screen.dart';

import 'pages/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            FetcherContentBookmarkScreen(),
            AppMorePage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              text: 'Home',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'Book Mark',
              icon: Icon(Icons.bookmark_added_rounded),
            ),
            Tab(
              text: 'More',
              icon: Icon(Icons.grid_view_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
