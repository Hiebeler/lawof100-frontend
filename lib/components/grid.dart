import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lawof100/components/addEntryDialog.dart';
import 'package:lawof100/components/dialog.dart';
import 'package:lawof100/my_globals.dart';

class Grid extends StatefulWidget {
  var entriesList = [];
  String startDateString = "";
  int challengeId;
  Function reload;

  Grid(
      {Key? key,
      required this.entriesList,
      required this.startDateString,
      required this.challengeId,
      required this.reload})
      : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  List<Map> gridList = [];

  DateTime startDate = DateTime.now();

  void fillGridList() {
    startDate = DateTime.parse(widget.startDateString);

    for (int i = 1; i < 101; i++) {
      List day =
          widget.entriesList.where((element) => (element["day"]) == i).toList();
      if (day.length == 1) {
        gridList.add(day.first);
      } else {
        gridList.add(
            {"day": i, "description": "", "successful": 2, "timestamp": null});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    fillGridList();
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(59, 66, 79, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8, crossAxisSpacing: 6, mainAxisSpacing: 6),
        children: [
          ...gridList.map((e) {
            int day = e["day"];
            DateTime datePlusDaysPlus2 = DateTime(
                startDate.year, startDate.month, startDate.day + day + 2);
            DateTime datePlusDaysPlus1 = DateTime(
                startDate.year, startDate.month, startDate.day + day + 1);
            DateTime datePlusDays =
                DateTime(startDate.year, startDate.month, startDate.day + day);
            return GestureDetector(
              onTap: () {
                if (e["successful"] == 1 || e["successful"] == 0) {
                  bool change = false;
                  if (datePlusDays.isBefore(DateTime.now()) &&
                      datePlusDaysPlus2.isAfter(DateTime.now())) {
                    change = true;
                  }
                  showDialog(
                      context:
                          myGlobals.scaffoldKey.currentContext as BuildContext,
                      builder: (BuildContext context) {
                        return CustomDialog.entry(
                            "Day " + e["day"].toString(),
                            e["description"],
                            change,
                            day,
                            widget.challengeId, () {
                          widget.reload();
                        });
                      });
                } else if (datePlusDays.isBefore(DateTime.now()) &&
                    datePlusDaysPlus2.isAfter(DateTime.now())) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddEntryDialog(
                          day: day,
                          challengeId: widget.challengeId,
                          reload: () {
                            widget.reload();
                          });
                    },
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: e["successful"] == 1
                      ? Theme.of(context).primaryColor
                      : e["successful"] == 0
                          ? const Color.fromRGBO(104, 9, 9, 1.0)
                          : const Color.fromRGBO(40, 45, 54, 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                child: datePlusDays.isBefore(DateTime.now()) &&
                        datePlusDaysPlus1.isAfter(DateTime.now())
                    ? const Icon(Icons.close)
                    : Container(),
              ),
            );
          })
        ],
      ),
    );
  }
}
