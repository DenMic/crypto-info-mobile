import 'package:crypto_info/model/crypto_asset.dart';

class CryptoAssetList {
  List<CryptoAsset> cryptoAssetList;

  CryptoAssetList.fromJson(Map<String, dynamic> json) {
    cryptoAssetList = [];
    final data = json.values.first;

    data.forEach((element) {
      cryptoAssetList.add(new CryptoAsset.fromJson(element));
    });
  }
}