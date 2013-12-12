package org.hearth4j

import groovy.util.logging.Slf4j
import org.luaj.vm2.LuaClosure

@Slf4j
@SuppressWarnings('PublicInstanceField')
@SuppressWarnings('NonFinalPublicField')
class Card extends Triggerable {
    int nr = 45
    public String type
    public boolean token = false
    public String name
    public Hero hero
    public String description
    public MinionType subtype
    public Rarity rarity

    public int cost
    public int overload = 0
    public int attack
    public int health
    public int durability
    public int durabilityLoss = 1

    public boolean charge = false
    public boolean taunt = false
    public boolean defender = false
    public boolean windfury = false
    public boolean divineShield = false
    public boolean stealth = false
    public boolean shroud = false

    public boolean broken = false

    public LuaClosure costModifier

    Card(String type, int nr, String name, int cost, String hero, String description, Rarity rarity) {
        this.nr = nr
        if (nr == 10000)
            this.nr = 0
        this.type = type
        this.name = name
        this.cost = cost
        if (hero)
            this.hero = Hero.valueOf(hero.toUpperCase())
        this.description = description

        log.trace "creating $name"
        this.rarity = rarity
    }

    @Override
    String toString() {
        name
    }
}

