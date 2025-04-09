import 'package:flutter/material.dart';

/// A reusable widget that displays a single address.
/// It highlights the widget if it is selected and provides a tap callback.
class AddressTile extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressTile({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(address.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.phone),
          const SizedBox(height: 4),
          Text(address.address),
        ],
      ),
      // If selected, apply a blue tint background
      tileColor: isSelected ? Colors.blue.shade100 : null,
    );
  }
}

/// Model representing an address.
class Address {
  final String name;
  final String phone;
  final String address;

  Address({
    required this.name,
    required this.phone,
    required this.address,
  });
}
