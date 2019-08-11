import 'package:ptv_api_client/api.dart';

class ApiService {
  ApiService();

  Future<V3DisruptionsResponse> getDisruptions() async {
    final api_instance = DisruptionsApi();

    try {
      final V3DisruptionsResponse result =
          await api_instance.disruptionsGetAllDisruptions();
      return result;
    } catch (e) {
      print(
          "Exception when calling DisruptionsApi->disruptionsGetAllDisruptions: $e\n");
      return null;
    }
  }
}
