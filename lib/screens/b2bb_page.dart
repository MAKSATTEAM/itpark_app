import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/b2b_cubit.dart';
import 'package:eventssytem/cubit/all/b2b_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/b2b_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eventssytem/models/b2b_model.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'invitation_page.dart';
import 'meeting_detail_page.dart';
import 'package:eventssytem/widgets/background.dart';

class B2bPage extends StatefulWidget {
  const B2bPage({super.key});

  @override
  State<B2bPage> createState() => _B2bPageState();
}

class _B2bPageState extends State<B2bPage> with TickerProviderStateMixin {
  late TabController _controller;
  late TabController _controller2;
  String? participantId;
  String? eventId; // Извлекается из SharedPreferences
  String selectedDate = '2024-11-13';

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _controller = TabController(length: 3, vsync: this);
    _controller2 = TabController(length: 2, vsync: this);

    // Load participant and event ID
    _loadParticipantAndEventId();

    // Add listener to switch dates when the user switches tabs
    _controller.addListener(() {
      setState(() {
        switch (_controller.index) {
          case 0:
            selectedDate = '2024-11-13';
            break;
          case 1:
            selectedDate = '2024-11-14';
            break;
          case 2:
            selectedDate = '2024-11-15';
            break;
        }
        // Only update after changing tabs (meeting dates)
        update();
      });
    });

