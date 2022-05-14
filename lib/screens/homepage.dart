// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/screens/streams/CATEGORIES_STREAM.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:generalshop/screens/utilities/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/helpers_api.dart';
import '../product/product.dart';
import 'utilities/helpers_widgets.dart';
import 'package:generalshop/product/home_products.dart';
import 'package:generalshop/screens/streams/dots_stream.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  HelpersApi helpersApi = HelpersApi();
  HomeProductBloc homeProductBloc = HomeProductBloc();
  // CategoriesStream categoriesStream = CategoriesStream();
  List<ProductCategory> productCategories;
  PageController _pageController;
  TabController tabController;
  int currentIndex = 0;
  // int dotCurrentIndex = 1;
  // DotsStream dotsStream = DotsStream();

  @override
  void initState() {
    // homeProductBloc = HomeProductBloc();
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.75,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
    // categoriesStream.dispose();
    // dotsStream.dispose();
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
            return loading();
            break;
          case ConnectionState.done:
          case ConnectionState.active:
            if (snapShot.hasError) {
              return error(snapShot.error.toString());
            } else {
              if (!snapShot.hasData) {
                return error('no data found');
              } else {
                this.productCategories = snapShot.data;
                homeProductBloc.fetchProducts
                    .add(this.productCategories[0].category_id);
                return _screen(snapShot.data, context);
              }
            }
            break;
        }
        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories, BuildContext context) {
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
          indicatorWeight: 3,
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
                    return _drawProducts(snapShot.data, context);
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

  // this function to show random 5 products for each category
  List<Product> _randomTopProducts(List<Product> products) {
    List<int> indexes = [];
    Random random = Random();
    int counter = 5;
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
        counter--;
      }
    } while (counter != 0);

    for (int index in indexes) {
      newProducts.add(products[index]);
    }
    return newProducts;
  }

  Widget _drawProducts(List<Product> products, BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);

    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              onPageChanged: (int index) {
                // dotsStream.dotsSink.add(index);
                // dotIndex.value = index;
              },
              itemBuilder: (context, position) {
                return InkWell(
                  onTap: () {
                    print(topProducts[position].product_title);
                  },
                  child: Card(
                    margin: EdgeInsets.only(right: 4, left: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      child: Image(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(topProducts[position].featuredImage()),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 24),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    onTap: () {
                      print(products[position].product_title);
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                            ),
                            child: Image(
                              image: NetworkImage(
                                  products[position].featuredImage()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            products[position].product_title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                              '\$ ${products[position].product_price.toString()}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
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

  List<Widget> _drawDots(int qty, int index) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == index)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.lightGrey,
          ),
          width: 10,
          height: 10,
          margin: (i == qty)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 10),
        ),
      );
    }
    return widgets;
  }
}
