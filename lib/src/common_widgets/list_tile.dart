import 'package:benji_rider/theme/colors.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  final String text;
  final bool isOnline;
  final IconData icon;
  final Function() nav;

  const MyListTile({
    super.key,
    required this.text,
    required this.isOnline,
    required this.icon,
    required this.nav,
  });

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.nav,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      leading: Icon(
        widget.icon,
        size: 24,
        color: widget.isOnline ? kAccentColor : const Color(0xFF8D8D8D),
      ),
      title: Text(
        widget.text,
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 19.86,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
