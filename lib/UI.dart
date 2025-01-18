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
  List<dynamic> products = [];
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
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: products.map((product) {
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  "${product['id'] ?? 'No ID'}. ${product['name'] ?? 'No Name'}",
                ),
                subtitle: Text(
                  product['data'] != null
                      ? "Color: ${product['data']['color'] ?? 'N/A'}\nCapacity: ${product['data']['capacity'] ?? 'N/A'}"
                      : "No Additional Data",
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> getProduct() async {
    try {

      Uri uri = Uri.parse('https://api.restful-api.dev/objects');
      Response response = await get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print("API Response: $jsonData");
        products = jsonData;
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
