-- HERO

local spell = Card:createAbility(10000, 'Anduin Wrynn', 2, 'Priest', 'Heal target minion or hero for 2.', 'Uncollectible');
spell.onCast = function() game:chooseTarget(character, function() this():heal(2); end); end

local sf1 = Card:createAbility(10000, 'Shadowform 1', 2, 'Priest', 'Deal 2 damage.', 'Epic');
sf1.onCast = function() game:chooseTarget(character, function() this():damage(2, this().owner); end) end

local sf2 = Card:createAbility(10000, 'Shadowform 2', 2, 'Priest', 'Deal 3 damage.', 'Epic');
sf2.onCast = function() game:chooseTarget(character, function() this():damage(3, this().owner); end) end

local spell = Card:createSpell(143, 'Shadowform', 3, 'Priest', 'Your Hero Power becomes \'Deal 2 damage\'. if already in Shadowform; 3 damage.', 'Epic');
spell.onCast = function() if this().owner.ability == sf1 then this().owner.ability = sf2; else this().owner.ability = sf1; end end;

-- SPELLS

local spell = Card:createSpell(120, 'Silence', 0, 'Priest', 'Silence a minion.', 'Common');
spell.onCast = function() game:chooseTarget(minion, function() this():silence() end); end

local spell = Card:createSpell(119, 'Circle of Healing', 0, 'Priest', 'Restore 4 Health to ALL minions.', 'Common');
spell.onCast = function() game:forEach(minion, function() this():heal(4); end); end;

local spell = Card:createSpell(121, 'Holy Smite', 1, 'Priest', 'Deal $SPELL_POWER:2$ damage.', 'Basic');
spell.onCast = function() game:chooseTarget(character, function() this():spellDamage(2, game:currentPlayer()); end); end

local spell = Card:createSpell(122, 'Power Word: Shield', 1, 'Priest', 'Give a minion +3 Health.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this():gain(0, 3); end); end

local spell = Card:createSpell(135, 'Shadow Word: Pain', 2, 'Priest', 'Destroy a minion with 3 or less Attack', 'Basic');
spell.onCast = function() game:chooseTarget(function() return minion() and this():getAttack() <= 3 end, function() this():destroy(); end); end

local spell = Card:createSpell(123, 'Divine Spirit', 2, 'Priest', 'Double a minion\'s Health.', 'Basic');
spell.onCast = function() game:chooseTarget(minion, function() this():gain(0, this():getHealth()); end); end

local spell = Card:createSpell(141, 'Mind Blast', 3, 'Priest', 'Deal $SPELL_POWER:5$ damage to the enemy hero.', 'Basic');
spell.onCast = function() game:currentOpponent():spellDamage(5, game:currentPlayer()); end

local spell = Card:createSpell(131, 'Thoughtsteal', 3, 'Priest', 'Copy 2 cards from your opponents deck and put them in your hand.', 'Common');
spell.onCast = function() for i = 1, 2, 1 do this().owner:drawCard(this().owner.opponent.library:get(0).card.name); this().owner.opponent:shuffle(); end end;

local spell = Card:createSpell(138, 'Mass Dispel', 4, 'Priest', 'Silence all enemy minions. Draw a Card.', 'Rare');
spell.onCast = function() this().owner:draw(); game:forEach(enemyMinion, function() this():silence() end); end

local spell = Card:createSpell(144, 'Holy Nova', 5, 'Priest', 'Deal $SPELL_POWER:2$ damage to all enemies. Restore 2 Health to all friendly characters.', 'Basic');
spell.onCast = function() game:spellDamageForEach(enemy, 2, game:currentPlayer()); game:forEach(friendly, function() this():heal(2); end); end;

local spell = Card:createSpell(145, 'Mind Control', 8, 'Priest', 'Take control of an enemy minion.', 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(enemyMinion, function() this().controller.board:remove(this()); this().controller = source.owner; source.owner.board:add(this()); end); end;

-- MINIONS

local spell = Card:createMinion(136, 'Lightwell', 2, 'Priest', 'At the start of your turn, restore 3 Health to a damaged friendly character.', 0, 5, 'Rare');
spell.onStartOfTurn = function() if this().controller == game:currentPlayer() then game:chooseTarget(function() return friendly() and damaged() end, function() this():heal(3); end); end end;

local spell = Card:createMinion(23, 'Northshire Cleric', 2, 'Priest', 'When a minion is healed, draw a card.', 1, 3, 'Basic');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onHeal = function() if minion() then source.controller:draw(); end end end;

local spell = Card:createMinion(24, 'Cabal Shadow Priest', 6, 'Priest', 'Battlecry: Take control of an enemy minion that has 2 or less Attack.', 3, 4, 'Epic');
spell.onCast = function() local source = this(); game:chooseTarget(function() return enemyMinion() and this():getAttack() <= 2; end, function() this().controller.board:remove(this()); this().controller = source.owner; source.owner.board:add(this()); end); end;

local spell = Card:createMinion(25, 'Prophet Velen', 7, 'Priest', 'Battlecry: Draw a card for each undamaged Character.', 5, 7, 'Legendary');
spell.onCast = function() local source = this(); game:forEach(function() return character() and not damaged() and this() ~= source end, function() source.owner:draw(); end); end;

-- MISSING


local spell = Card:createSpell(0, 'Mind Vision', 1, 'Priest', '', 'Basic')
spell.broken = true;

local spell = Card:createSpell(0, 'Inner Fire', 1, 'Priest', '', 'Common')
spell.broken = true;

local spell = Card:createSpell(0, 'Shadow Word: Death', 3, 'Priest', '', 'Basic')
spell.broken = true;

local spell = Card:createSpell(0, 'Mindgames', 4, 'Priest', '', 'Epic')
spell.broken = true;

local spell = Card:createSpell(0, 'Holy Fire', 6, 'Priest', '', 'Rare')
spell.broken = true;

local spell = Card:createSpell(0, 'Shadow Madness', 4, 'Priest', '', 'Rare')
spell.broken = true;

local spell = Card:createMinion(0, 'Auchenai Soulpriest', 4, 'Priest', '', 3, 5, 'Rare', '')
spell.broken = true;

local spell = Card:createMinion(0, 'Lightspawn', 4, 'Priest', '', 0, 5, 'Common', '')
spell.broken = true;

local spell = Card:createMinion(0, 'Temple Enforcer', 6, 'Priest', '', 6, 6, 'Common', '')
spell.broken = true;






