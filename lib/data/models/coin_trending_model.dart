class CoinTrendingResponse {
  List<Coins>? coins;

  CoinTrendingResponse({this.coins});

  CoinTrendingResponse.fromJson(Map<String, dynamic> json) {
    if (json['coins'] != null) {
      coins = <Coins>[];
      json['coins'].forEach((v) {
        coins!.add(new Coins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coins != null) {
      data['coins'] = this.coins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coins {
  CoinTrending? item;

  Coins({this.item});

  Coins.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? CoinTrending.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class CoinTrending {
  String? id;
  num? coinId;
  String? name;
  String? symbol;
  num? marketCapRank;
  String? thumb;
  String? small;
  String? large;
  String? slug;
  num? priceBtc;
  num? score;

  CoinTrending(
      {this.id,
      this.coinId,
      this.name,
      this.symbol,
      this.marketCapRank,
      this.thumb,
      this.small,
      this.large,
      this.slug,
      this.priceBtc,
      this.score});

  CoinTrending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coinId = json['coin_id'];
    name = json['name'];
    symbol = json['symbol'];
    marketCapRank = json['market_cap_rank'];
    thumb = json['thumb'];
    small = json['small'];
    large = json['large'];
    slug = json['slug'];
    priceBtc = json['price_btc'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coin_id'] = this.coinId;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['market_cap_rank'] = this.marketCapRank;
    data['thumb'] = this.thumb;
    data['small'] = this.small;
    data['large'] = this.large;
    data['slug'] = this.slug;
    data['price_btc'] = this.priceBtc;
    data['score'] = this.score;
    return data;
  }
}
