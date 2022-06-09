import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Product> products = [];
  Timer? debouncer;
  String query = '';

  Future searchBook(String query) async => debounce(
        () async {
          final products = <Product>[];
          if (!mounted) return;
          setState(() {
            this.query = query;
            this.products = products;
          });
          print('SONG IS');
        },
      );

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Constants.formBox(
                            context: context,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      onChanged: (str) {},
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      controller: _searchController,
                                      obscureText: true,
                                      decoration:
                                          Constants.inputDecoration('Search')),
                                ),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.search))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              products.isEmpty
                  ? Center(
                      child: Text('No results'),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => SearchResult(
                          product: products[index],
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 2,
                        ),
                        itemCount: products.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, this.product}) : super(key: key);
  final Product? product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          // push(context, FoodDetail(foodItem: foodItem!));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: Palette.white, borderRadius: BorderRadius.circular(24)),
          height: 100,
          width: size.width,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/',
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product!.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        product!.price,
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product!.qty.toString(),
                        style: TextStyle(color: Palette.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
