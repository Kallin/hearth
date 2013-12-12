package org.hearth4j

import com.google.inject.Inject
import com.google.inject.assistedinject.Assisted
import groovy.util.logging.Slf4j

@Slf4j
class CardLibrary {

    @Inject
    CardLibrary(@Assisted Version version, CardLoader cardLoader) {
        List<Card> allCards = cardLoader.load(version)

        allCards.each {
            add(it)
        }
    }

    List<Card> neutralCards = []
    Map<Hero, List<Card>> cardsForHeros = [:]

    List<Card> getAllCardsForHero(Hero hero) {
        List<Card> cardsForHero = cardsForHeros[hero]
        logCardsForHero(hero, cardsForHero)
        cardsForHero
    }

    List<Card> getCardsForHeroExcludingRarity(Hero hero, Rarity rarity) {
        cardsForHeroFind(hero) { it.rarity != rarity }
    }

    List<Card> getCardsForHeroByRarity(Hero hero, Rarity rarity) {
        cardsForHeroFind(hero) { it.rarity == rarity }
    }

    Card getCardByName(String name) {
        def card = neutralCards.find { it.name == name }
        if (!card) {
            for (Hero hero in Hero.values()) {
                card = getAllCardsForHero(hero).find { it.name == name }
                if (card)
                    break
            }
        }

        if (!card)
            throw new IllegalArgumentException("unable to find card by name [$name]")

        card
    }

    private List<Card> cardsForHeroFind(Hero hero, Closure closure) {
        List<Card> cardsForHero = cardsForHeros[hero].findAll closure
        logCardsForHero(hero, cardsForHero)
        cardsForHero
    }

    private void logCardsForHero(Hero hero, List<Card> cardsForHero) {
        log.trace "found these cards for $hero:\n" + cardsForHero.sort { it.name }
    }

    def add(Card card) {
        Hero hero = card.hero
        if (hero) {
            def cards = cardsForHeros[hero]
            if (!cards)
                cardsForHeros[hero] = cards = []
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
        allSpells.sort { it.name }
    }

    def get(Hero hero, String cardName) {
        def card = cardsForHeros[hero].find { it.name == cardName }
        if (!card)
            card = neutralCards.find { it.name == cardName }

        if (!card)
            throw new IllegalArgumentException("unable to find card:[$cardName] for hero:[$hero]")

        card
    }
}
