import 'package:api_project/consts.dart';
import 'package:api_project/create_product.dart';
import 'package:api_project/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class ApiUi extends StatefulWidget {
  const ApiUi({super.key});

  @override
  State<ApiUi> createState() => _ApiUiState();
}

class _ApiUiState extends State<ApiUi> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Usage'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              getProduct();
              isLoading = true;
              setState(() {
              });
            },
            child: Icon(
              Icons.refresh_outlined,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateProduct()));
          },
          child: Icon(Icons.add)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: pro.products.map((product) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        "${product['id'] ?? 'No ID'}. ${product['title'] ?? 'No Name'}",
                      ),
                      subtitle: Text("Description: ${product['body']}"),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  //getMethod
  Future<void> getProduct() async {
    try {
      Uri uri = Uri.parse(ApiUrl.apiGetPostUrl);
      Response response = await get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("API Response: $jsonData");
        pro.products = jsonData;
        setState(() {
          isLoading = false;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }
}
