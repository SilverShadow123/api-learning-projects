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
    getNekoImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neko Images'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getNekoImages,
        backgroundColor: Colors.pinkAccent,
        child: const Icon(
          Icons.refresh_outlined,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: nekoImages.length,
                itemBuilder: (context, index) {
                  final neko = nekoImages[index];
                  return Card(
                    color: Colors.pinkAccent.shade100,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            neko['url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            neko['anime_name'] ?? 'No Info',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future<void> getNekoImages() async {
    Uri uri = Uri.parse(apiAdress.apiBaseUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> nekoImg = jsonDecode(response.body);
      print(response.body);
      nekoImages = nekoImg['results'];
      isLoading = false;
      setState(() {});
    } else {
      print('No Data Found');
    }
  }
}
