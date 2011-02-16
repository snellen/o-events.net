# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OEventsNet::Application.initialize!

# Shamelessly copied from http://snippets.dzone.com/posts/show/5019
# add this to environment.rb
# call to_iso on any UTF8 string to get a ISO string back
# example : "Cédez le passage aux français".to_iso
class String
  require 'iconv' #this line is not needed in rails !
  def to_iso
    Iconv.conv('ISO-8859-1', 'utf-8', self)
  end
end
