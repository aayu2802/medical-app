import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _errorMessage = '';
  String _passwordError = '';

  final String _correctPassword = '123456';

  void _signInWithEmail() {
    setState(() {
      if (_emailController.text.isEmpty ||
          !_emailController.text.contains('@')) {
        _errorMessage = 'Incorrect Email Address';
      } else if (_passwordController.text != _correctPassword) {
        _passwordError = "Password don't match";
      } else {
        _errorMessage = '';
        _passwordError = '';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  void _signInWithGoogle() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Google Sign-In feature coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      './assets/a.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Adhicine',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  errorText: _passwordError.isNotEmpty ? _passwordError : null,
                  suffixIcon: const Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signInWithEmail,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(child: Text('OR')),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: const Icon(Icons.login),
                label: const Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New to Adhicine? '),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<DateTime> days =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier(-1);
  static final ValueNotifier<Map<DateTime, List<String>>> medicineNotifier =
      ValueNotifier({});

  void _navigateToDateResult(BuildContext context, DateTime selectedDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateResultPage(selectedDate: selectedDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi Harry!'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_alert),
          ),
          CircleAvatar(
            backgroundImage: AssetImage('./assets/profile.png'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '5 Medicines Left',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 80,
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndexNotifier,
                    builder: (context, selectedIndex, _) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          DateTime day = days[index];
                          String formattedDay = DateFormat('EEE').format(day);
                          String formattedDate =
                              DateFormat('MMM d').format(day);
                          bool isSelected = index == selectedIndex;

                          return GestureDetector(
                            onTap: () {
                              selectedIndexNotifier.value = index;
                              _navigateToDateResult(context, day);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: isSelected
                                    ? null
                                    : Border.all(color: Colors.grey),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    formattedDay,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: medicineNotifier,
                    builder: (context, medicineData, _) {
                      List<String>? medicines =
                          medicineData[days[selectedIndexNotifier.value]];
                      return medicines != null && medicines.isNotEmpty
                          ? ListView.builder(
                              itemCount: medicines.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(medicines[index]),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    './assets/empty_box.png',
                                    width: 150,
                                    height: 150,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Nothing Is Here, Add a Medicine',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          BottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMedicinePage()),
                );
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Report',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DateResultPage extends StatelessWidget {
  final DateTime selectedDate;

  const DateResultPage({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for $formattedDate'),
      ),
      body: Center(
        child: Text(
          'Displaying results for $formattedDate',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class AddMedicinePage extends StatefulWidget {
  @override
  _AddMedicinePageState createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  double _sliderValue = 1;
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _medicineController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime initialDate =
        isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now());
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addMedicine() {
    if (_startDate != null && _medicineController.text.isNotEmpty) {
      DateTime selectedDate = _startDate!;
      HomePage.medicineNotifier.value = {
        ...HomePage.medicineNotifier.value,
        selectedDate: [
          ...?HomePage.medicineNotifier.value[selectedDate],
          _medicineController.text
        ],
      };
      HomePage.medicineNotifier.notifyListeners();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _medicineController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
                prefixIcon: Icon(Icons.medication),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Compartment',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => CircleAvatar(
                  child: Text('${index + 1}'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Total Count',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _sliderValue,
              min: 1,
              max: 100,
              divisions: 100,
              label: _sliderValue.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Set Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(_startDate == null
                        ? 'Start Date'
                        : DateFormat('MMM d, yyyy').format(_startDate!)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text(_endDate == null
                        ? 'End Date'
                        : DateFormat('MMM d, yyyy').format(_endDate!)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Before Food'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('After Food'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Before Sleep'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMedicine,
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
