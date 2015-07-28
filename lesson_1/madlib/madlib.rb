# madlib.rb

# methods
#################################

def print_bad_file(file_name)
  puts "#{file_name} missing or file not valid. Program exiting..."
end

def bad_file?(file_name)
  file_name.empty? || !File.file?(file_name)
end

def read_helper_file(file_name)
  if bad_file?(file_name)
    print_bad_file(file_name)
    exit
  end
  File.open(file_name, "r") do |file|
    file.read.split
  end
end

def read_story_file(file_name)
  if bad_file?(file_name)
    print_bad_file(file_name)
    exit
  end
  File.open(file_name, "r") do |file| 
    file.read
  end
end

# load files
#################################

story = read_story_file(ARGV[0])
heroes = read_helper_file("heroes.txt")
monsters = read_helper_file("monsters.txt")
adjectives = read_helper_file("adjectives.txt")
verbs = read_helper_file("verbs.txt")

