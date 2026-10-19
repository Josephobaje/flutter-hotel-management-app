import 'package:staymanager/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('availability and occupancy', () {
    expect(availableRooms.length, 4);
    expect(occupancyRate(), closeTo(0.333, 0.01));
  });
  test('billing total', () {
    expect(billTotal(rooms[0], 3, extras: 5000), 80000);
    expect(billTotal(rooms[4], 2), 190000);
  });
  test('bookings seed', () {
    expect(bookings.length, 3);
    expect(bookings.where((b) => b.checkedIn).length, 2);
  });
}
