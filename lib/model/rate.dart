class RateModel {
  String id;
  String symbol;
  String currencySymbol;
  String type;
  String rateUsd;

  
  RateModel({this.id, this.symbol, this.currencySymbol, this.type, this.rateUsd});

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      symbol: json['symbol'] as String,
      currencySymbol: json['currencySymbol'] as String,
      type: json['type'] as String,
      rateUsd: json['rateUsd'] as String,
    );
  }
}