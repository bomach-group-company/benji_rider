import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class OnlineOfflineCard extends StatefulWidget {
  final bool isOnline;
  final Future<void> Function() toggleOnline;
  const OnlineOfflineCard(
      {super.key, required this.isOnline, required this.toggleOnline});

  @override
  State<OnlineOfflineCard> createState() => _OnlineOfflineCardState();
}

class _OnlineOfflineCardState extends State<OnlineOfflineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: ShapeDecoration(
        color: kTextWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isOnline ? 'Online' : 'Offline',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                splashRadius: 5,
                onPressed: widget.toggleOnline,
                icon: Icon(
                  widget.isOnline ? Icons.toggle_on : Icons.toggle_off,
                  color:
                      widget.isOnline ? kAccentColor : const Color(0xFF8D8D8D),
                  size: 35,
                ),
              ),
            ],
          ),
          kSizedBox,
          Text(
            widget.isOnline
                ? "Yay! Start receiving delivery requests"
                : 'You are currently offline, go online to start receiving delivery request.',
            style: const TextStyle(
              color: Color(0xFF979797),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
