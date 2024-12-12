import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class APIServices{

  // Fetch all data Product from the api https://fakestoreapi.com/products
  Future<List<ProductModel>> fetchAllProduct() async{
    const String url = "https://fakestoreapi.com/products";

    try{
      final response = await http.get(Uri.parse(url));
          //.get(Uri.parse(url))
      if(response.statusCode == 200 ){
        List<dynamic> responseDataList = json.decode(response.body);
        List<ProductModel> productsList = responseDataList.map((json){
          return ProductModel.fromJson(json);
        }).toList();

        return productsList;
      } else {
        print("Failed to fetch product the status code : ${response.statusCode}");
        throw Exception("Isilda to fetch products");
      }
    } catch(err){
      print("Error : $err");
      throw Exception("Failed to fetch product");
    }
  }

  // Fetch a single product from api
  Future<ProductModel> fetchSingleProduct(int id)async{
    final String url = "https://fakestoreapi.com/products/$id";

    try{
      final response  = await http.get(Uri.parse(url));

      // checking data fetch successfully
      if (response.statusCode == 200){
        ProductModel singleProduct = ProductModel.fromJson(json.decode(response.body));
        return singleProduct;
      } else {
        print("Failed to fetch the product. Status code : ${response.statusCode}");
        throw Exception("Failed to fetch product");
      }
    } catch(err){
      print("Error : $err");
      throw Exception("Failed to fetch product");
    }
  }
}