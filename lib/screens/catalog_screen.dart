import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../main.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import 'add_product_screen.dart';
import 'login_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<ProductModel> _all = [], _filtered = [];
  bool _loading = true;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetch();
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() => _filtered = q.isEmpty
          ? _all
          : _all.where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q)).toList());
    });
  }

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  Future<void> _fetch() async {
    setState(() => _loading = true);
    try {
      final list = await ApiService.getProducts();
      setState(() { _all = list; _filtered = list; });
    } catch (e) {
      _toast('Gagal memuat: $e', err: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _delete(ProductModel p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppTheme.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: AppTheme.redBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.redBorder)),
                child: const Icon(Icons.delete_outline_rounded,
                    color: AppTheme.redSoft, size: 22),
              ),
              const SizedBox(height: 14),
              const Text('Hapus produk?',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              const SizedBox(height: 6),
              Text('"${p.name}" akan dihapus dari katalog.',
                  style: const TextStyle(
                      fontSize: 13, color: AppTheme.textSecondary)),
              const SizedBox(height: 22),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.border),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13)),
                    child: const Text('Batal',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.redSoft,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13)),
                    child: const Text('Hapus',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
    if (ok == true) {
      final success = await ApiService.deleteProduct(p.id);
      if (success) { _toast('Produk berhasil dihapus ✓'); _fetch(); }
      else _toast('Gagal menghapus produk', err: true);
    }
  }

  Future<void> _showSubmit() async {
    final nameC  = TextEditingController();
    final priceC = TextEditingController();
    final descC  = TextEditingController();
    final ghC    = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        padding: EdgeInsets.only(
            left: 22, right: 22, top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  width: 36, height: 4,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                      color: AppTheme.border,
                      borderRadius: BorderRadius.circular(2))),
            ),
            Row(children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: AppTheme.greenLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.greenBorder)),
                child: const Icon(Icons.upload_rounded,
                    color: AppTheme.green, size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Submit Tugas',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
            ]),
            const SizedBox(height: 18),
            _sheetField(nameC, 'Nama produk', Icons.inventory_2_outlined),
            const SizedBox(height: 10),
            _sheetField(priceC, 'Harga (angka)', Icons.payments_outlined,
                inputType: TextInputType.number),
            const SizedBox(height: 10),
            _sheetField(descC, 'Deskripsi', Icons.notes_rounded),
            const SizedBox(height: 10),
            _sheetField(ghC, 'URL GitHub', Icons.code_rounded),
            const SizedBox(height: 20),
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
                      color: AppTheme.green.withOpacity(0.3),
                      blurRadius: 14, offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    final ok = await ApiService.submitTugas(
                      name: nameC.text.trim(),
                      price: int.tryParse(priceC.text.trim()) ?? 0,
                      description: descC.text.trim(),
                      githubUrl: ghC.text.trim(),
                    );
                    _toast(ok
                        ? 'Tugas berhasil disubmit! 🎉'
                        : 'Submit gagal, coba lagi', err: !ok);
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.white, size: 18),
                  label: const Text('Submit Sekarang',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetField(TextEditingController c, String hint, IconData icon,
      {TextInputType inputType = TextInputType.text}) =>
      TextField(
        controller: c,
        keyboardType: inputType,
        style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, size: 18, color: AppTheme.green),
        ),
      );

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

  String _fmt(double price) {
    final s = price.toStringAsFixed(0).split('').reversed.toList();
    final r = <String>[];
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && i % 3 == 0) r.add('.');
      r.add(s[i]);
    }
    return 'Rp ${r.reversed.join()}';
  }

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
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                  child: Row(children: [
                    const Icon(Icons.menu_rounded,
                        size: 22, color: Colors.white),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Halo 👋', style: TextStyle(
                              fontSize: 11, color: Colors.white70)),
                          Text('PBM Shop', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                        ],
                      ),
                    ),
                    _appBarBtn(
                      label: 'Submit',
                      icon: Icons.upload_rounded,
                      onTap: _showSubmit,
                    ),
                    const SizedBox(width: 6),
                    _appBarBtn(
                      label: 'Keluar',
                      icon: Icons.logout_rounded,
                      onTap: () async {
                        await ApiService.deleteToken();
                        if (mounted) Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      },
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8, offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchCtrl,
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textPrimary),
                      decoration: const InputDecoration(
                        hintText: 'Cari produk...',
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 18, color: AppTheme.textMuted),
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ]),
            ),

            
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Row(children: [
                const Text('Produk Saya',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppTheme.greenLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.greenBorder)),
                  child: Text('${_filtered.length} items',
                      style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.green,
                          fontWeight: FontWeight.w700)),
                ),
              ]),
            ),

            
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(
                      color: AppTheme.green, strokeWidth: 2))
                  : _filtered.isEmpty
                      ? _empty()
                      : RefreshIndicator(
                          onRefresh: _fetch,
                          color: AppTheme.green,
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 100),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: _filtered.length,
                            itemBuilder: (_, i) => _card(_filtered[i]),
                          ),
                        ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final ok = await Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddProductScreen()));
            if (ok == true) _fetch();
          },
          backgroundColor: AppTheme.green,
          elevation: 4,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
        ),
      );

  Widget _appBarBtn({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(9)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ],
          ),
        ),
      );

  Widget _card(ProductModel p) => Container(
        decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10, offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.greenLight, Color(0xFFF0FFF1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14))),
              child: const Center(
                child: Icon(Icons.inventory_2_outlined,
                    size: 34, color: AppTheme.greenBorder),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 3),
                    Text(_fmt(p.price),
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.green)),
                    const SizedBox(height: 2),
                    Text(p.description,
                        style: const TextStyle(
                            fontSize: 10, color: AppTheme.textMuted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () => _delete(p),
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 13, color: AppTheme.redSoft),
                        label: const Text('Hapus',
                            style: TextStyle(
                                color: AppTheme.redSoft,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                        style: TextButton.styleFrom(
                            backgroundColor: AppTheme.redBg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: AppTheme.redSoft.withOpacity(0.2))),
                            padding: const EdgeInsets.symmetric(vertical: 5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _empty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 68, height: 68,
              decoration: BoxDecoration(
                  color: AppTheme.greenLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.greenBorder)),
              child: const Icon(Icons.inventory_2_outlined,
                  size: 30, color: AppTheme.green),
            ),
            const SizedBox(height: 14),
            const Text('Belum ada produk',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 6),
            const Text('Tap tombol + untuk menambahkan',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          ],
        ),
      );
}