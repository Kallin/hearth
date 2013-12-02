-- HERO

local spell = Card:createAbility(10000, 'Garrosh Hellscream', 2, 'Warrior', 'Gain 2 armor.', 'Uncollectible');
spell.onCast = function() this().owner.armor = this().owner.armor + 2; end

-- WEAPONS

local spell = Card:createWeapon(155, 'Fiery War Axe', 2, 'Warrior', '', 3, 2, 'Basic');

local spell = Card:createWeapon(92, 'Arcanite Reaper', 5, 'Warrior', '', 5, 2, 'Basic');

local spell = Card:createWeapon(86, 'Gorehowl', 7, 'Warrior', 'Attacking a minion costs 1 Attack instead of 1 Durability.', 7, 1, 'Epic');
spell.onCast = function() this():addGlobalAura('NONE', 0, false).onAttack = function() if isType(other(), 'Minion') then this().weapon:looseAttack(1); else this().weapon:looseDurability(1); end end; end;
spell.durabilityLoss = 0;

local spell = Card:createWeapon(10000, 'Arathi Weapon', 0, '', '', 2, 2, 'Uncollectible');

-- SPELLS

local spell = Card:createSpell(102, 'Charge', 0, 'Warrior', 'Give your minions Charge this turn.', 'Basic');
spell.onCast = function() game:forEach(friendlyMinion, function() this().charge = true; end); end;

local spell = Card:createSpell(190, 'Inner Rage', 0, 'Warrior', 'Deal $SPELL_POWER:1$ damage to a minion. It gains +2 Attack this turn.', 'Common');
spell.onCast = function() game:chooseTarget(minion, function() this():spellDamage(1, game:currentPlayer()); this():addAura('ATTACK', 2, true); end); end

local spell = Card:createSpell(87, 'Execute', 1, 'Warrior', 'Destroy a damaged enemy minion.', 'Basic');
spell.onCast = function() game:chooseTarget(function() return enemyMinion() and damaged() end, function() this():destroy(); end); end

local spell = Card:createSpell(154, 'Whirlwind', 1, 'Warrior', 'Deal $SPELL_POWER:1$ damage to ALL minions', 'Basic');
spell.onCast = function() game:spellDamageForEach(minion, 1, game:currentPlayer()); end;

local spell = Card:createSpell(100, 'Battle Rage', 2, 'Warrior', 'Draw a card for each damaged minion on the battlefield.', 'Common');
spell.onCast = function() local source = this(); game:forEach(minion, function() if damaged() then source.owner:draw(); end end); end

local spell = Card:createSpell(192, 'Rampage', 2, 'Warrior', 'Give a damaged minion +3/+3.', 'Common');
spell.onCast = function() game:chooseTarget(function() return minion() and damaged() end, function() this():gain(3, 3); end); end

local spell = Card:createSpell(301, 'Slam', 2, 'Warrior', 'Deal 2 damage to a minion. If it survives, draw a card.', 'Common');
spell.onCast = function() local source = this(); game:chooseTarget(minion, function() this():damage(2, source.owner); if this():getHealth() > 0 then source.owner:draw() end end); end;

local spell = Card:createSpell(95, 'Heroic Strike', 2, 'Warrior', 'Give your hero +4 Attack this turn.', 'Basic');
spell.onCast = function() game:currentPlayer():addAura('ATTACK', 4, true); end

local spell = Card:createSpell(93, 'Cleave', 2, 'Warrior', 'Deal $SPELL_POWER:2$ damage to two random enemy minions.', 'Basic');
spell.onCast = function() game:spellDamageForEachRandom(2, enemyMinion, 2, game:currentPlayer()); end;

local spell = Card:createSpell(219, 'Mortal Strike', 4, 'Warrior', 'Deal $SPELL_POWER:4$ damage. If your hero has 12 or less Health, deal $SPELL_POWER:8$ damage instead.', 'Rare');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() if source.owner:getHealth() <= 12 then this():spellDamage(8, game:currentPlayer()); else this():spellDamage(4, game:currentPlayer()); end end); end

local spell = Card:createSpell(204, 'Brawl', 5, 'Warrior', 'Destroy all minions except one. (chosen randomly)', 'Epic');
spell.onCast = function() game:forEachExceptRandom(1, minion, function() this():destroy(); end); end;

-- MINIONS

local spell = Card:createMinion(109, 'Armorsmith', 2, 'Warrior', 'Whenever a friendly minion takes damage, gain 1 Armor.', 2, 3, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onDamage = function() if minion() and source.controller == this().controller then source.controller.armor = source.controller.armor + 1; end end; end;

local spell = Card:createMinion(98, 'Cruel Taskmaster', 2, 'Warrior', 'Battlecry: Deal 1 damage to a minion and give it +2 Attack.', 2, 1, 'Common');
spell.onCast = function() local source = this(); game:chooseTarget(minion, function() this():damage(1, source); this():gain(2, 0); end) end;

local spell = Card:createMinion(224, 'Warsong Commander', 3, 'Warrior', 'Your other minions have Charge.', 2, 2, 'Basic');
spell.onCast = function() local source = this(); this():addGlobalAura('CHARGE', function() if minion() and this().controller == source.controller and this() ~= source then return 1; else return 0; end end, false); end;

local spell = Card:createMinion(184, 'Frothing Berserker', 3, 'Warrior', 'Whenever a minion takes damage, gain +1 Attack.', 1, 4, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onDamage = function() if minion() then source:gain(1, 0); end end; end;


local spell = Card:createMinion(91, 'Arathi Weaponsmith', 4, 'Warrior', 'Battlecry: Equip a 2/2 Weapon.', 3, 3, 'Common');
spell.onCast = function() this().owner:equip('Arathi Weapon'); end;

local spell = Card:createMinion(216, 'Kor\'kron Elite', 4, 'Warrior', 'Charge', 4, 3, 'Basic');
spell.charge = true;

local spell = Card:createMinion(227, 'Grom Hellscream', 8, 'Warrior', 'Charge. Enrage: +6 Attack.', 4, 9, 'Legendary');
spell.onCast = function() this():addAura('ATTACK', function() if damaged() then return 6 else return 0 end end, false); end;
spell.charge = true;

-- MISSING

local spell = Card:createSpell(0, 'Commanding Shout', 2, 'Warrior', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Shield Slam', 1, 'Warrior', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Shield Block', 3, 'Warrior', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Upgrade', 1, 'Warrior', '', 'Rare');
spell.broken = true;


