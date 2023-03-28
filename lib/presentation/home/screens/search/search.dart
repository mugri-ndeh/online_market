import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/presentation/home/screens/search/cubit/search_cubit.dart';
import 'package:online_market/util/constants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

import '../../../../services/errors/global_error_handling/custom_consumer.dart';
import '../product_detail/product_detail.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        body: SafeArea(
          child: CustomBlocConsumer<SearchCubit, SearchState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
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
                                              context
                                                  .read<SearchCubit>()
                                                  .search();
                                            },
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            controller: context
                                                .watch<SearchCubit>()
                                                .searchController,
                                            decoration:
                                                Constants.inputDecoration(
                                                    'Search')),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.search))
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
                    if (state is SearchLoaded)
                      state.products.isEmpty
                          ? const Center(
                              child: Text('No results'),
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => SearchResult(
                                  product: state.products[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  thickness: 2,
                                ),
                                itemCount: state.products.length,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                              ),
                            ),
                  ],
                ),
              );
            },
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
          push(context, ProductDetailPage(product: product!));
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
                      imageUrl: product!.image,
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
                        product!.availableQuantity.toString() + ' Available',
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
