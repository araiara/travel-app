import 'package:flutter/material.dart';
import 'package:travel_app/provider/travel_provider.dart';
import 'package:travel_app/screens/travel_detail_screen.dart';
import 'package:provider/provider.dart';

class TravelSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData themeData = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
      ),
    );
    return themeData;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Center(child: Text('Search through the Travel App!'))
        : Consumer<TravelProvider>(
            builder: (ctx, data, child) {
              final searchResults = data.getSearchResults(query);
              return searchResults.isEmpty
                ? Center(
                    child: Text('The destination \'$query\' does not exist'),
                  )
                : ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    itemCount: searchResults.length,
                    itemBuilder: (ctx, index) {
                      final travel = searchResults[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => TravelDetailScreen(
                                    id: travel.id,
                                  )));
                        },
                        leading: Image.network(
                          travel.imageUrl,
                          height: 80,
                        ),
                        title: Text(travel.name),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Center(child: Text('Search through the Travel App!'))
        : Consumer<TravelProvider>(
            builder: (ctx, data, child) {
              final searchResults = data.getSearchResults(query);
              return searchResults.isEmpty
                  ? Center(
                      child: Text('The travel with \'$query\' doesnt exist'),
                    )
                  : ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      itemCount: searchResults.length,
                      itemBuilder: (ctx, index) {
                        final travel = searchResults[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => TravelDetailScreen(
                                      id: travel.id,
                                    )));
                          },
                          leading: Image.network(
                            travel.imageUrl,
                            height: 80,
                          ),
                          title: Text(travel.name),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
            },
          );
  }
}