package org.hearth4j.lua

import groovy.util.logging.Slf4j
import org.hearth4j.*

import javax.script.ScriptEngine
import javax.script.ScriptEngineManager

@Slf4j
class LuaClasspathCardProvider implements CardProvider {

    // the card library is populated via lua calls to static methods on this class
    private static CardLibrary cardLibrary

    @Override
    CardLibrary provideCards(Version version) {

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

        ScriptEngineManager sem = new ScriptEngineManager();
        ScriptEngine engine = sem.getEngineByExtension(".lua");

        // todo: inject this
        engine.put("Card", this.class);

        cardLibrary = new CardLibrary()
        luaPaths.each {
            log.info "load lua resource: $it"
            engine.eval(new InputStreamReader(this.getClass().getResourceAsStream(it)));
            log.info "now at ${cardLibrary.allCards.size()} cards"
        }
        return cardLibrary;
    }

    public static Card createMinion(int nr, String name, int cost, String hero, String description, int attack, int health, String rarity) {
        return createMinion(nr, name, cost, hero, description, attack, health, rarity, "");
    }

    public static Card createMinion(int nr, String name, int cost, String hero, String description, int attack, int health, String rarity, String type) {
        Card card = new Card("minion", nr, name, cost, hero, description, Rarity.valueOf(rarity.toUpperCase()));
        card.attack = attack;
        card.health = health;
        if (type)
            card.subtype = MinionType.valueOf(type.toUpperCase());
        cardLibrary.add(card);
        return card;
    }


    public static Card createSpell(int nr, String name, int cost, String hero, String description, String rarity) {
        Card card = new Card("card", nr, name, cost, hero, description, Rarity.valueOf(rarity.toUpperCase()));
        cardLibrary.add(card);
        return card;
    }

    public static Card createWeapon(int nr, String name, int cost, String hero, String description, int attack, int durability, String rarity) {
        Card card = new Card("weapon", nr, name, cost, hero, description, Rarity.valueOf(rarity.toUpperCase()));
        card.attack = attack;
        card.durability = durability;
        cardLibrary.add(card);
        return card;
    }

    //todo: hero cards need to be identified as such
    public static Card createAbility(int nr, String name, int cost, String hero, String description) {
        Card card = new Card("ability", nr, name, cost, hero, description, Rarity.UNCOLLECTIBLE);
        cardLibrary.add(card);
        return card;
    }

}
