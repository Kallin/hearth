package org.hearth4j

import org.luaj.vm2.LuaClosure

public class Triggerable {
    public LuaClosure onCast;
    public LuaClosure onDamage;
    public LuaClosure onDamageDealt;
    public LuaClosure onDeath;
    public LuaClosure onStartOfTurn;
    public LuaClosure onEndOfTurn;
    public LuaClosure onHeal;
    public LuaClosure onDraw;
    public LuaClosure onAttack;
    public LuaClosure onSecredRevealed;
    public LuaClosure onSummon;

//    public LuaFunction getHandler(Event e) {
//        switch (e) {
//            case ATTACK:
//                return onAttack;
//            case DAMAGE:
//                return onDamage;
//            case DAMAGE_DEALT:
//                return onDamageDealt;
//            case START_OF_TURN:
//                return onStartOfTurn;
//            case END_OF_TURN:
//                return onEndOfTurn;
//            case DEATH:
//                return onDeath;
//            case CAST:
//                return onCast;
//            case HEAL:
//                return onHeal;
//            case DRAW:
//                return onDraw;
//            case SECRET_REVEALED:
//                return onSecredRevealed;
//            case SUMMON:
//                return onSummon;
//        }
//
//        throw new RuntimeException("Unknown Trigger");
//
//    }

//    public void applyToAura(Aura a) {
//        a.onCast = onCast;
//        a.onDamage = onDamage;
//        a.onDamageDealt = onDamageDealt;
//        a.onDeath = onDeath;
//        a.onStartOfTurn = onStartOfTurn;
//        a.onEndOfTurn = onEndOfTurn;
//        a.onHeal = onHeal;
//        a.onDraw = onDraw;
//        a.onAttack = onAttack;
//        a.onSecredRevealed = onSecredRevealed;
//        a.onSummon = onSummon;
//    }

}
