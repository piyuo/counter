import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../wizard_navigator.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final projectSchedule = projectProvider.project!.schedule;
    return pip.PipScaffold(
      title: 'Schedules',
      child: ChangeNotifierProvider(
          create: (_) => ScheduleScreenProvider(),
          child: Consumer<ScheduleScreenProvider>(builder: (context, scheduleScreenProvider, child) {
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoListSection(
                  backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                  header: const Text(''),
                  children: List.generate(
                    projectSchedule.schedulePeriods.length,
                    (index) {
                      final projectTime = projectSchedule.schedulePeriods[index];
                      return CupertinoListTile(
                        title: Text(projectTime.label),
                        trailing: const CupertinoListTileChevron(),
                        subtitle: Text(projectTime.formatString(context)),
                        onTap: () async {
                          Navigator.of(context).pushNamed(scheduleDetailRoute, arguments: {
                            'schedulePeriod': projectTime,
                            'projectSchedule': projectSchedule,
                            'scheduleScreenProvider': scheduleScreenProvider,
                          });
                        },
                      );
                    },
                  ),
                ),
                CupertinoListSection(
                  backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                  children: [
                    CupertinoListTile(
                      title: Center(
                          child: CupertinoButton(
                        onPressed: () async {
                          final projectTime = app.SchedulePeriod(
                              label: 'Time Range ${projectSchedule.schedulePeriods.length + 1}',
                              startTime: const TimeOfDay(hour: 8, minute: 0),
                              endTime: const TimeOfDay(hour: 9, minute: 0));
                          projectSchedule.schedulePeriods.add(projectTime);

                          Navigator.of(context).pushNamed(scheduleDetailRoute, arguments: {
                            'schedulePeriod': projectTime,
                            'projectSchedule': projectSchedule,
                            'scheduleScreenProvider': scheduleScreenProvider,
                          });
                        },
                        child: const Text('Add Schedule'),
                      )),
                    )
                  ],
                ),
              ],
            ));
          })),
    );
  }
}

/// the provider for the schedule screen
class ScheduleScreenProvider with ChangeNotifier {
  ScheduleScreenProvider();

  /// redraw the screen
  void redraw() {
    notifyListeners();
  }
}
