import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app_081/screens/home/native_camera.dart';
import 'storage_helper.dart';

class CameraHomescreen extends StatefulWidget {
  const CameraHomescreen({super.key});

  @override
  State<CameraHomescreen> createState() => _CameraHomescreenState();
}

class _CameraHomescreenState extends State<CameraHomescreen> {
  File? _imageFile;

  Future<void> _requestPermissions() async{
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> _takePicture() async{
    await _requestPermissions();
    final File? result = await Navigator.push<File?>(
      context,
      MaterialPageRoute(builder: (_)=> const NativeCamera()),
    );
    if (result != null){
      final saved = await StorageHelper.saveImage(result, 'camera');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Disimpan: ${saved.path}')));
    }
  }

  Future<void> _pickFromGallery() async{
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if(picked != null){
      final saved = await StorageHelper.saveImage(File(picked.path), 'gallery');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Disalin: ${saved.path}')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera),
                    label: const Text('Ambil Foto'),
                    onPressed: _takePicture,
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.folder),
                  label: const Text('Pilih dari Galeri'),
                  onPressed: _pickFromGallery,
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_imageFile != null)
            Column(
              children: [
                Padding(padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  _imageFile!, 
                  width: double.infinity
                  ),
                ),
                Text(
                  'Gambar disimpan di: ${_imageFile?.path ?? 'Tidak ada'}',
                  style: const TextStyle(fontSize: 12),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Hapus Gambar'),
                  onPressed: () async {
                    await _imageFile?.delete();
                    setState(() => _imageFile = null);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gambar dihapus')));
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Gunakan Gambar Sebagai Logo'),
                  onPressed: () {
                    Navigator.pop(context, _imageFile);
                  },
                ),
              ],
            )
            else
              const Text('Belum ada gambar diambil/dipilih'),
            const SizedBox(height: 20)
          ],
        )
      ),
    );
  }
}