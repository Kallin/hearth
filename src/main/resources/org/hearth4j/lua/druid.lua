-- HERO

local spell = Card:createAbility(10000, 'Malfurion Stormrage', 2, 'Druid', 'Gain 1 armor and 1 attack.', 'Uncollectible')
spell.onCast = function()
    this().owner.armor = this().owner.armor + 1
    this().owner:addAura('ATTACK', 1, true)
end

-- SPELLS

local spell = Card:createSpell(53, 'Moonfire', 0, 'Druid', 'Deal $SPELL_POWER:1$ damage.', 'Basic');
spell.onCast = function() game:chooseTarget(character, function() this():spellDamage(1, game:currentPlayer()); end); end

local spell = Card:createSpell(52, 'Innervate', 0, 'Druid', 'Gain 2 Mana Crystals this turn only.', 'Basic');
spell.onCast = function() this().owner:addAura('MANA', 2, true); end

local spell = Card:createSpell(54, 'Claw', 1, 'Druid', 'Give your hero +3 Attack this turn.', 'Basic');
spell.onCast = function() game:currentPlayer():addAura('ATTACK', 3, true); end;

local spell = Card:createSpell(56, 'Mark of the Wild', 2, 'Druid', 'Give a minion Taunt and +2/+2. (+2 Attack and +2 Health)', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this().taunt = true; this():gain(2, 2); end); end
local spell = Card:createSpell(57, 'Power of the Wild', 2, 'Druid', 'Choose One - Give your minions +1/+1; or summon a 3/2 Panther.', 'Common');
spell.onCast = function() game:chooseOne("Give your minions +1/+1", function() game:forEach(friendlyMinion, function() this():gain(1, 1); end); end,
    "Summon a 3/2 Panther", function() this().owner:summon('Panther'); end);
end;

local spell = Card:createSpell(58, 'Savagery', 2, 'Druid', 'Deal damage equal to your hero\'s attack to all enemy minions.', 'Rare');
spell.onCast = function() game:damageForEach(enemyMinion, game:currentPlayer():getAttack(), game:currentPlayer()); end;

local spell = Card:createSpell(59, 'Wild Growth', 2, 'Druid', 'Gain an empty Mana Crystal.', 'Basic');
spell.onCast = function() this().owner:gainManaCrystals(1); end;
local spell = Card:createSpell(130, 'Wrath', 2, 'Druid', 'Choose One - Deal $SPELL_POWER:3$ damage; or Deal $SPELL_POWER:1$ damage and draw a card.', 'Common');
spell.onCast = function() local source = this(); game:chooseOne("Deal 3 damage", function() game:chooseTarget(character, function() this():spellDamage(3, game:currentPlayer()); end); end,
    "Deal 1 damage and draw a card", function() game:chooseTarget(character, function() this():spellDamage(1, game:currentPlayer()); source.owner:draw() end); end);
end;
local spell = Card:createSpell(169, 'Healing Touch', 3, 'Druid', 'Restore 8 Health.', 'Basic');
spell.onCast = function() game:chooseTarget(character, function() this():heal(8); end); end

local spell = Card:createSpell(317, 'Savage Roar', 3, 'Druid', 'Give your characters +2 Attack this turn.', 'Basic');
spell.onCast = function() game:forEach(friendly, function() this():addAura('ATTACK', 2, true); end) end;

local spell = Card:createSpell(318, 'Soul of the Forest', 4, 'Druid', 'Give your minions "Deathrattle: Summon a 2/2 Treant."', 'Common');
spell.onCast = function() game:forEach(friendlyMinion, function() this():addAura('NONE', 0, false).onDeath = function() this().controller:summon('Treant (SotF)'); end; end) end;

local spell = Card:createSpell(163, 'Swipe', 4, 'Druid', 'Deal $SPELL_POWER:4$ damage to an enemy and $SPELL_POWER:1$ damage to all other enemies.', 'Basic');
spell.onCast = function()
    game:chooseTarget(enemy,
        function()
            local source = this();
            this():spellDamage(4, game:currentPlayer());
            game:spellDamageForEach(function() return enemy() and this() ~= source end, 1, game:currentPlayer())
        end);
end

