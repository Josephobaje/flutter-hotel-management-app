class Room {
  final int number;
  final String type;
  final int price;
  bool occupied;
  Room(this.number, this.type, this.price, this.occupied);
}

class Booking {
  final String guest;
  final int room;
  final int nights;
  bool checkedIn;
  Booking(this.guest, this.room, this.nights, {this.checkedIn = false});
}

final rooms = [
  Room(101, 'Standard', 25000, false),
  Room(102, 'Deluxe', 40000, true),
  Room(103, 'Executive', 65000, false),
  Room(201, 'Standard', 25000, true),
  Room(202, 'Suite', 95000, false),
  Room(203, 'Deluxe', 40000, false),
];
final bookings = [
  Booking('Adaeze Okafor', 102, 3, checkedIn: true),
  Booking('Ibrahim Musa', 201, 2, checkedIn: true),
  Booking('Chinedu Eze', 202, 4),
];
List<Room> get availableRooms => rooms.where((r) => !r.occupied).toList();
int billTotal(Room r, int nights, {int extras = 0}) =>
    r.price * nights + extras;
double occupancyRate() => rooms.where((r) => r.occupied).length / rooms.length;
