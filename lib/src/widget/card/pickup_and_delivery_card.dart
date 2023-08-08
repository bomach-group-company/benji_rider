import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class PickupDeliveryCard extends StatefulWidget {
  final Function() pickupFunc;
  final Function() deliveryFunc;
  final bool isDelivery;
  const PickupDeliveryCard(
      {super.key,
      required this.pickupFunc,
      required this.deliveryFunc,
      this.isDelivery = false});

  @override
  State<PickupDeliveryCard> createState() => _PickupDeliveryCardState();
}

class _PickupDeliveryCardState extends State<PickupDeliveryCard> {
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
                widget.isDelivery ? 'Pending Delivery' : 'Pending Pickup',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          kHalfSizedBox,
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '21 Bartus Street, Enugu. ',
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 14,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '12km',
                  style: TextStyle(
                    color: Color(0xFFEC2623),
                    fontSize: 14,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          kSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '20 mins ago',
                style: TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              OutlinedButton(
                onPressed:
                    widget.isDelivery ? widget.deliveryFunc : widget.pickupFunc,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: kAccentColor,
                  ),
                  foregroundColor: kAccentColor,
                  shape: StadiumBorder(
                    side: BorderSide(color: kAccentColor),
                  ),
                ),
                child: Text(
                  widget.isDelivery ? 'Arrived' : 'Pick-up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kAccentColor,
                    fontSize: 15.53,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
