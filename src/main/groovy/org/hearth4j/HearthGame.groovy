package org.hearth4j

import javax.inject.Inject
import java.security.SecureRandom

class HearthGame {

    @Inject
    CardLibraryFactory cardLibraryFactory

    CardLibrary cardLibrary

    Player currentPlayer
    Player otherPlayer

    def begin() {
        cardLibrary = cardLibraryFactory.make(new Version(Version.V1))

        chooseStartingPlayer()
        bothPlayers.each { player ->
            Collections.shuffle(player.deck.cards)
        }

        otherPlayer.hand.add(cardLibrary.getCardByName('The Coin'))

        3.times {
            bothPlayers*.draw()
        }
    }

    def chooseStartingPlayer() {
        if (new SecureRandom().nextBoolean())
            switchPlayers()
    }

    List<Player> getBothPlayers() {
        [currentPlayer, otherPlayer]
    }

    private void switchPlayers() {
        def tempPlayer = currentPlayer
        currentPlayer = otherPlayer
        otherPlayer = tempPlayer
    }
}
