import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

import '../../../../../main.dart';
import '../../../../../services/errors/global_error_handling/custom_consumer.dart';
import 'cubit/shop_cubit.dart';

class AddShopPage extends StatelessWidget {
  const AddShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          title: const Text(
            'Add a shop',
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: CustomBlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {
            if (state is ShopSuccess) {
              showSnackBar(context, 'Shop Created');
              context.router.pop();
            }
          },
          builder: (context, state) {
            if (state is ShopLoading) {
              return const LoadingScreen();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: context.watch<ShopCubit>().nameController,
                      validator: (val) =>
                          val!.isEmpty ? 'Please input a name' : null,
                      decoration: getInputDecoration(
                          hint: 'Shop name',
                          darkMode:
                              Theme.of(context).brightness == Brightness.dark,
                          errorColor: AppColors.error),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Add an image',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    context.watch<ShopCubit>().image == null
                        ? GestureDetector(
                            onTap: () async {
                              context.read<ShopCubit>().pickImage();
                            },
                            child: imgplace(
                                context: context, height: 100, width: 100))
                        : SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(
                              context.watch<ShopCubit>().image!,
                              fit: BoxFit.contain,
                            )),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomOutlinedButton(
                        child: const Text('Create Shop'),
                        onTap: () {
                          context.read<ShopCubit>().addShop();
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
