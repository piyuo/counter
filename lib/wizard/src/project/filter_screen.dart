import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

class FilterScreen extends StatelessWidget {
  const FilterScreen({
    this.previousPageTitle,
    super.key,
  });

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final String pageTitle = context.l.filter_screen_title;

    return Consumer<app.ProjectProvider>(
      builder: (context, projectProvider, child) => ChangeNotifierProvider(
        create: (_) => FilterScreenProvider(
          filterType: projectProvider.project!.filter.filterType,
          start: projectProvider.project!.filter.start,
          end: projectProvider.project!.filter.end,
        ),
        child: Consumer<FilterScreenProvider>(
          builder: (context, filterScreenProvider, child) {
            bool checkStartBeforeEnd({TimeOfDay? start, TimeOfDay? end}) {
              TimeOfDay startTime = start ?? projectProvider.project!.filter.start;
              TimeOfDay endTime = end ?? projectProvider.project!.filter.end;
              return startTime.hour < endTime.hour ||
                  (startTime.hour == endTime.hour && startTime.minute < endTime.minute);
            }

            return PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, result) async {
                  if (didPop) {
                    return;
                  }
                  final bool shouldPop = checkStartBeforeEnd(
                    start: filterScreenProvider.start,
                    end: filterScreenProvider.end,
                  );

                  if (shouldPop) {
                    final newFilter = vision.Filter(
                      filterScreenProvider.filterType,
                      start: filterScreenProvider.start,
                      end: filterScreenProvider.end,
                    );

                    projectProvider.setFilter(newFilter);
                    if (context.mounted) Navigator.pop(context);
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text(context.l.filter_screen_error_title),
                        content: Text(context.l.filter_screen_error_content),
                        actions: [
                          CupertinoDialogAction(
                            child: Text(context.l.ok),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: pip.PipScaffold(
                  previousPageTitle: previousPageTitle,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      pip.PipHeader(
                        child: Column(
                          children: [
                            Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(context.l.filter_screen_desc, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      CupertinoListSection(
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          children: List.generate(vision.FilterType.values.length, (index) {
                            final availableFilter = vision.FilterType.values[index];
                            return CupertinoListTile(
                              leading: availableFilter == filterScreenProvider.filterType
                                  ? const Icon(CupertinoIcons.check_mark)
                                  : SizedBox.shrink(),
                              title: Text(vision.formattedStringForFilterType(context, availableFilter)),
                              onTap: () {
                                filterScreenProvider.setFilterType(availableFilter);
                              },
                            );
                          })),
                      CupertinoListSection(
                        header: Text(context.l.filter_screen_error_custom),
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: [
                          CupertinoListTile(
                            title: Text(context.l.filter_screen_error_start),
                            leading: const Icon(CupertinoIcons.alarm),
                            additionalInfo: Text(filterScreenProvider.start.format(context)),
                            onTap: () => filterScreenProvider.showStartTimePicker(),
                          ),
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: filterScreenProvider.isStartTimePickerVisible ? 120 : 0,
                              child: CupertinoDatePicker(
                                initialDateTime: filterScreenProvider.startTime,
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (DateTime datetime) {
                                  filterScreenProvider.setStartTime(datetime);
                                },
                              )),
                          CupertinoListTile(
                            title: Text(context.l.filter_screen_error_end),
                            leading: const Icon(CupertinoIcons.alarm_fill),
                            additionalInfo: Text(filterScreenProvider.end.format(context)),
                            onTap: () => filterScreenProvider.showEndTimePicker(),
                          ),
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: filterScreenProvider.isEndTimePickerVisible ? 120 : 0,
                              child: CupertinoDatePicker(
                                initialDateTime: filterScreenProvider.endTime,
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (DateTime datetime) {
                                  filterScreenProvider.setEndTime(datetime);
                                },
                              )),
                        ],
                      ),
                      pip.PipFooter(),
                    ]),
                  ),
                ));
          },
        ),
      ),
    );
  }
}

/// provide filter screen support.
class FilterScreenProvider with ChangeNotifier {
  FilterScreenProvider({
    required this.filterType,
    required this.start,
    required this.end,
  });

  /// the filter type
  vision.FilterType filterType;

  /// the start time
  TimeOfDay start;

  /// the end time
  TimeOfDay end;

  /// the start time picker is visible or not
  bool isStartTimePickerVisible = true;

  /// the end time picker is visible or not
  bool isEndTimePickerVisible = false;

  /// show start time picker
  void showStartTimePicker() {
    isStartTimePickerVisible = true;
    isEndTimePickerVisible = false;
    notifyListeners();
  }

  /// show end time picker
  void showEndTimePicker() {
    isStartTimePickerVisible = false;
    isEndTimePickerVisible = true;
    notifyListeners();
  }

  /// the start time
  DateTime get startTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, start.hour, start.minute);
  }

  /// the end time
  DateTime get endTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, end.hour, end.minute);
  }

  /// set the start time
  void setStartTime(DateTime time) {
    start = TimeOfDay(hour: time.hour, minute: time.minute);
    filterType = vision.FilterType.custom;
    notifyListeners();
  }

  /// set the end time
  void setEndTime(DateTime time) {
    filterType = vision.FilterType.custom;
    end = TimeOfDay(hour: time.hour, minute: time.minute);
    notifyListeners();
  }

  /// set the filter type
  void setFilterType(vision.FilterType value) {
    filterType = value;
    notifyListeners();
  }
}
