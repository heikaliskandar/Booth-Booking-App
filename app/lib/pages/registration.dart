import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/specialize_area.dart';
import '../models/booking_info.dart';
import '../common_widgets/buttons.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
    required this.user,
    required this.area,
  }) : super(key: key);

  final User user;
  final SpecializeArea area;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  DateTime? selectedDateTime;
  int totalPrice = 0;
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
    updateTotalPrice();
  }

  void updateTotalPrice() {
    int areaPrice = areaPrices[widget.area.areas] ?? 0;
    int quantity = int.tryParse(quantityController.text) ?? 0;
    int additionalPrice = 0;

    additionalItems[widget.area.areas]?.forEach((item) {
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
      additionalItems[widget.area.areas]?[index]['selected'] = value ?? false;
      updateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.area.areas),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    SizedBox(height: 25),
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
                    SizedBox(height: 25),
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
                          return "Please enter only numeric characters.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller:
                          TextEditingController(text: widget.area.areas),
                      decoration: const InputDecoration(
                        labelText: "Service Provided",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 25),
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
                                return "Please enter only numeric values.";
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
                    SizedBox(height: 25),
                    if (additionalItems[widget.area.areas] != null) ...[
                      ExpansionTile(
                        title: const Text(
                          "Additional Items",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children:
                            additionalItems[widget.area.areas]!.map((item) {
                          int index =
                              additionalItems[widget.area.areas]!.indexOf(item);
                          return CheckboxListTile(
                            title: Text("${item['item']} (RM${item['price']})"),
                            value: item['selected'],
                            onChanged: (value) {
                              onAdditionalItemChanged(value, index);
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 25),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Price: "),
                        Text("RM $totalPrice",
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                    SizedBox(height: 32),
                    InkWell(
                      onTap: () async {
                        DateTime? pickedDateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );

                        if (pickedDateTime != null && mounted) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null && mounted) {
                            setState(() {
                              selectedDateTime = DateTime(
                                pickedDateTime.year,
                                pickedDateTime.month,
                                pickedDateTime.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            });
                          }
                        }
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(
                          text: selectedDateTime != null
                              ? "${selectedDateTime?.year}-${selectedDateTime?.month.toString().padLeft(2, '0')}-${selectedDateTime?.day.toString().padLeft(2, '0')} ${selectedDateTime?.hour.toString().padLeft(2, '0')}:${selectedDateTime?.minute.toString().padLeft(2, '0')}"
                              : '',
                        ),
                        decoration: const InputDecoration(
                          labelText: "Booking date & time",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (selectedDateTime == null) {
                            return 'Please select date and time.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                    ButtonGradient(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print('Form is valid, creating registration');
                          List<Map<String, dynamic>> selectedItems =
                              additionalItems[widget.area.areas]
                                      ?.where(
                                          (item) => item['selected'] == true)
                                      .toList() ??
                                  [];
                          BookingInfo registration = BookingInfo(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            areas: widget.area.areas,
                            username: widget.user.username,
                            dateTime: selectedDateTime ?? DateTime.now(),
                            quantity: int.parse(quantityController.text),
                            totalPrice: totalPrice.toDouble(),
                            additionalItems: selectedItems,
                          );

                          await BookingInfo.createRegistration(
                              registration, widget.user, context);
                          print(
                              'Registration created, navigating to ConfirmPage');
                        }
                      },
                      label: 'Book Now',
                      textStyle: TextStyle(color: Colors.white),
                      borderRadius: 50,
                      gradientColor: [
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
        ],
      ),
    );
  }
}