local spell = Card:createSpell(167, 'Nourish', 5, 'Druid', 'Choose One - Gain 2 Mana Crystals; or Draw 3 cards.', 'Rare');
spell.onCast = function() game:chooseOne("Gain 2 Mana Crystals", function() this().owner:gainManaCrystals(2); this().owner:gainMana(2); end,
    "Draw 3 cards", function() for i = 1, 3, 1 do this().owner:draw(); end end);
end;

local spell = Card:createSpell(314, 'Force of Nature', 5, 'Druid', 'Summon three 2/2 Treants with Charge that die at the end of the turn.', 'Epic');
spell.onCast = function() for i = 1, 3, 1 do this().owner:summon('Treant (FoN)') end end;

local spell = Card:createSpell(320, 'Starfall', 5, 'Druid', 'Chose One - Deal $SPELL_POWER:5$ damage to an enemy; or $SPELL_POWER:2$ damage to all of them."', 'Rare');
spell.onCast = function() local source = this(); game:chooseOne("Deal 5 damage to an enemy", function() game:chooseTarget(enemy, function() this():spellDamage(5, source.owner); end) end,
    "Deal 2 damage to all enemies", function() game:spellDamageForEach(enemy, 2, source.owner) end);
end;

-- MINIONS

local spell = Card:createMinion(57, 'Panther', 0, '', '', 3, 2, 'Uncollectible', '');
spell.token = true;

local spell = Card:createMinion(83140, 'Treant (FoN)', 0, 'Druid', 'Charge. Dies at the end of the turn.', 2, 2, 'Uncollectible');
spell.token = true;
spell.charge = true;
spell.onEndOfTurn = function() this():destroy(); end;

local spell = Card:createMinion(83180, 'Treant (SotF)', 0, 'Druid', '', 2, 2, 'Uncollectible');
spell.token = true;

local spell = Card:createMinion(81650, 'Treant', 0, 'Druid', 'Taunt.', 2, 2, 'Uncollectible');
spell.token = true;
spell.taunt = true;

local spell = Card:createMinion(33, 'Keeper of the Grove', 4, 'Druid', 'Choose One - Deal 2 damage; or Silence a minion.', 2, 3, 'Rare');
spell.onCast = function() local source = this(); game:chooseOne("Deal 2 damage", function() game:chooseTarget(character, function() this():damage(2, source); end); end,
    "Silence a minion", function() game:chooseTarget(minion, function() this():silence(); end); end);
end;

local spell = Card:createMinion(313, 'Druid of the Claw', 5, 'Druid', 'Choose One - Charge; or +3 Health and Taunt', 4, 4, 'Common', '');
spell.onCast = function() game:chooseOne("Charge", function() this().charge = true; end,
    "+3 Health and Taunt", function() this():gain(0, 3); this().taunt = true; end);
end;

local spell = Card:createMinion(170, 'Ancient of Lore', 7, 'Druid', 'Choose One - Draw 2 cards; or Restore 8 Health.', 5, 5, 'Epic');
spell.onCast = function() game:chooseOne("Draw 2 cards", function() for i = 1, 2, 1 do this().owner:draw(); end end,
    "Restore 8 Health", function() game:chooseTarget(character, function() this():heal(8); end); end);
end;

local spell = Card:createMinion(165, 'Cenarius', 8, 'Druid', 'Choose One - Give all friendly minions +2/+2; or summon two 2/2 Treants with Taunt.', 5, 8, 'Legendary');
spell.onCast = function() game:chooseOne("Give all friendly minions +2/+2", function() game:forEach(friendlyMinion, function() this():gain(2, 2) end); end,
    "Summon two 2/2 Treants with Taunt", function() for i = 1, 2, 1 do this().owner:summon('Treant'); end end);
end;

-- MISSING

local spell = Card:createSpell(0, 'Naturalize', 1, 'Druid', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(0, 'Mark of Nature', 4, 'Druid', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(0, 'Bite', 4, 'Druid', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Starfire', 5, 'Druid', '', 'Basic');
spell.broken = true;

local spell = Card:createMinion(0, 'Ancient of War', 7, 'Druid', '', 5, 5, 'Epic', '');
spell.broken = true;

local spell = Card:createMinion(0, 'Ironbark Protector', 8, 'Druid', '', 8, 8, 'Basic', '');
spell.broken = true;

