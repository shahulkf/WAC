import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:provider/provider.dart';
import 'package:task/utils/constants/constants.dart';
import 'package:task/view%20model/home_view_model.dart';
import 'package:tuple/tuple.dart';

class HomePage extends StatelessWidget {
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Category Page'),
    Text('Cart Page'),
    Text('Offers Page'),
    Text('Account Page'),
  ];

  const HomePage({super.key});

  Future<void> _refreshData(BuildContext context) async {
    await context.read<HomeViewModel>().fetchDatas();
  }

  @override
  Widget build(BuildContext context) {
    size(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenFullHeight * .07),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 147, 200, 72),
          leading: const Icon(Icons.shopping_cart_outlined),
          title: SizedBox(
            height: screenFullHeight * .04.w,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Selector<HomeViewModel, int>(
        selector: (_, viewModel) => viewModel.selectedIndex,
        builder: (context, selectedIndex, child) {
          if (selectedIndex == 0) {
            return Selector<HomeViewModel, Tuple3<List<Widget>, bool, bool>>(
              selector: (_, viewModel) => Tuple3(viewModel.homePageWidgets,
                  viewModel.homeLoading, viewModel.isOffline),
              builder: (context, data, child) {
                if (data.item2) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (data.item3) {
                    // Showing cached data when offline
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(context),
                      child: ListView.builder(
                        itemCount: data.item1.length,
                        itemBuilder: (context, index) {
                          return data.item1[index];
                        },
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(context),
                      child: ListView.builder(
                        itemCount: data.item1.length,
                        itemBuilder: (context, index) {
                          return data.item1[index];
                        },
                      ),
                    );
                  }
                }
              },
            );
          } else {
            return Center(child: _widgetOptions.elementAt(selectedIndex));
          }
        },
      ),
      bottomNavigationBar: Selector<HomeViewModel, int>(
        selector: (_, viewModel) => viewModel.selectedIndex,
        builder: (context, selectedIndex, child) {
          return MotionTabBar(
            initialSelectedTab: "Home",
            useSafeArea: true,
            labels: const ["Home", "Category", "Cart", "Offers", "Account"],
            icons: const [
              Icons.home,
              Icons.category,
              Icons.shopping_cart,
              Icons.local_offer,
              Icons.account_circle,
            ],
            tabSize: 40.w,
            tabBarHeight: 50.w,
            textStyle: TextStyle(
              fontSize: 10.sp,
              color: Colors.black,
            ),
            tabIconColor: Colors.grey[600],
            tabIconSize: 28.0,
            tabIconSelectedSize: 26.0,
            tabSelectedColor: Colors.green,
            tabIconSelectedColor: Colors.white,
            tabBarColor: const Color.fromARGB(255, 212, 212, 212),
            onTabItemSelected: (int index) {
              context.read<HomeViewModel>().setSelectedIndex(index);
            },
          );
        },
      ),
    );
  }
}
