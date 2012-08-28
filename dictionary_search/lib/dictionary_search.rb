class Array2D < Array
  def [](n)
    self[n]=Array.new if super(n)==nil
    super(n)
  end
end

class DictionarySearch
  def initialize(file_path)
    # Build a 2D array of words by placing each of them in the appropriate
    # row based on their length. 
    @words_array = Array2D.new
    
    # We are not handling exceptions deliberately here.      
    file = File.new(file_path, "r")
    
    # ASSUMPTION: We assume that the words list in the file is already sorted.
    while (line = file.gets)
      line = line.rstrip  
      @words_array[line.length] << line
    end
    file.close  
  end

  def word_pairs
    result = Array.new
    
    # The idea is to compare only equal length words by iterating on each row 
    # of the 2D words array. Then pick each word in the column and compare its 
    # substring (minus the last 2 chars) with rest of the words in that row.
    # Since all the words/columns are already sorted inside a row, we can break 
    # out of the comparison loop as soon as we encounter the first word whose 
    # substring doesn't match.    
  
    # Ignoring words with length<=2
    for i in 3..@words_array.length - 1
      equal_length_words_count = @words_array[i].length
      
      # Iterate over all the equal length words except the last one
      for j in 0..equal_length_words_count-2
        
        for k in j+1..equal_length_words_count-1
        
          # Compare substrings (minus the last 2 chars)
          if (@words_array[i][j][0,i-2]==@words_array[i][k][0,i-2])
          
            # Cross-compare the last 2 chars
            if ((@words_array[i][j][i-1].chr==@words_array[i][k][i-2].chr)&&(@words_array[i][j][i-2].chr==@words_array[i][k][i-1].chr))            
              result <<  [@words_array[i][j], @words_array[i][k]] 
            end  
          else
            # Since the word/column list is sorted we can safely break out and 
            # not compare this particular word with rest of the words in this 
            # row
            break                        
          end
        end # iterator k
          
      end # iterator j
    end # iterator i
    
    result    
  end
end
