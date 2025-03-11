import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventssytem/models/b2b_model.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'additional_services_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvitationDetailsPage extends StatefulWidget {
  final Participant participant;
  final String myParticipantId;
  final String eventId;

  const InvitationDetailsPage({
    Key? key,
    required this.participant,
    required this.myParticipantId,
    required this.eventId,
  }) : super(key: key);

  @override
  _InvitationDetailsPageState createState() => _InvitationDetailsPageState();
}

class _InvitationDetailsPageState extends State<InvitationDetailsPage> {
  final B2bRepository _b2bRepository = B2bRepository();
  List<ThemeModel> meetingThemes = [];
  List<LanguageModel> languages = [];
  List<TimeslotModel> timeslots = [];
  String selectedDate = '11-13-2024';
  String? selectedTimeslot;
  String? selectedTable;
  String? selectedTheme;
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    fetchTimeslots();
    fetchMeetingThemes();
    fetchLanguages();
  }

  Future<void> fetchTimeslots() async {
    try {
      final fetchedTimeslots = await _b2bRepository.getTimeslotsForInvitation(
        widget.eventId,
        widget.myParticipantId,
        widget.participant.id.toString(),
        selectedDate,
      );
      setState(() {
        timeslots = fetchedTimeslots;
      });
    } catch (e) {
      print('Error loading timeslots: $e');
    }
  }

  Future<void> fetchMeetingThemes() async {
    try {
      final themes = await _b2bRepository.getMeetingThemes();
      setState(() {
        meetingThemes = themes;
      });
    } catch (e) {
      print('Ошибка при загрузке тем встреч: $e');
    }
  }

  Future<void> fetchLanguages() async {
    try {
      final fetchedLanguages = await _b2bRepository.getLanguages();
      setState(() {
        languages = fetchedLanguages;
      });
    } catch (e) {
      print('Error loading languages: $e');
    }
  }

  String formatDateForDisplay(String date) {
    final dateParts = date.split('-');
    return '${dateParts[1]}/${dateParts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.invitations ?? 'Invitation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['11-13-2024', '11-14-2024', '11-15-2024'].map((date) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                  });
                  fetchTimeslots();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: selectedDate == date ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    formatDateForDisplay(date),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedTimeslot,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)?.timeslot ?? 'Timeslot',
            ),
            items: timeslots.map((slot) {
              return DropdownMenuItem(
                value: slot.formattedTime,
                child: Text(slot.formattedTime),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedTimeslot = value),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedTheme,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)?.theme ?? 'Meeting Theme',
            ),
            items: meetingThemes.map((theme) {
              return DropdownMenuItem(
                value: theme.nameRus,
                child: Text(theme.nameRus),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedTheme = value),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedLanguage,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)?.language ?? 'Meeting Language',
            ),
            items: languages.map((language) {
              return DropdownMenuItem(
                value: language.name,
                child: Text(language.name),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedLanguage = value),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: selectedTheme != null && selectedLanguage != null
                ? () {
                    final selectedTimeslotId = timeslots.firstWhere(
                      (slot) => slot.formattedTime == selectedTimeslot,
                      orElse: () => TimeslotModel(id: 0, nameRus: '', nameEng: '', dateTimeStart: DateTime.now(), dateTimeEnd: DateTime.now()),
                    ).id;

                    final selectedThemeId = meetingThemes.firstWhere(
                      (theme) => theme.nameRus == selectedTheme,
                      orElse: () => ThemeModel(id: 0, nameRus: '', nameEng: ''),
                    ).id;

                    final selectedLanguageIds = languages
                        .where((language) => selectedLanguage == language.name)
                        .map((language) => language.id)
                        .toList();

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.75,
                        child: AdditionalServicesPage(
                          eventId: widget.eventId,
                          myParticipantId: widget.myParticipantId,
                          invitedParticipantId: widget.participant.id,
                          timeslotId: selectedTimeslotId,
                          meetingThemeId: selectedThemeId,
                          languageIds: selectedLanguageIds,
                          selectedDate: selectedDate, // Передаем дату
                          selectedTimeslot: selectedTimeslot ?? 'неизвестно', // Передаем время
                        ),
                      ),
                    );
                  }
                : null,
            child: Text(AppLocalizations.of(context)?.next ?? 'Next'),
          ),
        ],
      ),
    );
  }
}
