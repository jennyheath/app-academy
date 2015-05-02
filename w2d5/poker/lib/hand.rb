class Hand

  def initialize(cards)
    @cards = cards
  end

  def cards
    @cards
  end

  def better_than?(second_hand)

    # extract card values and suits using constants in card - make method in card
    # my_best_hand on both hands
    #
    # use heirarchy
    # {:royal_flush => 10, :straigh_flush => 9}
    # if tied, send to tie breaker method

  end

  def my_best_hand
    #[[value, suit], [value, suit], [value, suit]]
    # :royal_flush
    #
  end

  def tie_breaker(hand1, hand2)
    #two hands of same category
  end
end
