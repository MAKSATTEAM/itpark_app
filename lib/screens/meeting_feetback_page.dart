import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'package:eventssytem/widgets/background.dart';

class MeetingFeedbackPage extends StatefulWidget {
  final String eventId;
  final String participantId;
  final String meetingId;

  const MeetingFeedbackPage({
    Key? key,
    required this.eventId,
    required this.participantId,
    required this.meetingId,
  }) : super(key: key);

  @override
  _MeetingFeedbackPageState createState() => _MeetingFeedbackPageState();
}

class _MeetingFeedbackPageState extends State<MeetingFeedbackPage> {
  final B2bRepository _b2bRepository = B2bRepository();
  bool? isHappen;
  bool? isUseful;
  String? conclusion;
  String? suggestion;
  String? feedback;
  bool isSubmitting = false;
  int currentStep = 0;

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (isHappen == null || isUseful == null || conclusion == null || feedback == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)?.completeAllFields ?? 'Please complete all fields'),
      ));
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      await _b2bRepository.submitFeedback(
        eventId: widget.eventId,
        participantId: widget.participantId,
        meetingId: widget.meetingId,
        isHappen: isHappen!,
        isUseful: isUseful!,
        conclusion: conclusion!,
        feedback: feedback!,
      );

      _showSuccessDialog();
    } catch (e) {
      print("Error submitting feedback: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)?.submissionError ?? 'Error submitting feedback'),
      ));
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Icon(Icons.thumb_up, color: Colors.blue, size: 80),
          content: Text(AppLocalizations.of(context)?.thankYou ?? 'Thank you for your feedback!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              child: Text(AppLocalizations.of(context)?.back ?? 'Back to Main'),
            ),
          ],
        );
      },
    );
  }

  void _nextStep() {
    // Проверка, заполнено ли поле для текущего вопроса
    bool isStepComplete = false;
    switch (currentStep) {
      case 0:
        isStepComplete = isHappen != null;
        break;
      case 1:
        isStepComplete = isUseful != null;
        break;
      case 2:
        isStepComplete = _textController.text.isNotEmpty;
        if (isStepComplete) {
          conclusion = _textController.text; // Сохраняем значение для заключения
        }
        break;
      case 3:
        isStepComplete = _textController.text.isNotEmpty;
        if (isStepComplete) {
          feedback = _textController.text; // Сохраняем значение для отзыва
        }
        break;
    }

    if (!isStepComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)?.completeAllFields ?? 'Please complete this field'),
        ),
      );
      return;
    }

    setState(() {
      if (currentStep < 3) {
        currentStep++;
      } else {
        _submitFeedback();
      }

      // Очистить контроллер после сохранения данных для текущего шага
      _textController.clear();

      // Устанавливаем значение контроллера для нового шага
      switch (currentStep) {
        case 2:
          _textController.text = conclusion ?? '';
          break;
        case 3:
          _textController.text = feedback ?? '';
          break;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (currentStep > 0) {
        currentStep--;
      }

      // Устанавливаем значение контроллера на основании сохраненных данных при возврате к предыдущему шагу
      _textController.clear();
      switch (currentStep) {
        case 2:
          _textController.text = conclusion ?? '';
          break;
        case 3:
          _textController.text = feedback ?? '';
          break;
      }
    });
  }

  Widget _buildQuestionContent(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations?.meetingHappened ?? 'Did the meeting happen?', style: TextStyle(fontSize: 18)),
            RadioListTile<bool>(
              title: Text(localizations?.yes ?? 'Yes'),
              value: true,
              groupValue: isHappen,
              onChanged: (value) => setState(() => isHappen = value),
            ),
            RadioListTile<bool>(
              title: Text(localizations?.no ?? 'No'),
              value: false,
              groupValue: isHappen,
              onChanged: (value) => setState(() => isHappen = value),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations?.meetingUseful ?? 'Was the meeting useful?', style: TextStyle(fontSize: 18)),
            RadioListTile<bool>(
              title: Text(localizations?.yes ?? 'Yes'),
              value: true,
              groupValue: isUseful,
              onChanged: (value) => setState(() => isUseful = value),
            ),
            RadioListTile<bool>(
              title: Text(localizations?.no ?? 'No'),
              value: false,
              groupValue: isUseful,
              onChanged: (value) => setState(() => isUseful = value),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations?.meetingConclusion ?? 'Any conclusions or agreements?', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: localizations?.enterConclusion ?? 'Enter your conclusion here',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations?.meetingFeedback ?? 'Any additional feedback?', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: localizations?.enterFeedback ?? 'Enter your feedback here',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(localizations?.meetingFeedback ?? 'Meeting Feedback'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: _buildQuestionContent(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0 && currentStep < 4)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                        side: BorderSide(color: Colors.blue),
                      ),
                      onPressed: _previousStep,
                      child: Text(localizations?.back ?? 'Back', style: TextStyle(color: Colors.blue, fontSize: 18)),
                    ),
                  if (currentStep < 4)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: _nextStep,
                      child: isSubmitting
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(localizations?.next ?? 'Next', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
