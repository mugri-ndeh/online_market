const String baseApi = "http://10.0.2.2/emarket_php/functions/";

class Api {
  static const String login = baseApi + "common/login.php";
  static const String signup = baseApi + "common/signup.php";
  static const String completeProfile = baseApi + "common/complete_profile.php";
  static const String getUser = baseApi + "common/get_user.php";
  static const String resetPassword = baseApi + "customer/reset_password";
  static const String editProfile = baseApi + "common/edit_profile.php";
  static const String updatePassword = baseApi + "customer/update_password.php";
  static const String getCategories = baseApi + "common/get_categories.php";
}

class CustomerApi {
  static const String changeOrder = baseApi + "customer/change_order.php";
  static const String createOrder = baseApi + "customer/createOrder.php";
  static const String deleteReview = baseApi + "customer/";
  static const String getAllProducts =
      baseApi + "customer/get_all_products.php";
  static const String getPromo = baseApi + "customer/get_promo.php";
  static const String getReviews = baseApi + "customer/";
  static const String makeReview = baseApi + "customer/make_review.php";
  static const String search = baseApi + "customer/search.php";
  static const String viewStores = baseApi + "customer/view_stores.php";
  static const String getWishList = baseApi + "customer/get_wish_list.php";
  static const String getShopProducts =
      baseApi + "customer/get_shop_products.php";
  static const String addToWish = baseApi + "customer/add_to_wish.php";
  static const String getOrders = baseApi + "customer/get_orders.php";
}

class SellerApi {
  static const String addProducts = baseApi + "seller/add_products.php";
  static const String createPromo = baseApi + "seller/create_promo.php";
  static const String createStore = baseApi + "seller/create_store.php";
  static const String getPromo = baseApi + "seller/get_promo.php";
  static const String getReviews = baseApi + "seller/get_reviews.php";
  static const String getShopReview = baseApi + "seller/get_shop_review.php";
  static const String updateStore = "seller/update_store.php";
  static const String viewAllProducts =
      baseApi + "seller/view_all_products.php";
  static const String viewProducts = baseApi + "seller/view_products.php";
  static const String viewStores = baseApi + "seller/view_stores.php";
  static const String uploadImage = baseApi + "seller/upload_image.php";
}
