import 'dart:typed_data';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class OcrService {
  final TextRecognizer _recognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  /// Extract text from image bytes using ML Kit OCR
  Future<String> extractTextFromBytes(Uint8List imageBytes) async {
    try {
      // Save bytes to temp file (MLKit needs file path)
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        path.join(tempDir.path, 'ocr_${DateTime.now().millisecondsSinceEpoch}.jpg'),
      );
      await tempFile.writeAsBytes(imageBytes);

      final result = await extractTextFromFile(tempFile.path);

      // Clean up
      await tempFile.delete();

      return result;
    } catch (e) {
      return '';
    }
  }

  /// Extract text from a file path
  Future<String> extractTextFromFile(String filePath) async {
    try {
      final inputImage = InputImage.fromFilePath(filePath);
      final recognizedText = await _recognizer.processImage(inputImage);

      if (recognizedText.text.isEmpty) {
        return '';
      }

      // Clean and structure the text
      return _cleanOcrText(recognizedText.text);
    } catch (e) {
      return '';
    }
  }

  String _cleanOcrText(String raw) {
    return raw
        .replaceAll(RegExp(r'\n{3,}'), '\n\n') // max 2 newlines
        .replaceAll(RegExp(r' {2,}'), ' ')      // max 1 space
        .trim();
  }

  void dispose() {
    _recognizer.close();
  }
}