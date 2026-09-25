import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constraints/colors.dart';

class CustomerDetails extends StatefulWidget {
  final dynamic customer;

  const CustomerDetails({super.key, required this.customer});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    final item = widget.customer;
    bool isActive = item['IsInActive'] == false;
    final img = item['ImagePath'];
    return Scaffold(
      backgroundColor: UColors.secondary,
      appBar: AppBar(
        title: Text(item['Name']),
        backgroundColor: UColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [UColors.primary, UColors.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child: Column(
              children: [
                SizedBox(height: 24),

                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: UColors.primary,
                    backgroundImage: img != null
                        ? NetworkImage('https://www.hisabplus.com/$img')
                        : null,
                    child: img == null ? Icon(Iconsax.user) : null,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? LinearGradient(
                            colors: [Colors.green, Colors.green.shade100],
                          )
                        : LinearGradient(
                            colors: [Colors.red, Colors.redAccent],
                          ),
                    color: isActive ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isActive ? 'Active' : 'InActive',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text(
          //   item['Name'] ?? 'No Name',
          //   style: const TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black87,
          //   ),
          // ),
          Expanded(
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              child: Column(
                children: [
                  //note
                  if (item['Note'] != null && item['Note'] != '')
                    ListTile(
                      leading: Icon(Iconsax.note_text),
                      title: Text(
                        'Note',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['Note'].toString()),
                    ),
                  //phone
                  if (item['Phone'] != null && item['Phone'] != '')
                    ListTile(
                      leading: Icon(Iconsax.mobile),
                      title: Text(
                        'Phone',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['Phone'].toString()),
                    ),

                  //email
                  if (item['Email'] != null && item['Email'] != '')
                    ListTile(
                      leading: Icon(Iconsax.sms),
                      title: Text(
                        'Email',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['Email'].toString()),
                    ),

                  //primary address
                  if (item['PrimaryAddress'] != null &&
                      item['PrimaryAddress'] != '')
                    ListTile(
                      leading: Icon(Iconsax.map),
                      title: Text(
                        'PrimaryAddress',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['PrimaryAddress'].toString()),
                    ),

                  //cast
                  if (item['CustType'] != null && item['CustType'] != '')
                    ListTile(
                      leading: Icon(Iconsax.hierarchy),
                      title: Text(
                        'CustType',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['CustType'].toString()),
                    ),

                  //secondary address
                  if (item['SecoundaryAddress'] != null &&
                      item['SecoundaryAddress'] != '')
                    ListTile(
                      leading: Icon(Iconsax.map),
                      title: Text(
                        'SecoundaryAddress',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['SecoundaryAddress'].toString()),
                    ),
                  //date
                  if (item['LastTransactionDate'] != null &&
                      item['LastTransactionDate'] != '')
                    ListTile(
                      leading: Icon(Iconsax.calendar_search),
                      title: Text(
                        'LastTransactionDate',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      subtitle: Text(item['LastTransactionDate'].toString()),
                    ),

                  //total due
                  if (item['TotalDue'] != null && item['TotalDue'] != '')
                    ListTile(
                      leading: Icon(Iconsax.wallet_remove),
                      title: Text(
                        'TotalDue',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      subtitle: Text(
                        ' Tk ' + item['TotalDue'].toString(),
                        style: TextStyle(
                          color: UColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
