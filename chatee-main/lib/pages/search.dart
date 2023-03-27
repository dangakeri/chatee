import 'dart:ffi';

import 'package:chatee/models/user.dart';
import 'package:chatee/pages/home.dart';
import 'package:chatee/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  late final Future<QuerySnapshot> searchResultsFuture;
  HandleSearch(String query) {
    Future<QuerySnapshot> users =
        userRef.where('displayName', isGreaterThanOrEqualTo: query).get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  ClearSearch() {
    searchController.clear();
  }

  BuildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for a user ...',
          filled: true,
          prefixIcon: const Icon(
            Icons.account_box,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: ClearSearch(),
          ),
        ),
        onFieldSubmitted: HandleSearch,
      ),
    );
  }

  BuildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: ListView(children: [
        SvgPicture.asset(
          'assets/search.svg',
          height: orientation == Orientation.portrait ? 300 : 200,
        ),
        const Text(
          'Find Users',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 60,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    BuildSearchResults() {
      return FutureBuilder(
        future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<Text> searchResults = [];
          snapshot.data!.docs.forEach(
            (doc) {
              User user = User.fromDocument(doc);
              searchResults.add(
                Text(user.username),
              );
            },
          );
          return ListView(
            children: searchResults,
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
      appBar: BuildSearchField(),
      body:
          searchResultsFuture == null ? BuildNoContent() : BuildSearchResults(),
    );
  }
}

class UserResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('User Result');
  }
}
