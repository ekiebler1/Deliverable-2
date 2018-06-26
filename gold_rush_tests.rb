require 'minitest/autorun'
require 'simplecov'
SimpleCov.start
require_relative 'main'

class GoldRushTests < Minitest::Test
  
  # Almost every test needs a freshly intialized prospector 
  # because of this I made a set up method
  def setup
  	@test_prospector = Prospector.new
  	@test_prospector.intialize
  end
  # This unit test tests if the intialize method works
  # a prospectors minerals and moves are set to 0
  # previous location should be nil and current is sutter creek
  # This test makes sure the values are as they should be
  def test_intialize
  	refute_nil @test_prospector
  	assert_kind_of Prospector, @test_prospector
	assert_equal 0, @test_prospector.current_gold
	assert_equal 0, @test_prospector.current_silver
	assert_equal 0, @test_prospector.total_gold
	assert_equal 0, @test_prospector.total_silver
	assert_equal 0, @test_prospector.move_count
	assert_nil @test_prospector.previous_location
	assert_equal 0, @test_prospector.num_days
	assert_equal 'Sutter Creek', @test_prospector.current_location
  end
  
  # The following unit tests are for the mine method
  # in the prospector.rb file. Each one is testing the
  # mine method at that location and checks if the values
  # returned are in the specified range.
  # This method has > 10 equilence classes.
  # These tests confirm the values returned from mining in
  # each location return values in the correct range
  def test_mine_sutter_creek
	@test_prospector.current_location = 'Sutter Creek'
	@test_prospector.mine
	assert_operator 2, :>=, @test_prospector.current_gold
	assert_equal 0, @test_prospector.current_silver
	assert_operator 2, :>=, @test_prospector.total_gold
	assert_equal 0, @test_prospector.total_silver
  end 
  
  def test_mine_coloma
	@test_prospector.current_location = 'Coloma'
	@test_prospector.mine
	assert_operator 3, :>=, @test_prospector.current_gold
	assert_equal 0, @test_prospector.current_silver
	assert_operator 3, :>=, @test_prospector.total_gold
	assert_equal 0, @test_prospector.total_silver
  end

  def test_mine_angels_camp
	@test_prospector.current_location = 'Angels Camp'
	@test_prospector.mine
	assert_operator 4, :>=, @test_prospector.current_gold
	assert_equal 0, @test_prospector.current_silver
	assert_operator 4, :>=, @test_prospector.total_gold
	assert_equal 0, @test_prospector.total_silver
  end

  def test_mine_nevada_city
	@test_prospector.current_location = 'Nevada City'
	@test_prospector.mine
	assert_operator 5, :>=, @test_prospector.current_gold
	assert_equal 0, @test_prospector.current_silver
	assert_operator 5, :>=, @test_prospector.total_gold
	assert_equal 0, @test_prospector.total_silver
  end

  def test_mine_virginia_city
	@test_prospector.current_location = 'Virginia City'
	@test_prospector.mine
	assert_operator 3, :>=, @test_prospector.current_gold
	assert_operator 3, :>=, @test_prospector.current_silver
	assert_operator 3, :>=, @test_prospector.total_gold
	assert_operator 3, :>=, @test_prospector.total_silver
  end

  def test_midas_mine
	@test_prospector.current_location = 'Midas'
	@test_prospector.mine
	assert_equal 0, @test_prospector.current_gold
	assert_operator 5, :>=, @test_prospector.current_silver
	assert_equal 0, @test_prospector.total_gold
	assert_operator 5, :>=, @test_prospector.total_silver
  end

  def test_el_dorado_cn
	@test_prospector.current_location = 'El Dorado Canyon'
	@test_prospector.mine
	assert_equal 0, @test_prospector.current_gold
	assert_operator 10, :>=, @test_prospector.current_silver
	assert_equal 0, @test_prospector.total_gold
	assert_operator 10, :>=, @test_prospector.total_silver
  end

  # This tests the add_to_bag function. The current gold and 
  # silver should be added to the totals of gold and silver
  # This test checks to make sure that it actually ups the totals
  def test_add_to_bag
  	@test_prospector.current_gold = 2
  	@test_prospector.current_silver = 3
  	@test_prospector.add_to_bag
  	assert_equal 3, @test_prospector.total_silver
  	assert_equal 2, @test_prospector.total_gold
  end
  
  # These methods test the move method. They depend on smaller move
  # Methods that return a new location based on random numbers. Because 
  # of this, reliance on the randomness, I'll stubb these smaller methods,
  # forcing them to return the desired location to test STUB
  def test_sutter_creek_move_coloma
  	@test_prospector.stub(:sutter_creek_move, 'Coloma') do
  	@test_prospector.move
  	assert_equal 'Coloma' , @test_prospector.current_location 
  	end
  end

  def test_sutter_creek_move_angels_camp
  	@test_prospector.stub(:sutter_creek_move, 'Angels Camp') do
  	@test_prospector.move
  	assert_equal 'Angels Camp' , @test_prospector.current_location 
  	end
  end

  def test_coloma_move_sutter_creek
  	@test_prospector.stub(:coloma_move, 'Sutter Creek') do
  	@test_prospector.current_location = 'Coloma'
  	@test_prospector.move
  	assert_equal 'Sutter Creek' , @test_prospector.current_location 
  	end
  end

  def test_coloma_move_virginia_city
  	@test_prospector.stub(:coloma_move, 'Virginia City') do
  	@test_prospector.current_location = 'Coloma'
  	@test_prospector.move
  	assert_equal 'Virginia City' , @test_prospector.current_location 
  	end
  end

  def test_angels_camp_move_nevada_city
  	@test_prospector.stub(:angels_camp_move, 'Nevada City') do
  	@test_prospector.current_location = 'Angels Camp'
  	@test_prospector.move
  	assert_equal 'Nevada City' , @test_prospector.current_location 
  	end
  end

  def test_angels_camp_move_sutter_creek
  	@test_prospector.stub(:angels_camp_move, 'Sutter Creek') do
  	@test_prospector.current_location = 'Angels Camp'
  	@test_prospector.move
  	assert_equal 'Sutter Creek' , @test_prospector.current_location 
  	end
  end

  def test_angels_camp_move_virginia_city
  	@test_prospector.stub(:angels_camp_move, 'Virginia City') do
  	@test_prospector.current_location = 'Angels Camp'
  	@test_prospector.move
  	assert_equal 'Virginia City' , @test_prospector.current_location 
  	end
  end
  	
  # This tests the calc total function. It is to return the 
  # monetary value for the total gold and silver
  def test_calc_total
  	@test_prospector.total_gold = 1
  	@test_prospector.total_silver = 1
  	assert_equal '21.98', @test_prospector.calc_total
  end

  # These test the possible answer of the end? function
  # This function has 2 equilence classes.
  # move count < 4 and move count > 4
  def test_end_fail
  	@test_prospector.move_count = 1
  	assert_equal false, @test_prospector.end?
  end

  def test_end_succ
  	@test_prospector.move_count = 4
  	assert_equal true, @test_prospector.end?
  end

  # These tests test the move? function.
  # It has 4 equivalence classes:
  # less than 3 moves: gold and silver are 0: returning true
  # less than 3 moves: gold and silver aren't 0: returning false
  # more than 3 moves: gold or silver are less than 2 and 3: returning true
  # more than 3 moves: gold or silver are greater than 2 and 3 : returnig false
  def test_move_less_3_succ
  	@test_prospector.current_silver = 0
  	@test_prospector.current_gold = 0
  	@test_prospector.move_count = 1 
  	assert_equal true, @test_prospector.move?
  end

  def test_move_less_3_fail
  	@test_prospector.current_gold = 3
  	assert_equal false, @test_prospector.move?
  end

  def test_move_greater_3_succ
  	@test_prospector.move_count = 4
  	@test_prospector.current_gold = 1
  	@test_prospector.current_silver =1
  	assert_equal true, @test_prospector.move?
  end

  def test_move_greater_3_fail
  	@test_prospector.move_count = 4
  	@test_prospector.current_gold = 8
  	assert_equal false, @test_prospector.move?
  end

  # These tests test the ounce_v_ounces method
  # It has 2 equivilence classes.
  # Mineral == 1: return ' ounce'
  # Mineral != 1: return ' ounces'
  def test_ounce_v_ounces_ounce
  	assert_equal ' ounce', @test_prospector.ounce_v_ounces(1)
  end

  def test_ounce_v_ounces_ounce
  	assert_equal ' ounces', @test_prospector.ounce_v_ounces(2)
  end

  # This tests the intialize group method in
  # the ProspectorGroup class.
  # checks that the num_prospectors is set
  # and that iteration count is set to 0 
  def test_initialize_group
  	test_group = ProspectorGroup.new
  	test_group.intialize_group(33, 3)
  	assert_equal 3, test_group.num_prospectors
  	assert_equal 0 , test_group.iteration_count
  end

  # This tests the spawn prospectors method in
  # the ProspectorGroup class. It checks to 
  # make sure that the correct number of prospectors
  # was put into the array
  def test_spawn_prospectors
  	test_group = ProspectorGroup.new
  	assert_equal 12 , test_group.spawn_prospectors(12).size
  end
end