import 'dart:convert';

import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../core/common/widgets/circular_indicator.dart';
import '../../core/common/widgets/home_drawer.dart';
import '../../core/constraints/colors.dart';
import 'customer_controller.dart';
import 'customer_details.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  //previously handel by that
  List<dynamic> customers = [].obs;

  RxBool isLoading = true.obs;
  RxBool isMoreLoading = false.obs;
  RxBool hasMore = true.obs;
  int pageNo = 1;
  RxString search = ''.obs;
  String token = '';

  final controller = Get.find<CustomerController>();
  final scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    token = Get.arguments?.toString() ?? '';
    getCustomers();

    //scroll
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (!isMoreLoading.value && hasMore.value) {
          pageNo++;
          getCustomers(page: pageNo);
        }
      }
    });
  }

  Future<void> getCustomers({String query = '', int page = 1}) async {
    setState(() {
      if (page == 1) {
        isLoading.value = true;
        isMoreLoading.value = false;
      } else {
        isMoreLoading.value = true;
      }
    });
    try {
      if (page > 1) {
        await Future.delayed(Duration(seconds: 2));
      }
      Uri url = Uri.parse(
        //url link change little bit pageNO=1 in previous
        'https://www.hisabplus.com/Values/GetCustomerList?searchquery=$query&pageNo=$page&pageSize=20&SortyBy=Balance',
      );

      http.Response response = await http.get(
        url,
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        setState(() {
          debugPrint(response.statusCode.toString());
          final Map<String, dynamic> data = jsonDecode(response.body);
          final List<dynamic> newList = data['CustomerList'] ?? [];
          isLoading.value = false;

          if (page == 1) {
            customers.assignAll(newList);
          } else {
            customers.addAll(newList);
          }
          hasMore.value = newList.length == 20;
        });
      } else {
        Get.snackbar('Error', 'Failed to load customer list');
        debugPrint('Error Occur and Response is ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Internet connection error');
    } finally {
      setState(() {
        isMoreLoading.value = false;
        isLoading.value = false;
      });
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
          backgroundColor: UColors.primary,
          toolbarHeight: 80,
          foregroundColor: Colors.white,
          title: Text('Customers'),
        ),
        drawer: UDrawer(controller: controller),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //searchbar
              searchTextFormField(),
              SizedBox(height: 12),

              Expanded(
                child: Obx(
                  () => isLoading.value
                      ? Center(child: UCircularProgressIndicator())
                      : customers.isEmpty
                      ? Text('No Customer found')
                      : ListView.builder(
                          // separatorBuilder: (context, index) =>
                          // const SizedBox(height: 8),
                          controller: scroll,
                          // shrinkWrap: true,
                          itemCount:
                              customers.length + (isMoreLoading.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == customers.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: UCircularProgressIndicator(),
                              );
                            }
                            final customer = customers[index];

                            final image = customer['ImagePath'];

                            String name = customer['Name'];
                            //for image
                            String firstLetter = name.isNotEmpty
                                ? name[0].toUpperCase()
                                : '?';

                            return customerImage(customer, image, firstLetter);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //customer profile function
  ListTile customerImage(dynamic customer, dynamic image, String firstLetter) {
    return ListTile(
      title: Text(
        customer['Name'],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      subtitle: Text(customer['Phone']),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        backgroundImage: (image != null && image.toString().trim().isNotEmpty)
            ? NetworkImage(
                image.toString().startsWith('http')
                    ? image
                    : 'https://hisabplus.com${image.toString().startsWith('/') ? '' : '/'}${customer['ImagePath']}',
              )
            : null,
        child: image == null ? Text(firstLetter) : null,
      ),
      trailing: Icon(Iconsax.arrow_right_3),
      onTap: () {
        if (customer['Id'] != null) {
          Get.to(() => CustomerDetails(customer: customer));
        }
      },
    );
  }

  //search function
  TextFormField searchTextFormField() {
    return TextFormField(
      controller: controller.search,

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        prefixIcon: Icon(Iconsax.user_search),
        suffixIcon: Obx(
          () => search.value.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.search.clear();
                    search.value = '';
                    pageNo = 1;
                    getCustomers(query: '');
                  },
                  icon: Icon(Iconsax.close_circle),
                )
              : SizedBox.shrink(),
        ),
        labelText: 'search',
      ),
      onChanged: (value) {
        search.value = value;
        pageNo = 1;
        getCustomers(query: value);
      },
    );
  }
}
