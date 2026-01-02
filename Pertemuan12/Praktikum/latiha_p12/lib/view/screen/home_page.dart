import 'package:flutter/material.dart';
import 'package:latiha_p12/model/contact_model.dart';
import 'package:latiha_p12/services/api_services.dart';
import 'package:latiha_p12/view/widget/contact_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _numberCtl = TextEditingController();
  
  // Instance API Service [cite: 119]
  final ApiServices _dataService = ApiServices();
  
  List<ContactsModel> _contactMdl = [];
  ContactResponse? ctRes;
  String _result = '-';
  
  // Variable untuk Edit Mode [cite: 587]
  bool isEdit = false;
  String idContact = '';

  // Validasi Nama [cite: 372]
  String? _validateName(String? value) {
    if (value != null && value.length < 4) {
      return 'Masukkan minimal 4 karakter';
    }
    return null;
  }

  // Validasi Nomor HP [cite: 378]
  String? _validatePhoneNumber(String? value) {
    if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
      return 'Nomor HP harus berisi angka';
    }
    return null;
  }

  // Fungsi Refresh Data [cite: 123]
  Future<void> refreshContactList() async {
    final users = await _dataService.getAllContact();
    setState(() {
      if (_contactMdl.isNotEmpty) _contactMdl.clear();
      if (users != null) {
        // Balik urutan agar data terbaru ada di atas
        _contactMdl.addAll(users.reversed); 
      }
    });
  }

  // Fungsi menampilkan dialog konfirmasi hapus [cite: 832]
  void _showDeleteConfirmationDialog(String id, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data $nama?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Tutup dialog dulu
                final res = await _dataService.deleteContact(id); // Hapus data
                setState(() {
                  ctRes = res; // Tampilkan pesan sukses
                });
                await refreshContactList(); // Refresh list
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
      const Text('Contacts API' , style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // === FORM INPUT ===
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtl,
                    validator: _validateName,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Nama',
                      suffixIcon: IconButton(
                        onPressed: _nameCtl.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _numberCtl,
                    validator: _validatePhoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Nomor HP',
                      suffixIcon: IconButton(
                        onPressed: _numberCtl.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),

            // === TOMBOL POST / UPDATE & CANCEL ===
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 10, // Jarak antar tombol
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState?.validate();
                        if (_nameCtl.text.isEmpty || _numberCtl.text.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Semua field harus diisi'))
                           );
                           return;
                        }
                        if (!isValidForm!) {
                          return;
                        }

                        final postModel = ContactInput(
                          namaKontak: _nameCtl.text,
                          nomorHp: _numberCtl.text,
                        );

                        ContactResponse? res;
                        // Logika cek apakah POST baru atau UPDATE [cite: 687-694]
                        if (isEdit) {
                          res = await _dataService.putContact(idContact, postModel);
                        } else {
                          res = await _dataService.postContact(postModel);
                        }

                        setState(() {
                          ctRes = res;
                          isEdit = false; // Kembalikan ke mode normal
                        });
                        
                        _nameCtl.clear();
                        _numberCtl.clear();
                        await refreshContactList();
                      },
                      child: Text(isEdit ? 'UPDATE' : 'POST'), // Label berubah dinamis [cite: 637]
                    ),
                    // Tombol Cancel Update hanya muncul saat mode edit [cite: 642]
                    if (isEdit)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            isEdit = false;
                            _nameCtl.clear();
                            _numberCtl.clear();
                          });
                        },
                        child: const Text('Cancel Update', style: TextStyle(color: Colors.white)),
                      ),
                  ],
                ),
              ],
            ),

            // === WIDGET HASIL RESPONSE ===
            const SizedBox(height: 8.0),
            if (ctRes != null)
              ContactCard(
                ctRes: ctRes!,
                onDismissed: () {
                  setState(() {
                    ctRes = null;
                  });
                },
              ),
            
            const SizedBox(height: 8.0),

            // === TOMBOL REFRESH & RESET ===
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await refreshContactList();
                    },
                    child: const Text('Refresh Data'),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Reset Form & Response [cite: 453]
                    setState(() {
                      _result = '-';
                      _contactMdl.clear();
                      ctRes = null;
                    });
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
            
            const SizedBox(height: 8.0),
            const Text('List Contact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8.0),

            // === LIST VIEW CONTACT ===
            Expanded(
              child: _contactMdl.isEmpty
                  ? Center(child: Text(_result)) // Tampilkan pesan jika kosong [cite: 190]
                  : _buildListContact(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk List Data [cite: 148-172]
  Widget _buildListContact() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final ctList = _contactMdl[index];
        return Card(
          child: ListTile(
            title: Text(ctList.namaKontak),
            subtitle: Text(ctList.nomorHp),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tombol Edit [cite: 601]
                IconButton(
                  onPressed: () async {
                    final contacts = await _dataService.getSingleContact(ctList.id);
                    if (contacts != null) {
                      setState(() {
                        _nameCtl.text = contacts.namaKontak;
                        _numberCtl.text = contacts.nomorHp;
                        isEdit = true; // Aktifkan mode edit
                        idContact = contacts.id;
                      });
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
                // Tombol Delete [cite: 863]
                IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(ctList.id, ctList.namaKontak);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemCount: _contactMdl.length,
    );
  }
}