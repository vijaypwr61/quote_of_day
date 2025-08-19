import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quote_of_day/models/quote_model.dart';
class QuoteService {
  static Future<List<QuoteModel>> loadQuotes() async {
    final String data = await rootBundle.loadString('assets/data/quotes.json');
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((e) => QuoteModel.fromJson(e)).toList();
  }
}