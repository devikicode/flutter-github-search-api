import 'package:flutter/material.dart';
import 'package:github_search/domain/repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';

class RepositoryDetailPage extends StatelessWidget {

  final Repository repository;

  RepositoryDetailPage({this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(this.repository.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.web),
            onPressed: _launchRepoURL,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(this.repository.avatarUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        this.repository.owner,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      _buildBadgeItem(
                          Icons.stars, Colors.amber,
                          this.repository.stars.toString()),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildBadgeItem(
                          Icons.call_split,
                          Colors.blueAccent,
                          this.repository.forks.toString()),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildBadgeItem(
                          Icons.remove_red_eye,
                          Colors.pink,
                          this.repository.watchers.toString()),
                    ],
                  ),
                )
              ],
            ),
            Divider(color: Colors.blueAccent, height: 2.0,),
            SizedBox(
              height: 10.0,
            ),
            Text(
              this.repository.description,
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Languaje"),
                      Text(this.repository.language),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Creado"),
                      Text(formatDate(this.repository.createdAt, [dd, '/', mm, '/', yyyy])),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Actualizado"),
                      Text(formatDate(this.repository.updatedAt, [dd, '/', mm, '/', yyyy])),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.blueAccent, height: 2.0,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                child: Text("Ver Repositorio", style: TextStyle(color: Colors.white),),
                color: Colors.blueAccent,
                onPressed: _launchRepoURL,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeItem(IconData iconData, Color iconColor, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 30.0, color: Colors.teal),
        ),
        SizedBox(width: 20.0),
        Icon(
          iconData,
          size: 40.0,
          color: iconColor,
        )
      ],
    );
  }

  void _launchRepoURL() async {
    final url = this.repository.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
