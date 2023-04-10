// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;

import '../main.dart' as _i1;
import '../model/shop.dart' as _i20;
import '../presentation/auth/complete_profile/complete_profile.dart' as _i4;
import '../presentation/auth/login/login.dart' as _i2;
import '../presentation/auth/signup/signup.dart' as _i3;
import '../presentation/base_screen/base.dart' as _i5;
import '../presentation/favorites/favorites.dart' as _i12;
import '../presentation/home/home.dart' as _i10;
import '../presentation/profile/index.dart' as _i13;
import '../presentation/seller/base.dart' as _i6;
import '../presentation/seller/home/seller_home.dart' as _i14;
import '../presentation/seller/orders/seller_orders.dart' as _i15;
import '../presentation/seller/profile/seller_profile.dart' as _i17;
import '../presentation/seller/shop/screens/add_shop/addshops.dart' as _i7;
import '../presentation/seller/shop/screens/products/addProducts.dart' as _i8;
import '../presentation/seller/shop/screens/products/products.dart' as _i9;
import '../presentation/seller/shop/screens/seller_shops.dart' as _i16;
import '../presentation/shop/index.dart' as _i11;

class AppRouter extends _i18.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LoginPage(key: args.key),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpPage(),
      );
    },
    CompleteProfileRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteProfileRouteArgs>(
          orElse: () => const CompleteProfileRouteArgs());
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.CompleteProfilePage(key: args.key),
      );
    },
    Base.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.BasePage(),
      );
    },
    SellerBase.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SellerBasePage(),
      );
    },
    AddShopRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AddShopPage(),
      );
    },
    AddProductsRoute.name: (routeData) {
      final args = routeData.argsAs<AddProductsRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AddProductsPage(
          key: args.key,
          shop: args.shop,
        ),
      );
    },
    ProductsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductsRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ProductsPage(
          key: args.key,
          shop: args.shop,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.HomePage(),
      );
    },
    ShopRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ShopPage(),
      );
    },
    FavouritesRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.FavouritesPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.ProfilePage(key: args.key),
      );
    },
    SellerHomeRoute.name: (routeData) {
      final args = routeData.argsAs<SellerHomeRouteArgs>(
          orElse: () => const SellerHomeRouteArgs());
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.SellerHomePage(key: args.key),
      );
    },
    SellerOrdersRoute.name: (routeData) {
      final args = routeData.argsAs<SellerOrdersRouteArgs>(
          orElse: () => const SellerOrdersRouteArgs());
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.SellerOrdersPage(key: args.key),
      );
    },
    SellerShopRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.SellerShopPage(),
      );
    },
    SellerProfileRoute.name: (routeData) {
      final args = routeData.argsAs<SellerProfileRouteArgs>(
          orElse: () => const SellerProfileRouteArgs());
      return _i18.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.SellerProfilePage(key: args.key),
      );
    },
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(
          SplashScreen.name,
          path: '/',
        ),
        _i18.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i18.RouteConfig(
          SignUpRoute.name,
          path: '/sign-up-page',
        ),
        _i18.RouteConfig(
          CompleteProfileRoute.name,
          path: '/complete-profile-page',
        ),
        _i18.RouteConfig(
          Base.name,
          path: '/base',
          children: [
            _i18.RouteConfig(
              HomeRoute.name,
              path: '',
              parent: Base.name,
            ),
            _i18.RouteConfig(
              ShopRoute.name,
              path: 'shop-page',
              parent: Base.name,
            ),
            _i18.RouteConfig(
              FavouritesRoute.name,
              path: 'favourites-page',
              parent: Base.name,
            ),
            _i18.RouteConfig(
              ProfileRoute.name,
              path: 'profile-page',
              parent: Base.name,
            ),
          ],
        ),
        _i18.RouteConfig(
          SellerBase.name,
          path: '/sellerbase',
          children: [
            _i18.RouteConfig(
              SellerHomeRoute.name,
              path: '',
              parent: SellerBase.name,
            ),
            _i18.RouteConfig(
              SellerOrdersRoute.name,
              path: 'seller-orders-page',
              parent: SellerBase.name,
            ),
            _i18.RouteConfig(
              SellerShopRoute.name,
              path: '',
              parent: SellerBase.name,
            ),
            _i18.RouteConfig(
              SellerProfileRoute.name,
              path: 'seller-profile-page',
              parent: SellerBase.name,
            ),
          ],
        ),
        _i18.RouteConfig(
          AddShopRoute.name,
          path: '/add-shop-page',
        ),
        _i18.RouteConfig(
          AddProductsRoute.name,
          path: '/add-products-page',
        ),
        _i18.RouteConfig(
          ProductsRoute.name,
          path: '/products-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i18.PageRouteInfo<void> {
  const SplashScreen()
      : super(
          SplashScreen.name,
          path: '/',
        );

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i18.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i19.Key? key})
      : super(
          LoginRoute.name,
          path: '/login-page',
          args: LoginRouteArgs(key: key),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i18.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.CompleteProfilePage]
