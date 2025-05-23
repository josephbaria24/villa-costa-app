import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalkinPage extends StatefulWidget {
  const WalkinPage({super.key});

  @override
  State<WalkinPage> createState() => _WalkinPageState();
}

class _WalkinPageState extends State<WalkinPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  final List<String> roomTypes = ['Standard', 'Cameron', 'Luxury'];
  String selectedRoomType = 'Standard';

  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(Duration(days: 2));
int get numberOfGuests => selectedAdults + selectedChildren;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? checkInDate : checkOutDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          // Automatically update checkout if it's before check-in
          if (checkOutDate.isBefore(checkInDate)) {
            checkOutDate = checkInDate.add(Duration(days: 1));
          }
        } else {
          checkOutDate = picked;
        }
      });
    }
  }


int selectedAdults = 1;
int selectedChildren = 0;

final List<int> adultOptions = List.generate(10, (index) => index + 1);
final List<int> childOptions = List.generate(6, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),title: const Text('Walk-in Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
      body: Scrollbar(
        thumbVisibility: true,
  thickness: 6,
  radius: const Radius.circular(8),
        child: SingleChildScrollView(
          
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Booking Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
        
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
        
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
        
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telephone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
        
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
        
              DropdownButtonFormField<String>(
                value: selectedRoomType,
                decoration: InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
                items: roomTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedRoomType = value;
                    });
                  }
                },
              ),
              SizedBox(height: 12),
        
              TextField(
                controller: unitController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Unit of Room',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
        
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(text: DateFormat.yMMMd().format(checkInDate)),
                          decoration: InputDecoration(
                            labelText: 'Check-in Date',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(text: DateFormat.yMMMd().format(checkOutDate)),
                          decoration: InputDecoration(
                            labelText: 'Check-out Date',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'Check-in: 2:00 PM onwards\nCheck-out: 12:00 PM noon or earlier',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text('Number of Guests', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        
        Row(
          children: [
            Expanded(
        child: DropdownButtonFormField<int>(
          value: selectedAdults,
          decoration: InputDecoration(
            labelText: 'Adults',
            border: OutlineInputBorder(),
          ),
          items: adultOptions.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                selectedAdults = newValue;
              });
            }
          },
        ),
            ),
            SizedBox(width: 12),
            Expanded(
        child: DropdownButtonFormField<int>(
          value: selectedChildren,
          decoration: InputDecoration(
            labelText: 'Children',
            border: OutlineInputBorder(),
          ),
          items: childOptions.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                selectedChildren = newValue;
              });
            }
          },
        ),
            ),
          ],
        ),
        SizedBox(height: 12),
        
              TextField(
                controller: additionalInfoController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Additional Information',
                  border: OutlineInputBorder(),
                ),
              ),
                SizedBox(height: 20),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white
                  ),
                  child: const Text('Book Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showConfirmationDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Booking'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConfirmationRow('Full Name', nameController.text),
              _buildConfirmationRow('Address', addressController.text),
              _buildConfirmationRow('Phone', phoneController.text),
              _buildConfirmationRow('Email', emailController.text),
              _buildConfirmationRow('Room Type', selectedRoomType),
              _buildConfirmationRow('Room Unit', unitController.text),
              _buildConfirmationRow('Check-in', DateFormat.yMMMd().format(checkInDate)),
              _buildConfirmationRow('Check-out', DateFormat.yMMMd().format(checkOutDate)),

              // ✅ Add this line to show number of guests
              _buildConfirmationRow('Guests', numberOfGuests.toString()),

              _buildConfirmationRow('Additional Info', additionalInfoController.text),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking confirmed!')),
              );
              // You can add actual booking logic here
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}


Widget _buildConfirmationRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value.isEmpty ? '-' : value),
        const Divider(),
      ],
    ),
  );
}

}
