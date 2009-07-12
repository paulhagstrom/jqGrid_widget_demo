# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fancytable_session',
  :secret      => '0d9754e66e9bf27023f0775a19c2dc81d9b554028eab945fca71b5a9ffb90014af16d5fc58308db21ae29729c08d93926026e2c23f2c303aa3b33acc1074be42'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
