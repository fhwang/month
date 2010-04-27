require 'rubygems'
spec = Gem::Specification.new do |s|
	s.name = 'month'
	s.version = '0.1.1'
	s.platform = Gem::Platform::RUBY
	s.date = Time.now
	s.summary = "Month is a utility class for representing months in Ruby."
	s.description = <<-DESC
Ruby Month is a utility class for representing months in Ruby. It handles addition, previous and next months, end and start dates, month names (in English), and a few other handy things.
	DESC
	s.require_paths = [ 'lib' ]
	s.files = Dir.glob( 'lib/**/*' ).delete_if { |item|
		item.include?('CVS')
	}
	s.author = "Francis Hwang"
	s.email = 'sera@fhwang.net'
	s.homepage = 'http://month.rubyforge.org/'
	s.autorequire = 'month'
end
if $0==__FILE__
  Gem::Builder.new(spec).build
end
