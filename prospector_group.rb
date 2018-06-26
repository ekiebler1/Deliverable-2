require_relative 'prospector'
# This is the class for the group of prospectors. Given a seed and a 
# number of prospectors it runs the game for that many prospectors
class ProspectorGroup

  attr_accessor :prospectors
  attr_accessor :iteration_count
  attr_accessor :num_prospectors

  # This is the set up method for this class. It seeds the random number
  # generator, spawns and intializes the group of prospectors, and sets 
  # the iteration counter to 0
  def intialize_group(seed, num_prospectors)
    srand(seed)
    @iteration_count = 0
    @num_prospectors = num_prospectors
  end

  # This is the method that actually spawns and intializes the prospectors.
  # It create the group of prospectors based off the given size and then 
  # calls the initialize method on all of them, setting them at the start of 
  # the game.
  def spawn_prospectors(num_prospectors)
    prospectors = []
    count = 0
    while count <= num_prospectors - 1
      prospectors[count] = Prospector.new
  	  prospectors[count].intialize
	  count += 1
    end
    prospectors
  end

  # This is were the actual magic happens. Prospector by Prospector, they
  # each run through the simulation, calling the iterate method, allowing each 
  # 5 moves, and then returning to San Fran.
  def iterate_all
	count = 0
	while count < @num_prospectors
	  puts 'Prospector ' + String(count + 1) + ' starting at Sutter Creek.'
	  prospectors[count].iterate
	  puts ' '
	  count += 1
	end
  end

  # This is the function the starter ruby file calls to play the game.
  # It spawns the prospectors and then runs through the game with each
  def play
  	@prospectors = spawn_prospectors(@num_prospectors)
	iterate_all
	exit 1
  end
end