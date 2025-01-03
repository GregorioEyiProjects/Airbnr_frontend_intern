import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:airbnbr/database/object_box_model/OBinit/MyObjectBox.dart';
import 'package:airbnbr/database/object_box_model/entities/RoomOBModel.dart';

class RoomListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final objectBox = Provider.of<MyObjectBox>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rooms List'),
      ),
      body: StreamBuilder<List<RoomOB>>(
        stream: objectBox.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms available'));
          }

          final rooms = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Rating')),
                DataColumn(label: Text('Bed Numbers')),
                DataColumn(label: Text('Review Numbers')),
                DataColumn(label: Text('Vendor Name')),
                DataColumn(label: Text('Years Hosting')),
                DataColumn(label: Text('Vendor Profession')),
                DataColumn(label: Text('Author Image')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Is Active')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Latitude')),
                DataColumn(label: Text('Longitude')),
              ],
              rows: rooms.map((room) {
                return DataRow(cells: [
                  DataCell(Text(room.mongoRoomId)),
                  DataCell(Text(room.name)),
                  DataCell(Text('\$${room.price}')),
                  DataCell(Text(room.rating?.toString() ?? 'N/A')),
                  DataCell(Text(room.bedNumbers.toString())),
                  DataCell(Text(room.reviewNumbers?.toString() ?? 'N/A')),
                  DataCell(Text(room.vendorName)),
                  DataCell(Text(room.yearsHosting.toString())),
                  DataCell(Text(room.vendorProfession)),
                  DataCell(Text(room.authorImage)),
                  DataCell(Text(room.locationName)),
                  DataCell(Text(room.date.toString())),
                  DataCell(Text(room.isActive ? 'Yes' : 'No')),
                  DataCell(Text(room.description ?? 'N/A')),
                  DataCell(Text(
                      room.localtionData.target?.latitude.toString() ?? 'N/A')),
                  DataCell(Text(
                      room.localtionData.target?.longitude.toString() ??
                          'N/A')),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
