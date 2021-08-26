class Rate{
  var status;
  Data? data;
  Rate.fromJson(Map<String, dynamic>json){
    status = json['STATUS'];
    data = json['DATA'] != null ? Data.fromJson(json['DATA']) : null;
  }
}
class Data{
  int? recommendations_all;
  int? recommendations_count;
  int? stop_lose;
  int? news;
  int? recommendations_win;
  int? recommendations_lose;
  int? recommendations_open;
  String? average_profit ;
  Data.fromJson(Map<String, dynamic>json){
    recommendations_all = json['recommendations_all'];
    recommendations_count = json['recommendations_count'];
    stop_lose = json['stop_lose'];
    news = json['new'];
    recommendations_win = json['recommendations_win'];
    recommendations_lose = json['recommendations_lose'];
    recommendations_open = json['recommendations_open'];
    average_profit = json['average_profit'];
  }

}