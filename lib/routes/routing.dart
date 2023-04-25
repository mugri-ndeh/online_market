// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:online_market/main.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/presentation/app_start/app_start_cubit.dart';
import 'package:online_market/presentation/auth/complete_profile/complete_profile.dart';
import 'package:online_market/presentation/auth/login/login.dart';
import 'package:online_market/presentation/auth/signup/signup.dart';
import 'package:online_market/presentation/base_screen/base.dart';
import 'package:online_market/presentation/favorites/favorites.dart';
import 'package:online_market/presentation/home/home.dart';
import 'package:online_market/presentation/onboarding/onboarding_screen.dart';
import 'package:online_market/presentation/profile/index.dart';
import 'package:online_market/presentation/seller/shop/screens/add_shop/addshops.dart';
import 'package:online_market/presentation/seller/shop/screens/products/addProducts.dart';
import 'package:online_market/presentation/seller/shop/screens/products/products.dart';
import 'package:online_market/presentation/shop/index.dart';

import '../presentation/seller/base.dart';
import '../presentation/seller/home/seller_home.dart';
import '../presentation/seller/orders/seller_orders.dart';
import '../presentation/seller/profile/seller_profile.dart';
import '../presentation/seller/shop/screens/seller_shops.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: CompleteProfilePage),
    AutoRoute(page: OnboardingScreen),
    AutoRoute(page: BasePage, name: 'Base', path: '/base', children: [
      AutoRoute(page: HomePage, initial: true),
      AutoRoute(page: ShopPage),
      AutoRoute(page: FavouritesPage),
      AutoRoute(page: ProfilePage),
    ]),
    AutoRoute(
        page: SellerBasePage,
        name: 'SellerBase',
        path: '/sellerbase',
        children: [
          AutoRoute(page: SellerHomePage, initial: true),
          AutoRoute(page: SellerOrdersPage),
          AutoRoute(page: SellerShopPage, path: ''),

          AutoRoute(page: SellerProfilePage),
          // AutoRoute(
          //   page: EmptyRouterPage,
          //   path: 'SellerShop',
          //   name: 'SellerShopScreen',
          //   deferredLoading: true,
          //   maintainState: true,
          //   children: [
          //     AutoRoute(page: SellerShopPage, path: ''),
          //     AutoRoute(page: AddShopPage),
          //     AutoRoute(page: AddProductsPage),
          //     AutoRoute(page: ProductsPage),
          //   ],
          // ),
        ]),
    AutoRoute(page: AddShopPage),
    AutoRoute(page: AddProductsPage),
    AutoRoute(page: ProductsPage),
  ],
)
class $AppRouter {}
