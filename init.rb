# FIX for engines model reloading issue in development mode
if ENV['RAILS_ENV'] != 'production'
	load_paths.each do |path|
		Dependencies.load_once_paths.delete(path)
	end
end
