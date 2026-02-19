class QuestionModel {
  final String questionId;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const QuestionModel({
    required this.questionId,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}
