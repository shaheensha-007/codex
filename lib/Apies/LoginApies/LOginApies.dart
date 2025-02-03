import 'dart:convert';
import 'package:http/http.dart';
import '../../Modelclass/Loginmodel/LoginModel.dart';
import '../../api_client.dart';

class LogininApi {
  ApiClient apiClient_1 = ApiClient();
  String trendingpath = 'login/';

  Future<LoginModel> postLogindata(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };

      Response response = await apiClient_1.invokeAPI(
          trendingpath, 'POST_', jsonEncode(body));
      try{
        final responseFromAPi = LoginModel.fromJson(
            json.decode(response.body));
      if (response.statusCode == 200) {
        final responseFromApi = LoginModel.fromJson(json.decode(response.body));

        if (responseFromApi.details?.toLowerCase() == "failed") {
          throw  responseFromAPi.details.toString();
        }

        return responseFromApi;
      } else {
        throw responseFromAPi.details.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}