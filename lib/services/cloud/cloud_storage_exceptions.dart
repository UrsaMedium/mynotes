
class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C in CRUD
class CouldNotCreateNoteExceptiont extends CloudStorageException{}
//R in CRUD
class CouldNotGetAllNotesExceptiont extends CloudStorageException{}
//U in CRUD
class CouldNotUpdateNoteExceptiont extends CloudStorageException{}
//D in CRUD
class CouldNotDeleteNoteExceptiont extends CloudStorageException{}