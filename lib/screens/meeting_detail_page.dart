import 'package:flutter/material.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'package:eventssytem/models/b2b_model.dart';
import 'suggest_new_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'meeting_feetback_page.dart';

class MeetingDetailsPage extends StatefulWidget {
  final String eventId;
  final String participantId;
  final String meetingId;
  final int? invitationStatus;  // Changed to int for meeting status ID
  final String? meetingName;     // New parameter for meeting name

  const MeetingDetailsPage({
    Key? key,
    required this.eventId,
    required this.participantId,
    required this.meetingId,
    required this.invitationStatus,
    required this.meetingName,
  }) : super(key: key);

  @override
  _MeetingDetailsPageState createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  final B2bRepository _b2bRepository = B2bRepository();
  DetailMeeting? meetingDetails;
  bool isLoading = true;
  bool _isAccepted = false;

  @override
  void initState() {
    super.initState();
    _fetchMeetingDetails();
  }

  Future<void> _fetchMeetingDetails() async {
    try {
      final fetchedDetails = await _b2bRepository.fetchMeetingDetails(
        widget.eventId,
        widget.participantId,
        widget.meetingId,
      );

      setState(() {
        meetingDetails = fetchedDetails;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading meeting: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _rejectMeeting() async {
    const int statusId = 5; // Status for "Meeting Cancelled"
    try {
      await _b2bRepository.updateMeetingStatus(
        eventId: widget.eventId,
        participantId: widget.participantId,
        meetingId: widget.meetingId,
        statusId: statusId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.meetingRejected ?? 'Meeting rejected')),
      );
      setState(() {
        _isAccepted = false;
      });
      _fetchMeetingDetails();
    } catch (e) {
      print("Error rejecting meeting: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.meetingRejectFailed ?? 'Failed to reject meeting')),
      );
    }
  }

  Future<void> _acceptInvitation() async {
    const int statusId = 3; // Status for "Meeting Scheduled"
    try {
      await _b2bRepository.updateMeetingStatus(
        eventId: widget.eventId,
        participantId: widget.participantId,
        meetingId: widget.meetingId,
        statusId: statusId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.invitationAccepted ?? 'Invitation accepted')),
      );

      setState(() {
        _isAccepted = true;
      });
      _fetchMeetingDetails();
    } catch (e) {
      print("Error accepting invitation: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)?.acceptInvitationFailed ?? 'Failed to accept invitation')),
      );
    }
  }

