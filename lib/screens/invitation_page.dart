import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventssytem/models/b2b_model.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/search_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'invitation_details_page.dart';

class InvitationPage extends StatefulWidget {
  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  late Future<List<Participant>>? participants;
  final B2bRepository b2bRepository = B2bRepository();
  String? participantId;
  String? eventId;
  String searchQuery = "";
  List<int> selectedCompetenceIds = [];

  @override
  void initState() {
    super.initState();
    _loadParticipantAndEventId();
  }

  Future<void> _loadParticipantAndEventId() async {
    final secureStorage = FlutterSecureStorage();
    final sharedPreferences = await SharedPreferences.getInstance();

    participantId = await secureStorage.read(key: 'participantId');
    eventId = sharedPreferences.getString('eventId');

    if (participantId != null && eventId != null) {
      _fetchParticipants();
    }
  }

  Future<void> _fetchParticipants({String? commonFilter}) async {
    if (participantId != null && eventId != null) {
      setState(() {
        participants = b2bRepository.fetchParticipantsWithFilters(
          eventId: eventId!,
          participantId: participantId!,
          competenceIds: selectedCompetenceIds,
          commonFilter: commonFilter, // передаем commonFilter
        );
      });
    }
  }

  void _applyFilters(List<int> competenceIds) {
    setState(() {
      selectedCompetenceIds = competenceIds;
    });
    _fetchParticipants(commonFilter: searchQuery);
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
    _fetchParticipants(commonFilter: query); // передаем строку поиска
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.invitations ?? 'Invitation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () async {
                final selectedFilters = await showModalBottomSheet<List<int>>(
                  context: context,
                  builder: (context) => FilterSelectionDialog(
                    initialSelected: selectedCompetenceIds,
                  ),
                );
                if (selectedFilters != null) {
                  _applyFilters(selectedFilters);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            CommonFilter(onSearchChanged: _updateSearchQuery),
            Expanded(
              child: participantId == null || eventId == null
                  ? const Center(child: CircularProgressIndicator())
                  : FutureBuilder<List<Participant>>(
                      future: participants,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text(
                            '${AppLocalizations.of(context)?.error ?? 'Error'}: ${snapshot.error}',
                          ));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text(
                            AppLocalizations.of(context)?.noInvitations ?? 'No invitations to display',
                          ));
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final participant = snapshot.data![index];
                            return ParticipantCard(
                              participant: participant,
                              myParticipantId: participantId!,
                              eventId: eventId!,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParticipantCard extends StatelessWidget {
  final Participant participant;
  final String myParticipantId;
  final String eventId;

  const ParticipantCard({
    Key? key,
    required this.participant,
    required this.myParticipantId,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: participant.photo != null
              ? NetworkImage(participant.photo!)
              : AssetImage('assets/icons/default_avatar.png') as ImageProvider,
        ),
        title: Text(
          '${participant.firstNameRus} ${participant.lastNameRus}',
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(participant.organizationRus ?? AppLocalizations.of(context)?.noOrganizationInfo ?? 'No organization information'),
            Text(
              participant.positionEng ?? '',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.75,
              child: InvitationDetailsPage(
                participant: participant,
                myParticipantId: myParticipantId,
                eventId: eventId,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CommonFilter extends StatelessWidget {
  final Function(String) onSearchChanged;

  const CommonFilter({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)?.search ?? 'Search', 
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: onSearchChanged, 
      ),
    );
  }
}

class FilterSelectionDialog extends StatefulWidget {
  final List<int> initialSelected;

  FilterSelectionDialog({required this.initialSelected});

  @override
  _FilterSelectionDialogState createState() => _FilterSelectionDialogState();
}

class _FilterSelectionDialogState extends State<FilterSelectionDialog> {
  late List<int> selectedCompetenceIds;

  @override
  void initState() {
    super.initState();
    selectedCompetenceIds = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    // Полный список доступных компетенций
    final availableCompetencies = [
      {'id': 85, 'name': 'textile and furniture manufacturing'},
      {'id': 86, 'name': 'trade and finance'},
      {'id': 87, 'name': 'construction'},
      {'id': 88, 'name': 'social activities'},
      {'id': 89, 'name': 'sport, recreation and entertainment'},
      {'id': 90, 'name': 'chemical industry'},
      {'id': 84, 'name': 'tourism'},
      {'id': 26, 'name': 'other'},
      {'id': 27, 'name': 'scientific research and development'},
      {'id': 28, 'name': 'IT sector'},
      {'id': 29, 'name': 'food industry'},
      {'id': 30, 'name': 'industrial sector'},
      {'id': 75, 'name': 'medicine'},
      {'id': 76, 'name': 'oil industry'},
      {'id': 77, 'name': 'books, cinema and telecommunications'},
      {'id': 78, 'name': 'Media'},
      {'id': 79, 'name': 'education'},
      {'id': 80, 'name': 'agricultural industry'},
      {'id': 81, 'name': 'public sector'},
      {'id': 82, 'name': 'transportation'},
      {'id': 83, 'name': 'waste treatment and waste disposal'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Filters'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: availableCompetencies.map((competence) {
                return CheckboxListTile(
                  title: Text(competence['name'] as String),
                  value: selectedCompetenceIds.contains(competence['id']),
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked == true) {
                        selectedCompetenceIds.add(competence['id'] as int);
                      } else {
                        selectedCompetenceIds.remove(competence['id']!);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedCompetenceIds);
              },
              child: Text('Apply'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedCompetenceIds.clear();
              });
            },
            child: Text(
              'Reset filters',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
