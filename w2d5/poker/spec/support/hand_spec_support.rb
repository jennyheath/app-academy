def generate_hand(cards_string) # '5h 6d '
  SUITS = {
    "h" => :heart,
    "c" => :club,
    "d" => :diamond,
    "s" => :spade
  }

  FACE_CARDS = {
    "k" => 13,
    "q" => 12,
    "j" => 11,
    "a" => 14
  }
  cards = cards_string.split(" ")
  card_objects = []

  cards.each do |card|
    value, suit = card.split("")
    if FACE_CARDS.include?(value)
      value = FACE_CARDS[value]
    else
      value = value.to_i
    end

    card_objects << double('card', value: value, suit: SUITS[suit])
  end

  Hand.new(card_objects)
end
