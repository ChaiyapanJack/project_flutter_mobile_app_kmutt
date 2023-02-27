import 'package:flutter/material.dart';

void main() => runApp(const MainCalendar());

class MainCalendar extends StatelessWidget {
  const MainCalendar({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'app',
      title: _title,
      home: TwitterSearchPage(restorationId: 'main'),
    );
  }
}

class TwitterSearchPage extends StatefulWidget {
  const TwitterSearchPage({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<TwitterSearchPage> createState() => _TwitterSearchPage();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _TwitterSearchPage extends State<TwitterSearchPage>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final DateSearchController = TextEditingController();

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        DateSearchController.text =
            "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        // ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title:
            Text("Search Trand Twitter", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 183, 236, 123),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Search',
                        border: border,
                        errorBorder: border,
                        disabledBorder: border,
                        focusedBorder: border,
                        focusedErrorBorder: border,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              print('Clear');
                              DateSearchController.clear();
                            }),
                      ),
                      controller: DateSearchController,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 147, 16),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _restorableDatePickerRouteFuture.present();
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
