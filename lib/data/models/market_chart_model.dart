class MarketChartResponse {
  List? prices;
  List? marketCaps;
  List? totalVolumes;

  MarketChartResponse({this.prices, this.marketCaps, this.totalVolumes});

  MarketChartResponse.fromJson(Map<String, dynamic> json) {
    prices = json['prices'];
    marketCaps = json['marketCaps'];
    totalVolumes = json['totalVolumes'];
  }
}
