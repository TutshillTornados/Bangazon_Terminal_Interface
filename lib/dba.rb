# This file in the MODEL in the MVC
require 'sqlite3'
class DatabaseAdmin

    @@filepath = nil

        def self.filepath=(path=nil)
        @@filepath = File.join(APP_ROOT, path)
        end

        def self.file_exists?
            if @@filepath && File.exists?(@@filepath)
                return true
            else
                return false
            end
        end
          
        def self.file_useable?
            return false unless @@filepath
            return false unless File.exists?(@@filepath)
            return false unless File.readable?(@@filepath)
            return false unless File.writable?(@@filepath)
            return true
        end
    
        def self.create_file
            # creates the database
            SQLite3::Database.new(@@filepath) unless file_exists?
            return file_useable?
        end

end

