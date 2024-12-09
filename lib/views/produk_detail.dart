import 'package:flutter/material.dart';
import 'package:pos_uas/controllers/produk_controller.dart';
import 'package:pos_uas/model/produk.dart';
import 'package:pos_uas/views/produk_form.dart';
import 'package:pos_uas/views/produk_page.dart';
import 'package:pos_uas/widgets/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  // Widget tombol untuk edit dan hapus
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk!),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void confirmHapus() {
    if (widget.produk?.id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "ID produk tidak valid",
        ),
      );
      return;
    }

    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            Navigator.pop(context); // Tutup dialog konfirmasi
            _hapusProduk();
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }

  // Fungsi untuk menghapus produk
  void _hapusProduk() {
    ProdukController.deleteProduk(id: widget.produk!.id!).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProdukPage()),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Hapus gagal, silahkan coba lagi",
        ),
      );
    });
  }
}
