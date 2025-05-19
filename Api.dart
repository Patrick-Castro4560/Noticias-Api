
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ApiDataScreen extends StatefulWidget {
  const ApiDataScreen({super.key});

  @override
  _ApiDataScreenState createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  List<dynamic> articles = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    final url =
        'https://newsapi.org/v2/everything?q=tesla&from=2025-04-19&sortBy=publishedAt&apiKey=88cf073a8d654b5b8a7b3fb076d60d46';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        articles = data['articles'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Error al cargar las noticias');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noticias sobre Tesla')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ListTile(
                    leading:
                        article['urlToImage'] != null
                            ? Image.network(
                              article['urlToImage'],
                              width: 100,
                              fit: BoxFit.cover,
                            )
                            : null,
                    title: Text(article['title'] ?? 'Sin título'),
                    subtitle: Text(article['description'] ?? 'Sin descripción'),
                    onTap: () {
                    },
                  );
                },
              ),
    );
  }
}
