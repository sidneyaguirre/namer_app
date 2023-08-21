import 'package:flutter/material.dart';
import 'package:word_generator/src/widgets/favorites_page.dart';
import 'package:word_generator/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _page = GeneratorPage();
  int _pageIndex = 0;

  void _navigate(int index) {
    switch (index) {
      case 0:
        _page = GeneratorPage();
        break;
      case 1:
        _page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $index');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var landscapeView = constraints.maxWidth >= 600;
      var portraitView = constraints.maxWidth < 600;

      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: landscapeView
                  ? NavigationRail(
                      extended: true,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite),
                          label: Text('Favorites'),
                        ),
                      ],
                      selectedIndex: _pageIndex,
                      onDestinationSelected: (value) {
                        _pageIndex = value;
                        _navigate(value);
                      },
                    )
                  : SizedBox.shrink(),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: _page,
              ),
            ),
          ],
        ),
        bottomNavigationBar: portraitView
            ? BottomNavigationBar(
                currentIndex: _pageIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                ],
                onTap: (value) {
                  _pageIndex = value;
                  _navigate(value);
                },
              )
            : SizedBox.shrink(),
      );
    });
  }
}
