import 'package:flutter/material.dart';
import 'package:k_beauty_compass/l10n/app_localizations.dart';
import './dashboard_screen.dart'; // Import the dashboard screen

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class QuizQuestion {
  final String questionText;
  final List<String> options;
  final bool allowMultipleSelection;

  QuizQuestion({
    required this.questionText,
    required this.options,
    this.allowMultipleSelection = false,
  });
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, List<int>> _selectedAnswers = {};

  List<QuizQuestion> _getQuestions(BuildContext context) {
    return [
      QuizQuestion(
        questionText: AppLocalizations.of(context)!.whichCountryDoYouResideIn,
        options: [
          "South Korea",
          "United States",
        ],
      ),
      QuizQuestion(
        questionText: AppLocalizations.of(context)!.afterWashingYourFaceYourSkinFeels,
        options: [
          AppLocalizations.of(context)!.tightAndDry,
          AppLocalizations.of(context)!.smoothAndNormal,
          AppLocalizations.of(context)!.shinyAndOily,
        ],
      ),
      QuizQuestion(
        questionText: AppLocalizations.of(context)!.whatAreYourBiggestSkinWorries,
        options: [
          AppLocalizations.of(context)!.acneBlemishes,
          AppLocalizations.of(context)!.pores,
          AppLocalizations.of(context)!.wrinkles,
          AppLocalizations.of(context)!.redness,
          AppLocalizations.of(context)!.dullness,
        ],
        allowMultipleSelection: true,
      ),
      QuizQuestion(
        questionText: AppLocalizations.of(context)!.areYouSensitiveToFragrance,
        options: [
          AppLocalizations.of(context)!.yes,
          AppLocalizations.of(context)!.no,
        ],
      ),
      QuizQuestion(
        questionText: AppLocalizations.of(context)!.howMuchTimeForSkincare,
        options: [
          AppLocalizations.of(context)!.lessThan5Minutes,
          AppLocalizations.of(context)!.fiveToTenMinutes,
          AppLocalizations.of(context)!.moreThan10Minutes,
        ],
      ),
      QuizQuestion(
        questionText: AppLocalizations.of(context)!.whichShadeIsClosestToYourBareSkin,
        options: [
          AppLocalizations.of(context)!.fair,
          AppLocalizations.of(context)!.light,
          AppLocalizations.of(context)!.medium,
          AppLocalizations.of(context)!.tan,
          AppLocalizations.of(context)!.deep,
        ], // These would be replaced by color swatches
      ),
    ];
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _nextQuestion(List<QuizQuestion> questions) {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // End of quiz
      print("Quiz finished. Answers: $_selectedAnswers");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(quizAnswers: _selectedAnswers)),
      );
    }
  }

  void _onOptionSelected(int optionIndex, List<QuizQuestion> questions) {
    setState(() {
      final question = questions[_currentQuestionIndex];
      if (question.allowMultipleSelection) {
        if (_selectedAnswers[_currentQuestionIndex]?.contains(optionIndex) ?? false) {
          _selectedAnswers[_currentQuestionIndex]!.remove(optionIndex);
        } else {
          _selectedAnswers.putIfAbsent(_currentQuestionIndex, () => []).add(optionIndex);
        }
      } else {
        _selectedAnswers[_currentQuestionIndex] = [optionIndex];
        _nextQuestion(questions);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = _getQuestions(context);
    final currentQuestion = questions[_currentQuestionIndex];
    final isLastQuestion = _currentQuestionIndex == questions.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.findingYourBeautyCompass),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey.shade200,
              color: Colors.pink.shade300,
            ),
            const SizedBox(height: 40),
            // Question Text
            Text(
              currentQuestion.questionText,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Options
            ListView.builder(
              shrinkWrap: true,
              itemCount: currentQuestion.options.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedAnswers[_currentQuestionIndex]?.contains(index) ?? false;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: OutlinedButton(
                    onPressed: () => _onOptionSelected(index, questions),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: isSelected ? Colors.pink.shade50 : Colors.white,
                      side: BorderSide(color: isSelected ? Colors.pink.shade300 : Colors.grey.shade300, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(currentQuestion.options[index], style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            // Navigation Buttons
            Row(
              children: [
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: _previousQuestion,
                    child: Text(AppLocalizations.of(context)!.previous),
                  ),
                const Spacer(),
                if (currentQuestion.allowMultipleSelection)
                  ElevatedButton(
                    onPressed: () => _nextQuestion(questions),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      backgroundColor: Colors.pink.shade300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      isLastQuestion ? AppLocalizations.of(context)!.finish : AppLocalizations.of(context)!.next,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}