  Future<void> _suggestNewTime() async {
    if (meetingDetails == null) return;

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.75,
        child: InvitationDetailsPage(
          participant: Participant(
            id: int.parse(widget.participantId),
            firstNameRus: meetingDetails!.participant,
            lastNameRus: meetingDetails!.participantOrganization ?? '',
            firstNameEng: '',
            lastNameEng: '',
            organizationRus: meetingDetails!.participantOrganization ?? '',
            organizationEng: meetingDetails!.participantOrganization ?? '',
          ),
          myParticipantId: widget.participantId,
          eventId: widget.eventId,
          fetchedTheme: meetingDetails!.meetingTheme,
          fetchedLanguage: meetingDetails!.languages,
        ),
      ),
    );

    if (result != null) {
      final timeslotId = result['timeslotId'] as String;
      final newStartTime = result['newStartTime'] as DateTime;
      final newEndTime = result['newEndTime'] as DateTime;

      await _sendTimeChangeRequest(timeslotId, newStartTime, newEndTime);
    }
  }

  Future<void> _sendTimeChangeRequest(String timeslotId, DateTime newStartTime, DateTime newEndTime) async {
    try {
      await _b2bRepository.suggestNewMeetingTime(
        eventId: widget.eventId,
        participantId: widget.participantId,
        meetingId: widget.meetingId,
        timeslotId: timeslotId,
        newDateTimeStart: newStartTime,
        newDateTimeEnd: newEndTime,
        meetingStatusId: 1,
        meetingStatusName: "Waiting for a reply to an invitation",
        participant: meetingDetails?.participant ?? '',
        participantOrganization: meetingDetails?.participantOrganization ?? '',
        meetingTheme: meetingDetails?.meetingTheme ?? '',
        isNeedTranslator: meetingDetails?.isNeedTranslator ?? false,
        isNeedPhotograph: meetingDetails?.isNeedPhotograph ?? false,
        languages: meetingDetails?.languages ?? '',
        isYouSender: meetingDetails?.isYouSender ?? true,
        isYouTimeChanger: true,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Time change request sent')),
      );

      _fetchMeetingDetails();
    } catch (e) {
      print("Error suggesting new time: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to suggest new time')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.meeting?? 'Meeting'), // Display meeting name in the AppBar
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : meetingDetails != null
              ? _buildMeetingContent()
              : Center(child: Text(AppLocalizations.of(context)?.loadingError ?? 'Error loading data')),
    );
  }

  Widget _buildMeetingContent() {
    if (meetingDetails == null) return Container();

    final statusName = meetingDetails!.meetingStatusName;
    final participantName = meetingDetails!.participant;
    final companyName = meetingDetails!.participantOrganization;
    final startTime = meetingDetails!.dateTimeStart;
    final endTime = meetingDetails!.dateTimeEnd;
    final location = meetingDetails!.table ?? AppLocalizations.of(context)?.locationNotProvided ?? '';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${AppLocalizations.of(context)?.status ?? 'Status'}:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(statusName, style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text(participantName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(companyName, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text('${_formatDateTime(startTime)} - ${_formatTime(endTime)}', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text('${AppLocalizations.of(context)?.location ?? 'Location'}: $location', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
          Text('${AppLocalizations.of(context)?.theme ?? 'Theme'}:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(meetingDetails!.meetingTheme, style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          Text(AppLocalizations.of(context)?.additional ?? 'Additional', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 8),
          _buildAdditionalInfo(),
          Spacer(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
  if (meetingDetails != null) {
    List<Widget> buttons = [];

    // Show "Rate Meeting" button if the meeting is completed and feedback is not filled
    if (widget.invitationStatus == 4 && !meetingDetails!.isFeedbackFilled) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            // Navigate to MeetingFeedbackPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeetingFeedbackPage(
                  eventId: widget.eventId,
                  participantId: widget.participantId,
                  meetingId: widget.meetingId,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          ),
          child: Text(AppLocalizations.of(context)?.rateMeeting ?? 'Rate Meeting'),
        ),
      );
    }

    // Show Accept, Reject, and Suggest New Time buttons if invitation is waiting for reply
    if (widget.invitationStatus == 1 && !_isAccepted && !meetingDetails!.isYouSender) {
      buttons.addAll([
        ElevatedButton(
          onPressed: _acceptInvitation,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          ),
          child: Text(AppLocalizations.of(context)?.acceptInvitation ?? 'Accept Invitation'),
        ),
        
        ElevatedButton(
          onPressed: _suggestNewTime,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          ),
          child: Text(AppLocalizations.of(context)?.suggestNewTime ?? 'Suggest New Time'),
        ),
        TextButton(
          onPressed: _rejectMeeting,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // Red text color with no background
          ),
          child: Text(AppLocalizations.of(context)?.rejectInvitation ?? 'Reject Invitation'),
        ),
      ]);
    } 
    // Show Suggest New Time and Reject buttons if the meeting is scheduled
    else if (widget.invitationStatus == 3 || _isAccepted) {
      buttons.addAll([
        ElevatedButton(
          onPressed: _suggestNewTime,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          ),
          child: Text(AppLocalizations.of(context)?.suggestNewTime ?? 'Suggest New Time'),
        ),
        TextButton(
          onPressed: _rejectMeeting,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // Red text color with no background
          ),
          child: Text(AppLocalizations.of(context)?.rejectMeeting ?? 'Reject Meeting'),
        ),
      ]);
    } 
    // Show "Accept Meeting" button if the invitation was declined
    else if (widget.invitationStatus == 2) {
      buttons.add(
        ElevatedButton(
          onPressed: _acceptInvitation,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          ),
          child: Text(AppLocalizations.of(context)?.acceptMeeting ?? 'Accept Meeting'),
        ),
      );
    } 
    // Show Suggest New Time and Reject buttons for other cases if the user is the sender
    else if (widget.invitationStatus != 4 && meetingDetails!.isYouSender) {
      buttons.addAll([
        ElevatedButton(
          onPressed: _suggestNewTime,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          ),
          child: Text(AppLocalizations.of(context)?.suggestNewTime ?? 'Suggest New Time'),
        ),
        TextButton(
          onPressed: _rejectMeeting,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // Red text color with no background
          ),
          child: Text(AppLocalizations.of(context)?.rejectMeeting ?? 'Reject Meeting'),
        ),
      ]);
    }

    // Center buttons vertically and display them in a column with spacing
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons
            .map((button) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: button,
                ))
            .toList(),
      ),
    );
  } else {
    return Center(child: Text(AppLocalizations.of(context)?.noMeetingDetails ?? 'No meeting details available.'));
  }
}

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(AppLocalizations.of(context)?.meetingLanguage ?? 'Meeting Language', meetingDetails!.languages),
        _buildInfoRow(AppLocalizations.of(context)?.translatorNeeded ?? 'Translator needed', meetingDetails!.isNeedTranslator ? AppLocalizations.of(context)?.yes ?? 'Yes' : AppLocalizations.of(context)?.no ?? 'No'),
        _buildInfoRow(AppLocalizations.of(context)?.photographerNeeded ?? 'Photographer needed', meetingDetails!.isNeedPhotograph ? AppLocalizations.of(context)?.yes ?? 'Yes' : AppLocalizations.of(context)?.no ?? 'No'),
        _buildInfoRow(AppLocalizations.of(context)?.youAreSender ?? 'You are the sender', meetingDetails!.isYouSender ? AppLocalizations.of(context)?.yes ?? 'Yes' : AppLocalizations.of(context)?.no ?? 'No'),
        _buildInfoRow(AppLocalizations.of(context)?.timeSuggestedByYou ?? 'Time suggested by you', meetingDetails!.isYouTimeChanger ? AppLocalizations.of(context)?.yes ?? 'Yes' : AppLocalizations.of(context)?.no ?? 'No'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Text(value, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_getDayOfWeek(dateTime.weekday)}, ${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getDayOfWeek(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
