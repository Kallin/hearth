-- HERO

local spell = Card:createAbility(10000, 'Jaina Proudmoore', 2, 'Mage', 'Deal 1 damage.', 'Uncollectible');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() this():damage(1, source.owner); end) end

--SPELLS

local spell = Card:createSpell(277, 'Mirror Image', 1, 'Mage', 'Summon two 0/1 minions with Taunt.', 'Basic');
spell.onCast = function() for i = 1, 2, 1 do this().owner:summon('Mirror Image Minion'); end end;

local spell = Card:createMinion(277, 'Mirror Image Minion', 0, 'Mage', 'Taunt.', 0, 1, 'Uncollectible');
spell.token = true;
spell.taunt = true;

local spell = Card:createSpell(125, 'Ice Lance', 1, 'Mage', 'Freeze a character. If it was already Frozen, deal $SPELL_POWER:4$ damage instead.', 'Common');
spell.onCast = function()
    game:chooseTarget(character, function()
        if this():frozen()
        then this():spellDamage(4, game:currentPlayer());
        else this():freeze()
        end
    end);
end

local spell = Card:createSpell(28, 'Arcane Missiles', 1, 'Mage', 'Shoot 3 missiles at random enemies for $SPELL_POWER:1$ damage each.', 'Basic');
spell.onCast = function() for i = 1, 3, 1 do game:forEachRandom(1, enemy, function() this():spellDamage(1, game:currentPlayer()); end); end end;

local spell = Card:createSpell(289, 'Frost Nova', 2, 'Mage', 'Freeze ALL enemy minions.', 'Basic');
spell.onCast = function() game:forEach(enemyMinion, function() this():freeze() end); end;

local spell = Card:createSpell(195, 'Arcane Explosion', 2, 'Mage', 'Deal $SPELL_POWER:1$ damage to all enemies.', 'Basic');
spell.onCast = function() local source = this() game:spellDamageForEach(enemy, 1, source.owner); end;

local spell = Card:createSpell(253, 'Mirror Entity', 3, 'Mage', 'Secret: When a minion attacks. Summon a copy of it.', 'Common');
spell.onCast = function() local source = this(); this().owner:addSecretAura(function() source.owner:summon(other().card.name); end).onAttack =
function() if minion() and source.owner ~= this().controller then aura():trigger(this()); end end
end;

local spell = Card:createSpell(41, 'Arcane Intellect', 3, 'Mage', 'Draw 2 cards.', 'Basic');
spell.onCast = function() this().owner:draw(); this().owner:draw(); end;

local spell = Card:createSpell(198, 'Frost Bolt', 3, 'Mage', 'Deal $SPELL_POWER:3$ damage to a character and Freeze it.', 'Basic');
spell.onCast = function() game:chooseTarget(character, function() this():spellDamage(3, game:currentPlayer()); this():freeze() end); end;

local spell = Card:createSpell(40, 'Polymorph', 4, 'Mage', 'Transform a minion into a 1/1 Sheep.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this():transform('Sheep'); end); end;

local spell = Card:createMinion(40, 'Sheep', 0, '', '', 1, 1, 'Uncollectible', '');
spell.token = true;

local spell = Card:createSpell(254, 'Blizzard', 5, 'Mage', 'Deal $SPELL_POWER:2$ damage to all enemy minions and Freeze them.', 'Rare');
spell.onCast = function()
    game:spellDamageForEach(enemyMinion, 2, game:currentPlayer());
    game:forEach(enemyMinion, function() this():freeze(); end);
end;

local spell = Card:createSpell(156, 'Fireball', 5, 'Mage', 'Deal $SPELL_POWER:6$ damage.', 'Basic');
spell.onCast = function() game:chooseTarget(character, function() this():spellDamage(6, game:currentPlayer()); end); end

-- MINIONS

local spell = Card:createMinion(196, 'Mana Wyrm', 1, 'Mage', 'Whenever you cast a spell gain +1 Attack.', 0, 3, 'Common');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if this().card.type == 'spell' and source.controller == this().owner then source:gain(1, 0); end end; end;

local spell = Card:createMinion(255, 'Sorcerer\'s Apprentice', 2, 'Mage', 'Your spells cost (1) less.', 2, 2, 'Common');
spell.onCast = function() local source = this(); this():addGlobalAura('COST', function() if this().card.type == 'spell' and this().owner == source.controller then return -1 else return 0 end end, false); end;

local spell = Card:createMinion(262, 'Water Elemental', 4, 'Mage', 'Freeze any enemy that Water Elemental damages.', 3, 6, 'Basic');
spell.onDamageDealt = function() if enemy() and this().controller ~= other().controller then this():freeze(); end end

local spell = Card:createMinion(14, 'Archmage Antonidas', 7, 'Mage', 'Whenever you cast a spell, put a \'Fireball\' spell into your hand.', 5, 7, 'Legendary');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if this().card.type == 'spell' and source.controller == this().owner then source.controller:drawCard('Fireball'); end end; end;

-- MISSING

local spell = Card:createSpell(0, 'Ice Block', 3, 'Mage', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Pyroblast', 8, 'Mage', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Spellbender', 3, 'Mage', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Counterspell', 3, 'Mage', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Vaporize', 3, 'Mage', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Cone of Cold', 3, 'Mage', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(0, 'Flamestrike', 7, 'Mage', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Ice Barrier', 3, 'Mage', '', 'Common');
spell.broken = true;

local spell = Card:createMinion(0, 'Ethereal Arcanist', 4, 'Mage', '', 3, 3, 'Rare', '');
spell.broken = true;

local spell = Card:createMinion(0, 'Kirin Tor Mage', 3, 'Mage', '', 4, 3, 'Rare', '');
spell.broken = true;