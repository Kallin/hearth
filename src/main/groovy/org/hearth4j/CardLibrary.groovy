package org.hearth4j

import groovy.util.logging.Slf4j

@Slf4j
class CardLibrary {

    List<Card> neutralCards = new LinkedList<Card>();
    Map<Hero, List<Card>> cardsForHeros = new LinkedHashMap<Hero, List<Card>>()

    List<Card> getAllCardsForHero(Hero hero) {
        List<Card> cardsForHero = cardsForHeros[hero]
        logCardsForHero(hero, cardsForHero)
        return cardsForHero
    }

    List<Card> getCardsForHeroExcludingRarity(Hero hero, Rarity rarity) {
        return cardsForHeroFind(hero) { it.rarity != rarity }
    }

    List<Card> getCardsForHeroByRarity(Hero hero, Rarity rarity) {
        return cardsForHeroFind(hero) { it.rarity == rarity }
    }

    private List<Card> cardsForHeroFind(Hero hero, Closure closure) {
        List<Card> cardsForHero = cardsForHeros[hero].findAll closure
        logCardsForHero(hero, cardsForHero)
        return cardsForHero
    }

    private void logCardsForHero(Hero hero, List<Card> cardsForHero) {
        log.trace("found these cards for $hero:\n${cardsForHero.sort { it.name }}")
    }

    def add(Card card) {
        Hero hero = card.hero
        if (hero) {
            final cards = cardsForHeros[hero]
            if (!cards)
                cardsForHeros[hero] = cards = new LinkedList<Card>()
            cards << card
        } else {
            neutralCards << card
        }
    }

    List<Card> getAllCards() {
        def allSpells = []
        cardsForHeros.values().each {
            allSpells.addAll(it)
        }
        allSpells.addAll(neutralCards)
        return allSpells.sort { it.name }
    }

    def get(Hero hero, String cardName) {
        def card = cardsForHeros[hero].find { it.name == cardName }
        if (!card)
            card = neutralCards.find { it.name == cardName }

        if (!card)
            throw new RuntimeException("unable to find card:[$cardName] for hero:[$hero]")

        return card
    }
}
