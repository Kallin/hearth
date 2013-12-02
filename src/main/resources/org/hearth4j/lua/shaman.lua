-- HERO

local spell = Card:createAbility(10000, 'Thrall', 2, 'Shaman', 'Randomly summons a Healing Stream Totem, Stoneclaw Totem or Searing Totem', 'Uncollectible');
spell.onCast = function() local r = game:random(1, 4);
if r == 1 then this().owner:summon('Healing Stream Totem'); end
if r == 2 then this().owner:summon('Stoneclaw Totem'); end
if r == 3 then this().owner:summon('Searing Totem'); end
if r == 4 then this().owner:summon('Wrath of Air Totem'); end
end

local spell = Card:createMinion(10000, 'Healing Totem', 0, 'Shaman', 'Heals each friendly character for one health at the end of each turn.', 0, 2, 'Uncollectible', 'Totem');
spell.token = true;
spell.onEndOfTurn = function() if this().controller == game:currentPlayer() then game:forEach(friendly, function() this():heal(1); end); end end

local spell = Card:createMinion(80003, 'Stoneclaw Totem', 0, 'Shaman', 'Taunt.', 0, 2, 'Uncollectible', 'Totem');
spell.token = true;
spell.taunt = true;

local spell = Card:createMinion(80002, 'Searing Totem', 0, 'Shaman', '', 1, 1, 'Uncollectible', 'Totem');
spell.token = true;

local spell = Card:createMinion(80001, 'Wrath of Air Totem', 0, 'Shaman', 'Spell Power +1.', 0, 2, 'Uncollectible', 'Totem');
spell.token = true;
spell.onCast = function() local source = this(); this():addGlobalAura('SPELL_POWER', function() if this().owner == source.controller then return 1 else return 0 end end, false); end;

-- WEAPONS

local spell = Card:createWeapon(321, 'Stormforged Axe', 2, 'Shaman', 'Overload: (1)', 2, 3, 'Common');
spell.overload = 1;

local spell = Card:createWeapon(257, 'Doomhammer', 5, 'Shaman', 'Windfury, Overload: (2)', 2, 8, 'Epic');
spell.overload = 2;
spell.onCast = function() this().owner:addAura('WINDFURY', 1, false); end;

-- SPELLS

local spell = Card:createMinion(271, 'Frog', 0, '', '', 0, 1, 'Uncollectible', '');
spell.token = true;
spell.taunt = true;

local spell = Card:createSpell(200, 'Ancestral Healing', 0, 'Shaman', 'Restore a minion to full health.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this().health = this().maxHealth; end); end

local spell = Card:createSpell(113, 'Forked Lightning', 1, 'Shaman', 'Deal $SPELL_POWER:2$ damage to 2 random enemy minions. Overload: (2)', 'Common');
spell.overload = 2;
spell.onCast = function() game:spellDamageForEachRandom(2, enemyMinion, 2, game:currentPlayer()); end;

local spell = Card:createSpell(217, 'Lightning Bolt', 1, 'Shaman', 'Deal $SPELL_POWER:3$ damage. Overload: (1)', 'Common');
spell.overload = 1;
spell.onCast = function()
    game:chooseTarget(character, function()
        this():spellDamage(3, game:currentPlayer());
    end);
end

local spell = Card:createSpell(270, 'Frost Shock', 1, 'Shaman', 'Deal $SPELL_POWER:1$ damage to an enemy character and Freeze it.', 'Basic');
spell.onCast = function() game:chooseTarget(enemy, function() this():spellDamage(1, game:currentPlayer()); this():freeze() end); end

local spell = Card:createSpell(266, 'Earth Shock', 1, 'Shaman', 'Deal $SPELL_POWER:1$ damage to a minion and Silence it.', 'Common');
spell.onCast = function() local source = this(); game:chooseTarget(minion, function() this():spellDamage(1, source.owner); this():silence(); end); end;

local spell = Card:createSpell(126, 'Ancestral Spirit', 2, 'Shaman', 'Choose a minion. When that minion is destroyed, return it to the battlefield.', 'Rare');
spell.onCast = function() game:chooseTarget(minion, function() this():addAura('NONE', 0, false).onDeath = function() this().owner:summon(this().card.name); end; end); end;

local spell = Card:createSpell(15, 'Windfury', 2, 'Shaman', 'Give a minion Windfury.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this().windfury = true; end); end;

local spell = Card:createSpell(256, 'Feral Spirit', 3, 'Shaman', 'Summon two 2/3 Spirit Wolves with Taunt. Overload: (2).', 'Rare');
spell.overload = 2;
spell.onCast = function() for i = 1, 2, 1 do this().owner:summon('Spirit Wolf'); end end;

local spell = Card:createSpell(271, 'Hex', 3, 'Shaman', 'Transform a minion into a 0/1 Frog with Taunt.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this():transform('Frog'); end); end;

local spell = Card:createSpell(274, 'Lightning Storm', 3, 'Shaman', 'Deal $SPELL_POWER:2$-$SPELL_POWER:3$ damage to all enemy minions. Overload: (2)', 'Rare');
spell.overload = 2;
spell.onCast = function() local source = this(); game:forEach(enemyMinion, function() this():spellDamage(game:random(2, 3), source.owner); end); end;

local spell = Card:createSpell(157, 'Bloodlust', 5, 'Shaman', 'Give your minions +3 Attack this turn.', 'Basic');
spell.onCast = function() game:forEach(friendlyMinion, function() this():addAura('ATTACK', 3, true); end); end

-- MINIONS

local spell = Card:createMinion(208, 'Dust Devil', 1, 'Shaman', 'Windfury. Overload: (2)', 3, 1, 'Common');
spell.windfury = true;
spell.overload = 2;

local spell = Card:createMinion(268, 'Flametongue Totem', 2, 'Shaman', 'Adjacent minions have +2 Attack.', 0, 3, 'Basic', 'Totem');
spell.onCast = function() local source = this(); this():addGlobalAura('ATTACK', function() if minion() and this():adjacent(source) then return 2 else return 0 end end, false); end;

local spell = Card:createMinion(261, 'Windspeaker', 4, 'Shaman', 'Battlecry: Gives a friendly minion Windfury.', 3, 3, 'Basic');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this().windfury = true; end); end;

local spell = Card:createMinion(391, 'Earth Elemental', 5, 'Shaman', 'Taunt. Overload: (3)', 7, 8, 'Epic', '');
spell.taunt = true;
spell.overload = 3;

local spell = Card:createMinion(199, 'Al\'Akir the Windlord', 8, 'Shaman', 'Windfury. Charge. Divine Shield. Taunt.', 3, 5, 'Legendary');
spell.windfury = true;
spell.charge = true;
spell.divineShield = true;
spell.taunt = true;

-- MISSING

local spell = Card:createSpell(0, 'Far Sight', 3, 'Shaman', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Lava Burst', 3, 'Shaman', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Totemic Might', 0, 'Shaman', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Rockbiter Weapon', 1, 'Shaman', '', 'Basic');
spell.broken = true;

local spell = Card:createMinion(0, 'Mana Tide Totem', 3, 'Shaman', '', 0, 3, 'Rare', 'Totem');
spell.broken = true;

local spell = Card:createMinion(0, 'Fire Elemental', 6, 'Shaman', '', 6, 5, 'Basic', '');
spell.broken = true;

local spell = Card:createMinion(0, 'Unbound Elemental', 3, 'Shaman', '', 2, 4, 'Common', '');
spell.broken = true;