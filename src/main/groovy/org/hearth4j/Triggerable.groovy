package org.hearth4j

import org.luaj.vm2.LuaClosure

@SuppressWarnings('PublicInstanceField')
@SuppressWarnings('NonFinalPublicField')
class Triggerable {
    public LuaClosure onCast
    public LuaClosure onDamage
    public LuaClosure onDamageDealt
    public LuaClosure onDeath
    public LuaClosure onStartOfTurn
    public LuaClosure onEndOfTurn
    public LuaClosure onHeal
    public LuaClosure onDraw
    public LuaClosure onAttack
    public LuaClosure onSecredRevealed
    public LuaClosure onSummon
}
