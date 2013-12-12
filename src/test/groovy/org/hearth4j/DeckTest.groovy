package org.hearth4j

import static org.hearth4j.IllegalDeckCause.*

class DeckTest extends LibraryBasedTest {

    def 'can load simple deck'() {
        when:
        def simpleDeck = getDeckByFilename('simple_hunter.dek')

        then:
        simpleDeck.cards.size() == Deck.DECK_SIZE
    }

    def 'incorrectly sized decks fails'() {
        when:
        getDeckByFilename('illegal_too_small.dek')

        then:
        IllegalDeckException tooSmallException = thrown()
        tooSmallException.illegalDeckCause == TOO_SMALL

        when:
        getDeckByFilename('illegal_too_big.dek')

        then:
        IllegalDeckException tooBigException = thrown()
        tooBigException.illegalDeckCause == TOO_BIG
    }

    def 'decks can only contain up to 2 of any non-legendary card'() {
        when:
        getDeckByFilename('illegal_three_of_a_kind.dek')

        then:
        IllegalDeckException exception = thrown()
        exception.illegalDeckCause == TOO_MANY_OF_TYPE
    }

    def 'decks can only contain 1 of each legendary card'() {
        when:
        getDeckByFilename('illegal_legendaries.dek')

        then:
        IllegalDeckException exception = thrown()
        exception.illegalDeckCause == TOO_MANY_LEGENDARIES
    }

    def 'decks must only use non-neutral cards from their own hero'() {
        when:
        getDeckByFilename('illegal_hunter_using_mage_card.dek')

        then:
        thrown(RuntimeException)
    }

    def 'decks must use known cards'() {
        when:
        getDeckByFilename('illegal_fake_card.dek')

        then:
        thrown(RuntimeException)
    }

    private Deck getDeckByFilename(String fileName) {
        DeckFactory.make(this.getClass().getResourceAsStream("/org/hearth4j/deck/$fileName").text, cardLibrary)
    }

}
