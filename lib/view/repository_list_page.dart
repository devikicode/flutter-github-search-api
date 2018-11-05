import 'package:flutter/material.dart';

class RepositoryListPage extends StatefulWidget {

  RepositoryListPage({Key key}) : super(key: key);

  @override
  _RepositoryListPageState createState() => new _RepositoryListPageState();
}

class _RepositoryListPageState extends State<RepositoryListPage> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: ListView.builder(
        itemBuilder: (_, int index) => RepositoryItem(),
        itemCount: 10,
      ),
    );
  }
}

class RepositoryItem extends StatelessWidget {

  const RepositoryItem();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Image.network(
            "https://avatars2.githubusercontent.com/u/5383506?v=4",
            fit: BoxFit.fill,
            width: 50.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Titulo"),
                  SizedBox(height: 6.0),
                  Text("Descripcion"),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              BulletColumn(icon: Icons.star, count: 123),
              BulletColumn(icon: Icons.print, count: 345),
              BulletColumn(icon: Icons.add, count: 678),
            ],
          ),
        ],
      ),
    );
  }
}

class BulletColumn extends StatelessWidget {

  final IconData icon;
  final int count;

  const BulletColumn({
    Key key, this.icon, this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Icon(this.icon),
          Text(this.count.toString()),
        ],
      ),
    );
  }
}