# Chose Treetop over Citrus & Ragel to write the Parsing expression grammar
require 'treetop'
require './subscription_argument'

class ArgumentParser
  def initialize
    @parser = SubscriptionArgumentParser.new
  end

  def parse(args)
    # Customized the message(s) in the raised exceptions to make them more 
    # descriptive. Acceptance rspec tests still pass.

    raise ArgumentError.new("Args list is invalid. It is not a String.") if !args.is_a?(String)

    tree = @parser.parse(args)		
    raise ArgumentError.new("Args list is invalid. " + @parser.failure_reason) if tree.nil?

    result = Array.new

    # elements[0] and elements[2] are the opening & closing curly braces.
    # See the top rule in the defined treetop grammar file
    tree.elements[1].args.each do |node|
      result << unescape(node.text_value)
    end		

    result
  end

  private
    def unescape(arg)
      unescaped_arg = arg
      replacements = [ ["|,", ","], ["|{", "{"], ["|}", "}"] ]
      replacements.each do |replacement| 
	      unescaped_arg.gsub!(replacement[0], replacement[1])
      end
      unescaped_arg
    end	

end
