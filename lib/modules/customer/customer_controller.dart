import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  final search = TextEditingController();

  //get customer list
  // Future<void> getCustomers({String query = ''}) async {
  //   setState(() {
  //     isLoading = false;
  //   });
  //   Uri url = Uri.parse(
  //     'https://www.hisabplus.com/Values/GetCustomerList?searchquery=$query&pageNo=1&pageSize=20&SortyBy=Balance',
  //   );
  //   http.Response response = await http.get(
  //     url,
  //     headers: {'Authorization': token},
  //   );
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       debugPrint(response.statusCode.toString());
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       customers = data['CustomerList'];
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     debugPrint('Error Occur and Response is ${response.statusCode}');
  //   }
  // }
}
