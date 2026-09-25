import 'dart:convert';

import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'customer_controller.dart';
import 'customer_details.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  List<dynamic> customers = [];
  bool isLoading = true;
  String token = '';
  final controller = Get.find<CustomerController>();
  @override
  void initState() {
    super.initState();
    token = Get.arguments?.toString() ?? '';
    getCustomers();
  }

  Future<void> getCustomers({String query = ''}) async {
    setState(() {
      isLoading = true;
    });
    Uri url = Uri.parse(
      'https://www.hisabplus.com/Values/GetCustomerList?searchquery=$query&pageNo=1&pageSize=20&SortyBy=Balance',
    );
    http.Response response = await http.get(
      url,
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200) {
      setState(() {
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> data = jsonDecode(response.body);
        customers = data['CustomerList'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error Occur and Response is ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.search.text.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (controller.search.text.isNotEmpty) {
          controller.search.clear();
          FocusScope.of(context).unfocus();
          setState(() {});
          getCustomers(query: '');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.black,
          title: Center(child: Text('Customers')),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: controller.search,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  prefixIcon: Icon(Iconsax.user_search),
                  suffixIcon: controller.search.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            controller.search.clear();
                            setState(() {});
                            getCustomers(query: '');
                          },
                          icon: Icon(Iconsax.close_circle),
                        )
                      : null,
                  labelText: 'search',
                ),
                onChanged: (value) {
                  setState(() {});
                  getCustomers(query: value);
                },
              ),
              SizedBox(height: 12),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : customers.isEmpty
                    ? Text('No Customer found')
                    : ListView.builder(
                        // separatorBuilder: (context, index) =>
                        // const SizedBox(height: 8),
                        shrinkWrap: true,
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          final image = customer['ImagePath'];
                          return ListTile(
                            title: Text(
                              customer['Name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Text(customer['Phone']),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              backgroundImage:
                                  (image != null &&
                                      image.toString().trim().isNotEmpty)
                                  ? NetworkImage(
                                      image.toString().startsWith('http')
                                          ? image
                                          : 'https://hisabplus.com${image.toString().startsWith('/') ? '' : '/'}${customer['ImagePath']}',
                                    )
                                  : null,
                              child: customer['ImagePath'] == null
                                  ? Icon(Iconsax.user)
                                  : null,
                            ),
                            trailing: Icon(Iconsax.arrow_right_3),
                            onTap: () {
                              if (customer['Id'] != null) {
                                Get.to(
                                  () => CustomerDetails(customer: customer),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
