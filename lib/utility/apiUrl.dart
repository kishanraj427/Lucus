class ApiUrl {
  static const String baseUrl = 'https://api.example.com';
  static const String getStores = '/stores';
  static String bookStore(String storeId) => '/stores/{storeId}/book';
}
