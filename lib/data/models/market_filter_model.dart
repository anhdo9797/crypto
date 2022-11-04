class MarketFilterModel {
  String? value;
  String? key;

  MarketFilterModel({
    this.key,
    this.value,
  });

  MarketFilterModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['key'] = key;

    return data;
  }
}
