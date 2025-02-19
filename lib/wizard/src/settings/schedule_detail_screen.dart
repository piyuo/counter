import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'schedule_screen.dart';

class ScheduleDetailScreen extends StatelessWidget {
  const ScheduleDetailScreen({
    required this.schedulePeriod,
    required this.projectSchedule,
    required this.scheduleScreenProvider,
    super.key,
  });

  /// the schedule screen provider
  final ScheduleScreenProvider scheduleScreenProvider;

  /// the time range
  final app.Schedule projectSchedule;

  /// the time range
  final app.SchedulePeriod schedulePeriod;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    return ChangeNotifierProvider<ScheduleTimeProvider>(
        create: (_) => ScheduleTimeProvider(
              projectTime: schedulePeriod,
              projectSchedule: projectSchedule,
              projectProvider: projectProvider,
            ),
        child: Consumer<ScheduleTimeProvider>(builder: (context, scheduleTimeProvider, child) {
          return PopScope(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (didPop) {
                  return;
                }
                projectProvider.notifyTimeRangesChanged();
                scheduleScreenProvider.redraw();
                Navigator.pop(context, result);
              },
              child: pip.PipScaffold(
                title: scheduleTimeProvider.nameController.text,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    CupertinoListSection(
                      header: const Text('Name'),
                      backgroundColor: CupertinoColors.transparent,
                      children: [
                        CupertinoTextField(
                          clearButtonMode: OverlayVisibilityMode.editing,
                          placeholder: 'Name to identify this time range',
                          padding: const EdgeInsets.all(16),
                          controller: scheduleTimeProvider.nameController,
                        ),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: CupertinoColors.transparent,
                      header: const Text('Time'),
                      children: [
                        CupertinoListTile(
                          title: const Text('Start'),
                          leading: const Icon(CupertinoIcons.alarm),
                          additionalInfo: Text(schedulePeriod.formatStartTime(context)),
                          onTap: () => scheduleTimeProvider.showStartTimePicker(),
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: scheduleTimeProvider.isStartTimePickerVisible ? 120 : 0,
                            child: CupertinoDatePicker(
                              initialDateTime: scheduleTimeProvider.startTime,
                              mode: CupertinoDatePickerMode.time,
                              onDateTimeChanged: (DateTime datetime) {
                                scheduleTimeProvider.setStartTime(datetime);
                              },
                            )),
                        CupertinoListTile(
                          title: const Text('End'),
                          leading: const Icon(CupertinoIcons.alarm_fill),
                          additionalInfo: Text(schedulePeriod.formatEndTime(context)),
                          onTap: () => scheduleTimeProvider.showEndTimePicker(),
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: scheduleTimeProvider.isEndTimePickerVisible ? 120 : 0,
                            child: CupertinoDatePicker(
                              initialDateTime: scheduleTimeProvider.endTime,
                              mode: CupertinoDatePickerMode.time,
                              onDateTimeChanged: (DateTime datetime) {
                                scheduleTimeProvider.setEndTime(datetime);
                              },
                            )),
                      ],
                    ),
                    CupertinoListSection(
                      backgroundColor: CupertinoColors.transparent,
                      children: [
                        CupertinoListTile(
                          title: Center(
                              child: CupertinoButton(
                            onPressed: () async {
                              projectSchedule.schedulePeriods.remove(schedulePeriod);
                              Navigator.pop(context, true);
                            },
                            child: const Text('Remove', style: TextStyle(color: CupertinoColors.systemRed)),
                          )),
                        )
                      ],
                    ),
                  ],
                )),
              ));
        }));
  }
}

/// provide schedule related settings
class ScheduleTimeProvider with ChangeNotifier {
  ScheduleTimeProvider({
    required app.SchedulePeriod projectTime,
    required app.Schedule projectSchedule,
    required this.projectProvider,
  }) : _projectTime = projectTime {
    nameController.text = projectTime.label;
    nameController.addListener(() {
      projectTime.label = nameController.text;
      projectProvider.notifyTimeRangesChanged();
    });
  }

  /// the settings provider
  final app.ProjectProvider projectProvider;

  /// the project time currently edit
  final app.SchedulePeriod _projectTime;

  /// the start time picker is visible or not
  bool isStartTimePickerVisible = true;

  /// the end time picker is visible or not
  bool isEndTimePickerVisible = false;

  /// the time range name controller, the name like 'breakfast', 'lunch', 'dinner'
  TextEditingController nameController = TextEditingController();

  /// update the time range label from name controller
  void updateTimeRangeLabel() {
    _projectTime.label = nameController.text;
  }

  /// the start time
  DateTime get startTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, _projectTime.startTime.hour, _projectTime.startTime.minute);
  }

  /// set the start time
  void setStartTime(DateTime time) {
    _projectTime.startTime = TimeOfDay(hour: time.hour, minute: time.minute);
    projectProvider.notifyTimeRangesChanged();
    notifyListeners();
  }

  /// the end time
  DateTime get endTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, _projectTime.endTime.hour, _projectTime.endTime.minute);
  }

  /// set the end time
  void setEndTime(DateTime time) {
    _projectTime.endTime = TimeOfDay(hour: time.hour, minute: time.minute);
    projectProvider.notifyTimeRangesChanged();
    notifyListeners();
  }

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
}
