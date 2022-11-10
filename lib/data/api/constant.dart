class ApiConstant {
  ApiConstant._();

  static const timeOut = 100000;
  static const receiveTimeout = 30000;

  // endpoint
  static const login = "api/login";
  static const register = "api/register";
  static const String users = 'api/users';
  static const coinMarket = 'coins/markets';
  static const coin = 'coins/';
  static const coinTrending = 'search/trending';
  static marketChart(String id) => 'coins/$id/market_chart';
  static coinOhld(String id) => 'coins/$id/ohlc';

// static const register = "api/register";

}
