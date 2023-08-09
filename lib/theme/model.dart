import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../app/call/call.dart';
import '../src/providers/constants.dart';
import 'colors.dart';

Future<void> deliveryModel(BuildContext context, Function() acceptRequestFunc,
    {Function()? pickedUpFunc,
    Function()? deliveryFunc,
    bool isPickup = false,
    bool isDelivery = false}) {
  return showModalBottomSheet<void>(
    barrierColor: kBlackColor.withOpacity(0.7),
    isScrollControlled: true,
    enableDrag: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      padding: const EdgeInsets.all(2),
                      decoration: ShapeDecoration(
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 1,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kAccentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Container(
                      color: kAccentColor,
                      height: kDefaultPadding * 2,
                      width: 1.5,
                    ),
                    Icon(
                      Icons.location_on_sharp,
                      size: 12,
                      color: kAccentColor,
                    ),
                  ],
                ),
                kHalfWidthSizedBox,
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '21 Bartus Street, Abuja Nigeria',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 15.97,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      Text(
                        '21 Bartus Street, Abuja Nigeria',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 15.97,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            kSizedBox,
            kSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 82.13,
                  height: 82.13,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/food/burgers.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.13),
                    ),
                  ),
                ),
                kHalfWidthSizedBox,
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rice and Chicken',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.69,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      Text(
                        'Food ',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.69,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      Text(
                        '3 plates',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.69,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      Text(
                        '40kg',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.69,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kHalfSizedBox,
                      Text(
                        'Item is fragile (glass) so be careful',
                        style: TextStyle(
                          color: Color(0xFF454545),
                          fontSize: 13.69,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            kSizedBox,
            kSizedBox,
            (isPickup || isDelivery)
                ? ListTile(
                    leading: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profile/avatar-image.jpg'),
                    ),
                    title: const Text('Miracle Ages'),
                    trailing: InkWell(
                      onTap: () {
                        Get.to(
                          () => const CallPage(),
                          routeName: 'CallPage',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.downToUp,
                        );
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: const Icon(Icons.phone),
                    ),
                  )
                : const Text(
                    'You will be able to contact customer \nonce you accept pick up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 13.69,
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
            kSizedBox,
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      kDefaultPadding * 2,
                    ),
                  ),
                  onPressed: isPickup
                      ? pickedUpFunc
                      : isDelivery
                          ? deliveryFunc
                          : acceptRequestFunc,
                  child: Text(
                    isPickup
                        ? 'Confirm Pickup'
                        : isDelivery
                            ? 'Delivery Completed'
                            : 'Accept Request',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.53,
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                kHalfSizedBox,
                isDelivery
                    ? const SizedBox()
                    : OutlinedButton(
                        onPressed: isPickup
                            ? acceptRequestFunc
                            : () {
                                Navigator.of(context).pop();
                              },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            kDefaultPadding * 2,
                          ),
                        ),
                        child: Text(
                          isPickup ? 'Cancel' : 'Reject',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFD41920),
                            fontSize: 15.53,
                            fontFamily: 'Sen',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
              ],
            ),
            kSizedBox
          ],
        ),
      );
    },
  );
}
