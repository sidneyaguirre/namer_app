import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_generator/widgets.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// watches and gets notified with the changes by [ChangeNotifier]
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: NameCard(
              pair: pair,
              // This key causes the AnimatedSwitcher to interpret this as a "new"
              // child each time the count changes, so that it will begin its animation
              // when the word changes.
              key: ValueKey<WordPair>(pair),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NameCard extends StatelessWidget {
  const NameCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RichText(
          text: TextSpan(
            text: pair.first,
            semanticsLabel: pair.asPascalCase,
            style: DefaultTextStyle.of(context).style.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w100,
                ),
            children: <TextSpan>[
              TextSpan(
                text: pair.second,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textScaleFactor: 3.0,
        ),
      ),
    );
  }
}
