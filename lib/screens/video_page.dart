// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class VideoPage extends StatelessWidget {
//   String url;
//   VideoPage({required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [
//           WebView(
//             initialUrl: url,
//             javascriptMode: JavascriptMode.unrestricted,
//           ),
//           Padding(
//               padding: EdgeInsets.all(16),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                       width: 40,
//                       height: 40,
//                       padding: EdgeInsets.all(12),
//                       child: SvgPicture.asset(
//                         "assets/icons/left.svg",
//                         color: Color(0xFF25282B),
//                       ),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(1000))),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
