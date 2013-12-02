--MINIONS

local spell = Card:createMinion(107, 'Abomination', 5, '', 'Taunt. Deathrattle: Deal 2 damage to ALL characters.', 4, 4, 'Rare');
spell.taunt = true;
spell.onDeath = function() local source = this(); game:damageForEach(character, 2); end;

local spell = Card:createMinion(45, 'Acolyte of Pain', 3, '', 'Whenever this minion takes damage, draw a card.', 1, 3, 'Common');
spell.onDamage = function() this().controller:draw(); end;

local spell = Card:createMinion(34, 'Alexstrasza', 9, '', 'Battlecry: Set a hero\'s remaining Health to 15.', 8, 8, 'Legendary', 'Dragon');
spell.onCast = function() game:chooseTarget(hero, function() this().health = 15; end) end;

local spell = Card:createMinion(16, 'Amani Berserker', 2, '', 'Enrage: +3 Attack', 2, 3, 'Common');
spell.onCast = function() this():addAura('ATTACK', function() if damaged() then return 3 else return 0 end end, false); end;

local spell = Card:createMinion(50, 'Ancient Brewmaster', 4, '', 'Battlecry: Return a friendly minion from your battlefield to your hand.', 5, 4, 'Common');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this():unsummon() end); end;

local spell = Card:createMinion(60, 'Ancient Watcher', 2, '', 'Can\'t Attack.', 4, 5, 'Rare');
spell.defender = true;

local spell = Card:createMinion(104, 'Angry Chicken', 1, '', 'Enrage: +5 Attack', 1, 1, 'Rare', 'Beast');
spell.onCast = function() this():addAura('ATTACK', function() if damaged() then return 5 else return 0 end end, false); end;

local spell = Card:createMinion(77, 'Arcane Golem', 3, '', 'Charge, Battlecry: Give your opponent a Mana Crystal.', 4, 2, 'Rare');
spell.charge = true;
spell.onCast = function() this().owner.opponent:gainManaCrystals(1); end;

local spell = Card:createMinion(129, 'Argent Squire', 1, '', 'Divine Shield', 1, 1, 'Common');
spell.divineShield = true;

local spell = Card:createMinion(116, 'Baron Geddon', 7, '', 'At the end of your turn, deal 2 damage to ALL other characters.', 7, 5, 'Legendary');
spell.onEndOfTurn = function() if this().controller == game:currentPlayer() then local source = this(); game:damageForEach(function() return character and this() ~= source end, 2); end end;

local spell = Card:createMinion(79, 'Blood Knight', 3, '', 'Battlecry: All minions lose Divine Shield. Gain +3/+3 for each Shield lost.', 3, 3, 'Epic');
spell.onCast = function() local source = this(); game:forEach(minion, function() if this().divineShield then this().divineShield = false; source:gain(3, 3) end end); end;

local spell = Card:createMinion(44, 'Bloodfen Raptor', 2, '', '', 3, 2, 'Basic', 'Beast');

local spell = Card:createMinion(61, 'Bloodmage Thalnos', 2, '', 'Spell Power +1, Deathrattle: Draw a card.', 1, 1, 'Legendary');
spell.onCast = function() local source = this(); this():addGlobalAura('SPELL_POWER', function() if this().owner == source.controller then return 1 else return 0 end end, false); end;
spell.onDeath = function() this().controller:draw(); end;

local spell = Card:createMinion(62, 'Bloodsail Raider', 2, '', 'Battlecry: Gain Attack equal to the Attack of your weapon.', 2, 3, 'Common', 'Pirate');
spell.onCast = function() if this().owner:hasWeapon() then this():gain(this().owner.weapon.attack, 0); end end;

local spell = Card:createMinion(63, 'Bluegill Warrior', 2, '', 'Charge', 2, 1, 'Basic', 'Murloc');
spell.charge = true;

local spell = Card:createMinion(112, 'Boulderfist Ogre', 6, '', '', 6, 7, 'Basic');

local spell = Card:createMinion(114, 'Cairne Bloodhoof', 6, '', 'Deathrattle: Summon a 4/5 Baine Bloodhoof.', 4, 5, 'Legendary');
spell.onDeath = function() this().controller:summon('Baine Bloodhoof'); end;

local spell = Card:createMinion(10000, 'Baine Bloodhoof', 6, '', '', 4, 5, 'Uncollectible');
spell.token = true;

