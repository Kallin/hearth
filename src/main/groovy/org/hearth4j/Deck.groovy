package org.hearth4j

import static org.hearth4j.IllegalDeckCause.*

class Deck {

    public final static int DECK_SIZE = 30

    Hero hero
    List<Card> cards

}

class DeckFactory {

    static Deck make(String dekDefinition, CardLibrary cardLibrary) {


        def lines = dekDefinition.readLines()

        Hero hero = Hero.valueOf(lines[0].toUpperCase())

        List<Card> cards = []
        lines[1..-1].each {
            def (count, name) = it.split(' x ')
            def card = cardLibrary.get(hero, name)

            (count as int).times {
                cards.add(card)
            }
        }

        if (cards.size() > Deck.DECK_SIZE)
            throw new IllegalDeckException(TOO_BIG, cards)

        if (cards.size() < Deck.DECK_SIZE)
            throw new IllegalDeckException(TOO_SMALL, cards)

        if (cards.findAll { it.rarity == Rarity.LEGENDARY }.groupBy { it.name }.find { it.value.size() > 1 })
            throw new IllegalDeckException(TOO_MANY_LEGENDARIES, cards)

        if (cards.groupBy { it.name }.find { it.value.size() > 2 })
            throw new IllegalDeckException(TOO_MANY_OF_TYPE, cards)

        if (cards.find { it.hero && it.hero != hero })
            throw new IllegalDeckException(WRONG_HERO, cards)

        new Deck(cards: cards, hero: hero)
    }

}

