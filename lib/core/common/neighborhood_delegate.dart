import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NeighborhoodDelegate extends SearchDelegate {
  NeighborhoodDelegate({required this.neighborhoodList});
  final List<String> neighborhoodList;

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 18,
      );

  @override
  String? get searchFieldLabel => 'Search Neighborhood';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? neighborhoodList
        : neighborhoodList
            .where(
              (neighborhood) =>
                  neighborhood.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            close(context, suggestions[index]);
          },
          title: Text(suggestions[index]),
        );
      },
    );
  }
}
