import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://rrzgczduwjtpqdfarffg.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJyemdjemR1d2p0cHFkZmFyZmZnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY2NTQ0OTksImV4cCI6MjA0MjIzMDQ5OX0.jSMtS7LsmxmCmCeXiJpStmy-HOfZ9RB2awyd8ucrhUM';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
