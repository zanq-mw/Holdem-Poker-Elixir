# Holdem Poker Elixir

Holdem Poker Elixir is a program used to decide the winner of a round of poker between 2 players. It assesses each players hands, compares the two hands, and outputs the winning hand, using Holdem Poker rules.

## Input
The input of the program is a list of nine integers corresponding to the 2-card hands of each player and the 5-card shared pool. The integers in the list are in order of how they are dealt out in a poker game, so the first integer corresponds to the first card of player 1, then first card of player 2, second card of player 1, second card of player 2, and the last 5 correspond to the shared pool.

The integer used to represent each card is its number in order of a 52 card deck organized ascendingly.

![Poker cards](./poker-cards.png?raw=true)

Each player's full hand consists of their 2 cards and the 5 card pool. For example, an input like this
```
[ 11, 2, 3, 4, 8, 39, 20, 45, 49 ]
```
corresponds to the following 2 hands (represented as lists)
```
[ 11, 3, 8, 39, 20, 45, 49 ]
[ 2, 4, 8, 39, 20, 45, 49 ]
```

The deal function serves as the main function of this program. It takes in the input, separates it into 2 hands, converts the integers into strings that represent the cards (For example, since 2 is the 2 of clubs, it converts it to '2C'), assesses and compares the hands, and finally outputs the winning hand. 

## Comparing Hands
The program assess the hands by checking the is they meet any of the poker rankings. A higher ranking is rarer and thus holds more value. If there is a tie, meaning each hand has the same ranking, the program compares the kicker of each hand (the next highest card in each hand) and whichever one has a higher kicker wins the round.

The ranking are as follows, in ascending order:
1. **High Card (Lowest value)** - When you have no card combinations, the highest card value in your hand. Aces are high in Poker.
2. **One pair** - Two cards of the same value.
3. **Two pair** - Two pairs of different card values.
4. **Three-of-a-Kind** - Three cards of the same value.
5. **Straight** - Five cards in order, such as 6♠-7♡-8♢-9♠-10♣. The suits do not match.
6. **Flush** - Five cards of the same suite. The value of the Flush is determined by the highest card in it. For example, a Flush with a King as the highest value card would beat a Flush with a Queen as the highest value card.
7. **Full House** - Three cards of one value, and two cards of another value. Full houses are consider "____ full of ____" where the first blank is the set of three and the second blank is the pair. For example, a full house 9♡-9♣-9♠-5♡-5♢ would be called "nines full of fives".

    The best full house that is possible is A♡-A♢-A♣-K♠-K♡. Suits do not matter.

    When comparing a full house to another full house, the set of three is compared first. If both players have the same set of three, then the pairs are compared. If the pairs match as well, then it is a tie.
8. **Four-of-a-kind** - Four cards of the same value.
9. **Straight Flush** - A straight flush is when a straight is made up of cards of the same suit, such as 6♡-7♡-8♡-9♡-10♡.
10. **Royal Flush (Highest Value)** - A royal flush is actually just a straight flush of the cards 10♢-J♢-Q♢-K♢-A♢. Suit does not matter.

## How To Run
In the main.exs file, edit the bottom line to input the cards to be assessed using the deal function.
```
IO.inspect(Poker.deal [ 11, 2, 3, 4, 8, 39, 20, 45, 49 ])
```
Execute the file to get the winning hand
```
> run-project
["13H", "11C"]
```
