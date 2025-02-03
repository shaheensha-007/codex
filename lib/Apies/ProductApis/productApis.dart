import 'dart:convert';
import 'package:codex/Modelclass/ProductModels/Productdetalis.dart';
import 'package:http/http.dart';
import '../../api_client.dart';

class ProductdetalisApi {
  ApiClient apiClient_1 = ApiClient();
  String trendingpath = 'parts_categories/';
//  Map<int, ProductdetalisModel> partsById = {};

  Future<List<ProductdetalisModel>> fetchProductDetails() async {
    try {
      // Sending a GET request (without a body)
      Response response = await apiClient_1.invokeAPI(trendingpath, 'GET', null);

      if (response.statusCode == 200) {
        // Convert response body into a JSON object
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductdetalisModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load product details: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching product details: $e");
    }
  }
}
