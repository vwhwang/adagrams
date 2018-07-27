def draw_letters
  letter_pool_array = [
    "A", "A", "A", "A", "A", "A", "A", "A", "A",
    "B", "B",
    "C", "C",
    "D", "D", "D", "D",
    "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E", "E",
    "F", "F",
    "G", "G", "G",
    "H", "H",
    "I", "I", "I", "I", "I", "I", "I", "I", "I",
    "J", "K",
    "L", "L", "L", "L",
    "M", "M",
    "N", "N", "N", "N", "N", "N",
    "O", "O", "O", "O", "O", "O", "O", "O",
    "P", "P", "Q",
    "R", "R", "R", "R", "R", "R",
    "S", "S", "S", "S",
    "T", "T", "T", "T", "T", "T",
    "U", "U", "U", "U",
    "V", "V",
    "W", "W",
    "X", "Y", "Y", "Z"
  ]
  drawn_letters = []
  10.times do |letter|
    drawn_letters << letter_pool_array.shuffle.pop
  end
  drawn_letters
end

def uses_available_letters? input, letters_in_hand
  input_array = input.upcase.split('')
  letter_hash = {}

  letters_in_hand.each do |letter|
    letter_hash[letter] = letter_hash[letter] ? letter_hash[letter] + 1 : 1
  end

  input_array.each do |letter|
    if letter_hash[letter]
      if letter_hash[letter] < 1
        return false
      else
        letter_hash[letter] -= 1
      end
    else
      return false
    end
  end

  true
end

def score_word input
  letter_scores = {
      "A"=>1,
      "E"=>1,
      "I"=>1,
      "O"=>1,
      "U"=>1,
      "L"=>1,
      "N"=>1,
      "R"=>1,
      "S"=>1,
      "T"=>1,
      "D"=>2,
      "G"=>2,
      "B"=>3,
      "C"=>3,
      "M"=>3,
      "P"=>3,
      "F"=>4,
      "H"=>4,
      "V"=>4,
      "W"=>4,
      "Y"=>4,
      "K"=>5,
      "J"=>8,
      "X"=>8,
      "Q"=>10,
      "Z"=>10
    }

  total_score = 0

  letters = input.upcase.split('')

  letters.each do |letter|
    total_score += letter_scores[letter]
  end

  total_score += letters.length > 6 ? 8 : 0

  total_score
end

def break_tie(incumbent, challenger)
  if incumbent[:word].length == 10
    return incumbent
  elsif challenger[:word].length == 10
    return challenger
  elsif challenger[:word].length < incumbent[:word].length
    return challenger
  else
    return incumbent
  end
end

def highest_score_from words
  score_hashes = words.map do |word|
    {
      :word => word,
      :score => score_word(word)
    }
  end

  winning_hash = score_hashes.first

  score_hashes.each do |current_hash|
    if current_hash[:score] > winning_hash[:score]
      winning_hash = current_hash
    elsif current_hash[:score] == winning_hash[:score]
      winning_hash = break_tie(winning_hash, current_hash)
    end
  end

  return winning_hash
end