local spell = Card:createMinion(205, 'Captain\'s Parrot', 1, '', 'Whenever you play a Pirate, draw a card.', 1, 2, 'Epic', 'Beast');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onSummon = function() if minion() and this().card.subtype == 'Pirate' and source.controller == this().owner then source.controller:draw(); end end; end;

local spell = Card:createMinion(103, 'Chillwind Yeti', 4, '', '', 4, 5, 'Basic');

local spell = Card:createMinion(80, 'Coldlight Oracle', 3, '', 'Battlecry: Each player draws 2 cards.', 2, 2, 'Rare', 'Murloc');
spell.onCast = function() for i = 1, 2, 1 do game:currentPlayer():draw(); game:currentOpponent():draw(); end end;

local spell = Card:createMinion(81, 'Coldlight Seer', 3, '', 'Battlecry: Give ALL other Murlocs +2 Health.', 2, 3, 'Rare', 'Murloc');
spell.onCast = function() local source = this(); game:forEach(function() return minion() and this().card.subtype == 'Murloc' and this() ~= source end, function() this():gain(0, 2) end); end;

local spell = Card:createMinion(180, 'Core Hound', 7, '', '', 9, 4, 'Basic', 'Beast');

local spell = Card:createMinion(51, 'Cult Master', 4, '', 'When one of your other minions dies, draw a card.', 3, 4, 'Common');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onDeath = function() if this() ~= source and source.controller == this().controller then source.controller:draw(); end end; end;

