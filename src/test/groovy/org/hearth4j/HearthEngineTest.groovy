package org.hearth4j

import javax.inject.Inject

class HearthEngineTest extends LibraryBasedTest {

    @Inject
    HearthGame hearthGame

    def 'players have the correct # of cards after the mulligan stage'() {
        when:

        def player1 = new Player(deck: simpleDeck)
        def player2 = new Player(deck: simpleDeck)

        hearthGame.currentPlayer = player1
        hearthGame.otherPlayer = player2
        hearthGame.begin()

        then:

        hearthGame.currentPlayer.hand.size() == 3
        hearthGame.otherPlayer.hand.size() == 4
        hearthGame.otherPlayer.hand.find { it.name == 'The Coin' }
    }

    Deck getSimpleDeck() {
        DeckFactory.make(this.getClass().getResourceAsStream('/org/hearth4j/deck/simple_hunter.dek').text, cardLibrary)
    }

}
