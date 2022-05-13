class Urls {
  static const baseUrl = 'https://newsapi.org/v2/';
  static String categoryData({country, category}) =>
      "$baseUrl${"/top-headlines?country=$country&category=$category&apiKey=8454ed8e9a2b418d8227098efe5e343b"}";
  static String homeapi({website, from, to}) =>
      "$baseUrl/everything?domains=$website&language=en&from=$from&to=$to&apiKey=0aacbc697a864022adbf7c160ca39a02";
  static String search({searchText}) =>
      "$baseUrl${"/everything?q=$searchText&sortBy=relevancy&apiKey=0aacbc697a864022adbf7c160ca39a02"}";
}
