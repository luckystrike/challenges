class Polynomial
  def initialize(elements=[])
    raise ArgumentError.new("Two or more coefficients are required") if elements.length < 2
    @elements = elements
  end

  def to_s
    result = ""
    power = @elements.length - 1
    @elements.each do |coefficient|
      case
        when power > 1
          term = "x^" + power.to_s
        when power == 1
          term = "x"
        else     
          term = ""
      end
    
      power = power - 1     
      
      case 
        when coefficient == 0 
          next
        when coefficient == 1
          # Never show 1 as a coefficient and no '+' sign if this is the first
          # term of the polynomial      
          term = (result.empty?)?(term):("+" + term)
        when coefficient > 1
          # Don't show the '+' sign if this is the first term of the polynomial 
          term = (result.empty?)?(coefficient.to_s + term):("+" + coefficient.to_s + term)
        when coefficient == -1  
          term = "-" + term
        else 
          term = coefficient.to_s + term        
      end     
      result = result + term      
    end
    (result.empty?)?"0":result
  end
  
end
