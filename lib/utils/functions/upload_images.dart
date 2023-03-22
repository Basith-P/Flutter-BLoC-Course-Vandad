import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

Future<bool> uploadImage(String uid, String imagePath) =>
    FirebaseStorage.instance
        .ref('$uid/${const Uuid().v4()}')
        .putFile(File(imagePath))
        .then((_) => true)
        .catchError((_) => false);
