import 'package:flutter/material.dart';
import 'package:github_search/view/repository_list_page.dart';

void main() => runApp(new GitHubSearchApp());

class GitHubSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'GitHub Search Repository',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RepositoryListPage(),
    );
  }
}
