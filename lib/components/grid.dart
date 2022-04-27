import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  var gridList = [];

  Grid({Key? key, required this.gridList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(59, 66, 79, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: GridView(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, crossAxisSpacing: 6, mainAxisSpacing: 6),
        children: [
          ...(gridList.map((e) {
            return (Container(
              decoration: BoxDecoration(
                color: e == 1
                    ? Color.fromRGBO(8, 181, 102, 1.0)
                    : Color.fromRGBO(40, 45, 54, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ));
          }))
        ],
      ),
    );
  }
}
