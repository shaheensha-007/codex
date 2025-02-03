import 'dart:convert';
import 'package:codex/Modelclass/ProductModels/Productdetalis.dart';
import 'package:codex/Modelclass/viewproductmodel/ViewProductModel.dart';
import 'package:http/http.dart';
import '../../api_client.dart';

class ViewdetalisApi {
  ApiClient apiClient_1 = ApiClient();


  Future<ViewProductModel> fetchViewProductDetails({required String id}) async {
    try {
      String trendingpath = 'parts_categories/$id';
      Response response = await apiClient_1.invokeAPI(trendingpath, 'GET', null);

      if (response.statusCode == 200) {
        // Convert response body into a JSON object
        var jsonResponse = jsonDecode(response.body);
        return ViewProductModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load product details: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching product details: $e");
    }
  }
}