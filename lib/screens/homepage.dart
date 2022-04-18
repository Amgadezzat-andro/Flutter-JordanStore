// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:generalshop/screens/utilities/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/helpers_api.dart';
import 'utilities/helpers_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  HelpersApi helpersApi = HelpersApi();
  TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return FutureBuilder(
      future: helpersApi.fetchCategories(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductCategory>> snapShot,
      ) {
        switch (snapShot.connectionState) {
          case ConnectionState.none:
            return error('No Connection Made');
            break;
          case ConnectionState.waiting:
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.done:
            if (snapShot.hasError) {
              return error(snapShot.error.toString());
            } else {
              if (!snapShot.hasData) {
                return error('no data found');
              } else {
                return _screen(snapShot.data);
              }
            }
            break;
        }
        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories) {
    tabController = TabController(
      initialIndex: 0,
      length: categories.length,
      vsync: this,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
        ],
        bottom: TabBar(
          indicatorColor: ScreenUtilities.mainBlue,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
        ),
      ),
      body: Container(),
    );
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];
    for (ProductCategory category in categories) {
      tabs.add(
        Tab(
          text: category.category_name,
        ),
      );
    }
    return tabs;
  }
}
