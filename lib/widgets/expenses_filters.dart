import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/filters_provider.dart';

class ExpensesFilters extends ConsumerStatefulWidget {
  const ExpensesFilters({super.key});

  @override
  ConsumerState<ExpensesFilters> createState() => _ExpensesFiltersState();
}

class _ExpensesFiltersState extends ConsumerState<ExpensesFilters> {
  // DateTime? _startDate = null;
  // DateTime? _endDate = null;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(filtersProvider);
    // _startDate = filters['startDate'];
    // _endDate = filters['endDate'];
  }

  void _presentDatePicker(date) {
    final filtersNotifier = ref.watch(filtersProvider.notifier);
    var startDate = filtersNotifier.state['startDate'];
    var endDate = filtersNotifier.state['endDate'];

    print(startDate);

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      date == 'startDate' ? startDate = selectedDate : endDate = selectedDate;
      if (startDate != null && endDate != null) {
        if (startDate!.isAfter(endDate!)) {
          final temp = startDate;
          startDate = endDate;
          endDate = temp;
        }
        filtersNotifier.setDateFilters(startDate, endDate);
        return;
      }

      filtersNotifier.setDateFilter(date, selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filtersProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              TextButton(
                child: Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  _presentDatePicker('startDate');
                },
              ),
              Text('From: '),
              Expanded(
                child: Text(
                  filters['startDate'] == null
                      ? ' '
                      : DateFormat('dd/MM/yy').format(filters['startDate']!),
                ),
              ),
              TextButton(
                child: Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  _presentDatePicker('endDate');
                },
              ),
              Text('To: '),
              Expanded(
                child: Text(
                  filters['endDate'] == null
                      ? ' '
                      : DateFormat('dd/MM/yy').format(filters['endDate']!),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final cat in categoryIcons.entries)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Icon(cat.value),
                      ),
                      onSelected: (bool selected) {
                        ref
                            .read(filtersProvider.notifier)
                            .setCategoryFilter(cat.key, selected);
                      },
                      selected: ref.read(filtersProvider)['category'][cat.key],
                      backgroundColor: Colors.grey,
                      selectedColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500)),
                    ),
                  )
              ],
            ),
          ),
        ),
        // TextButton(onPressed: (){ resetFilters();}, child: Text( 'sium'),)
      ],
    );
  }
}
