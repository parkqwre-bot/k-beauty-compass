import 'package:flutter/material.dart';
import 'package:k_beauty_compass/l10n/app_localizations.dart';
import './dashboard_screen.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return [
      QuizQuestion(
        questionText: l10n.whichCountryDoYouResideIn,
        options: ["South Korea", "United States"],
      ),
      QuizQuestion(
        questionText: l10n.afterWashingYourFaceYourSkinFeels,
        options: [l10n.tightAndDry, l10n.smoothAndNormal, l10n.shinyAndOily, l10n.notSure],
      ),
      QuizQuestion(
        questionText: l10n.whatAreYourBiggestSkinWorries,
        options: [l10n.acneBlemishes, l10n.pores, l10n.wrinkles, l10n.redness, l10n.dullness],
        allowMultipleSelection: true,
      ),
      QuizQuestion(
        questionText: l10n.areYouSensitiveToSpecifics,
        options: [l10n.verySensitive, l10n.somewhatSensitive, l10n.notSensitive, l10n.notSure],
      ),
      QuizQuestion(
        questionText: l10n.howMuchTimeForSkincare,
        options: [l10n.lessThan5Minutes, l10n.fiveToTenMinutes, l10n.moreThan10Minutes],
      ),
      QuizQuestion(
        questionText: l10n.personalColor,
        options: [l10n.warmTone, l10n.coolTone, l10n.notSure],
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
    final question = questions[_currentQuestionIndex];
    if (!question.allowMultipleSelection && !_selectedAnswers.containsKey(_currentQuestionIndex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("답변을 선택해주세요."), duration: Duration(seconds: 1)),
      );
      return;
    }

    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(quizAnswers: _selectedAnswers)),
      );
    }
  }

  void _onOptionSelected(int optionIndex, QuizQuestion question) {
    setState(() {
      if (question.allowMultipleSelection) {
        if (_selectedAnswers[_currentQuestionIndex]?.contains(optionIndex) ?? false) {
          _selectedAnswers[_currentQuestionIndex]!.remove(optionIndex);
        } else {
          _selectedAnswers.putIfAbsent(_currentQuestionIndex, () => []).add(optionIndex);
        }
      } else {
        _selectedAnswers[_currentQuestionIndex] = [optionIndex];
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
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey.shade200,
              color: Colors.pink.shade300,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Column(
                  key: ValueKey<int>(_currentQuestionIndex), // Key is crucial for AnimatedSwitcher
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      currentQuestion.questionText,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentQuestion.options.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedAnswers[_currentQuestionIndex]?.contains(index) ?? false;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: OutlinedButton(
                              onPressed: () => _onOptionSelected(index, currentQuestion),
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: _previousQuestion,
                    child: Text(AppLocalizations.of(context)!.previous),
                  )
                else
                  const SizedBox(), // To keep space
                
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
