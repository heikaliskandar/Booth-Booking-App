import 'registration.dart';
import 'package:flutter/material.dart';
import '../models/specialize_area.dart';
import '../models/user.dart';

class AreasPage extends StatefulWidget {
  const AreasPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  _AreasPageState createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  List<SpecializeArea> areas = [];

  @override
  void initState() {
    super.initState();
    _getAreas();
  }

  void _getAreas() async {
    final data = await SpecializeArea.getAllAreaDetails();
    setState(() {
      areas = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Provided'),
        backgroundColor: const Color.fromARGB(255, 200, 209, 230),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30 * 2),
          child: ListView.builder(
            itemCount: areas.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(
                        user: widget.user,
                        area: areas[index],
                      ),
                    ),
                  );
                },
                child: _createServiceCard(areas[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _createServiceCard(SpecializeArea services) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color.fromARGB(255, 24, 43, 92),
        ),
      ),
      color: const Color.fromARGB(255, 24, 43, 92),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16 * 2),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Text(
            services.areas,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
