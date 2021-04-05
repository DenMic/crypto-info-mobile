import 'dart:convert';

import 'package:crypto_info/common/const/date_value_const.dart';
import 'package:crypto_info/model/crypto_asset.dart';
import 'package:crypto_info/model/crypto_asset_list.dart';
import 'package:crypto_info/model/crypto_history.dart';
import 'package:http/http.dart' as http;

Future<List<CryptoAsset>> fetchAssetsAsync({int limit = 5}) async {
  List<CryptoAsset> assetList = [];
  var paramLimit = '?limit=$limit';

  if(limit == null) {
    paramLimit = "";
  }

  final request = http.Request('GET', Uri.parse('https://api.coincap.io/v2/assets$paramLimit'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final stringResponse = await response.stream.bytesToString();
    final objResp = json.decode(stringResponse);

    assetList = CryptoAssetList.fromJson(objResp).cryptoAssetList;
    // final Iterable assetsJson = json.decode(response.body);
    // assetList = List<CryptoAsset>.from(assetsJson.map((model) => CryptoAsset.fromJson(model)));
  } else {
    throw Exception('Failed to load assets');
  }

  return assetList;
}

Future<CryptoAsset> fetchAssetAsync({String idAsset}) async {
  CryptoAsset asset;

  final request = http.Request('GET', Uri.parse('https://api.coincap.io/v2/assets/$idAsset'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final stringResponse = await response.stream.bytesToString();
    var jsonVal = json.decode(stringResponse) as Map<String, dynamic>;
    asset = CryptoAsset.fromJson(jsonVal.values.first);
  } else {
    throw Exception('Failed to load assets');
  }

  return asset;
}

Future<List<CryptoHistory>> getHisotryAssetAsync({String idAsset, String intervalType, int dateFrom}) async {
  List<CryptoHistory> asset;

  final request = http.Request('GET', Uri.parse('https://api.coincap.io/v2/assets/$idAsset/history?interval=$intervalType&start=$dateFrom&end=${DateValueConst.today}'));
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final stringResponse = await response.stream.bytesToString();
    var jsonVal = json.decode(stringResponse) as Map<String, dynamic>;
    asset = CryptoHistory.parseListCryptoHistorydModel(jsonVal.values.first);
  } else {
    throw Exception('Failed to load assets');
  }

  return asset;
}

Future<List<CryptoAsset>> getListCryptoAssetAsync({List<String> idAssets}) async {
  List<CryptoAsset> assets = [];

  for(var idAsset in idAssets) {
    final request = http.Request('GET', Uri.parse('https://api.coincap.io/v2/assets/$idAsset'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final stringResponse = await response.stream.bytesToString();
      var jsonVal = json.decode(stringResponse) as Map<String, dynamic>;
      assets.add(CryptoAsset.fromJson(jsonVal.values.first));

    }
  }

  return assets;
}
