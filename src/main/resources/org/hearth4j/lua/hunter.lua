-- HERO

local spell = Card:createAbility(10000, 'Rexxar', 2, 'Hunter', 'Deal 2 damage to the enemy hero.', 'Uncollectible');
spell.onCast = function() this().owner.opponent:damage(2, this().owner); end

-- WEAPONS

local spell = Card:createWeapon(233, 'Eaglehorn Bow', 3, 'Hunter', 'Whenever a Secret is revealed, gain +1 Durability.', 2, 3, 'Rare');
spell.onCast = function()
    local source = this()
    this():addGlobalAura('NONE', 0, false).onSecredRevealed =
    function()
        source:gainDurability(1)
    end
end

--SPELLS

local spell = Card:createSpell(272, 'Hunter\'s Mark', 0, 'Hunter', 'Change a minion\'s Health to 1 this turn.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() local h = this():getHealth() - 1; this():addAura('HEALTH', -h, true); end); end;

local spell = Card:createSpell(269, 'Flare', 1, 'Hunter', 'All minions lose Stealth. Destroy all enemy Secrets. Draw a card.', 'Rare');
spell.onCast = function() game:forEach(minion, function() this().stealth = false; end); game:currentPlayer().secrets:clear(); game:currentOpponent().secrets:clear(); game:currentPlayer():draw(); end;

local spell = Card:createSpell(248, 'Arcane Shot', 1, 'Hunter', 'Deal $SPELL_POWER:2$ damage', 'Basic');
spell.onCast = function() game:chooseTarget(enemy, function() this():spellDamage(2, game:currentPlayer()); end); end

local spell = Card:createSpell(213, 'Freezing Trap', 2, 'Hunter', 'Secret: When an enemy attacks, Freeze it this turn and next turn.', 'Common');
spell.onCast = function() local source = this(); this().owner:addSecretAura(function() other():freeze(2); end).onAttack =
function() if source.owner ~= this().controller then aura():trigger(this()); end end
end;

local spell = Card:createSpell(30, 'Explosive Trap', 2, 'Hunter', 'Secret: When a minion damages your hero, deal 2 damage to all enemies.', 'Common');
spell.onCast = function() local source = this(); this().owner:addSecretAura(function() game:damageForEach(friendly, 2, aura().owner); end).onDamage =
function() if this() == source.owner and isType(other(), 'Minion') then aura():trigger(this()); end end
end;

local spell = Card:createSpell(172, 'Snake Trap', 2, 'Hunter', 'Secret: When one of your minions is attacked, summon three 1/1 Snakes.', 'Epic');
spell.onCast = function() local source = this(); this().owner:addSecretAura(function() for i = 1, 3, 1 do this():summon('Snake') end end).onAttack =
function() if isType(other(), 'Minion') and source.owner == other().controller then aura():trigger(source.owner); end end
end;

local spell = Card:createSpell(222, 'Snipe', 2, 'Hunter', 'Secret: When your apponent plays a minion, deal 4 damage to it', 'Common');
spell.onCast = function() local source = this(); this().owner:addSecretAura(function() other():damage(4, source.owner); end).onSummon =
function() if source.owner ~= this().owner and minion() then aura():trigger(this()); end end
end;

local spell = Card:createSpell(273, 'Kill Command', 3, 'Hunter', 'Deal $SPELL_POWER:3$ damage. If you have a Beast, deal $SPELL_POWER:5$ damage instead', 'Basic');
spell.onCast = function() game:chooseTarget(character, function() if game:countTargets(function() return friendlyMinion() and this().card.subtype == 'Beast'; end) > 0 then this():spellDamage(5, game:currentPlayer()); else this():spellDamage(3, game:currentPlayer()); end end); end

local spell = Card:createSpell(279, 'Multi-Shot', 4, 'Hunter', 'Deal $SPELL_POWER:3$ damage to two random enemy minions.', 'Basic');
spell.onCast = function() game:spellDamageForEachRandom(2, enemyMinion, 3, game:currentPlayer()); end;

local spell = Card:createSpell(223, 'Unleash the Hounds', 1, 'Hunter', 'Give your Beasts +1 Attack and Charge', 'Common');
spell.onCast = function() game:forEach(function() return friendlyMinion() and this().card.subtype == 'Beast'; end, function() this():gain(1, 0); this().charge = true; end); end;

--MINIONS

local spell = Card:createMinion(81720, 'Snake', 0, 'Hunter', '', 1, 1, 'Uncollectible', 'Beast');
spell.token = true;

local spell = Card:createMinion(245, 'Timber Wolf', 1, 'Hunter', 'Your other Beasts have +1 attack', 1, 1, 'Basic', 'Beast');
spell.onCast = function() local source = this(); this():addGlobalAura('ATTACK', function() if minion() and this().controller == source.controller and this() ~= source and this().card.subtype == 'Beast' then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(220, 'Scavenging Hyena', 2, 'Hunter', 'Whenever a Beast dies, gain +2/+2', 2, 2, 'Common', 'Beast');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onDeath = function() if this().card.subtype == 'Beast' then source:gain(2, 2) end end; end;

local spell = Card:createMinion(244, 'Starving Buzzard', 2, 'Hunter', 'Whenever you play a Beast, draw a card', 2, 2, 'Basic', 'Beast');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onSummon = function() if this() ~= source and minion() and this().owner == source.controller and this().card.subtype == 'Beast' then source.owner:draw() end end; end;

local spell = Card:createMinion(228, 'Houndmaster', 4, 'Hunter', 'Battlecry: Give a friendly Beast +2/+2 and Taunt', 4, 3, 'Basic');
spell.onCast = function() game:chooseTarget(function() return friendlyMinion() and this().card.subtype == 'Beast' end, function() this():gain(2, 2); this().taunt = true; end); end;

local spell = Card:createMinion(246, 'Tundra Rhino', 5, 'Hunter', 'Your Beasts have Charge', 2, 5, 'Basic', 'Beast');
spell.onCast = function() local source = this(); this():addGlobalAura('CHARGE', function() if minion() and this().controller == source.controller and this().card.subtype == 'Beast' then return 1; else return 0; end end, false); end;

local spell = Card:createMinion(231, 'King Crush', 9, 'Hunter', 'Charge', 8, 8, 'Legendary', 'Beast');
spell.charge = true;

-- MISSING

local spell = Card:createSpell(231, 'Bestial Wrath', 1, 'Hunter', '', 'Epic');
spell.broken = true;

local spell = Card:createWeapon(233, 'Gladiator\'s Longbow', 7, 'Hunter', '', 5, 2, 'Epic');
spell.broken = true;

local spell = Card:createSpell(231, 'Explosive Shot', 5, 'Hunter', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(231, 'Misdirection', 2, 'Hunter', '', 'Rare');
spell.broken = true;

local spell = Card:createMinion(231, 'Savannah Highmane', 6, 'Hunter', '', 6, 5, 'Rare', 'Beast');
spell.broken = true;

local spell = Card:createSpell(231, 'Animal Companion', 3, 'Hunter', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(231, 'Deadly Shot', 3, 'Hunter', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(231, 'Tracking', 1, 'Hunter', '', 'Basic');
spell.broken = true;








