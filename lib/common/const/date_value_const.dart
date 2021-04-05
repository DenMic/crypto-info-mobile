class DateValueConst {
  static int today = DateTime.now().toUtc().millisecondsSinceEpoch;

  static int oneDay = DateTime.now().add(Duration(days: -1)).toUtc().millisecondsSinceEpoch;
  static int oneWeek = DateTime.now().add(Duration(days: -7)).toUtc().millisecondsSinceEpoch;
  static int oneMonth = DateTime.now().add(Duration(days: -31)).toUtc().millisecondsSinceEpoch;
  static int threeMonth = DateTime.now().add(Duration(days: -93)).toUtc().millisecondsSinceEpoch;
  static int oneYear = DateTime.now().add(Duration(days: -365)).toUtc().millisecondsSinceEpoch;
  static int all = DateTime.now().add(Duration(days: -365)).toUtc().millisecondsSinceEpoch;
}