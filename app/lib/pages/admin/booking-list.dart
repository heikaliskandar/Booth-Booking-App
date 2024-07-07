import 'package:flutter/material.dart';
import '../../models/booking_info.dart';

class BookingPage extends StatefulWidget {
  final String username; 
  final bool isAdmin; 

  const BookingPage({super.key, required this.username, required this.isAdmin}); 

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<BookingInfo> allBoothBooks = [];
  List<BookingInfo> displayedBoothBooks = [];

  @override
  void initState() {
    super.initState();
    _loadBoothBooks();
  }

  void _loadBoothBooks() async {
    List<BookingInfo> boothBooks;
    if (widget.isAdmin) {
      boothBooks = await BookingInfo.getBoothBooks(); 
    } else {
      boothBooks = await BookingInfo.getUserBoothBooks(widget.username); 
    }

    setState(() {
      allBoothBooks = boothBooks;
      displayedBoothBooks = boothBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), 
                      child: ListView.builder(
                        itemCount: displayedBoothBooks.length,
                        itemBuilder: (context, index) {
                          var bookingItem = displayedBoothBooks[index];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10), 
                            child: BookingItem(
                              orderNumber: bookingItem.id.toString(),
                              userName: bookingItem.name,
                              email: bookingItem.email,
                              phone: bookingItem.phone,
                              areas: bookingItem.areas,
                              username: bookingItem.username,
                              date: bookingItem.dateTime.day.toString() +
                                  "/" +
                                  bookingItem.dateTime.month.toString() +
                                  "/" +
                                  bookingItem.dateTime.year.toString(),
                              time: bookingItem.dateTime.hour.toString() +
                                  ":" +
                                  bookingItem.dateTime.minute.toString(),
                              quantity: bookingItem.quantity,
                              totalPrice: bookingItem.totalPrice,
                              additionalItems: bookingItem.additionalItems, 
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingItem extends StatelessWidget {
  final String orderNumber;
  final String userName;
  final String email;
  final String phone;
  final String areas;
  final String username;
  final String date;
  final String time;
  final int quantity;
  final double totalPrice;
  final List<Map<String, dynamic>> additionalItems;

  const BookingItem({
    super.key,
    required this.orderNumber,
    required this.userName,
    required this.email,
    required this.phone,
    required this.areas,
    required this.username,
    required this.date,
    required this.time,
    required this.quantity,
    required this.totalPrice,
    required this.additionalItems,
  });

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Details', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDetailRow('Booking ID', orderNumber),
                _buildDetailRow('Service', areas),
                _buildDetailRow('Name', userName),
                _buildDetailRow('Email', email),
                _buildDetailRow('Phone', phone),
                _buildDetailRow('Username', username),
                _buildDetailRow('Date', date),
                _buildDetailRow('Time', time),
                _buildDetailRow('Quantity', quantity.toString()),
                _buildDetailRow('Total Price', 'RM$totalPrice'),
                if (additionalItems.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text('Additional Items', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ...additionalItems.map((item) {
                  return _buildDetailRow(item['item'], 'RM${item['price']}');
                }).toList(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetailsDialog(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Color(0xFFE5E7EB),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Booking ID: ',
                              style: TextStyle(),
                            ),
                            TextSpan(
                              text: orderNumber,
                              style: const TextStyle(
                                color: Color(0xFF6F61EF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF15161E),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color.fromARGB(255, 36, 28, 105),
                            width: 2,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                            child: const Text(
                              "Booked",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      "Service: $areas",
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      "Date: $date",
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF606A85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      "Time: $time",
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF606A85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
