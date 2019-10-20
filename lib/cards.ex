defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles a deck of playing cards
    The `deck` argument is a list of strings representing a deck of playing cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Checks if a card exists in a provided deck.
    The `deck` argument is a list of strings representing a deck of playing cards.
    the `card` argument is a string representing a playing card.

    ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Two of Diamonds")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `deck` argument is a list of strings representing a deck of playing cards.
    The `hand_size` argument indicates how many cards should be in the hand.

    ## Examples

      iex> deck = Cards.create_deck
      iex> { hand, deck } = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    { hand, rest_of_deck }  = Enum.split(deck, hand_size)
  end

  @doc """
    Saves a deck to the filesystem.
    The `deck` argument is a list of strings representing a deck of playing cards.
    The `filename` argument is a string representing the filename.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck from the filesystem.
    The `filename` argument is a string representing the filename.
  """
  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term binary
      { :error, _reason } -> "That file does not exist"
    end
  end

  @doc """
    Creates a hand, which is a list cards
    The `hand_size` argument is a number representing the number of cards you wish to return in the string.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
