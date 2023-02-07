// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:online_market/main.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/presentation/app_start/app_start_cubit.dart';
import 'package:online_market/presentation/auth/login/login.dart';
import 'package:online_market/presentation/auth/signup/signup.dart';
import 'package:online_market/presentation/base_screen/base.dart';
import 'package:online_market/presentation/cart/cart_screen.dart';
import 'package:online_market/presentation/favourites/favourites.dart';
import 'package:online_market/presentation/home/home.dart';
import 'package:online_market/presentation/profile/index.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoadingScreen, initial: true),
    AutoRoute(page: Login),
    AutoRoute(page: SignUp),
    AutoRoute(page: CompleteProfile),
    AutoRoute(page: BaseScreen, name: 'Base', path: '/base', children: [
      AutoRoute(page: Home, initial: true),
      AutoRoute(page: Shop),
      AutoRoute(
        page: CartPage,
      ),
      AutoRoute(
        page: Favourites,
      ),
      AutoRoute(
        page: Profile,
      ),
    ]),
  ],
)
class $AppRouter {}
