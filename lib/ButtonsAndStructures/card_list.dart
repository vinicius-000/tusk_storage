import 'package:flutter/material.dart';

class CardList<T> extends StatelessWidget {
  final Future<List<T>> Function() load;
  final Widget Function(T item) itemBuilder;

  const CardList({
    super.key,
    required this.load,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: snapshot.data!
              .map(itemBuilder)
              .toList(),
        );
      },
    );
  }
}
