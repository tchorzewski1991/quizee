import 'package:flutter/foundation.dart';

class Answer {
  final bool correct;
  int _score;

  Answer({@required this.correct}) {
    this._score = 0;
  }

  void updateScore(bool received) {
    _score += (correct == received ? 1 : 0);
  }

  void resetScore() {
    _score = 0;
  }

  bool isCorrect() {
    return _score == 1;
  }
}
