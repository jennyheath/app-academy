class Card
  attr_reader :value, :suit

  FACE_CARD_VALUES = {
    # :two => 2,
    # :three => 3,
    # :four => 4,
    # :five => 5,
    # :six => 6,
    # :seven => 7,
    # :eight => 8,
    # :nine => 9,
    # :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13,
    :ace => 14
  }

  CARD_SUITS = {
    :spade => "S",
    :diamond => "D",
    :heart => "H",
    :club => "C"
  }

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def values
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].concat(FACE_CARD_VALUES.keys)
  end

  def suits
    CARD_SUITS.keys
  end
end
