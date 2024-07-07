import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/booking_info.dart';
import 'booking_register_info.dart';

class ConferencePage extends StatefulWidget {
  const ConferencePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  List<BookingInfo> registers = [];
  bool isLoading = true;

  void getList() async {
    print('Fetching registration list for user: ${widget.user.username}');
    final data = await BookingInfo.getAllRegistration(widget.user.username);
    print('Fetched registration list: ${data.length} entries');
    print('Data: $data');
    setState(() {
      registers = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (registers.isNotEmpty) {
        print('Displaying ${registers.length} registrations');
        return Scaffold(
          appBar: AppBar(
            title: const Text("Booking Details"),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                child: ListView.builder(
                  itemCount: registers.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(
                        color: Color.fromARGB(255, 24, 43, 92),
                      ),
                    ),
                    color: Colors.white70,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: ListTile(
                      title: Text(
                        registers[index].areas,
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConferenceInfoPage(
                                      user: widget.user,
                                      registration: registers[index],
                                    ),
                                  ),
                                ).then((_) {
                                  getList();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                BookingInfo.deleteRegistration(
                                  registers[index].id,
                                  context,
                                  () {
                                    getList();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Booth Booking"),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  "No booking created.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
