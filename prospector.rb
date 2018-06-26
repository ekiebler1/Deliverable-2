# the main class for the prospector object
class Prospector

  attr_accessor :current_gold
  attr_accessor :current_silver
  attr_accessor :total_gold
  attr_accessor :total_silver
  attr_accessor :current_location
  attr_accessor :previous_location
  attr_accessor :move_count
  attr_accessor :num_days

  # This method intializes all the prospectors variable
  # all mineral counts are set to 0
  # the locations are set to nil for previous and current to 
  # sutter creek for the start of the game
  # the number of days and move count are also set to 0 
  # because nothing has happened yet
  def intialize
    @current_gold = 0
  	@current_silver = 0
  	@total_gold = 0
  	@total_silver = 0
  	@current_location = 'Sutter Creek'
  	@previous_location = nil
  	@move_count = 0
  	@num_days = 0
  end

  # This method that assigns the values of gold and silver given based off current_location
  # and then displays how much of each was found.
  # The amount of each is given as follows:
  # Location     | Max Silver | Max Gold
  # ------------------------------------
  # Sutter Creek |    0       |    2
  # Coloma       |    0       |    3
  # Angels Camp  |    0       |    4
  # Nevada City  |    0       |    5
  # Virginia City|    3       |    3
  # Midas        |    5       |    0
  # El Dorado Cn |   10       |    0
  # ------------------------------------
  def mine
  	case @current_location
	when 'Sutter Creek'
	  sutter_creek_mine
	when 'Coloma'
	  coloma_mine
	when 'Angels Camp'
	  angels_camp_mine
	when 'Nevada City'
	  nevada_city_mine
	when 'Virginia City'
	  virginia_city_mine
	when 'Midas'
	  midas_mine
	when 'El Dorado Canyon'
	  el_dorado_cn_mine
	end
	display_current_spoils
  end

  # This method determines where a prospector moves to based of current_location
  # and then shows where they were and where they are going
  # The moves are based off the following:
  # Nevada City
  #  \
  #   \
  #  Angels Camp
  #    |     \            /---------- Midas
  #    |     Virginia City              |
  #    |            |    \              |
  #    |            |     \---------- El Dorado Canyon
  #    |            |
  #    |            |
  #Sutter Creek - Coloma
  def move
  	@previous_location = @current_location
	case @current_location
	when 'Sutter Creek'
	  @current_location = sutter_creek_move
	when 'Coloma'
	  @current_location = coloma_move
	when 'Angels Camp'
	  @current_location = angels_camp_move
	when 'Nevada City'
	  @current_location = nevada_city_move
	when 'Virginia City'
	  @current_location = virginia_city_move
	when 'Midas'
	  @current_location = midas_move
	when 'El Dorado Canyon'
	  @current_location = el_dorado_cn_move
	end
	puts 'Moving from ' + String(@previous_location) + ' to ' + String(@current_location) + ', carrying ' + String(@total_gold) + ounce_v_ounces(@total_gold) + ' of gold and ' + String(@total_silver) + ounce_v_ounces(@total_silver) + ' of silver.'
	@move_count += 1
  end

  # This is the main method that preforms the game for the prospector.
  # It preforms the mining and moving of the prospector and then
  # once the game is over shows how the prospector did
  def iterate
  	loop do	
  		mine
  		if move?
  			move
  		end
  		@num_days += 1
  		break if end?
  	end
  	display_end_message
  end

  # Displays the metals the prospector found each iteration
  def display_current_spoils
  	if @current_silver == 0 && @current_gold == 0
	  puts 'No Precious Metals Found at ' + String(@current_location)
	else
	  if @current_silver != 0
	    puts 'Found ' + String(@current_silver) + ounce_v_ounces(@current_silver) + ' of silver in ' + String(@current_location) 
	  end
	  if @current_gold != 0
	    puts 'Found ' + String(@current_gold) + ounce_v_ounces(@current_gold) + ' of gold in ' + String(@current_location)
	  end
	end
  end

  # Displays ounces or ounce based off the given amount of a mineral
  # 1 = ounce
  # anything else = ounces
  def ounce_v_ounces mineral
	if mineral == 1
	  ' ounce'
	else 
	  ' ounces'
	end
  end

  # Checks if the prospector should move. If they have moved 3 or less times
  # they move if they find neither gold or silver. If they have moved more than
  # 3 times, they move if they find 2 or less gold and 3 or less silver 
  def move?
  	if @move_count < 3
	  if @current_gold == 0 && @current_silver == 0
	    true
	  else
	  	false
	  end
	else
	  if @current_gold < 2 && @current_silver < 3
	  	true
	  else
		false
	  end
	end
  end

  # Checks if the game keeps going. If the move count is 5 it returns false
  def end?
  	if @move_count < 4
  	  false
  	else
	  true
	end
  end

  # Adds the current gold and current silver to the total gold and total silver
  def add_to_bag
	@total_gold += @current_gold
	@total_silver += @current_silver
  end

  # Displays the end message of the game. It says how many days the prospector lasted,
  # how much gold and silver they found, and the amount of $$ that gold and silver is worth
  def display_end_message
    puts 'After ' + String(@num_days) + ' days, the Prospector returns to San Fransisco with:'
	puts String(@total_gold) + String(ounce_v_ounces(@total_gold)) + ' of gold.'
	puts String(@total_silver) + String(ounce_v_ounces(@total_silver)) + ' of silver.'
	puts 'Heading home with $' + calc_total + '.'
  end

  # Calculates the amount of $$ a prospector earns based off the amount of gold and silver.
  def calc_total
    String((@total_gold * 20.67 + @total_silver * 1.31).round(2))
  end

  # These are the different random mining methods, the amount of minerals recieved is
  # determined by location: each on is said on the chart above the mine method
  def sutter_creek_mine
	@current_gold = rand(3)
	@current_silver = 0
	add_to_bag
  end

  def coloma_mine
	@current_gold = rand(4)
	@current_silver = 0
	add_to_bag
  end

  def angels_camp_mine
	@current_gold = rand(5)
	@current_silver = 0
	add_to_bag
  end

  def nevada_city_mine
	@current_gold = rand(6)
	@current_silver = 0
	add_to_bag
  end

  def virginia_city_mine
	@current_gold = rand(4)
	@current_silver = rand(4)
	add_to_bag
  end

  def midas_mine
	@current_gold = 0
	@current_silver = rand(6)
	add_to_bag
  end

  def el_dorado_cn_mine
	@current_gold = 0
	@current_silver = rand(11)
	add_to_bag
  end

  # These are the methods that determine where a prospector will move based on current location
  # the choices of where based on each location are shown above the move method 
  def sutter_creek_move
	case rand(2)
	when 0
	  'Coloma'
	when 1
	  'Angels Camp'
	end
  end

  def coloma_move
	case rand(2)
	when 0
	  'Virginia City'
	when 1
	  'Sutter Creek'
	end
  end

  def angels_camp_move
	case rand(3)
	when 0
	  'Sutter Creek'
	when 1
	  'Nevada City'
	when 2
	  'Virginia City'
	end
  end

  def nevada_city_move
	'Angels Camp'
  end

  def virginia_city_move
	case rand(4)
	when 0
	  'Coloma'
	when 1
	  'Angels Camp'
	when 2
	  'Midas'
	when 3
	  'El Dorado Canyon'
	end
  end

  def midas_move
	case rand(2)
	when 0
	  'Virginia City'
	when 1
	  'El Dorado Canyon'
	end
  end

  def el_dorado_cn_move
	case rand(2)
	when 0
	  'Virginia City'
	when 1
	  'Midas'
	end
  end
end