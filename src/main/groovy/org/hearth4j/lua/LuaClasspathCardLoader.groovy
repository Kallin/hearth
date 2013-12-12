package org.hearth4j.lua

import groovy.util.logging.Slf4j
import org.hearth4j.*

import javax.script.ScriptEngine
import javax.script.ScriptEngineManager

@Slf4j
@SuppressWarnings('FactoryMethodName')
@SuppressWarnings('FactoryMethodName')
class LuaClasspathCardLoader implements CardLoader {

    // the card library is populated via lua calls to static methods on this class
    private static List<Card> allCards

    @Override
    List<Card> load(Version version) {

        log.info "providing cards for $version.version"

        def luaRoot = '/org/hearth4j/lua'

        List<String> luaPaths = [
                "$luaRoot/init.lua",
                "$luaRoot/neutral.lua",
                "$luaRoot/druid.lua",
                "$luaRoot/hunter.lua",
                "$luaRoot/mage.lua",
                "$luaRoot/paladin.lua",
                "$luaRoot/priest.lua",
                "$luaRoot/rogue.lua",
                "$luaRoot/shaman.lua",
                "$luaRoot/warlock.lua",
                "$luaRoot/warrior.lua",
        ]

        ScriptEngineManager sem = new ScriptEngineManager()
        ScriptEngine engine = sem.getEngineByExtension('.lua')

        engine.put('Card', this.class)

        allCards = []
        luaPaths.each {
            log.info "load lua resource: $it"
            engine.eval(new InputStreamReader(this.getClass().getResourceAsStream(it)))
            log.info "now at ${allCards.size()} cards"
        }
        allCards
    }

    static Card createMinion(int nr, String name, int cost, String hero, String description, int attack, int health, String rarity) {
        createMinion(nr, name, cost, hero, description, attack, health, rarity, '')
    }

    static Card createMinion(int nr, String name, int cost, String hero, String description, int attack, int health, String rarity, String type) {
        Card card = new Card('minion', nr, name, cost, hero, description, Rarity.valueOf(rarity.toUpperCase()))
        card.attack = attack
        card.health = health
        if (type)
            card.subtype = MinionType.valueOf(type.toUpperCase())
        allCards << card
        card
    }


    static Card createSpell(int nr, String name, int cost, String hero, String description, String rarity) {
        Card card = new Card('card', nr, name, cost, hero, description, Rarity.valueOf(rarity.toUpperCase()))
        allCards << card
        card
    }

    static Card createWeapon(int nr, String name, int cost, String hero, String description, int attack, int durability, String rarity) {
        Card card = new Card('weapon', nr, name, cost, hero, description, Rarity.valueOf(rarity.toUpperCase()))
        card.attack = attack
        card.durability = durability
        allCards << card
        card
    }

    //todo: hero cards need to be identified as such
    static Card createAbility(int nr, String name, int cost, String hero, String description) {
        Card card = new Card('ability', nr, name, cost, hero, description, Rarity.UNCOLLECTIBLE)
        allCards << card
        card
    }

}
