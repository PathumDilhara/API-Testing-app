import 'package:f27_api/screens/edit_product_page.dart';
import 'package:flutter/material.dart';

import '../api/api_services.dart';
import '../model/product_model.dart';

class SingleProductPage extends StatelessWidget {
  final int productId;
  SingleProductPage({
    super.key,
    required this.productId,
  });

  final APIServices apiServices = APIServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: apiServices.fetchSingleProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ), // bcs we used single child scroll view
                    const CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("Product not found"),
              );
            } else {
              ProductModel singleProduct = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      singleProduct.image,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      singleProduct.title,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text("\$${singleProduct.price}",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(singleProduct.description),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProductPage(product: singleProduct),
                              ),
                            );
                          },
                          child: Text("Update"),
                        ),
                        ElevatedButton(onPressed: () async{
                          await apiServices.deleteProduct(singleProduct.id!);
                          Navigator.pop(context);
                        }, child: Text("Delete"))
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
