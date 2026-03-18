import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  final List<Map> favoriteMovies = [];
  final Map<String, List<Map<String, dynamic>>> movieReviews = {};
  
  // Lưu trữ vé số kỷ niệm
  final List<Map<String, dynamic>> digitalTickets = [];

  // Đa ngôn ngữ
  bool isEnglish = false;

  void toggleLanguage() {
    isEnglish = !isEnglish;
    notifyListeners();
  }

  String translate(String vi, String en) {
    return isEnglish ? en : vi;
  }

  void toggleFavorite(Map movie) {
    bool exists = favoriteMovies.any((m) => m['name'] == movie['name']);
    if (exists) {
      favoriteMovies.removeWhere((m) => m['name'] == movie['name']);
    } else {
      favoriteMovies.add(movie);
    }
  }

  bool isFavorite(Map movie) {
    return favoriteMovies.any((m) => m['name'] == movie['name']);
  }

  void addReview(String movieName, Map<String, dynamic> review) {
    if (!movieReviews.containsKey(movieName)) {
      movieReviews[movieName] = [
        {"user": "Nguyễn Văn A", "rating": 5, "comment": "Phim cực kỳ hay, kỹ xảo tuyệt vời!", "time": "2 giờ trước"},
        {"user": "Trần Thị B", "rating": 4, "comment": "Nội dung lôi cuốn, nhưng hơi dài một chút.", "time": "5 giờ trước"},
      ];
    }
    if (review["time"] == null) {
      review["time"] = "Vừa xong";
    }
    // review may contain "movieImg"
    movieReviews[movieName]!.insert(0, review);
  }

  List<Map<String, dynamic>> getReviews(String movieName) {
    return movieReviews[movieName] ?? [
      {"user": "Nguyễn Văn A", "rating": 5, "comment": "Phim cực kỳ hay, kỹ xảo tuyệt vời!", "time": "2 giờ trước"},
      {"user": "Trần Thị B", "rating": 4, "comment": "Nội dung lôi cuốn, nhưng hơi dài một chút.", "time": "5 giờ trước"},
    ];
  }

  void addDigitalTicket(Map<String, dynamic> ticket) {
    digitalTickets.insert(0, ticket);
  }

  List<Map<String, dynamic>> getMyTickets() {
    return digitalTickets;
  }
}
