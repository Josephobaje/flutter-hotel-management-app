import 'package:flutter/material.dart';

import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'StayManager NG',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0B2A4A),
        secondary: const Color(0xFF00BCD4),
      ),
      useMaterial3: true,
    ),
    home: const Home(),
  );
}

String naira(num v) =>
    '₦${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\B)(?=(\d{3})+(?!\d))'), (m) => ',')}';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _S();
}

class _S extends State<Home> {
  int tab = 0;
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('StayManager NG')),
    body: [_rooms(), _bookings(), _billing()][tab],
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (i) => setState(() => tab = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.bed), label: 'Rooms'),
        NavigationDestination(icon: Icon(Icons.book_online), label: 'Bookings'),
        NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Billing'),
      ],
    ),
  );
  Widget _rooms() => ListView(
    children: [
      ListTile(
        title: Text('${availableRooms.length} rooms available'),
        subtitle: Text(
          'Occupancy ${(occupancyRate() * 100).toStringAsFixed(0)}%',
        ),
      ),
      ...rooms.map(
        (r) => ListTile(
          leading: const Icon(Icons.meeting_room),
          title: Text('Room ${r.number} - ${r.type}'),
          subtitle: Text(naira(r.price)),
          trailing: Chip(label: Text(r.occupied ? 'Occupied' : 'Available')),
        ),
      ),
    ],
  );
  Widget _bookings() => ListView(
    children: bookings
        .map(
          (b) => ListTile(
            title: Text(b.guest),
            subtitle: Text('Room ${b.room} - ${b.nights} nights'),
            trailing: Chip(
              label: Text(b.checkedIn ? 'Checked in' : 'Reserved'),
            ),
            onTap: () => setState(() => b.checkedIn = !b.checkedIn),
          ),
        )
        .toList(),
  );
  Widget _billing() {
    final r = rooms[4];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sample bill', style: Theme.of(context).textTheme.headlineSmall),
          Text('Room ${r.number} ${r.type}: ${naira(r.price)} x 2 nights'),
          Text('Extras: ${naira(5000)}'),
          Text(
            'Total: ${naira(billTotal(r, 2, extras: 5000))}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text('Check-out settles the bill. Demo only, no real payment.'),
        ],
      ),
    );
  }
}
