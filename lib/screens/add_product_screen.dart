import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../main.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameC  = TextEditingController();
  final _priceC = TextEditingController();
  final _descC  = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameC.dispose(); _priceC.dispose(); _descC.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name  = _nameC.text.trim();
    final pText = _priceC.text.trim();
    final desc  = _descC.text.trim();
    if (name.isEmpty || pText.isEmpty || desc.isEmpty) {
      _toast('Semua field wajib diisi', err: true); return;
    }
    final price = int.tryParse(pText);
    if (price == null) {
      _toast('Harga harus berupa angka', err: true); return;
    }
    setState(() => _loading = true);
    try {
      final ok = await ApiService.addProduct(ProductModel(
          id: 0, name: name,
          price: price.toDouble(),
          description: desc, createdAt: ''));
      if (ok && mounted) {
        _toast('Produk berhasil disimpan! ✓');
        await Future.delayed(const Duration(milliseconds: 300));
        Navigator.pop(context, true);
      } else {
        _toast('Gagal menyimpan produk', err: true);
      }
    } catch (e) {
      _toast('Error: $e', err: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _toast(String msg, {bool err = false}) =>
      scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Text(msg, style: const TextStyle(
            color: Colors.white, fontSize: 13)),
        backgroundColor: err ? AppTheme.redSoft : AppTheme.green,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ));

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppTheme.bg,
        body: SafeArea(
          child: Column(children: [
            
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.green, AppTheme.greenDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
              child: Row(children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(9)),
                    child: const Icon(Icons.chevron_left_rounded,
                        size: 20, color: Colors.white),
                  ),
                ),
                const Expanded(
                  child: Text('Tambah Produk',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(9)),
                  child: const Icon(Icons.person_outline_rounded,
                      size: 18, color: Colors.white),
                ),
              ]),
            ),

            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppTheme.greenLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.greenBorder)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.info_outline_rounded,
                            size: 15, color: AppTheme.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Data tidak dapat diedit setelah disimpan. '
                            'Pastikan semua informasi sudah benar '
                            'sebelum menekan tombol simpan.',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.greenDark,
                                height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10, offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Column(children: [
                      _grp('NAMA PRODUK',
                        TextField(
                          controller: _nameC,
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                            hintText: 'cth. Macbook Pro M5 2026',
                            prefixIcon: Icon(Icons.label_outline_rounded,
                                size: 18, color: AppTheme.green),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      _grp('HARGA',
                        TextField(
                          controller: _priceC,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                            hintText: 'cth. 32450000',
                            prefix: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text('Rp',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.green,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      _grp('DESKRIPSI',
                        TextField(
                          controller: _descC,
                          maxLines: 4,
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                            hintText:
                                'Tulis deskripsi singkat tentang produk ini...',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 56),
                              child: Icon(Icons.notes_rounded,
                                  size: 18, color: AppTheme.green),
                            ),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 24),

                  
                  SizedBox(
                    width: double.infinity, height: 52,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.green, AppTheme.greenDark],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.green.withOpacity(0.35),
                            blurRadius: 14, offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _loading ? null : _save,
                        icon: _loading
                            ? const SizedBox(
                                width: 18, height: 18,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Icon(Icons.save_alt_rounded,
                                color: Colors.white, size: 18),
                        label: Text(
                            _loading ? 'Menyimpan...' : 'Simpan Produk',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Data tidak dapat diedit setelah disimpan',
                      style: TextStyle(
                          fontSize: 11, color: AppTheme.textMuted)),
                ]),
              ),
            ),
          ]),
        ),
      );

  Widget _grp(String label, Widget field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: .8,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary)),
          const SizedBox(height: 6),
          field,
        ],
      );
}