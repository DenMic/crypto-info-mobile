import 'package:flutter/material.dart';

class CryptoAsset {
  String id;
  int rank;
  String symbol;
  String name;
  double supply;
  double maxSupply;
  double marketCapUsd;
  double volumeUsd24Hr;
  double priceUsd;
  double changePercent24Hr;
  double vwap24Hr;

  // Asset();
  CryptoAsset({ @required this.id, 
    @required this.rank, 
    @required this.symbol,
    @required this.name,
    @required this.supply,
    @required this.maxSupply,
    @required this.marketCapUsd,
    @required this.volumeUsd24Hr,
    @required this.priceUsd,
    @required this.changePercent24Hr,
    @required this.vwap24Hr });

  factory CryptoAsset.fromJson(Map<String, dynamic> json) {
    return CryptoAsset(
      id: json['id'],
      rank: json['rank'] != null ? int.tryParse(json['rank']) : null,
      symbol: json['symbol'],
      name: json['name'],
      supply: json['supply'] != null ? double.tryParse(json['supply']) : null,
      maxSupply: json['maxSupply'] != null ? double.tryParse(json['maxSupply']) : null,
      marketCapUsd: json['marketCapUsd'] != null ? double.tryParse(json['marketCapUsd']) : null,
      volumeUsd24Hr: json['volumeUsd24Hr'] != null ? double.tryParse(json['volumeUsd24Hr']) : null,
      priceUsd: json['priceUsd'] != null ? double.tryParse(json['priceUsd']) : null,
      changePercent24Hr: json['changePercent24Hr'] != null ? double.tryParse(json['changePercent24Hr']) : null,
      vwap24Hr: json['vwap24Hr'] != null ? double.tryParse(json['vwap24Hr']) : null
    );
  }
}