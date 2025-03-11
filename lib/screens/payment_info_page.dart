import 'package:flutter/material.dart';
import 'success_message_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentInfoPage extends StatelessWidget {
  final bool needPhotograph;
  final bool needTranslator;
  final String selectedDate; // Параметр для даты
  final String selectedTimeslot; // Параметр для времени

  PaymentInfoPage({
    required this.needPhotograph,
    required this.needTranslator,
    required this.selectedDate,
    required this.selectedTimeslot,
  });

  @override
  Widget build(BuildContext context) {
    int photographerCost = 5000;
    int translatorCost = 2000;
    int totalCost = 0;

    if (needPhotograph) totalCost += photographerCost;
    if (needTranslator) totalCost += translatorCost;

    return Scaffold(
      backgroundColor: Colors.white, // Фон всего экрана белый
      appBar: AppBar(
        backgroundColor: Colors.white, // Фон AppBar белый
        elevation: 0, // Убираем тень AppBar
        iconTheme: IconThemeData(color: Colors.black), // Черные иконки
        title: Text(
          AppLocalizations.of(context)?.payment ?? 'Payment',
          style: TextStyle(color: Colors.black), // Черный текст заголовка
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (needPhotograph)
                Column(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)?.photographerService ?? 'Photographer Service'}: $photographerCost ₽',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              if (needTranslator)
                Column(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)?.translatorService ?? 'Translator Service'}: $translatorCost ₽',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                '${AppLocalizations.of(context)?.totalCost ?? 'Total Cost'}: $totalCost ₽',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)?.paymentInstructions ??
                    'Оплата производится на стойке регистрации в зоне B2B',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessMessagePage(
                        date: selectedDate, // Передача даты
                        time: selectedTimeslot, // Передача времени
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 62, 91, 207), // Цвет кнопки
                  foregroundColor: Colors.white, // Цвет текста кнопки
                ),
                child: Text(AppLocalizations.of(context)?.understand ?? 'Понятно'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
