import 'package:flutter/material.dart';

int refreshCount = 0;

//final _searchBoxController = TextEditingController();

class Recent extends StatelessWidget {
  const Recent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
/*
  Widget _simpleTable() {
    return ChangeNotifierProvider<data.DataSource>(
      create: (context) => data.DataSource<op.Order>(
        id: 'recent_order',
        dataRemover: (BuildContext context, List<String> removeList) async => true,
        dataBuilder: () => op.Order(),
        dataLoader: (BuildContext context, isRefresh, limit, anchorTimestamp, anchorId) async {
          await Future.delayed(const Duration(seconds: 1));
          if (isRefresh) {
            return List.generate(
                limit,
                (index) => op.Order(
                      entity: pb.Entity(
                        id: unique.uuid(),
                        updateTime: DateTime.now().utcTimestamp,
                        notGoingToChange: false,
                        deleted: false,
                      ),
                    ));
          }
          refreshCount++;
          if (refreshCount > 2) {
            refreshCount = 0;
            return [];
          }

          // load more data
          return List.generate(
              limit,
              (index) => op.Order(
                    entity: pb.Entity(
                      id: unique.uuid(),
                      updateTime: DateTime.now().utcTimestamp,
                      notGoingToChange: false,
                      deleted: false,
                    ),
                  ));
        },
      ),
      child: Consumer<data.DataSource<op.Order>>(
          builder: (context, dataSource, child) => data.PageTable<op.Order>(
                dataSource: dataSource,
                columns: [
                  data.PageColumn(label: const Text('ID')),
                ],
                tableBuilder: (BuildContext context, op.Order order, int rowIndex) {
                  return [
                    Text(order.entityID, overflow: TextOverflow.ellipsis),
                  ];
                },
                cardBuilder: (BuildContext context, op.Order person, int rowIndex) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Text(person.entityID),
                      ]));
                },
                onRowTap: (BuildContext context, op.Order person, int rowIndex) => debugPrint(person.entityID),
              )),
    );
  }*/
}
