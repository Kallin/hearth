package org.hearth4j

class Player {

    public static final int MAXIMUM_BOARD_SIZE = 7
    public static final int MAXIMUM_HAND_SIZE = 10
    public static final int MAXIMUM_MANA_CRYSTALS = 10

    Deck deck

    List<Card> hand = []
    List<Card> discardPile = []
    List<Card> playedCards = []
    Card heroCard
    Card abilityCard

    int currentMana
    int manaCrystals

// whats the model look like here ?
    /*

    does the player encapsulate the board? perhaps that's fine for now.
     */

    def draw() {
        hand.add deck.cards.pop()
    }
}
