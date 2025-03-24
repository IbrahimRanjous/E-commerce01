import 'package:flutter/material.dart';
import 'widgets/primary_header_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
