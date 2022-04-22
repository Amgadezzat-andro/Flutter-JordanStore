// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:generalshop/screens/utilities/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/helpers_api.dart';
import '../product/product.dart';
import 'utilities/helpers_widgets.dart';
import 'package:generalshop/product/home_products.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;

  HelpersApi helpersApi = HelpersApi();

  HomeProductBloc homeProductBloc = HomeProductBloc();
  List<ProductCategory> productCategories;

  TabController tabController;

  int currentIndex = 0;

  @override
  void initState() {
    // homeProductBloc = HomeProductBloc();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
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
                this.productCategories = snapShot.data;
                homeProductBloc.fetchProducts
                    .add(this.productCategories[0].category_id);
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
          onTap: (int index) {
            homeProductBloc.fetchProducts
                .add(this.productCategories[index].category_id);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: homeProductBloc.productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.none:
                return error('Nothing is working');
                break;
              case ConnectionState.waiting:
                return loading();
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapShot.hasError) {
                  return error(snapShot.error.toString());
                } else {
                  if (!snapShot.hasData) {
                    return error('no data returned');
                  } else {
                    return _drawProduct(snapShot.data);
                  }
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _drawProduct(List<Product> products) {
    return Container(
      child: Column(children: [
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, position) {
              return Card(
                child: Container(
                  child: Image(
                    image: NetworkImage(products[position].featuredImage()),
                  ),
                ),
              );
            },
            itemCount: products.length,
          ),
        ),
      ]),
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
