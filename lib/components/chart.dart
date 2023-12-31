import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentsTransaction, {super.key});

  final List<Transaction> recentsTransaction;

  List<Map<String, Object>> get groupedTransactrions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentsTransaction.length; i++) {
        bool sameDay = recentsTransaction[i].date.day == weekDay.day;
        bool sameMoth = recentsTransaction[i].date.month == weekDay.month;
        bool sameYear = recentsTransaction[i].date.year == weekDay.year;

        if (sameYear && sameMoth && sameDay) {
          totalSum += recentsTransaction[i].value;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactrions.fold(0.0, (sum, tr) {
      return sum + (tr["value"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactrions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr["day"].toString(),
                value: (tr["value"] as double),
                pecentage: _weekTotalValue == 0
                    ? 0
                    : (tr["value"] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
