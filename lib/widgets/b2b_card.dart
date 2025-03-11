// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:eventssytem/cubit/all/b2b_cubit.dart';
// import 'package:eventssytem/cubit/all/b2b_state.dart';// Состояния B2B
// import 'package:eventssytem/models/b2b_model.dart'; // Модели данных

// class B2bCard extends StatelessWidget {
//   final String eventId;
//   final String participantId;
//   final String selectedDate;

//   B2bCard({required this.eventId, required this.participantId, required this.selectedDate});

//   @override
//   Widget build(BuildContext context) {
//     // Подключаем кубит для загрузки данных
//     return BlocProvider(
//       create: (context) => B2bCubit(context.read())..fetchTimeslots(eventId, participantId, selectedDate),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('B2B'),
//           bottom: TabBar(
//             indicatorColor: Colors.blue,
//             tabs: [
//               Tab(text: "Встречи"),
//               Tab(text: "Приглашения"),
//             ],
//           ),
//         ),
//         body: BlocBuilder<B2bCubit, B2bState>(
//           builder: (context, state) {
//             if (state is B2bLoading) {
//               return Center(child: CircularProgressIndicator());
//             }
//             if (state is B2bLoadedTimeslots) {
//               return _buildTimeslotList(context, state.timeslots);
//             }
//             if (state is B2bLoadedInvitations) {
//               return _buildInvitationList(context, state.invitations);
//             }
//             if (state is B2bError) {
//               return Center(child: Text(state.message));
//             }
//             return Center(child: Text('Нет данных'));
//           },
//         ),
//       ),
//     );
//   }

//   // Виджет для списка слотов встреч
//   Widget _buildTimeslotList(BuildContext context, List<MeetingSlot> timeslots) {
//     return ListView.builder(
//       itemCount: timeslots.length,
//       itemBuilder: (context, index) {
//         final slot = timeslots[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${slot.startTime.hour}:${slot.startTime.minute} - ${slot.endTime.hour}:${slot.endTime.minute}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 SizedBox(height: 8),
//                 Text('Свободный слот'),
//                 SizedBox(height: 8),
//                 Text('Свободные столы: ${slot.availableTables} из ${slot.totalTables}'),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.bookmark_border),
//                       onPressed: () {
//                         // Логика для добавления в избранное
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Виджет для списка приглашений
//   Widget _buildInvitationList(BuildContext context, List<Invitation> invitations) {
//     return ListView.builder(
//       itemCount: invitations.length,
//       itemBuilder: (context, index) {
//         final invitation = invitations[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${invitation.meetingTime.hour}:${invitation.meetingTime.minute} - ${invitation.receiverName}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 SizedBox(height: 8),
//                 Text(invitation.senderName),
//                 SizedBox(height: 8),
//                 Text('Статус: ${invitation.status}'),
//                 if (!invitation.isYouSender)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // Логика принятия встречи
//                         },
//                         child: Text('Принять'),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Логика отклонения встречи
//                         },
//                         child: Text('Отклонить'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