local spell = Card:createMinion(82, 'Dalaran Mage', 3, '', 'Spell Power +1', 2, 4, 'Basic');
spell.onCast = function() local source = this(); this():addGlobalAura('SPELL_POWER', function() if this().owner == source.controller then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(191, 'Dark Iron Dwarf', 4, '', 'Battlecry: Give a minion +2 Attack.', 4, 4, 'Common');
spell.onCast = function() game:chooseTarget(minion, function() this():gain(2, 0); end) end;

local spell = Card:createMinion(183, 'Darkscale Healer', 5, '', 'Battlecry: Restore 2 Health to all friendly characters.', 4, 5, 'Basic');
spell.onCast = function() game:forEach(friendly, function() this():heal(2); end) end;

local spell = Card:createMinion(19, 'Deathwing', 10, '', 'Battlecry: Destroy all other minions and discard your hand.', 8, 8, 'Legendary', 'Dragon');
spell.onCast = function() this().owner:discardRandom(this().owner.hand:size()); local source = this() game:forEach(function() return minion() and source ~= this() end, function() this():destroy(); end); end

local spell = Card:createMinion(110, 'Defender of Argus', 4, '', 'Battlecry: Give adjacent minions +1/+1 and Taunt.', 3, 3, 'Rare');
spell.onCast = function() this():forEachNeighbor(function() this():gain(1, 1); this().taunt = true; end); end;

local spell = Card:createMinion(83, 'Demolisher', 3, '', 'At the start of your turn, deal 2 damage to a random enemy.', 1, 4, 'Rare');
spell.onStartOfTurn = function() local source = this(); if game:currentPlayer() == this().controller then game:forEachRandom(1, enemy, function() this():damage(2, source); end); end end;

local spell = Card:createMinion(1, 'Dire Wolf Alpha', 2, '', 'Adjacent minions have +1 Attack.', 2, 2, 'Common', 'Beast');
spell.onCast = function() local source = this(); this():addGlobalAura('ATTACK', function() if minion() and this():adjacent(source) then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(65, 'Doomsayer', 2, '', 'At the start of your turn, destroy ALL minions.', 0, 7, 'Epic');
spell.onStartOfTurn = function() if game:currentPlayer() == this().controller then game:forEach(minion, function() this():destroy(); end); end end;

local spell = Card:createMinion(84, 'Earthen Ring Farseer', 3, '', 'Battlecry: Restore 3 health.', 3, 3, 'Common');
spell.onCast = function() game:chooseTarget(character, function() this():heal(3); end); end;

local spell = Card:createMinion(187, 'Elven Archer', 1, '', 'Battlecry: Deal 1 damage.', 1, 1, 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() this():damage(1, source); end); end;

local spell = Card:createMinion(85, 'Emperor Cobra', 3, '', 'Has +Attack equal to the number of Mana crystals you have.', 0, 1, 'Rare', 'Beast');
spell.onCast = function() this():addAura('ATTACK', function() return this().controller:getMaxMana(); end, false); end;

local spell = Card:createMinion(5, 'Faerie Dragon', 2, '', 'Can\'t be targeted by Spells or Hero Powers.', 3, 2, 'Common');
spell.shroud = true;

local spell = Card:createMinion(81590, 'Finkle Einhorn', 2, '', '', 3, 3, 'Uncollectible');

local spell = Card:createMinion(21, 'Flesheating Ghoul', 3, '', 'Whenever a minion dies, gain +1 Attack.', 2, 3, 'Common');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onDeath = function() source:gain(1, 0); end; end;

local spell = Card:createMinion(6, 'Frostwolf Grunt', 2, '', 'Taunt', 2, 2, 'Basic');
spell.taunt = true;

local spell = Card:createMinion(3, 'Gadgetzan Auctioneer', 5, '', 'When you cast a spell, draw a card.', 4, 4, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if this().card.type == 'spell' and source.controller == this().owner then source.controller:draw(); end end; end;

local spell = Card:createMinion(20, 'Goldshire Footman', 1, '', 'Taunt', 1, 2, 'Basic');
spell.taunt = true;

local spell = Card:createMinion(4, 'Grimscale Oracle', 1, '', 'ALL other Murlocs have +1 Attack.', 1, 1, 'Basic', 'Murloc');
spell.onCast = function() local source = this(); this():addGlobalAura('ATTACK', function() if minion() and source ~= this() and this().card.subtype == 'Murloc' then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(7, 'Ironbeak Owl', 2, '', 'Battlecry: Silence a minion.', 2, 1, 'Common');
spell.onCast = function() game:chooseTarget(minion, function() this():silence() end); end

local spell = Card:createMinion(173, 'Hogger', 6, '', 'At the end of your turn, summon a 2/2 Gnoll with Taunt.', 4, 4, 'Legendary');
spell.onEndOfTurn = function() if this().controller == game:currentPlayer() then this().controller:summon('Gnoll'); end; end;

local spell = Card:createMinion(10000, 'Gnoll', 6, '', '', 2, 2, 'Uncollectible');
spell.token = true;
spell.taunt = true;

local spell = Card:createMinion(189, 'Ironforge Rifleman', 3, '', 'Battlecry: Deal 1 damage.', 2, 2, 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() this():damage(1, source); end); end;

local spell = Card:createMinion(8, 'Knife Juggler', 2, '', 'When you play a minion, deal 1 damage to a random enemy.', 2, 3, 'Rare');
spell.onCast = function()
    local source = this();
    this():addGlobalAura('NONE', 0, false).onSummon =
    function()
        if this() ~= source and minion() and this().owner == source.controller then
            game:forEachRandom(1, enemy, function() this():damage(1, source); end);
        end;
    end;
end;

local spell = Card:createMinion(9, 'Kobold Geomancer', 2, '', 'Spell Power +1', 2, 2, 'Basic');
spell.onCast = function() local source = this(); this():addGlobalAura('SPELL_POWER', function() if this().owner == source.controller then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(186, 'Leper Gnome', 1, '', 'Deathrattle: Deal 2 damage to the enemy hero.', 1, 1, 'Common');
spell.onDeath = function() local source = this(); this().controller.opponent:damage(2, source); end;

local spell = Card:createMinion(10, 'Loot Hoarder', 2, '', 'Deathrattle: Draw a card.', 2, 1, 'Common');
spell.onDeath = function() this().controller:draw(); end;

local spell = Card:createMinion(194, 'Lord of the Arena', 6, '', 'Taunt', 6, 4, 'Basic');
spell.taunt = true;

local spell = Card:createMinion(175, 'Lorewalker Cho', 1, '', 'Whenever a player casts a spell, put a copy into the other player\'s hand.', 1, 3, 'Legendary');
spell.onCast = function()
    this():addGlobalAura('NONE', 0, false).onCast =
    function()
        if this().card.type == 'spell' then
            this().owner.opponent:drawCard(this().card.name);
        end;
    end;
end;

local spell = Card:createMinion(182, 'Magma Rager', 3, '', '', 5, 1, 'Basic');

local spell = Card:createMinion(35, 'Malygos', 9, '', 'Spell Power +5', 4, '12', 'Legendary', 'Dragon');
spell.onCast = function() local source = this(); this():addGlobalAura('SPELL_POWER', function() if this().owner == source.controller then return 5 else return 0 end end, false); end;

local spell = Card:createMinion(12, 'Mana Addict', 2, '', 'Whenever you cast a spell, gain +3 Attack this turn.', 1, 3, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if this().card.type == 'spell' and source.controller == this().owner then source:addAura('ATTACK', 3, true); end end; end;

local spell = Card:createMinion(66, 'Mana Wraith', 2, '', 'ALL minions costs (1) more.', 2, 2, 'Rare');
spell.onCast = function() this():addGlobalAura('COST', function() if this().card.type == 'minion' then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(67, 'Master Swordsmith', 2, '', 'At the end of your turn, give another random friendly Minion +1 Attack.', 2, 3, 'Rare');
spell.onEndOfTurn = function() if this().controller == game:currentPlayer() then local source = this(); game:forEachRandom(1, function() return friendlyMinion() and this() ~= source end, function() this():gain(1, 0); end); end end;



local spell = Card:createMinion(89, 'Mogu\'shan Warden', 4, '', 'Taunt', 1, 7, 'Common');
spell.taunt = true;

local spell = Card:createMinion(236, 'Molten Giant', '20', '', 'Costs (1) less for each damage your hero has taken.', 10, 10, 'Epic');
spell.costModifier = function() return this().health - this().maxHealth; end;

local spell = Card:createMinion(18, 'Mountain Giant', '12', '', 'Costs (1) less for each other card in your hand.', 10, 10, 'Epic');
spell.costModifier = function() return 1 - this().hand:size(); end;

local spell = Card:createMinion(88, 'Murloc Raider', 1, '', '', 2, 1, 'Basic', 'Murloc');

local spell = Card:createMinion(197, 'Murloc Tidecaller', 1, '', 'Whenever a Murloc is played, gain +1 Attack.', 1, 2, 'Rare', 'Murloc');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if minion() and this().card.subtype == 'Murloc' then source:gain(1, 0) end end; end;

local spell = Card:createMinion(68, 'Murloc Tidehunter', 2, '', 'Battlecry: Summon a 1/1 Murloc Scout.', 2, 1, 'Basic', 'Murloc');
spell.onCast = function() this().owner:summon('Murloc Scout'); end;

local spell = Card:createMinion(10000, 'Murloc Scout', 2, '', '', 1, 1, 'Uncollectible', 'Murloc');
spell.token = true;

local spell = Card:createMinion(70, 'Nat Pagle', 2, '', 'At the end of your turn, you have a 50% chance to draw a card.', 0, 5, 'Legendary');
spell.onEndOfTurn = function() if this().controller == game:currentPlayer() and game:random(1, 2) == 1 then this().controller:draw(); end end;

local spell = Card:createMinion(181, 'Nightblade', 5, '', 'Battlecry: Deal 3 damage to the enemy hero.', 4, 4, 'Basic');
spell.onCast = function() local source = this(); this().owner.opponent:damage(3, source); end;

local spell = Card:createMinion(71, 'Novice Engineer', 2, '', 'Battlecry: Draw a card.', 1, 2, 'Basic');
spell.onCast = function() this().owner:draw(); end;

local spell = Card:createMinion(36, 'Nozdormu', 9, '', 'Players only have 15 second to take their turns.', 8, 8, 'Legendary', 'Dragon');

local spell = Card:createMinion(101, 'Oasis Snapjaw', 4, '', '', 2, 7, 'Basic', 'Beast');

local spell = Card:createMinion(127, 'Priestess of Elune', 6, '', 'Battlecry: Restore 4 Health to your hero.', 5, 4, 'Common');
spell.onCast = function() this().owner:heal(7); end;

local spell = Card:createMinion(168, 'Ragnaros the Firelord', 8, '', 'Can\'t Attack. At the end of your turn, deal 8 damage to a random enemy.', 8, 8, 'Legendary');
spell.defender = true;
spell.onEndOfTurn = function() local source = this(); if this().controller == game:currentPlayer() then game:forEachRandom(1, enemy, function() this():damage(8, source); end); end end;

local spell = Card:createMinion(78, 'Big Game Hunter', 3, '', 'Battlecry: Destroy a minion with an Attack of 7 or more.', 4, 2, 'Epic');
spell.onCast = function() game:chooseTarget(function() return enemyMinion() and this():getAttack() >= 7 end, function() this():destroy(); end) end;

local spell = Card:createMinion(42, 'Raid Leader', 3, '', 'Your other minions have +1 Attack.', 2, 2, 'Basic');
spell.onCast = function() local source = this(); this():addGlobalAura('ATTACK', function() if minion() and this().controller == source.controller and this() ~= source then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(178, 'Razorfen Hunter', 3, '', 'Battlecry: Summon a 1/1 Boar.', 2, 3, 'Basic');
spell.onCast = function() this().owner:summon('Boar'); end;

local spell = Card:createMinion(10000, 'Boar', 3, '', '', 1, 1, 'Uncollectible', 'Beast');
spell.token = true;

local spell = Card:createMinion(73, 'River Crocolisk', 2, '', '', 2, 3, 'Basic', 'Beast');

local spell = Card:createMinion(39, 'Sea Giant', '12', '', 'Costs (1) less for each other minion on the battlefield.', 10, 10, 'Epic');
spell.costModifier = function() return -(this().board:size() + this().opponent.board:size()); end;

local spell = Card:createMinion(43, 'Sen\'jin Shieldmasta\'', 4, '', 'Taunt', 3, 5, 'Basic');
spell.taunt = true;

local spell = Card:createMinion(188, 'Shattered Sun Cleric', 3, '', 'Battlecry: Give a friendly minion +1/+1.', 3, 3, 'Basic');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this():gain(1, 1); end); end;

local spell = Card:createMinion(26, 'Shieldbearer', 1, '', 'Taunt. Enrage: +1 Attack.', 0, 4, 'Common');
spell.taunt = true;
spell.onCast = function() this():addAura('ATTACK', function() if damaged() then return 1 else return 0 end end, false); end;

local spell = Card:createMinion(94, 'Silver Hand Knight', 5, '', 'Battlecry: Summon a 2/2 Squire.', 4, 4, 'Common');
spell.onCast = function() this().owner:summon('Squire'); end;

local spell = Card:createMinion(10000, 'Squire', 3, '', '', 2, 2, 'Uncollectible');
spell.token = true;

local spell = Card:createMinion(96, 'Silverback Patriarch', 3, '', 'Taunt', 1, 4, 'Basic', 'Beast');
spell.taunt = true;

local spell = Card:createMinion(99, 'Southsea Deckhand', 1, '', 'Battlecry: Your equipped weapon gets +1 Durability.', 2, 1, 'Common', 'Pirate');
spell.onCast = function() if this().owner:hasWeapon() then this().owner.weapon.durability = this().owner.weapon.durability + 1; end end;

local spell = Card:createMinion(90, 'Spellbreaker', 4, '', 'Battlecry: Silence a minion.', 4, 3, 'Common');
spell.onCast = function() game:chooseTarget(minion, function() this():silence() end); end

local spell = Card:createMinion(193, 'Stonetusk Boar', 1, '', 'Charge', 1, 1, 'Basic', 'Beast');
spell.charge = true;

local spell = Card:createMinion(13, 'Stormpike Commando', 5, '', 'Battlecry: Deal 2 damage.', 4, 2, 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() this():damage(2, source); end); end;

local spell = Card:createMinion(177, 'Stormwind Knight', 4, '', 'Charge', 2, 5, 'Basic');
spell.charge = true;

local spell = Card:createMinion(74, 'Sunfury Protector', 2, '', 'Battlecry: Your other minions gain Taunt.', 2, 3, 'Rare');
spell.onCast = function() local source = this() game:forEach(function() return friendlyMinion() and source ~= this() end, function() this().taunt = true; end); end

local spell = Card:createMinion(17, 'Sylvannas Windrunner', 5, '', 'Battlecry: Discard your hand. Draw five 3/3 Skeletons.', 5, 5, 'Legendary');
spell.onCast = function() this().owner.hand:clear(); for i = 1, 3, 1 do this().owner:drawCard('Skeleton'); end; end;

local spell = Card:createMinion(10000, 'Skeleton', 1, '', '', 3, 3, 'Uncollectible');

local spell = Card:createMinion(164, 'The Beast', 6, '', 'Deathrattle: Summon a 3/3 Finkle Einhorn for your opponent.', 10, 6, 'Legendary', 'Beast');
spell.onDeath = function() this().controller.opponent:summon('Finkle Einhorn'); end;

local spell = Card:createMinion(31, 'The Black Knight', 6, '', 'Battlecry: Destroy a minion with Taunt.', 4, 5, 'Legendary');
spell.onCast = function() game:chooseTarget(function() return minion() and this().taunt end, function() this():destroy(); end); end;

local spell = Card:createMinion(286, 'Voodoo Doctor', 1, '', 'Battlecry: Restore 2 Health', 2, 1, 'Basic');
spell.onCast = function() game:chooseTarget(character, function() this():heal(2); end); end;

local spell = Card:createMinion(179, 'War Golem', 7, '', '', 7, 7, 'Basic');

local spell = Card:createMinion(49, 'Wild Pyromancer', 2, '', 'Whenever you cast a spell, deal 1 damage to a random enemy.', 3, 2, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if this().card.type == 'spell' and source.controller == this().owner then game:forEachRandom(1, enemy, function() this():damage(1, source) end); end end; end;

local spell = Card:createMinion(15, 'Windfury Harpy', 6, '', 'Windfury.', 4, 5, 'Common');
spell.windfury = true;

local spell = Card:createMinion(106, 'Wisp', 0, '', '', 1, 1, 'Common');

local spell = Card:createMinion(111, 'Wolfrider', 3, '', 'Charge', 3, 1, 'Basic');
spell.charge = true;

local spell = Card:createMinion(32, 'Worgen Infiltrator', 1, '', 'Stealth', 2, 1, 'Common');
spell.stealth = true;

local spell = Card:createMinion(29, 'Young Dragonhawk', 1, '', 'Windfury', 1, 1, 'Common', 'Beast');
spell.windfury = true;

local spell = Card:createMinion(75, 'Youthful Brewmaster', 2, '', 'Battlecry: Return a friendly minion from the battlefield to your hand.', 3, 2, 'Common');
spell.onCast = function() game:chooseTarget(friendlyMinion, function() this():unsummon() end); end;

local spell = Card:createMinion(260, 'Argent Commander', 6, '', 'Charge, Divine Shield.', 4, 3, 'Rare');
spell.charge = true;
spell.divineShield = true;




local spell = Card:createMinion(11, 'Mad Bomber', 2, '', 'Battlecry: Deal 3 damage randomly split between all other characters.', 3, 2, 'Common');
spell.onCast = function() local source = this(); for i = 1, 3, 1 do game:forEachRandom(1, function() return character() and this() ~= source end, function() this():damage(1, source) end); end end;

local spell = Card:createMinion(185, 'Stormwind Champion', 6, '', 'Your other minions have +1/+1.', 6, 6, 'Basic');
spell.onCast = function() local source = this();
this():addGlobalAura('ATTACK', function() if minion() and this().controller == source.controller and this() ~= source then return 1 else return 0 end end, false);
this():addGlobalAura('HEALTH', function() if minion() and this().controller == source.controller and this() ~= source then return 1 else return 0 end end, false);
end;
local spell = Card:createMinion(72, 'Pint-sized Summoner', 2, '', 'The first minion you play each turn costs (2) less.', 2, 2, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('COST', function() if this().card.type == 'minion' and this().owner == source.controller and game.minionsPlayed == 0 then return -2 else return 0 end end, false); end;

local spell = Card:createMinion(105, 'Lightwarden', 1, '', 'Whenever a character is healed, gain +1 Attack.', 1, 2, 'Rare');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onHeal = function() source:gain(1, 0) end end;

local spell = Card:createMinion(37, 'Onyxia', 9, '', 'When you draw a card, deal 2 damage to ALL characters.', 8, 8, 'Legendary', 'Dragon');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onDraw = function() if this().owner == source.controller then game:damageForEach(character, 2); end; end end;

local spell = Card:createMinion(108, 'Mind Control Tech', 3, '', 'Battlecry: Swap this with a random enemy minion.', 3, 3, 'Rare');
spell.onCast = function() local source = this();
game:forEachRandom(1, enemyMinion, function()
    local controller = this().controller;
    source.controller.board:remove(source);
    this().controller.board:remove(this());
    source.controller = controller;
    this().controller = source.owner;
    controller.board:add(source);
    source.owner.board:add(this());
end);
end;

local spell = Card:createMinion(294, 'Leeroy Jenkins', 4, '', 'Charge. Battlecry: Summon two 1/1 Whelps for your opponent.', 6, 2, 'Legendary', '');
spell.charge = true;
spell.onCast = function() for i = 1, 2, 1 do this().owner.opponent:summon('Whelp'); end end;
local spell = Card:createMinion(294, 'Whelp', 0, '', '', 1, 1, 'Uncollectible', '');
spell.token = true;

local spell = Card:createMinion(299, 'Harvest Golem', 3, '', 'Deathrattle: Summon a 2/1 Damaged Golem.', 2, 3, 'Common', '');
spell.onDeath = function() this().controller:summon('Damaged Golem'); end;

local spell = Card:createMinion(299, 'Damaged Golem', 0, '', '', 2, 1, 'Uncollectible', '');
spell.token = true;

local spell = Card:createMinion(300, 'Secretkeeper', 1, '', 'Whenever a Secret is revealed, gain +1/+1.', 2, 1, 'Rare', '');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onSecredRevealed =
function() source:gain(1, 1); end
end;

local spell = Card:createMinion(302, 'Imp Master', 3, '', 'At the end of your turn, deal 1 damage to this minion and summon a 1/1 Imp.', 1, 6, 'Rare', '');
spell.onEndOfTurn = function() if game:currentPlayer() == this().controller then this():damage(1, this()); this().controller:summon('Imp'); end end;
local spell = Card:createMinion(302, 'Imp', 0, '', '', 1, 1, 'Uncollectible', 'Demon');
spell.token = true;

local spell = Card:createMinion(97, 'Tauren Warrior', 3, '', 'Taunt. Enrage: +3 Attack', 2, 3, 'Common');
spell.taunt = true;
spell.onCast = function() this():addAura('ATTACK', function() if damaged() then return 3 else return 0 end end, false); end;


local spell = Card:createMinion(310, 'Acidic Swamp Ooze', 2, '', 'Battlecry: Destroy your opponent\'s weapon.', 3, 2, 'Basic', '');
spell.onCast = function() if this().owner.opponent:hasWeapon() then this().owner.opponent.weapon:destroy(); end end;

local spell = Card:createMinion(315, 'Captain Greenskin', 5, '', 'Whenever you attack with your hero, draw a card.', 5, 5, 'Legendary', 'Pirate');
spell.onCast = function() this():addGlobalAura('NONE', 0, false).onAttack = function() if this() == aura().owner.controller then aura().owner.controller:draw(); end end; end;

local spell = Card:createMinion(319, 'Stampeding Kodo', 5, '', 'Battlecry: Destroy a random enemy minion with 2 or less Attack.', 3, 5, 'Rare', 'Beast');
spell.onCast = function() game:forEachRandom(1, function() return enemyMinion() and this():getAttack() <= 2; end, function() this():destroy() end); end;

local spell = Card:createMinion(322, 'Sunwalker', 6, '', 'Taunt. Divine Shield', 4, 5, 'Rare', '');
spell.taunt = true;
spell.divineShield = true;

local spell = Card:createMinion(324, 'Young Priestess', 1, '', 'At the end of your turn, give another random friendly minion +1 Health.', 1, 2, 'Rare', '');
spell.onCast = function() local source = this(); this():addAura('NONE', 0, false).onEndOfTurn = function() if source.controller == game:currentPlayer() then game:forEachRandom(1, function() return friendlyMinion() and this() ~= source end, function() this():gain(0, 1); end); end; end; end;

local spell = Card:createMinion(325, 'Violet Teacher', 4, '', 'Whenever you cast a spell, summon a 1/1 Violet Apprentice.', 3, 5, 'Rare', '');
spell.onCast = function() local source = this(); this():addGlobalAura('NONE', 0, false).onCast = function() if this().owner == source.controller and this().card.type == "spell" then source.controller:summon('Violet Apprentice'); end end; end;
local spell = Card:createMinion(83250, 'Violet Apprentice', 0, '', '', 1, 1, 'Uncollectible', '');
spell.token = true;

local spell = Card:createMinion(293, 'Ironfur Grizzly', 3, '', 'Taunt', 3, 3, 'Basic', 'Beast');
spell.taunt = true;


local spell = Card:createMinion(235, 'King Mukla', 3, '', 'Battlecry: Give your opponent two Bananas.', 5, 5, 'Legendary', 'Beast');
spell.onCast = function() for i = 1, 2, 1 do this().owner.opponent:drawCard('Bananas'); end end;

local spell = Card:createSpell(82350, 'Bananas', 1, '', 'Give a minion +1/+1.', 'Uncollectible');
spell.onCast = function() local source = this(); game:chooseTarget(minion, function() this():gain(1, 1); end); end;

-- Missing

local spell = Card:createMinion(69, 'Millhouse Manastorm', 2, '', '', 4, 4, 'Legendary');
spell.broken = true

local spell = Card:createMinion(0, 'Gelbin Mekkatorque', 6, '', '', 6, 6, 'Legendary');
spell.broken = true

local spell = Card:createMinion(0, 'Gruul', 8, '', '', 7, 7, 'Legendary');
spell.broken = true

local spell = Card:createMinion(0, 'Harrison Jones', 5, '', '', 5, 4, 'Legendary');
spell.broken = true

local spell = Card:createMinion(0, 'Illidan Stormrage', 6, '', '', 7, 5, 'Legendary', 'Demon');
spell.broken = true

local spell = Card:createMinion(0, 'Old Murk-Eye', 4, '', '', 2, 4, 'Legendary');
spell.broken = true

local spell = Card:createMinion(0, 'Tinkmaster Overspark', 3, '', '', 2, 2, 'Legendary');
spell.broken = true

local spell = Card:createMinion(0, 'Ysera', 9, '', '', 4, 12, 'Legendary', 'Dragon');
spell.broken = true

local spell = Card:createMinion(0, 'Faceless Manipulator', 5, '', '', 3, 3, 'Epic');
spell.broken = true

local spell = Card:createMinion(0, 'Hungry Crab', 1, '', '', 1, 2, 'Epic', 'Beast');
spell.broken = true

local spell = Card:createMinion(0, 'Murloc Warleader', 3, '', '', 3, 3, 'Epic');
spell.broken = true

local spell = Card:createMinion(0, 'Southsea Captain', 3, '', '', 3, 3, 'Epic');
spell.broken = true

local spell = Card:createMinion(0, 'Alarm-o-Bot', 3, '', '', 0, 3, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Ancient Mage', 4, '', '', 2, 5, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Azure Drake', 5, '', '', 4, 4, 'Rare', 'Dragon');
spell.broken = true

local spell = Card:createMinion(0, 'Bloodsail Corsair', 1, '', '', 1, 2, 'Rare', 'Pirate');
spell.broken = true

local spell = Card:createMinion(0, 'Crazed Alchemist', 2, '', '', 2, 2, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Injured Blademaster', 3, '', '', 4, 7, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Questing Adventurer', 3, '', '', 2, 2, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Ravenholdt Assassin', 7, '', '', 7, 5, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Twlight Drake', 4, '', '', 4, 1, 'Rare');
spell.broken = true

local spell = Card:createMinion(0, 'Abusive Sergeant', 1, '', '', 2, 1, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Fen Creeper', 5, '', '', 3, 6, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Frost Elemental', 6, '', '', 5, 5, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Jungle Panther', 3, '', '', 4, 2, 'Common', 'Beast');
spell.broken = true

local spell = Card:createMinion(0, 'Raging Worgen', 3, '', '', 3, 3, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Scarlet Crusader', 3, '', '', 3, 1, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Silvermoon Guardian', 4, '', '', 3, 3, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Spiteful Smith', 5, '', '', 4, 6, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Stranglethorn Tiger', 5, '', '', 5, 5, 'Common', 'Beast');
spell.broken = true

local spell = Card:createMinion(0, 'Thrallmar Farseer', 3, '', '', 2, 3, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Venture Co. Mercenary', 5, '', '', 7, 6, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Dread Corsair', 4, '', '', 3, 3, 'Common');
spell.broken = true

local spell = Card:createMinion(0, 'Archmage', 6, '', '', 4, 7, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Booty Bay Bodyguard', 5, '', '', 5, 4, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Dragonling Mechanic', 4, '', '', 2, 4, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Frostwolf Warlord', 5, '', '', 4, 4, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Gnomish Inventor', 4, '', '', 2, 4, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Gurubashi Berserker', 5, '', '', 2, 7, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Ogre Magi', 4, '', '', 4, 4, 'Basic');
spell.broken = true

local spell = Card:createMinion(0, 'Reckless Rocketeer', 4, '', '', 4, 4, 'Basic');
spell.broken = true
