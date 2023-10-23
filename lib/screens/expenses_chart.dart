import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/filters_provider.dart';
import 'package:spese_condivise/resources/app_colors.dart';
import 'package:spese_condivise/widgets/indicator.dart';

class ExpensesChart extends ConsumerStatefulWidget {
  const ExpensesChart({super.key});

  @override
  ConsumerState<ExpensesChart> createState() => PieChartSample1State();
}

class PieChartSample1State extends ConsumerState<ExpensesChart> {
  int touchedIndex = -1;
  final colorMap = {
    Category.Affitto: AppColors.contentColorBlue,
    Category.Spesa: AppColors.contentColorYellow,
    Category.Bollette: AppColors.contentColorPink,
    Category.Istruzione: AppColors.contentColorGreen,
    Category.Svago: AppColors.contentColorPurple,
    Category.Trasporti: AppColors.contentColorOrange,
    Category.Altro: AppColors.contentColorRed,
  };

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final List<PieChartSectionData> sections = [];
    List<Expense> expenses = ref.watch(filteredExpenseProvider);
    double sommaSpese = 0;
    expenses!.forEach((element) {
      sommaSpese += element.cost;
    });

    for (int i = 0; i < Category.values.length; i++) {
      List<Expense> categoryExpenses = expenses
          .where((expense) => expense.category == Category.values[i])
          .toList();

      if (categoryExpenses.length == 0) continue;

      double somma = 0;
      categoryExpenses.forEach((element) {
        somma += element.cost;
      });

      double percentage = somma / sommaSpese * 100;
      var isTouched = i == touchedIndex;

      final fontSize = isTouched ? 20.0 : 16.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      double radius = isTouched ? 180 : 150;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      sections.add(
        PieChartSectionData(
          color: colorMap[Category.values[i]],
          value: percentage,
          title: "${percentage.ceil()}%",
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          radius: radius,
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? const BorderSide(color: AppColors.contentColorWhite, width: 6)
              : BorderSide(color: AppColors.contentColorWhite.withOpacity(0)),
          badgeWidget: _Badge(
            categoryIcons[Category.values[i]]!,
            size: widgetSize,
            borderColor: AppColors.contentColorBlack,
          ),
          badgePositionPercentageOffset: .98,
        ),
      );
    }
    return sections;
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.icon, {
    required this.size,
    required this.borderColor,
  });
  final IconData icon;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(child: Icon(icon)),
    );
  }
}
