import 'package:flutter/material.dart';
import '../models/specialize_area.dart';
import '../models/user.dart';
import '../models/booking_info.dart';
import '../common_widgets/buttons.dart';

class ConferenceInfoPage extends StatefulWidget {
  const ConferenceInfoPage({
    Key? key,
    required this.user,
    required this.registration,
  }) : super(key: key);

  final User user;
  final BookingInfo registration;

  @override
  State<ConferenceInfoPage> createState() => _ConferenceInfoPageState();
}

class _ConferenceInfoPageState extends State<ConferenceInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateAndTimeController = TextEditingController();
  final quantityController = TextEditingController();
  int totalPrice = 0;
  DateTime selectedDateTime = DateTime.now();
  String areaType = "";
  List<String> areaList = [];
  Map<String, int> areaPrices = {
    'Basic Booth': 400,
    'Standard Booth': 800,
    'Premium Booth': 1200,
    'Luxury Booth': 2000,
  };

  Map<String, List<Map<String, dynamic>>> additionalItems = {
    'Basic Booth': [
      {'item': 'Basic lighting', 'price': 150, 'selected': false},
      {'item': 'One table', 'price': 100, 'selected': false},
      {'item': 'Two chairs', 'price': 120, 'selected': false},
    ],
    'Standard Booth': [
      {'item': 'Enhanced lighting', 'price': 210, 'selected': false},
      {'item': 'Two tables', 'price': 200, 'selected': false},
      {'item': 'Four chairs', 'price': 240, 'selected': false},
    ],
    'Premium Booth': [
      {'item': 'Premium lighting', 'price': 0, 'selected': false},
      {'item': 'Three tables', 'price': 300, 'selected': false},
      {'item': 'Six chairs', 'price': 360, 'selected': false},
      {'item': 'Carpet', 'price': 160, 'selected': false},
    ],
    'Luxury Booth': [
      {'item': 'Luxury lighting', 'price': 350, 'selected': false},
      {'item': 'Four tables', 'price': 400, 'selected': false},
      {'item': 'Eight chairs', 'price': 480, 'selected': false},
      {'item': 'Carpet', 'price': 160, 'selected': false},
      {'item': 'WiFi', 'price': 200, 'selected': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registration.name;
    emailController.text = widget.registration.email;
    phoneController.text = widget.registration.phone.toString();
    dateAndTimeController.text = _formatDateTime(widget.registration.dateTime);
    selectedDateTime = widget.registration.dateTime;
    quantityController.text = widget.registration.quantity.toString();
    areaType = widget.registration.areas;
    totalPrice = widget.registration.totalPrice.toInt();
    widget.registration.additionalItems.forEach((item) {
      additionalItems[areaType]?.firstWhere((additionalItem) => additionalItem['item'] == item['item'])['selected'] = true;
    });
    getAreasList();
    updateTotalPrice();
  }

  void getAreasList() async {
    final data = await SpecializeArea.getAreasName();
    setState(() {
      areaList = data;
    });
  }

  void updateTotalPrice() {
    int areaPrice = areaPrices[areaType] ?? 0;
    int quantity = int.tryParse(quantityController.text) ?? 0;
    int additionalPrice = 0;

    additionalItems[areaType]?.forEach((item) {
      if (item['selected'] == true) {
        additionalPrice += item['price'] as int;
      }
    });

    setState(() {
      totalPrice = (areaPrice + additionalPrice) * quantity;
    });
  }

  void onQuantityChanged(String value) {
    updateTotalPrice();
  }

  void incrementQuantity() {
    int currentQuantity = int.tryParse(quantityController.text) ?? 0;
    currentQuantity++;
    quantityController.text = currentQuantity.toString();
    updateTotalPrice();
  }

  void decrementQuantity() {
    int currentQuantity = int.tryParse(quantityController.text) ?? 0;
    if (currentQuantity > 0) {
      currentQuantity--;
      quantityController.text = currentQuantity.toString();
      updateTotalPrice();
    }
  }

  void onAdditionalItemChanged(bool? value, int index) {
    setState(() {
      additionalItems[areaType]?[index]['selected'] = value ?? false;
      updateTotalPrice();
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          dateAndTimeController.text = _formatDateTime(selectedDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Booking"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone No.",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number.';
                    } else if (int.tryParse(value) == null) {
                      return "Please enter a valid phone number.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: dateAndTimeController,
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  decoration: const InputDecoration(
                    labelText: "Date & Time",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: TextEditingController(text: areaType),
                  decoration: const InputDecoration(
                    labelText: "Service Provided",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 32),
                if (additionalItems[areaType] != null) ...[
                  ExpansionTile(
                    title: const Text(
                      "Additional Items",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: additionalItems[areaType]!.map((item) {
                      int index = additionalItems[areaType]!.indexOf(item);
                      return CheckboxListTile(
                        title: Text("${item['item']} (RM${item['price']})"),
                        value: item['selected'],
                        onChanged: (value) {
                          onAdditionalItemChanged(value, index);
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 32),
                ],
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: decrementQuantity,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: quantityController,
                        onChanged: onQuantityChanged,
                        decoration: const InputDecoration(
                          labelText: "Quantity",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the quantity.';
                          } else if (int.tryParse(value) == null) {
                            return "Please enter a valid quantity.";
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: incrementQuantity,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Price: "),
                    Text("RM $totalPrice", style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
                const SizedBox(height: 32),
                ButtonGradient(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      List<Map<String, dynamic>> selectedItems = additionalItems[areaType]?.where((item) => item['selected'] == true).toList() ?? [];
                      BookingInfo updatedRegistration = BookingInfo(
                        id: widget.registration.id,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        areas: areaType,
                        username: widget.user.username,
                        dateTime: selectedDateTime,
                        quantity: int.parse(quantityController.text),
                        totalPrice: totalPrice.toDouble(),
                        additionalItems: selectedItems,
                      );

                      BookingInfo.updateRegistration(
                        updatedRegistration,
                        widget.user,
                        context,
                      );
                    }
                  },
                  label: 'Update Booking',
                  textStyle: const TextStyle(color: Colors.white),
                  borderRadius: 50,
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
}
