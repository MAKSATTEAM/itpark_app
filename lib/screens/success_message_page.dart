import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';

class SuccessMessagePage extends StatelessWidget {
  final String date;
  final String time;

  SuccessMessagePage({
    required this.date,
    required this.time,
  });

  // Форматирование даты из формата 'MM-dd-yyyy' в формат 'dd.MM'
  String formatDate(String date) {
    final parts = date.split('-');
    return '${parts[1]}.${parts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Делает Scaffold прозрачным
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Прозрачный AppBar
          elevation: 0, // Убираем тень AppBar
          title: Text(
            AppLocalizations.of(context)?.invitation ?? 'Приглашение',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble, size: 80, color: Colors.blue),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)?.messageSent ?? 'Сообщение отправлено!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)?.invitationDetails(
                        formatDate(date),
                        time,
                      ) ??
                      '“Благодарим Вас за оформление приглашения! $date в $time! Вас встретят и проводят наши менеджеры. Также Вам будет доступен бесплатный чайный стол. Желаем Вам успешных переговоров!”',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text(
                    AppLocalizations.of(context)?.backToB2B ?? 'Вернуться в раздел B2B',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
