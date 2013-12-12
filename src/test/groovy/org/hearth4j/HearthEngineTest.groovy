package org.hearth4j

import com.google.inject.Guice
import com.google.inject.Injector
import org.hearth4j.guice.HearthModule

import javax.inject.Inject

class HearthEngineTest extends LibraryBasedTest {

    @Inject
    DeckFactory deckFactory

    def 'players have the correct # of cards after the mulligan stage'() {
        when:

        def player1 = new Player(deck: simpleDeck)
        def player2 = new Player(deck: simpleDeck)

        Injector injector = Guice.createInjector(new HearthModule())
        def game = injector.getInstance(HearthGame)

        game.currentPlayer = player1
        game.otherPlayer = player2
        game.begin()

        then:

        game.currentPlayer.hand.size() == 3
        game.otherPlayer.hand.size() == 4
        game.otherPlayer.hand.find { it.name == 'The Coin' }
    }

    Deck getSimpleDeck() {
        DeckFactory.make(this.getClass().getResourceAsStream('/org/hearth4j/deck/simple_hunter.dek').text, cardLibrary)
    }

}
