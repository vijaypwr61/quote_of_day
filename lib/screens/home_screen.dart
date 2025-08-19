import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_of_day/models/quote_model.dart';
import 'package:quote_of_day/models/quote_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<QuoteModel> quotes = [];
  int quoteNum = 0;
  Future<void> loadQuotes() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    quotes.addAll(await QuoteService.loadQuotes());
    randomQuote();
    setState(() {});
  }

  randomQuote() {
    quoteNum = Random().nextInt(quotes.length);
  }

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: quotes.isNotEmpty
              ? Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.ease,
                          builder: (ctx, offset, child) {
                            return Opacity(
                              opacity: offset,
                              child: Transform.translate(
                                offset: Offset(0, (1 - offset) * 10),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            quotes[quoteNum].quote,
                            style: GoogleFonts.poppins(
                                fontSize: 30.0, color: Colors.purpleAccent),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        FutureBuilder(
                          future:
                              Future.delayed(const Duration(milliseconds: 700)),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                                builder: (ctx, offset, child) {
                                  return Opacity(
                                    opacity: offset,
                                    child: Transform.translate(
                                      offset: Offset(0, (1 - offset) * 10),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Text(
                                  quotes[quoteNum].author,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              );
                            }
                            return Text(
                              '',
                            );
                          },
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Built with Flutter by'),
                                TextSpan(
                                  text: ' @vijaypwr61',
                                  style: TextStyle(color: Colors.orange[300]),
                                ),
                              ],
                              style: GoogleFonts.poppins(
                                fontSize: 14.0,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                          // SizedBox(height: 10.0),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Quotes sourced from'),
                                TextSpan(
                                  text: ' dwyl',
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ],
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
