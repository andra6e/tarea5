import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=2d389c470efc4bb89561d121dc5c9670');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        newsList = json.decode(response.body)['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(newsList[index]['title'] ?? ''),
            subtitle: Text(newsList[index]['description'] ?? ''),
          );
        },
      ),
    );
  }
}