class CompleteProfileRoute
    extends _i18.PageRouteInfo<CompleteProfileRouteArgs> {
  CompleteProfileRoute({_i19.Key? key})
      : super(
          CompleteProfileRoute.name,
          path: '/complete-profile-page',
          args: CompleteProfileRouteArgs(key: key),
        );

  static const String name = 'CompleteProfileRoute';
}

class CompleteProfileRouteArgs {
  const CompleteProfileRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'CompleteProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.BasePage]
class Base extends _i18.PageRouteInfo<void> {
  const Base({List<_i18.PageRouteInfo>? children})
      : super(
          Base.name,
          path: '/base',
          initialChildren: children,
        );

  static const String name = 'Base';
}

/// generated route for
/// [_i6.SellerBasePage]
class SellerBase extends _i18.PageRouteInfo<void> {
  const SellerBase({List<_i18.PageRouteInfo>? children})
      : super(
          SellerBase.name,
          path: '/sellerbase',
          initialChildren: children,
        );

  static const String name = 'SellerBase';
}

/// generated route for
/// [_i7.AddShopPage]
class AddShopRoute extends _i18.PageRouteInfo<void> {
  const AddShopRoute()
      : super(
          AddShopRoute.name,
          path: '/add-shop-page',
        );

  static const String name = 'AddShopRoute';
}

/// generated route for
/// [_i8.AddProductsPage]
class AddProductsRoute extends _i18.PageRouteInfo<AddProductsRouteArgs> {
  AddProductsRoute({
    _i19.Key? key,
    required _i20.Shop shop,
  }) : super(
          AddProductsRoute.name,
          path: '/add-products-page',
          args: AddProductsRouteArgs(
            key: key,
            shop: shop,
          ),
        );

  static const String name = 'AddProductsRoute';
}

class AddProductsRouteArgs {
  const AddProductsRouteArgs({
    this.key,
    required this.shop,
  });

  final _i19.Key? key;

  final _i20.Shop shop;

  @override
  String toString() {
    return 'AddProductsRouteArgs{key: $key, shop: $shop}';
  }
}

/// generated route for
/// [_i9.ProductsPage]
class ProductsRoute extends _i18.PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    _i19.Key? key,
    required _i20.Shop shop,
  }) : super(
          ProductsRoute.name,
          path: '/products-page',
          args: ProductsRouteArgs(
            key: key,
            shop: shop,
          ),
        );

  static const String name = 'ProductsRoute';
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    this.key,
    required this.shop,
  });

  final _i19.Key? key;

  final _i20.Shop shop;

  @override
  String toString() {
    return 'ProductsRouteArgs{key: $key, shop: $shop}';
  }
}

/// generated route for
/// [_i10.HomePage]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i11.ShopPage]
class ShopRoute extends _i18.PageRouteInfo<void> {
  const ShopRoute()
      : super(
          ShopRoute.name,
          path: 'shop-page',
        );

  static const String name = 'ShopRoute';
}

/// generated route for
/// [_i12.FavouritesPage]
class FavouritesRoute extends _i18.PageRouteInfo<void> {
  const FavouritesRoute()
      : super(
          FavouritesRoute.name,
          path: 'favourites-page',
        );

  static const String name = 'FavouritesRoute';
}

/// generated route for
/// [_i13.ProfilePage]
class ProfileRoute extends _i18.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i19.Key? key})
      : super(
          ProfileRoute.name,
          path: 'profile-page',
          args: ProfileRouteArgs(key: key),
        );

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.SellerHomePage]
class SellerHomeRoute extends _i18.PageRouteInfo<SellerHomeRouteArgs> {
  SellerHomeRoute({_i19.Key? key})
      : super(
          SellerHomeRoute.name,
          path: '',
          args: SellerHomeRouteArgs(key: key),
        );

  static const String name = 'SellerHomeRoute';
}

class SellerHomeRouteArgs {
  const SellerHomeRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SellerHomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.SellerOrdersPage]
class SellerOrdersRoute extends _i18.PageRouteInfo<SellerOrdersRouteArgs> {
  SellerOrdersRoute({_i19.Key? key})
      : super(
          SellerOrdersRoute.name,
          path: 'seller-orders-page',
          args: SellerOrdersRouteArgs(key: key),
        );

  static const String name = 'SellerOrdersRoute';
}

class SellerOrdersRouteArgs {
  const SellerOrdersRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SellerOrdersRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.SellerShopPage]
class SellerShopRoute extends _i18.PageRouteInfo<void> {
  const SellerShopRoute()
      : super(
          SellerShopRoute.name,
          path: '',
        );

  static const String name = 'SellerShopRoute';
}

/// generated route for
/// [_i17.SellerProfilePage]
class SellerProfileRoute extends _i18.PageRouteInfo<SellerProfileRouteArgs> {
  SellerProfileRoute({_i19.Key? key})
      : super(
          SellerProfileRoute.name,
          path: 'seller-profile-page',
          args: SellerProfileRouteArgs(key: key),
        );

  static const String name = 'SellerProfileRoute';
}

class SellerProfileRouteArgs {
  const SellerProfileRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SellerProfileRouteArgs{key: $key}';
  }
}
