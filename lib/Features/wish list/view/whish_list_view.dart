import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/wish%20list/view/widgets/wish_list_view_body.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/widgets/user/user_controller.dart';

class WhishListView extends StatelessWidget {
  const WhishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          'Whishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: const [Icon(Iconsax.add)],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Call the fetch function to refresh user data.
            final controller = UserController.instance;
            controller.fetchUserRecord();
          },
          child: const CustomScrollView(
            physics:
                AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: WishListViewBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
