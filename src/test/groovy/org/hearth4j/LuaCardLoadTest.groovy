package org.hearth4j

import groovy.util.logging.Slf4j
import spock.lang.Ignore

@Slf4j
class LuaCardLoadTest extends LibraryBasedTest {

    def 'all cards are unique'() {
        def uniqueCards = cardLibrary.allCards.unique { it.name }

        expect:
        (cardLibrary.allCards - uniqueCards).isEmpty()
    }

    def 'the total # of cards is correct'() {
        expect:
        cardLibrary.allCards.findAll { it.rarity != Rarity.UNCOLLECTIBLE }.size() == 381
    }

    def 'the # of collectible cards per hero is correct'() {
        expect:
        Hero.values().each { Hero hero ->
            assert cardLibrary.getCardsForHeroExcludingRarity(hero, Rarity.UNCOLLECTIBLE).size() == 25
        }
    }

    def 'the # of cards by rarity per hero is correct'() {
        expect:
        Hero.values().each { Hero hero ->
            assert cardLibrary.getCardsForHeroByRarity(hero, Rarity.LEGENDARY).size() == 1
            assert cardLibrary.getCardsForHeroByRarity(hero, Rarity.EPIC).size() == 3
            assert cardLibrary.getCardsForHeroByRarity(hero, Rarity.RARE).size() == 5
            assert cardLibrary.getCardsForHeroByRarity(hero, Rarity.COMMON).size() == 6
            assert cardLibrary.getCardsForHeroByRarity(hero, Rarity.BASIC).size() == 10
        }
    }

    def 'the # of cards by rarity for neutrals are correct'() {
        expect:
        assert cardLibrary.neutralCards.findAll { it.rarity == Rarity.LEGENDARY }.size() == 26
        assert cardLibrary.neutralCards.findAll { it.rarity == Rarity.EPIC }.size() == 11
        assert cardLibrary.neutralCards.findAll { it.rarity == Rarity.RARE }.size() == 36
        assert cardLibrary.neutralCards.findAll { it.rarity == Rarity.COMMON }.size() == 40
        assert cardLibrary.neutralCards.findAll { it.rarity == Rarity.BASIC }.size() == 43
    }

    def 'the total # of cards per rarity is correct'() {
        expect:

        cardLibrary.allCards.findAll { it.rarity == Rarity.LEGENDARY }.size() == 35
        cardLibrary.allCards.findAll { it.rarity == Rarity.EPIC }.size() == 38
        cardLibrary.allCards.findAll { it.rarity == Rarity.RARE }.size() == 81
        cardLibrary.allCards.findAll { it.rarity == Rarity.COMMON }.size() == 94 // on hearthhead, this is free or common cards in the expert set (not actually any free cards in the expert set)
        cardLibrary.allCards.findAll { it.rarity == Rarity.BASIC }.size() == 133 // on hearthhead, this is free or common cards in the basic set
    }

    def 'the # of neutral cards is correct'() {
        expect:
        cardLibrary.neutralCards.findAll { it.rarity != Rarity.UNCOLLECTIBLE }.size() == 156
    }

    @Ignore
    def 'there are no broken cards present'() {
        expect:
        cardLibrary.allCards.findAll { it.broken }.isEmpty()
    }

}
