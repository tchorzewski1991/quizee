import 'answer.dart';
import 'question.dart';

class QuizManager {
  final List<Question> questions = [
    Question(
      text: 'Dart is object oriented programming language',
      answer: Answer(correct: true),
    ),
    Question(
      text: 'Empty interface in Go says nothing.',
      answer: Answer(correct: true),
    ),
    Question(
      text: 'Ruby is a statically typed programming language.',
      answer: Answer(correct: false),
    ),
  ];

  int _currentQuestionIdx;
  Question _currentQuestion;
  bool _quizFinished;

  void initState() {
    _currentQuestionIdx = 0;
    _currentQuestion = _getQuestion(_currentQuestionIdx);
    _quizFinished = false;

    questions.forEach((q) => q.reset());
  }

  void nextQuestion() {
    if (_currentQuestionIdx < questions.length) {
      _currentQuestion = _getQuestion(_currentQuestionIdx);
    } else {
      _quizFinished = true;
    }
  }

  bool isQuizFinished() {
    return _quizFinished;
  }

  void processAnswer(bool receivedAnswer) {
    _currentQuestion.processAnswer(receivedAnswer);
    _currentQuestionIdx++;
  }

  String getQuestionText() {
    return _currentQuestion.text;
  }

  Question _getQuestion(int idx) {
    return questions.elementAt(idx);
  }
}
