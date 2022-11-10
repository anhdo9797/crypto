class CoinDetail {
  String? id;
  String? symbol;
  String? name;
  int? blockTimeInMinutes;
  Description? description;
  Image? image;
  double? coingeckoScore;
  double? developerScore;
  double? communityScore;
  double? liquidityScore;
  double? publicInterestScore;
  MarketData? marketData;
  String? lastUpdated;

  CoinDetail(
      {this.id,
      this.symbol,
      this.name,
      this.blockTimeInMinutes,
      this.description,
      this.image,
      this.coingeckoScore,
      this.developerScore,
      this.communityScore,
      this.liquidityScore,
      this.publicInterestScore,
      this.marketData,
      this.lastUpdated});

  CoinDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    blockTimeInMinutes = json['block_time_in_minutes'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    coingeckoScore = json['coingecko_score'];
    developerScore = json['developer_score'];
    communityScore = json['community_score'];
    liquidityScore = json['liquidity_score'];
    publicInterestScore = json['public_interest_score'];
    marketData = json['market_data'] != null
        ? new MarketData.fromJson(json['market_data'])
        : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['block_time_in_minutes'] = this.blockTimeInMinutes;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['coingecko_score'] = this.coingeckoScore;
    data['developer_score'] = this.developerScore;
    data['community_score'] = this.communityScore;
    data['liquidity_score'] = this.liquidityScore;
    data['public_interest_score'] = this.publicInterestScore;
    if (this.marketData != null) {
      data['market_data'] = this.marketData!.toJson();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class Description {
  String? en;

  Description({this.en});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}

class Image {
  String? thumb;
  String? small;
  String? large;

  Image({this.thumb, this.small, this.large});

  Image.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    small = json['small'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['small'] = this.small;
    data['large'] = this.large;
    return data;
  }
}

class MarketData {
  CurrentPrice? currentPrice;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? priceChangePercentage7d;
  double? priceChangePercentage14d;
  double? priceChangePercentage30d;
  double? priceChangePercentage60d;
  double? priceChangePercentage200d;
  double? priceChangePercentage1y;
  double? marketCapChange24h;
  double? marketCapChangePercentage24h;
  String? lastUpdated;

  MarketData(
      {this.currentPrice,
      this.priceChange24h,
      this.priceChangePercentage24h,
      this.priceChangePercentage7d,
      this.priceChangePercentage14d,
      this.priceChangePercentage30d,
      this.priceChangePercentage60d,
      this.priceChangePercentage200d,
      this.priceChangePercentage1y,
      this.marketCapChange24h,
      this.marketCapChangePercentage24h,
      this.lastUpdated});

  MarketData.fromJson(Map<String, dynamic> json) {
    currentPrice = json['current_price'] != null
        ? new CurrentPrice.fromJson(json['current_price'])
        : null;
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    priceChangePercentage7d = json['price_change_percentage_7d'];
    priceChangePercentage14d = json['price_change_percentage_14d'];
    priceChangePercentage30d = json['price_change_percentage_30d'];
    priceChangePercentage60d = json['price_change_percentage_60d'];
    priceChangePercentage200d = json['price_change_percentage_200d'];
    priceChangePercentage1y = json['price_change_percentage_1y'];
    marketCapChange24h = json['market_cap_change_24h'];
    marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentPrice != null) {
      data['current_price'] = this.currentPrice!.toJson();
    }
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    data['price_change_percentage_7d'] = this.priceChangePercentage7d;
    data['price_change_percentage_14d'] = this.priceChangePercentage14d;
    data['price_change_percentage_30d'] = this.priceChangePercentage30d;
    data['price_change_percentage_60d'] = this.priceChangePercentage60d;
    data['price_change_percentage_200d'] = this.priceChangePercentage200d;
    data['price_change_percentage_1y'] = this.priceChangePercentage1y;
    data['market_cap_change_24h'] = this.marketCapChange24h;
    data['market_cap_change_percentage_24h'] =
        this.marketCapChangePercentage24h;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class CurrentPrice {
  double? usd;
  double? vef;
  int? vnd;

  CurrentPrice({this.usd, this.vef, this.vnd});

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    usd = json['usd'];
    vef = json['vef'];
    vnd = json['vnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usd'] = this.usd;
    data['vef'] = this.vef;
    data['vnd'] = this.vnd;
    return data;
  }
}
