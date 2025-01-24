import 'dart:convert';

import 'package:api_project/UI.dart';
import 'package:api_project/consts.dart';
import 'package:api_project/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

//final Function(String, String) postProductCallback;
  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _bodyTEController = TextEditingController();

  // postMethod
  Future<void> postProduct() async {
    Uri uri = Uri.parse(ApiUrl.apiGetPostUrl);
    final Map<String, dynamic> data = {
      'title': _titleTEController.text,
      'body': _bodyTEController.text,
    };
    Response response = await post(uri,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      print(response.body);
      final postData = jsonDecode(response.body);
      pro.products.add(postData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: Column(
          children: [
            TextField(
              controller: _titleTEController,
              decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: _bodyTEController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Description',
                enabledBorder: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                postProduct();
                // String title =_titleTEController.text;
                // String body =_bodyTEController.text;
// widget.postProductCallback(title,body);
                Navigator.pop(context);
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(264, 40)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTEController.dispose();
    _bodyTEController.dispose();
    super.dispose();
  }
}
