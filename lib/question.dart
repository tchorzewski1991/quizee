import 'answer.dart';

class Question {
  final String text;
  final Answer answer;

  bool _isAnswered = false;

  Question({this.text, this.answer});

  void processAnswer(bool receivedAnswer) {
    answer.updateScore(receivedAnswer);
    _isAnswered = true;
  }

  void reset() {
    answer.resetScore();
    _isAnswered = false;
  }

  bool get isAnswered => _isAnswered;
}
