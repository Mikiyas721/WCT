import '../../../../bloc/provider/provider.dart';
import '../../../../bloc/statBloc.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';

class StatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => StatBloc(),
        builder: (BuildContext context, StatBloc bloc) {
          bloc.fetchData();
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              ),
              body: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot snapShot) {
                  return SingleChildScrollView(
                      child: PaginatedDataTable(
                    source: DTS(),
                    header: Text("Drink Statistics"),
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text(
                        'Date    ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                      DataColumn(
                          label:
                              Text('Consumed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(
                          label:
                              Text('Left    ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    ],
                    columnSpacing: 30,
                  ));
                },
              ));
        });
  }
}

class DTS extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('Row $index')),
      DataCell(Text('Row $index')),
      DataCell(Text('Row $index')),
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
