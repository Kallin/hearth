package org.hearth4j

import static org.hearth4j.IllegalDeckCause.*

class DeckTest extends LibraryBasedTest {

    def 'can load simple deck'() {
        when:
        def simpleDeck = buildDeckFromFile("simple_hunter.dek")

        then:
        simpleDeck.cards.size() == 30
    }

    def 'incorrectly sized decks fails'() {
        when:
        buildDeckFromFile("illegal_too_small.dek")

        then:
        IllegalDeckException tooSmallException = thrown()
        tooSmallException.illegalDeckCause == TOO_SMALL

        when:
        buildDeckFromFile("illegal_too_big.dek")

        then:
        final IllegalDeckException tooBigException = thrown()
        tooBigException.illegalDeckCause == TOO_BIG
    }

    def 'decks can only contain up to 2 of any non-legendary card'() {
        when:
        buildDeckFromFile("illegal_three_of_a_kind.dek")

        then:
        final IllegalDeckException exception = thrown()
        exception.illegalDeckCause == TOO_MANY_OF_TYPE
    }

    def 'decks can only contain 1 of each legendary card'() {
        when:
        buildDeckFromFile("illegal_legendaries.dek")

        then:
        final IllegalDeckException exception = thrown()
        exception.illegalDeckCause == TOO_MANY_LEGENDARIES
    }

    def 'decks must only use non-neutral cards from their own hero'() {
        when:
        buildDeckFromFile("illegal_hunter_using_mage_card.dek")

        then:
        thrown(RuntimeException)
    }

    def 'decks must use known cards'() {
        when:
        buildDeckFromFile("illegal_fake_card.dek")

        then:
        thrown(RuntimeException)
    }

    private Deck buildDeckFromFile(String fileName) {
        return Deck.build(this.getClass().getResourceAsStream("/org/hearth4j/deck/$fileName").text, cardLibrary)
    }

}
