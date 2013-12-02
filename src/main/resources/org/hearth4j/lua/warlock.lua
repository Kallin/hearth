-- HERO

local spell = Card:createAbility(10000, 'Gul\'dan', 2, 'Warlock', 'Lose 2 life and draw a card.', 'Uncollectible');
spell.onCast = function() this().owner:damage(2, this().owner); this().owner:draw(); end

local suminf = Card:createAbility(10000, 'Summon Infernal', 2, 'Warlock', 'Summon a 6/6 Infernal', 'Uncollectible');
suminf.onCast = function() this().owner:summon('Infernal'); end

-- WEAPONS

local jarwep = Card:createWeapon(10000, 'Jaraxxus Weapon', 2, '', '', 3, 8, 'Uncollectible');

-- SPELLS

local spell = Card:createSpell(46, 'Soulfire', 0, 'Warlock', 'Deal $SPELL_POWER:4$ damage. Discard a random card.', 'Basic');
spell.onCast = function() this().owner:discardRandom(1); game:chooseTarget(character, function() this():spellDamage(4, game:currentPlayer()) end); end

local spell = Card:createSpell(48, 'Power Overwhelming', 1, 'Warlock', 'Give a friendly minion +4/+4 until end of turn. Then, it dies. Horribly.', 'Common');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this():gain(4, 4); this():addAura('NONE', 0, true).onEndOfTurn = function() this():destroy(); end; end); end

local spell = Card:createSpell(160, 'Drain Life', 3, 'Warlock', 'Deal $SPELL_POWER:2$ damage. Restore 2 Health to your hero.', 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() this():spellDamage(2, game:currentPlayer()); source.owner:heal(2) end); end

local spell = Card:createSpell(176, 'Shadow Bolt', 3, 'Warlock', 'Deal $SPELL_POWER:4$ damage to a minion.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this():spellDamage(4, game:currentPlayer()); end); end

local spell = Card:createSpell(118, 'Hellfire', 4, 'Warlock', 'Deal $SPELL_POWER:3$ damage to ALL characters.', 'Basic');
spell.onCast = function() game:spellDamageForEach(character, 3, game:currentPlayer()); end;

local spell = Card:createSpell(27, 'Siphon Soul', 6, 'Warlock', 'Destory a minion. Restore 3 Health to your hero.', 'Rare');
spell.onCast = function() local source = this(); game:chooseTarget(minion, function() this():destroy(); source.owner:heal(3); end); end

local spell = Card:createSpell(171, 'Twisting Nether', 8, 'Warlock', 'Destroy all Minions.', 'Epic');
spell.onCast = function() game:forEach(minion, function() this():destroy(); end); end;

-- MINIONS

local spell = Card:createMinion(47, 'Voidwalker', 1, 'Warlock', 'Taunt', 1, 3, 'Basic', 'Demon');
spell.taunt = true;

local spell = Card:createMinion(162, 'Succubus', 2, 'Warlock', 'Battlecry: Discard a random card.', 4, 4, 'Basic', 'Demon');
spell.onCast = function() this().owner:discardRandom(1); end

local spell = Card:createMinion(10000, 'Infernal', 2, 'Warlock', '', 6, 6, 'Uncollectible', 'Demon');
spell.token = true;

local spell = Card:createMinion(159, 'Felguard', 3, 'Warlock', 'Taunt. Battlecry: Destroy one of your Mana Crystals.', 3, 5, 'Rare', 'Demon');
spell.taunt = true;
spell.onCast = function() this().owner:destroyManaCrystals(1); end;

local spell = Card:createMinion(308, 'Void Terror', 3, 'Warlock', 'Battlecry: Destroy the minions on either side of this minion and gain their Attack and Health.', 3, 3, 'Rare', 'Demon');
spell.onCast = function() local source = this(); this():forEachNeighbor(function() source:gain(this():getAttack(), this():getHealth()); this():destroy(); end); end;

local spell = Card:createMinion(166, 'Pit Lord', 4, 'Warlock', 'Battlecry: Deal 7 damage to your hero.', 7, 7, 'Epic', 'Demon');
spell.onCast = function() local source = this(); this().owner:damage(7, source); end;

local spell = Card:createMinion(158, 'Doomguard', 5, 'Warlock', 'Charge, Battlecry: Discard two random cards.', 5, 7, 'Rare');
spell.charge = true;
spell.onCast = function() this().owner:discardRandom(2); end

local spell = Card:createMinion(115, 'Lord Jaraxxus', 9, 'Warlock', 'Battlecry: Destroy your hero and replace him with Lord Jaraxxus.', 3, 15, 'Legendary', 'Demon');
spell.onCast = function() this().owner.health = 15; this().owner.ability = suminf; this().owner:equip('Jaraxxus Weapon'); this():destroy(); end;

-- MISSING

local spell = Card:createSpell(0, 'Bane of Doom', 5, 'Warlock', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Shadowflame', 4, 'Warlock', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Corruption', 1, 'Warlock', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Demonfire', 2, 'Warlock', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(0, 'Sacrificial Pact', 0, 'Warlock', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Mortal Coil', 1, 'Warlock', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Sense Demons', 1, 'Warlock', '', 'Common');
spell.broken = true;

local spell = Card:createMinion(0, 'Blood Imp', 1, 'Warlock', '', 1, 1, 'Common', 'Demon');
spell.broken = true;

local spell = Card:createMinion(0, 'Dread Infernal', 6, 'Warlock', '', 6, 6, 'Basic', 'Demon');
spell.broken = true;

local spell = Card:createMinion(0, 'Flame Imp', 1, 'Warlock', '', 3, 2, 'Common', 'Demon');
spell.broken = true;

local spell = Card:createMinion(0, 'Summoning Portal', 4, 'Warlock', '', 0, 4, 'Common', '');
spell.broken = true;