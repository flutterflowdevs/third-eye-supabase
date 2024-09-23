import '../database.dart';

class EmergencyContactTable extends SupabaseTable<EmergencyContactRow> {
  @override
  String get tableName => 'emergencyContact';

  @override
  EmergencyContactRow createRow(Map<String, dynamic> data) =>
      EmergencyContactRow(data);
}

class EmergencyContactRow extends SupabaseDataRow {
  EmergencyContactRow(super.data);

  @override
  SupabaseTable get table => EmergencyContactTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get contactName => getField<String>('contact_name');
  set contactName(String? value) => setField<String>('contact_name', value);

  String? get contactNumber => getField<String>('contact_number');
  set contactNumber(String? value) => setField<String>('contact_number', value);

  String? get contactEmail => getField<String>('contact_email');
  set contactEmail(String? value) => setField<String>('contact_email', value);

  DateTime get contactCreatedAt => getField<DateTime>('contact_created_at')!;
  set contactCreatedAt(DateTime value) =>
      setField<DateTime>('contact_created_at', value);

  String? get contactImg => getField<String>('contact_img');
  set contactImg(String? value) => setField<String>('contact_img', value);
}
