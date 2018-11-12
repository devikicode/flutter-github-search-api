import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:github_search/domain/repository.dart';
import 'package:github_search/view/repository_detail_page.dart';

Future<List<Repository>> _getRepositories() async {
  final dio = new Dio();
  final response = await dio.get(
      'https://api.github.com/search/repositories?q=flutter&sort=stars&order=desc');
  List<Repository> list = new List();
  for (int i = 0; i < response.data['items'].length; i++) {
    list.add(Repository.fromJson(response.data['items'][i]));
  }
  return list;
}

class RepositoryListPage extends StatefulWidget {
  RepositoryListPage({Key key}) : super(key: key);

  @override
  _RepositoryListPageState createState() => new _RepositoryListPageState();
}

class _RepositoryListPageState extends State<RepositoryListPage> {
  Future<List<Repository>> repositories;

  @override
  void initState() {
    super.initState();
    repositories = _getRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Repos"),
          leading: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  repositories = _getRepositories();
                });
              }),
        ),
        body: FutureBuilder<List<Repository>>(
          future: repositories,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) =>
                        RepositoryItem(repository: snapshot.data[index]),
                  );
                }
            }
          },
        ));
  }
}

class RepositoryItem extends StatelessWidget {
  final Repository repository;

  const RepositoryItem({Key key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: GestureDetector(
        onTap: () => _goToDetail(context),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                repository.avatarUrl,
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              repository.owner,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              repository.name,
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          BudgeColumn(
                            icon: Icons.stars,
                            count: repository.stars,
                            color: Colors.amber,
                          ),
                          BudgeColumn(
                            icon: Icons.call_split,
                            count: repository.forks,
                            color: Colors.blue,
                          ),
                          BudgeColumn(
                            icon: Icons.remove_red_eye,
                            count: repository.watchers,
                            color: Colors.pink,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RepositoryDetailPage(repository: this.repository)),
    );
  }
}

class BudgeColumn extends StatelessWidget {

  final IconData icon;
  final int count;
  final Color color;

  const BudgeColumn({Key key, this.icon, this.count, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Icon(
            this.icon,
            color: this.color,
          ),
          Text(
            this.count.toString(),
            style: TextStyle(color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
