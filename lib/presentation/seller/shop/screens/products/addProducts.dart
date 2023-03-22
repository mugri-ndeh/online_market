//
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/main.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/presentation/seller/shop/screens/products/cubit/shop_products_cubit.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

import '../../../../../services/errors/global_error_handling/custom_consumer.dart';

class AddProductsPage extends StatelessWidget {
  const AddProductsPage({Key? key, required this.shop}) : super(key: key);
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopProductsCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          title: const Text(
            'Add a Product',
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: CustomBlocConsumer<ShopProductsCubit, ShopProductsState>(
          listener: (context, state) {
            if (state is ProductSuccess) {
              showSnackBar(context, 'Product added');
              context.router.pop();
            }
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              return const LoadingScreen();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller:
                          context.watch<ShopProductsCubit>().nameController,
                      decoration: getInputDecoration(
                          hint: 'Product name',
                          darkMode:
                              Theme.of(context).brightness == Brightness.dark,
                          errorColor: AppColors.error),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller:
                          context.watch<ShopProductsCubit>().priceController,
                      keyboardType: TextInputType.number,
                      decoration: getInputDecoration(
                          hint: 'Price',
                          darkMode:
                              Theme.of(context).brightness == Brightness.dark,
                          errorColor: AppColors.error),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller:
                          context.watch<ShopProductsCubit>().qtyController,
                      keyboardType: TextInputType.number,
                      decoration: getInputDecoration(
                          hint: 'Quantity',
                          darkMode:
                              Theme.of(context).brightness == Brightness.dark,
                          errorColor: AppColors.error),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          autofocus: true,
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  'Select category',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: context
                              .read<ShopProductsCubit>()
                              .categories
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item.toUpperCase(),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: context.watch<ShopProductsCubit>().category,
                          onChanged: (value) {
                            context
                                .read<ShopProductsCubit>()
                                .updateCategoty(value);
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                          ),
                          iconSize: 14,
                          selectedItemHighlightColor: AppColors.buttonColor,
                          iconEnabledColor: Theme.of(context).iconTheme.color,
                          iconDisabledColor: Colors.grey,
                          buttonHeight: 50,
                          buttonWidth: 160,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.buttonColor.withOpacity(0.3),
                            ),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          buttonElevation: 0,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 300,
                          dropdownWidth:
                              MediaQuery.of(context).size.width * 0.96,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 2,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Add an image',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    context.read<ShopProductsCubit>().image == null
                        ? GestureDetector(
                            onTap: () async {
                              context.read<ShopProductsCubit>().pickImage();
                            },
                            child: imgplace(
                                context: context, height: 100, width: 100))
                        : Image.file(context.read<ShopProductsCubit>().image!),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomOutlinedButton(
                        child: const Text('Add Product'),
                        onTap: () async {
                          context
                              .read<ShopProductsCubit>()
                              .addProductToShop(shop.id);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
