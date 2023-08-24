import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_generator/widgets.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);
    var titleTextStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );
    var itemTextStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.secondary,
    );

    return Center(
      child: appState.favorites.isNotEmpty
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'You have ${appState.favorites.length} favorites',
                    style: titleTextStyle,
                  ),
                ),
                for (var pair in appState.favorites)
                  GestureDetector(
                    onTap: () {
                      appState.removeFavorite(pair);
                    },
                    child: ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text(
                        pair.asLowerCase,
                        style: itemTextStyle,
                      ),
                    ),
                  )
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'You have no favorites yet.',
                style: titleTextStyle,
              ),
            ),
    );
  }
}
