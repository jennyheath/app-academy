class Hand
  R_FLUSH = 9
  STR_FLUSH = 8
  FOUR_OAK = 7
  FULL = 6
  FLUSH = 5
  STR = 4
  THREE_OAK = 3
  TWO_PAIR = 2
  PAIR = 1

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

  def tie_breaker(hand1, hand2, category)
    #two hands of same category
  end

  def card_v_s
    card_vals = []
    @cards.each do |card|
      card_vals << card.value_suit
    end

    card_vals
  end

  def card_values
    card_v_s.map {|(v, s)| v }
  end

  def card_suits
    card_v_s.map {|(v, s)| s }
  end

  def royal_flush?
    straight_flush? && (card_values.inject(:+) == 60)
  end

  def straight_flush?
    straight? && flush?
  end

  def four_kind?
  end

  def full_house?
  end

  def straight?
    # card_values.sort
  end

  def three_kind?
  end

  def two_pair?
  end

  def one_pair?
  end

end