    // Add listener for switching between "Meetings" and "Invitations" tabs
    _controller2.addListener(() {
      // Update when changing between meetings/invitations
      update();
    });
  }

  Future<void> _loadParticipantAndEventId() async {
    final secureStorage = FlutterSecureStorage();
    final sharedPreferences = await SharedPreferences.getInstance();

    participantId = await secureStorage.read(key: 'participantId');
    eventId = sharedPreferences.getString('eventId');

    // Fetch data once participantId and eventId are loaded
    if (participantId != null && eventId != null) {
      update();  // Trigger data fetch
    }

    setState(() {});
  }

  void update() {
    if (participantId != null && eventId != null) {
      if (_controller2.index == 0) {
        // Fetch timeslots for meetings
        context.read<B2bCubit>().fetchTimeslots(eventId!, participantId!, selectedDate);
      } else {
        // Fetch invitations
        context.read<B2bCubit>().fetchInvitations(eventId!, participantId!);
      }
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
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
          backgroundColor: kBacColor,
          actions: [
            IconButton(
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvitationPage()),
                );
              },
              icon: SvgPicture.asset("assets/icons/invations.svg"),
            ),
            NotificationIcon()
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Column(
              children: [
                ButtonsTabBar(
                  controller: _controller2,
                  backgroundColor: kButtonColor,
                  unselectedBackgroundColor: kUnSelectProgramColor,
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  radius: 9,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)?.meetings ?? "Meetings"), 
                    Tab(text: AppLocalizations.of(context)?.invitations ?? "Invitations"), 
                  ],
                ),
                TabBar(
                  controller: _controller,
                  indicatorColor: kTextGreenColor,
                  unselectedLabelColor: kTextGreyColor,
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                  labelColor: kTextGreenColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(text: '13/11'), // Date tab for 13/11
                    Tab(text: '14/11'), // Date tab for 14/11
                    Tab(text: '15/11'), // Date tab for 15/11
                  ],
                ),
              ],
            ),
          ),
        ),
        body: participantId == null || eventId == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _controller2,
                children: [
                  BlocBuilder<B2bCubit, B2bState>(
                    builder: (context, state) {
                      if (state is B2bLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is B2bLoadedTimeslots) {
                        return _buildMeetingCard(state.timeslots);
                      } else if (state is B2bError) {
                        return Center(child: Text('${AppLocalizations.of(context)?.error ?? "Error"}: ${state.message}'));
                      } else {
                        return Center(child: Text(AppLocalizations.of(context)?.nodata ?? "No data available"));
                      }
                    },
                  ),
                  BlocBuilder<B2bCubit, B2bState>(
                    builder: (context, state) {
                      if (state is B2bLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is B2bLoadedInvitations) {
                        return _buildInvitationCard(state.invitations);
                      } else if (state is B2bError) {
                        return Center(child: Text('${AppLocalizations.of(context)?.error ?? "Error"}: ${state.message}'));
                      } else {
                        return Center(child: Text(AppLocalizations.of(context)?.noinvitations ?? "No invitations available"));
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMeetingCard(List<MeetingSlot> timeslots) {
    return ListView.builder(
      itemCount: timeslots.length,
      itemBuilder: (context, index) {
        final MeetingSlot slot = timeslots[index];

        String startTime = '${slot.startTime.hour}:${slot.startTime.minute.toString().padLeft(2, '0')}';
        String endTime = '${slot.endTime.hour}:${slot.endTime.minute.toString().padLeft(2, '0')}';

        return InkWell(
          onTap: () {
            if (slot.meetingId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeetingDetailsPage(
                    eventId: eventId!,
                    participantId: participantId!,
                    meetingId: slot.meetingId.toString(),
                    invitationStatus: null,  // Pass correct status ID
                    meetingName: null, // Pass meeting name
                  ),
                ),
              );
            } else {
              print("Creating a new meeting");
            }
          },
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$startTime - $endTime',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (slot.isAvailable)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.freeslot ?? "Free slot",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                        if (slot.table != null && slot.table.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                '${slot.table}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)?.participant ?? "Participant"}: ${slot.participant}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${AppLocalizations.of(context)?.organization ?? "Organization"}: ${slot.participantOrganization}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        if (slot.table != null && slot.table.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                '${slot.table}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInvitationCard(List<Invitation> invitations) {
    return ListView.builder(
      itemCount: invitations.length,
      itemBuilder: (context, index) {
        final Invitation invitation = invitations[index];

        Color statusColor;
        Color statusTextColor;
        switch (invitation.meetingStatusId) {
          
          case 3:
            statusColor = Colors.green.shade100; 
            statusTextColor = Colors.green.shade800;
            break;
          case 1 :
            statusColor = Colors.orange.shade100; 
            statusTextColor = Colors.orange.shade800;
            
            break;
          case 5 :
            statusColor = Colors.red.shade100; 
            statusTextColor = Colors.red.shade800;
            break;
          default:
            statusColor = Colors.grey.shade300; 
            statusTextColor = Colors.grey.shade600;
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeetingDetailsPage(
                  eventId: eventId!,
                  participantId: participantId!,
                  meetingId: invitation.id.toString(),
                  invitationStatus: invitation.meetingStatusId,  // Pass correct status ID
                  meetingName: invitation.meetingStatusName , // Pass invitation name
                ),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.white, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), 
            ),
            elevation: 3.0, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    invitation.meetingStatusName,
                    style: TextStyle(
                      color: statusTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              invitation.participant,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            child: Text(invitation.participant[0]),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        invitation.participantOrganization,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${_formatDateTime(invitation.meetingTimeStart)} - ${_formatTime(invitation.meetingTimeEnd)}',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      if (invitation.newDateTimeStart != null &&
                          invitation.newDateTimeEnd != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            '${AppLocalizations.of(context)?.suggestnewtime ?? "New time"}: ${_formatDateTime(invitation.newDateTimeStart!)} - ${_formatTime(invitation.newDateTimeEnd!)}',
                            style: TextStyle(color: Colors.red.shade400),
                          ),
                        ),
                      SizedBox(height: 4),
                      Text(
                        '${AppLocalizations.of(context)?.theme ?? "Theme"}: ${invitation.meetingTheme}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      if (invitation.table != null && invitation.table.isNotEmpty)
                        Text(
                          '${AppLocalizations.of(context)?.table ?? "Table"}: ${invitation.table}',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      if (invitation.isNeedTranslator)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            AppLocalizations.of(context)?.needtranslator ?? "Translator needed",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      if (invitation.isNeedPhotograph)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            AppLocalizations.of(context)?.needphotograph ?? "Photographer needed",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      SizedBox(height: 4),
                      Text(
                        '${AppLocalizations.of(context)?.languages ?? "Languages"}: ${invitation.languages}',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      SizedBox(height: 16),
                      // if (!invitation.isYouSender)
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       ElevatedButton(
                      //         onPressed: () {},
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.blue, 
                      //           foregroundColor: Colors.white, 
                      //         ),
                      //         child: Text(AppLocalizations.of(context)?.accept ?? "Accept"),
                      //       ),
                      //       SizedBox(width: 8),
                      //       ElevatedButton(
                      //         onPressed: () {},
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.white,
                      //           foregroundColor: Colors.red,
                      //           side: BorderSide(color: Colors.red), 
                      //         ),
                      //         child: Text(AppLocalizations.of(context)?.decline ?? "Decline"),
                      //       ),
                      //     ],
                      //   )
                      // else if (invitation.isYouTimeChanger)
                      //   Align(
                      //     alignment: Alignment.centerRight,
                      //     child: TextButton(
                      //       onPressed: () {},
                      //       child: Text(
                      //         AppLocalizations.of(context)?.suggestnewtime ?? "Suggest a new time",
                      //         style: TextStyle(color: Colors.blueAccent),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  // Helper function to format DateTime
  String _formatDateTime(DateTime dateTime) {
    return '${_getDayOfWeek(dateTime.weekday)}, ${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Helper function to format time
  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Helper function for day of the week in Russian
  String _getDayOfWeek(int weekday) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return days[weekday - 1];
}

// Helper function for month names in English
String _getMonthName(int month) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month - 1];
}



}