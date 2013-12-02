-- HERO

local spell = Card:createAbility(10000, 'Valeera Sanguinar', 2, 'Rogue', 'Either equips a 1/2 Rogue Dagger or increases the currently equipped dagger\'s attack by 1.', 'Uncollectible');
spell.onCast = function() if this():hasWeapon() and this():hasWeapon() then this().weapon:addAura('ATTACK', 1, true); else this().owner:equip('Rogue Dagger'); end end

local spell = Card:createWeapon(10000, 'Rogue Dagger', 0, 'Rogue', '', 1, 2, 'Uncollectible');

local spell = Card:createWeapon(201, 'Assassin\'s Blade', 5, 'Rogue', '', 3, 4, 'Basic');

local spell = Card:createWeapon(225, 'Perdition\'s Blade', 3, 'Rogue', 'Battlecry: Deal 1 damage. Combo: Deal 2 damage instead.', 2, 2, 'Rare');
spell.onCast = function() game:chooseTarget(character, function() if game:combo() then this():damage(2, this().owner); else this():damage(1, this().owner); end end) end;

--SPELLS

local spell = Card:createMinion(207, 'Defias Ringleader', 2, 'Rogue', 'Combo: Summon a 2/1 Defias Bandit.', 2, 3, 'Common');
spell.onCast = function() if game:combo() then this().owner:summon('Defias Bandit'); end; end;

local spell = Card:createMinion(10000, 'Defias Bandit', 0, 'Rogue', '', 2, 1, 'Uncollectible');
spell.token = true;

local spell = Card:createMinion(215, 'Kidnapper', 5, 'Rogue', 'Combo: Return a minion to it\'s owner\'s hand.', 5, 3, 'Epic');
spell.onCast = function() if game:combo() then game:chooseTarget(minion, function() this():unsummon() end); end end;

local spell = Card:createMinion(218, 'Master of Disguise', 3, 'Rogue', 'Battlecry: Give a friendly minion Stealth.', 4, 3, 'Rare');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this().stealth = true; end); end;


local spell = Card:createMinion(221, 'SI-7 Agent', 3, 'Rogue', 'Combo: Deal 2 damage.', 3, 3, 'Rare');
spell.onCast = function() local source = this(); if game:combo() then game:chooseTarget(character, function() this():damage(2, source); end); end end;


local spell = Card:createMinion(237, 'Patient Assassin', 2, 'Rogue', 'Stealth. Destroy any minion damaged by the Patient Assassin.', 1, 1, 'Epic');
spell.stealth = true;
spell.onDamageDealt = function() if minion() then this():destroy(); end end;


local spell = Card:createMinion(209, 'Edwin VanCleef', 3, 'Rogue', 'Stealth. Combo: Gain +2/+2 for each other card played this turn.', 2, 2, 'Legendary');
spell.stealth = true;
spell.onCast = function() if game:combo() then this():gain(2 * (game.spellCount - 1), 2 * (game.spellCount - 1)); end end;

--MINIONS

local spell = Card:createSpell(264, 'Assassinate', 5, 'Rogue', 'Destroy an enemy minion.', 'Basic');
spell.onCast = function() game:chooseTarget(enemyMinion, function() this():destroy(); end); end

local spell = Card:createSpell(146, 'Backstab', 0, 'Rogue', 'Deal $SPELL_POWER:2$ damage to an enemy minion.', 'Basic');
spell.onCast = function() game:chooseTarget(enemyMinion, function() this():spellDamage(2, game:currentPlayer()); end); end

local spell = Card:createSpell(202, 'Betrayal', 3, 'Rogue', 'An enemy minion deals it\'s damage to the minions next to it.', 'Common');
spell.onCast = function() game:chooseTarget(enemyMinion, function() local source = this(); this():forEachNeighbor(function() this():damage(source:getAttack(), source); end); end); end;

