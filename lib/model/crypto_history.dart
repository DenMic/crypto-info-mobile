class CryptoHistory {
  final double priceUsd;
  final int time;
  final double circulatingSupply;
  final DateTime date;

  CryptoHistory({this.priceUsd, this.time, this.circulatingSupply, this.date});

  factory CryptoHistory.fromJson(Map<String, dynamic> json) {
    return CryptoHistory(
      priceUsd: double.parse(json['priceUsd']),
      time: json['time'],
      circulatingSupply: double.parse(json['circulatingSupply'] ?? "0"),
      date: DateTime.parse(json['date']),
    );
  }

  static List<CryptoHistory> parseListCryptoHistorydModel(List<dynamic> response) {
    if(response==null){
      return [];
    }
    return response.map((jsonString) => CryptoHistory.fromJson(jsonString)).toList();
  }
}