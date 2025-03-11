import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 40,
        onPressed: () {
          Navigator.pushNamed(context, '/search');
        },
        icon: SvgPicture.asset("assets/icons/search.svg"));
  }
}
