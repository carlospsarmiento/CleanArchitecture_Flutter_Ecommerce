class ApiEndpoints {
  //static const String baseUrl = "https://f2mrv4dr-3000.brs.devtunnels.ms"; // local
  static const String baseUrl = "https://backend-node-ecommerce-i5u5.onrender.com"; // render

  // Auth Endpoints
  static const String login = "/api/users/login";
  static const String signup = "/api/users/createWithImage";
  static const String logout = "/api/users/logout";
  static const String getAllUsers = "/api/users/getAll";

  // Ecommerce Endpoints
  static const String getAllCategories = "/api/categories/getAll";
  static const String getAllSpecialOffers = "/api/special-offers/getAll";
  static const String getFeaturedProducts = "/api/products/featured";
  //static const String getProducts = "/api/products";
  //static const String getProductDetails = "/api/products/{id}";

  static String searchProducts(String name) => "/api/products/search?name=$name";
}