local spell = Card:createSpell(203, 'Blade Flurry', 3, 'Rogue', 'Deal your weapon\'s damage to all enemy minions.', 'Rare');
spell.onCast = function() if game:currentPlayer():hasWeapon() then game:damageForEach(enemyMinion, game:currentPlayer().weapon.attack, game:currentPlayer()); end end

local spell = Card:createSpell(151, 'Cold Blood', 1, 'Rogue', 'Give a minion +2 Attack. Combo: +4 Attack instead.', 'Common');
spell.onCast = function() game:chooseTarget(minion, function() if game:combo() then this():gain(4, 0); else this():gain(2, 0); end end); end

local spell = Card:createSpell(147, 'Conceal', 0, 'Rogue', 'Give a friendly minion Stealth.', 'Common');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this().stealth = true; end); end

local spell = Card:createSpell(152, 'Deadly Poison', 1, 'Rogue', 'Give your weapon +2 Attack.', 'Basic');
spell.onCast = function() if this().owner:hasWeapon() then this().owner.weapon.attack = this().owner.weapon.attack + 2; end end

local spell = Card:createSpell(211, 'Eviscerate', 2, 'Rogue', 'Deal $SPELL_POWER:2$ damage. Combo: Deal $SPELL_POWER:4$ damage instead.', 'Common');
spell.onCast = function() game:chooseTarget(character, function() if game:combo() then this():spellDamage(4, game:currentPlayer()); else this():spellDamage(2, game:currentPlayer()); end end); end

local spell = Card:createSpell(212, 'Fan of Knives', 3, 'Rogue', 'Deal $SPELL_POWER:1$-$SPELL_POWER:2$ damage to all enemy minions.', 'Basic');
spell.onCast = function() game:forEach(enemyMinion, function() this():spellDamage(game:random(1, 2), game:currentPlayer()); end); end;

local spell = Card:createSpell(174, 'Sap', 2, 'Rogue', 'Return an enemy minion to its owner\�s hand.', 'Basic');
spell.onCast = function() game:chooseTarget(enemyMinion, function() this():unsummon() end); end;

local spell = Card:createSpell(149, 'Shadowstep', 0, 'Rogue', 'Return a friendly minion to your hand.', 'Common');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this():unsummon() end); end;

local spell = Card:createSpell(153, 'Sinister Strike', 1, 'Rogue', 'Deal $SPELL_POWER:3$ damage to the enemy hero.', 'Basic');
spell.onCast = function() game:currentOpponent():spellDamage(3, game:currentPlayer()); end;

local spell = Card:createSpell(281, 'Sprint', 7, 'Rogue', 'Draw 4 cards.', 'Basic');
spell.onCast = function() for i = 1, 4, 1 do this().owner:draw() end end

local spell = Card:createSpell(285, 'Vanish', 6, 'Rogue', 'Return all minions to their owner\'s hand.', 'Basic');
spell.onCast = function() game:forEach(minion, function() this():unsummon() end); end;

local spell = Card:createSpell(148, 'Preparation', 0, 'Rogue', 'The next spell you cast this turn costs (2) less.', 'Epic');
spell.onCast = function() local source = this(); this().owner:addGlobalAura('COST', function() if this().card.type == "spell" then return -2 else return 0 end end, true).onCast = function() aura():trigger(); end end;

local spell = Card:createSpell(214, 'Headcrack', 2, 'Rogue', 'Deal $SPELL_POWER:2$ damage to the enemy hero. Combo: Return this card to your hand next turn.', 'Rare');
spell.onCast = function() this().owner.opponent:spellDamage(2, this().owner); if game():combo() then this().owner:addAura('NONE', 0, false).onStartOfTurn = function() if game:currentPlayer() == aura().owner then aura().owner:drawCard('Headcrack'); aura():trigger(); end end end end;

-- MISSING

local spell = Card:createSpell(0, 'Shiv', 2, 'Rogue', '', 'Basic');
spell.broken = true;
