import 'main_menu.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/booking_info.dart';
import '../common_widgets/buttons.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({
    Key? key,
    required this.user,
    required this.register,
  }) : super(key: key);

  final User user;
  final BookingInfo register;

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final labelStyle = const TextStyle(
    color: Colors.grey,
  );
  final textStyle = const TextStyle(
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Confirmation",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                const Text(
                  "Thank you! For booking with Us",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                _buildInfoRow("Name", widget.register.name),
                const SizedBox(height: 16),
                _buildInfoRow("Email", widget.register.email),
                const SizedBox(height: 16),
                _buildInfoRow("Phone No.", widget.register.phone.toString()),
                const SizedBox(height: 16),
                _buildInfoRow(
                  "Date",
                  "${widget.register.dateTime.year}-${widget.register.dateTime.month.toString().padLeft(2, '0')}-${widget.register.dateTime.day.toString().padLeft(2, '0')}",
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  "Time",
                  "${widget.register.dateTime.hour.toString().padLeft(2, '0')}:${widget.register.dateTime.minute.toString().padLeft(2, '0')}",
                ),
                const SizedBox(height: 16),
                _buildInfoRow("Specialized Area", widget.register.areas),
                const SizedBox(height: 16),
                _buildInfoRow("Quantity", widget.register.quantity.toString()),
                const SizedBox(height: 16),
                if (widget.register.additionalItems.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Additional Items",
                        style: labelStyle,
                      ),
                      const SizedBox(height: 8),
                      ...widget.register.additionalItems.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "${item['item']} (RM${item['price']})",
                              style: textStyle,
                            ),
                          )),
                      const SizedBox(height: 16),
                    ],
                  ),
                _buildInfoRow(
                  "Total Price",
                  "RM ${widget.register.totalPrice.toStringAsFixed(2)}",
                ),
                const SizedBox(height: 16 * 5),
                ButtonGradient(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainMenuPage(
                          user: widget.user,
                          currentPage: 1,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  label: 'Back to Home',
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  borderRadius: 5,
                  gradientColor: const [
                    Color.fromARGB(255, 24, 43, 92),
                    Color.fromARGB(255, 24, 43, 92),
                  ],
                  stretch: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle,
        ),
        Text(
          value,
          style: textStyle,
        ),
      ],
    );
  }
}
