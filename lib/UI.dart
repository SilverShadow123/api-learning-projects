import 'dart:convert';
import 'package:api_project/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiUi extends StatefulWidget {
  const ApiUi({super.key});

  @override
  State<ApiUi> createState() => _ApiUiState();
}

class _ApiUiState extends State<ApiUi> {
  List<dynamic> nekoImages = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getNekoImages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neko Images'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getNekoImages();
        },
        child: const Icon(
          Icons.refresh_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: nekoImages.map((neko) {
                  return Card(
                    color: Colors.pinkAccent.shade100,
                    child: ListTile(
                      title: Image.network(neko['url']),
                      subtitle: Text('Details: ${neko['tags'] ?? 'no info'}',style: TextStyle(color: Colors.white),),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Future<void> getNekoImages() async {
    Uri uri = Uri.parse(apiAdress.apiBaseUrl);
    final params = {'limit': '20'};
    final uriWithParams = uri.replace(queryParameters: params);

    Response response = await get(uriWithParams);

    if (response.statusCode == 200) {
      final List<dynamic> nekoImg = jsonDecode(response.body);
      nekoImages = nekoImg;
      isLoading = false;
      setState(() {});
    }else{
      'no Data Found';
    }
  }
}
