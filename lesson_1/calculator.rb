# calculator.rb

# a method to test if a value is a number
def is_number?(num)
  true if Float(num) rescue false
end

# a method that retrieves a number from the user
def get_number
  loop do
    print "Enter a number: "
    num = gets.chomp
    if is_number?(num)
      return num
    end
    puts "Please enter a valid number!"
  end
end

num1 = get_number
num2 = get_number
operator = ""

loop do
  puts "What operation would you like to perform?"
  print "Choose from (+)(-)(*)(/): "
  operator = gets.chomp
  if operator == "+" || operator == "-" || operator == "*" || operator == "/"
    break
  elsif 
    puts "Please enter a valid operator!"
  end
end

case
when operator == "+"
  print "The result is: "
  puts num1.to_i + num2.to_i
when operator == "-"
  print "The result is: "
  puts num1.to_i - num2.to_i
when operator == "*"
  print "The result is: "
  puts num1.to_i * num2.to_i
when operator == "/"
  print "The result is: "
  puts num1.to_f / num2.to_f
end