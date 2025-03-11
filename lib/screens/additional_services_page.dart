import 'package:flutter/material.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'payment_info_page.dart';
import 'success_message_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdditionalServicesPage extends StatefulWidget {
  final String eventId;
  final String myParticipantId;
  final int invitedParticipantId;
  final int timeslotId;
  final int meetingThemeId;
  final List<int> languageIds;
  final String selectedDate;
  final String selectedTimeslot;

  const AdditionalServicesPage({
    Key? key,
    required this.eventId,
    required this.myParticipantId,
    required this.invitedParticipantId,
    required this.timeslotId,
    required this.meetingThemeId,
    required this.languageIds,
    required this.selectedDate,
    required this.selectedTimeslot,
  }) : super(key: key);

  @override
  _AdditionalServicesPageState createState() => _AdditionalServicesPageState();
}

class _AdditionalServicesPageState extends State<AdditionalServicesPage> {
  final B2bRepository _b2bRepository = B2bRepository();
  final PageController _pageController = PageController();
  bool needPhotograph = false;
  bool needTranslator = false;

  final int photographerCost = 5000;
  final int translatorCost = 2000;

  Future<void> sendInvitation() async {
    try {
      await _b2bRepository.createMeeting(
        eventId: widget.eventId,
        participantId: widget.myParticipantId,
        invitedParticipantId: widget.invitedParticipantId,
        timeslotId: widget.timeslotId,
        meetingThemeId: widget.meetingThemeId,
        needTranslator: needTranslator,
        needPhotograph: needPhotograph,
        languageIds: widget.languageIds,
      );

      if (!needPhotograph && !needTranslator) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessMessagePage(
              date: widget.selectedDate,
              time: widget.selectedTimeslot,
            ),
          ),
        );
      } else {
        _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    } catch (e) {
      print('Failed to send invitation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        // Страница выбора дополнительных услуг
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)?.additional ?? 'Additional',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(AppLocalizations.of(context)?.usePaidServices ?? 'Use paid services if needed:'),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)?.needPhotograph ?? 'Photographer services needed (5000 ₽)'),
                value: needPhotograph,
                onChanged: (value) => setState(() => needPhotograph = value),
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)?.needTranslator ?? 'Translator services needed (2000 ₽)'),
                value: needTranslator,
                onChanged: (value) => setState(() => needTranslator = value),
              ),
              SizedBox(height: 20),
              // Стоимость услуг фотографа и переводчика
              if (needPhotograph)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${AppLocalizations.of(context)?.photographerService ?? 'Photographer Service'}: $photographerCost ₽',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              if (needTranslator)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${AppLocalizations.of(context)?.translatorService ?? 'Translator Service'}: $translatorCost ₽',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              SizedBox(height: 10),
              // Инструкция по оплате
              Text(
                AppLocalizations.of(context)?.paymentInstructions ?? 'Оплата производится на стойке регистрации в зоне B2B',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: sendInvitation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      AppLocalizations.of(context)?.sendInvitation ?? 'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)?.back ?? 'Back',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Страница оплаты (если выбраны дополнительные услуги)
        PaymentInfoPage(
          needPhotograph: needPhotograph,
          needTranslator: needTranslator,
          selectedDate: widget.selectedDate,
          selectedTimeslot: widget.selectedTimeslot,
        ),
      ],
    );
  }
}
