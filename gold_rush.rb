require_relative 'prospector_group.rb'

# if the wrong arguments are given, show them how its done
def show_usage_and_exit
  puts 'Usage:' , 'ruby gold_rush.rb *seed* *num_prosectors*','*seed* should be an integer','*num_prosectors* should be a positive integer'
  exit 1
end

# Returns true if and only if:
# 1. There is two and only two arguments
# 2. The arguments, when converted to an integer, is nonnegative
# Returns false otherwise

def check_args(args)
  args.count == 2
  ARGV[1].to_i > 0
rescue StandardError
  false
end

# EXECUTION STARTS HERE

# Verify that the arguments are valid

valid_args = check_args ARGV

# If arguments are valid, create a new game
# Otherwise, show proper usage message and exit program

if valid_args
  new_seed = ARGV[0].to_i
  num_prosectors = ARGV[1].to_i
  g = ProspectorGroup.new
  g.intialize_group(new_seed, num_prosectors)
  g.play
else
  show_usage_and_exit
end