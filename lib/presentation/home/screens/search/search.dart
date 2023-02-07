import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/api/api.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

import '../product_detail/product_detail.dart';

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
          final products = (await UserApi.searchProducts(query))!;
          if (!mounted) return;
          setState(() {
            this.query = query;
            this.products = products;
          });
          print('RES');
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
                                      onChanged: (str) {
                                        searchBook(str);
                                      },
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      controller: _searchController,
                                      decoration:
                                          Constants.inputDecoration('Search')),
                                ),
                                IconButton(
                                    onPressed: () {
                                      searchBook(_searchController.text);
                                    },
                                    icon: Icon(Icons.search))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              products.isEmpty
                  ? const Center(
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
          push(context, ProductDetail(product: product!));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(24)),
          height: 100,
          width: size.width,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: Api.rootFolder + product!.image,
                      fit: BoxFit.contain,
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
                        product!.price + 'XAF',
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product!.qty.toString() + ' Available',
                        style: TextStyle(color: AppColors.primaryColor),
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
