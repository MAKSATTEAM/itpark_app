import 'package:flutter/material.dart';
import 'package:eventssytem/models/b2b_model.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvitationDetailsPage extends StatefulWidget {
  final Participant participant;
  final String myParticipantId;
  final String eventId;
  final String fetchedTheme; // Meeting theme from the first page
  final String fetchedLanguage; // Meeting language from the first page

  const InvitationDetailsPage({
    Key? key,
    required this.participant,
    required this.myParticipantId,
    required this.eventId,
    required this.fetchedTheme,
    required this.fetchedLanguage,
  }) : super(key: key);

  @override
  _InvitationDetailsPageState createState() => _InvitationDetailsPageState();
}

class _InvitationDetailsPageState extends State<InvitationDetailsPage> {
  final B2bRepository _b2bRepository = B2bRepository();
  String? selectedTimeslot;
  List<TimeslotModel> timeslots = [];
  String selectedDate = '11-13-2024';

  @override
  void initState() {
    super.initState();
    fetchTimeslots();
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
      print('Ошибка при загрузке временных слотов: $e');
    }
  }

  String formatDateForDisplay(String date) {
    final dateParts = date.split('-');
    return '${dateParts[1]}/${dateParts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.invitations ?? 'Invitation'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
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
            // Display fetched theme and language as non-editable fields
            TextFormField(
              initialValue: widget.fetchedTheme,
              readOnly: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.theme ?? 'Meeting Theme',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget.fetchedLanguage,
              readOnly: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.language ?? 'Meeting Language',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedTimeslot != null
                  ? () {
                      final selectedTimeslotId = timeslots.firstWhere(
                        (slot) => slot.formattedTime == selectedTimeslot,
                        orElse: () => TimeslotModel(id: 0, nameRus: '', nameEng: '', dateTimeStart: DateTime.now(), dateTimeEnd: DateTime.now()),
                      );

                      // Return selected timeslot data to the first screen
                      Navigator.pop(context, {
                        'timeslotId': selectedTimeslotId.id.toString(),
                        'newStartTime': selectedTimeslotId.dateTimeStart,
                        'newEndTime': selectedTimeslotId.dateTimeEnd,
                      });
                    }
                  : null,
              child: Text(AppLocalizations.of(context)?.next ?? 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}
