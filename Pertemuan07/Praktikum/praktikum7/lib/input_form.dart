import 'package:flutter/material.dart';

class MyInputForm extends StatefulWidget {
  const MyInputForm({super.key});
  @override
  State<MyInputForm> createState() => _MyInputFormState();
}

class _MyInputFormState extends State<MyInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _myDataList = [];
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();

  Map<String, dynamic>? editedData;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  void _addData() {
    final data = {'name': _controllerNama.text, 'email': _controllerEmail.text};
    setState(() {
      if (editedData != null) {
        // Jika editedData ada, maka kita sedang dalam mode edit
        // Sehingga kita perlu memperbarui data yang sedang diedit
        editedData!['name'] = data['name'];
        editedData!['email'] = data['email'];
        // Kosongkan kembali editedData setelah proses edit selesai
        editedData = null;
      } else {
        // Jika editedData kosong, maka kita sedang dalam mode insert
        _myDataList.add(data);
      }
      _controllerNama.clear();
      _controllerEmail.clear();
    });
  }

  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerEmail.text = data['email'];
      _controllerNama.text = data['name'];
      editedData = data;
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    const String expression =
        "[a-zA-Z0-9+._%-+]{1,256}"
        "\\@"
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        "("
        "\\."
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
        ")+";
    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) {
      return 'Email wajib diisi';
    }

    if (!regExp.hasMatch(value)) {
      return "Tolong inputkan email yang valid!";
    }
    return null;
  }

  String? _validateNama(String? value) {
    if (value!.length < 3) {
      return 'Masukkan setidaknya 3 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                    hintText: 'Write your email here...',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    fillColor: Color.fromARGB(255, 222, 254, 255),
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerNama,
                  validator: _validateNama,
                  decoration: const InputDecoration(
                    hintText: 'Write your name here...',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    fillColor: Color.fromARGB(255, 222, 254, 255),
                    filled: true,
                  ),
                ),
              ),
              ElevatedButton(
                child: Text(editedData != null ? 'Update' : 'Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addData();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'List Data',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _myDataList.length,
                  itemBuilder: (context, index) {
                    final data = _myDataList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              'ULBI',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name'] ?? ''),
                                Text(data['email'] ?? ''),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _editData(data);
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _deleteData(data);
                              });
                            },
                            icon: const Icon(Icons.delete),
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
      ),
    );
  }
}
