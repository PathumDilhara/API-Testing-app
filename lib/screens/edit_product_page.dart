import 'package:f27_api/api/api_services.dart';
import 'package:f27_api/model/product_model.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;
  const EditProductPage({
    super.key,
    required this.product,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final APIServices apiServices = APIServices();
  final _formKey = GlobalKey<FormState>();

  // these values will be initialized in init state method
  late String title;
  late double price;
  late String description;
  late String image;
  late String category;

  @override
  void initState() {
    super.initState();
    title = widget.product.title;
    price = widget.product.price;
    description = widget.product.description;
    image = widget.product.image;
    category = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  title = newValue!;
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // Price
              TextFormField(
                initialValue: price.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Price",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  price = double.parse(newValue!);
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // Description
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  description = newValue!;
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // Image
              TextFormField(
                initialValue: image,
                decoration: const InputDecoration(
                  labelText: "Image",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a image";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  image = newValue!;
                },
              ),
              const SizedBox(
                height: 16,
              ),

              // Category
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(
                  labelText: "Category",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a category";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  category = newValue!;
                },
              ),
              const SizedBox(
                height: 30,
              ),

              // Elevated button
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blueAccent)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!
                          .save(); // call all on saved methods inside Form's text form fields
                      ProductModel updatedProduct = ProductModel(
                        title: title,
                        price: price,
                        description: description,
                        image: image,
                        category: category,
                      );

                      try {
                        apiServices.updateProduct(
                            widget.product.id!, updatedProduct);
                        Navigator.pop(context);
                      } catch (err) {
                        print("Error : $err}");
                      }
                    }
                  },
                  child: const Text(
                    "Update Product",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
