import 'package:f27_api/model/product_model.dart';
import 'package:flutter/material.dart';

import '../api/api_services.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  APIServices apiServices = APIServices();
  final _formKey = GlobalKey<FormState>();

  String title = "";
  double price = 0.0;
  String description = "";
  String image = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),

              // Price
              TextFormField(
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price";
                  }
                  return null;
                },
                onSaved: (value) {
                  price = double.parse(value!);
                },
              ),

              // Description
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),

              // Image url
              TextFormField(
                decoration: const InputDecoration(labelText: "Image URL"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an image URL";
                  }
                  return null;
                },
                onSaved: (value) {
                  image = value!;
                },
              ),

              // Category
              TextFormField(
                decoration: const InputDecoration(labelText: "Category"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a category";
                  }
                  return null;
                },
                onSaved: (value) {
                  category = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // This will call the 'onSaved : ' then save assigned values to current state
                    _formKey.currentState!.save();

                    ProductModel newProduct = ProductModel(
                        title: title,
                        price: price,
                        description: description,
                        image: image,
                        category: category);

                    // close the form and navigate to Home/back
                    apiServices.addProduct(newProduct).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                child: const Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
