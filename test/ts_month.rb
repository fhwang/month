$: << 'lib'
require 'month'
require 'test/unit'

class TestMonth < Test::Unit::TestCase
	def setup
		@jan2000 = Month.new 2000, 1
		@dec2000 = Month.new 2000, 12
		@jan2001 = Month.new 2001, 1
	end

	def test_arithmetic
		assert_equal( Month.new( 2000, 2 ), @jan2000 + 1 )
		assert_equal( Month.new( 2001, 1 ), @jan2000 + 12 )
		assert_equal( Month.new( 1999, 10 ), @jan2000 - 3 )
		assert_equal( Month.new( 1999, 10 ), @jan2000 + -3 )
	end
	
	def test_checks_month
		caught = false
		begin
			Month.new 1, 2000
		rescue
			caught = true
		end
		assert caught
		Month.new 2000, 1
	end

	def test_compare
		assert @jan2000 < @jan2001
	end

	def test_default_init_to_current_month
		month = Month.new
		date = Date.today
		assert_equal( date.mon, month.month )
		assert_equal( date.year, month.year )
	end
	
	def test_hashable
		newJan2000 = Month.new( 2000, 1 )
		assert_equal @jan2000, newJan2000
		assert_equal @jan2000.hash, newJan2000.hash
		assert( @jan2000.eql?( newJan2000 ) )
		normalHash = {}
		normalHash[@jan2000] = 'q'
		assert_equal 'q', normalHash[newJan2000]
	end

	def test_prev_next_succ
		assert_equal( @dec2000, @jan2001.prev )
		assert_equal( @jan2001, @dec2000.next )
		assert_equal( @jan2001, @dec2000.succ )
		assert_equal( @jan2000, @jan2000.prev.next )
		assert_equal( @jan2000, @jan2000.prev.succ )
	end

	def test_start_date_and_end_date
		assert_equal( Date.new( 2000, 12, 1 ), @dec2000.start_date )
		assert_equal( Date.new( 2000, 12, 31 ), @dec2000.end_date )
		assert_equal( Date.new( 1999, 2, 28 ), Month.new( 1999, 2 ).end_date )
	end

	def test_to_s
		assert_equal 'Jan 2000', @jan2000.to_s
	end
end