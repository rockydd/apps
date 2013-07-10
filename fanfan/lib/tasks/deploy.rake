desc "Deploy to production"
task :deploy do
  DEST = '/var/www/'
  cp(DEST + "fanfan/db/production.sqlite3", '/tmp/')
  cp_r(Rails.root.to_s, DEST)
  cp("/tmp/production.sqlite3", DEST + "fanfan/db/")
end

