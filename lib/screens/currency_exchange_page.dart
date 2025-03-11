import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrencyExchangePage extends StatelessWidget {
  const CurrencyExchangePage({super.key});
   Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.currencyExchange ?? 'Обменные пункты'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Background().background),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(16, 120, 16, 16), // Top padding for spacing below the app bar
          children: [
            ExchangeLocationCard(
              title: localizations?.airport ?? 'Kazan Airport',
              address: localizations?.airportAddress ?? 'Kazan',
              hours: '00:00 - 24:00',
              note: localizations?.kazanExpoNote ?? 'Текст',
              type: localizations?.primary ?? 'Основной',
            ),
            SizedBox(height: 16),
            ExchangeLocationCard(
              title: localizations?.korstonKazanTitle ?? 'Korston Kazan',
              address: localizations?.korstonKazanAddress ?? 'Республика Татарстан, Казань, ул. Ершова, 1',
              hours: '10:00 - 19:00',
              note: localizations?.korstonKazanNote ?? 'Текст',
              type: localizations?.additional ?? 'Дополнительный',
            ),
            SizedBox(height: 16),
            ExchangeLocationCard(
              title: localizations?.kvartKazan ?? 'Kvart Kazan',
              address: localizations?.kvartAddress ?? 'Республика Татарстан, Казань, ул. Выставочная, 3',
              hours: '00:00 - 24:00',
              note: localizations?.korstonKazanNote ?? 'Текст',
              type: localizations?.additional ?? 'Дополнительный',
            ),
            SizedBox(height: 16),
            ExchangeLocationCard(
              title: localizations?.kazanExpoTitle ?? 'Kazan Expo',
              address: localizations?.kazanExpoAddress ?? 'Республика Татарстан, Казань, ул. Выставочная, 1',
              hours: '00:00 - 24:00',
              note: localizations?.korstonKazanNote ?? 'Текст',
              type: localizations?.additional ?? 'Дополнительный',
            ),
            SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () => _launchUrl("https://sprouts.maksat.pro/currency_rus.pdf"),
                          child: Text(
                            "Обменные пункты",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchUrl("https://sprouts.maksat.pro/currency_eng.pdf"),
                          child: Text(
                            "Currency Exchange Points",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchUrl("https://sprouts.maksat.pro/currency_chi.pdf"),
                          child: Text(
                            "兑换点",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ExchangeLocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String hours;
  final String note;
  final String type;

  const ExchangeLocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.hours,
    required this.note,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(
                color: type == 'Основной' ? Colors.blue : Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Адрес: $address'),
            SizedBox(height: 8),
            Text('Время работы: $hours'),
            SizedBox(height: 8),
            //Text('Примечание: $note'),
          ],
        ),
      ),
    );
  }
}
