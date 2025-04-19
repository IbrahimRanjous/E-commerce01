import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'add_new_address_view.dart';
import 'widgets/address_tile.dart';

/// The main page that displays a list of addresses and manages the selected index.
class UserAddressedView extends StatefulWidget {
  const UserAddressedView({super.key});

  @override
  State<UserAddressedView> createState() => _UserAddressedViewState();
}

class _UserAddressedViewState extends State<UserAddressedView> {
  // Preselect Maria Garcia (index 4) based on our design.
  int selectedIndex = 0;
  Color containerColor = TColors.grey;

  // List of addresses
  final List<Address> addresses = [
    Address(
      name: 'Coding with T',
      phone: '+923178059528',
      address: '82356 Timmy Coves, South Liana, Maine 87665, USA',
    ),
    Address(
      name: 'John Doe',
      phone: '(+123) 456 7890',
      address: '123 Main Street, New York, New York 10001, United States',
    ),
    Address(
      name: 'Alice Smith',
      phone: '(+987) 654 3210',
      address: '456 Elm Avenue, Los Angeles, California 90001, United States',
    ),
    Address(
      name: 'Taimoor Sikander',
      phone: '+923178059528',
      address: 'Street 35, Islamabad, Federal 48000, Pakistan',
    ),
    Address(
      name: 'Maria Garcia',
      phone: '(+541) 234 5678',
      address: '789 Oak Road, Buenos Aires, Buenos Aires 1001, Argentina',
    ),
    Address(
      name: 'Liam Johnson',
      phone: '+447890123456',
      address: '10 Park Lane, London, England SW1A 1AA, United Kingdom',
    ),
  ];

  /// Handler for selecting an address.
  void selectAddress(int index) {
    setState(() {
      selectedIndex = index;
      containerColor = TColors.accent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(TSizes.sm),
          margin: const EdgeInsets.all(TSizes.spaceBtwItems / 2),
          decoration: BoxDecoration(
            color:
                index == selectedIndex ? TColors.primary : TColors.darkerGrey,
            border: Border.all(color: TColors.primary),
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
          ),
          child: AddressTile(
            address: addresses[index],
            isSelected: index == selectedIndex,
            onTap: () => selectAddress(index),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print('Add new address tapped.+ $selectedIndex');
          }
          Get.to(() => const AddNewAddressView());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
