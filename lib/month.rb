require 'date'

# Month represents a specific month in time. With the exception of
# Month.month_names (which returns a zero-based array), every usage of the
# month value assumes that 1 equals January and 12 equals December.
#
# The Rubyforge project page can be viewed at
# http://rubyforge.org/projects/month.
class Month
	Version = '0.1.2'
	
	# Returns an array of the full names of months (in English). Note that
	# "January" is the 0th element, and "December" is the 11th element.
	def Month.month_names
		[ "January", "February", "March", "April", "May", "June", "July",
			"August", "September", "October", "November", "December" ]
	end
  
  def self.new_utc
    new Time.now.utc
  end

	include Comparable

	attr_reader :month, :year

	# A new month can be set to a specific +month+ and +year+, or you can call 
	# Month.new with no arguments to receive the current month.
	def initialize(*args)
    if args.empty?
			date = Date.today
			month = date.mon unless month
			year = date.year unless year
    elsif args.size == 2 &&
          args.first.is_a?(Integer) && args.last.is_a?(Integer)
      year, month = args.first, args.last
    else
      month = args.first.month
      year = args.first.year
    end
		fail "invalid month" if month < 1 || month > 12
		@month = month
		@year = year
	end

	# Returns a new Month that is +amountToAdd+ months later.
	def +( amountToAdd )
		( fullYears, remainingMonths ) = amountToAdd.divmod( 12 )
		resultYear = @year + fullYears
		resultMonth = @month + remainingMonths
		if resultMonth > 12
			resultMonth -= 12
			resultYear += 1
		end
		Month.new( resultYear, resultMonth )
	end
	
	# Returns a new Month that is +amount_to_subtract+ months earlier.
	def -(amount_to_subtract)
    if amount_to_subtract.is_a?(Integer)
      self + (-amount_to_subtract)
    else
      minuend_year = year
      minuend_month = month
      subtrahend_year = amount_to_subtract.year
      subtrahend_month = amount_to_subtract.month
      ((minuend_year - subtrahend_year) * 12) +
          minuend_month - subtrahend_month 
    end
	end
	
	# Compare this Month to another Month.
	def <=>(anOther)
		if @year == anOther.year
			@month <=> anOther.month
		else
			@year <=> anOther.year
		end
	end

	# Returns the last Date of the month.
	def end_date
		self.next.start_date - 1
	end

	# Is this Month equal to +anOther+? +anOther+ must be another Month of the
	# same value.
	def eql?(anOther)
		self == anOther
	end
	
	# Calculate a hash value for this Month.
	def hash
		"#{@year}#{@month}".to_i
	end
  
  def include?(obj)
    obj = Date.new(obj.year, obj.month, obj.day)
    start_date <= obj and end_date >= obj
  end

	# Returns the next Month.
	def next
		self + 1
	end
	
	alias_method :succ, :next
	
	# Returns the previous Month.
	def prev
		self - 1
	end
	
	# Returns the first Date of the month.
	def start_date
		Date.new( @year, @month, 1 )
	end
  
  def strftime(string)
    %w(b B c m y Y).each do |code|
      string = string.gsub(
        /([^%]|^)%#{code}/, '\1' + start_date.strftime("%#{code}")
      )
    end
    string = string.gsub /%([\w])/, '\1'
    string = string.gsub /%%/, '%'
    string
  end
	
	# Returns a string of the format "January 2001".
	def to_s
		Month.month_names[@month-1][0..2] + " " + @year.to_s
	end
end
