import 'package:benji_rider/repo/models/tasks.dart';
import 'package:benji_rider/src/providers/constants.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:benji_rider/theme/colors.dart';
import 'package:flutter/material.dart';

class DirectsPage extends StatefulWidget {
  final TasksModel task;
  const DirectsPage({super.key, required this.task});

  @override
  State<DirectsPage> createState() => _DirectsPageState();
}

class _DirectsPageState extends State<DirectsPage> {
  @override
  Widget build(BuildContext context) {
    print('widget.task ${widget.task} ${widget.task.orders}');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        title: "Items",
        elevation: 10.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Items',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              kSizedBox,
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.task.orders.length,
                separatorBuilder: (BuildContext context, int index) {
                  return kSizedBox;
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kTextWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.task.orders[index].orderitems.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return kHalfSizedBox;
                      },
                      itemBuilder: (BuildContext context, int indexItem) {
                        return Text(
                            '${widget.task.orders[index].orderitems[indexItem].quantity}x ${widget.task.orders[index].orderitems[indexItem].product.name}');
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
