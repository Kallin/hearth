-- HERO

local spell = Card:createAbility(10000, 'Uther the Lightbringer', 2, 'Paladin', 'Summon a 1/1 Silver Hand Recruit.', 'Uncollectible');
spell.onCast = function() this().owner:summon('Silver Hand Recruit'); end;

local spell = Card:createMinion(10000, 'Silver Hand Recruit', 3, '', '', 1, 1, 'Uncollectible');
spell.token = true;

-- WEAPONS

local spell = Card:createWeapon(304, 'Light\'s Justice', 1, 'Paladin', '', 1, 4, 'Basic');

local spell = Card:createWeapon(298, 'Sword of Justice', 3, 'Paladin', 'Whenever you play a minion, give it +1/+1 and this loses a Durability.', 1, 5, 'Epic');
spell.onCast = function()
    local source = this();
    this():addGlobalAura('NONE', 0, false).onSummon =
    function()
        if source.owner == this().owner and this().card.type == "minion" then
            this():gain(1, 1); source:looseDurability(1);
        end
    end
end;

local spell = Card:createWeapon(323, 'Truesilver Champion', 4, 'Paladin', 'When your hero attacks, restore 2 Health to it.', 4, 2, 'Basic');
spell.onCast = function() this():addGlobalAura('NONE', 0, false).onAttack = function() if this() == aura().owner.controller then aura().owner.controller:heal(2); end end; end;

-- SPELLS

local spell = Card:createSpell(296, 'Blessing of Wisdom', 1, 'Paladin', 'Choose a minion. Whenever it attacks, draw a card.', 'Common');
spell.onCast = function() local source = this();
game:chooseTarget(minion, function()
    this():addAura('NONE', 0, false).onAttack = function() this().controller:draw(); end
end);
end;

local spell = Card:createSpell(297, 'Repentance', 1, 'Paladin', 'Secret: When your opponent plays a minion, reduce its Health to 1.', 'Common');
spell.onCast = function() local source = this(); this().owner:addSecretAura(function() other().health = 1; end).onSummon =
function() if source.owner ~= this().owner and minion() then aura():trigger(this()); end end
end;

local spell = Card:createSpell(210, 'Equality', 2, 'Paladin', 'Change the Health of ALL minions to 1.', 'Rare');
spell.onCast = function() game:forEach(minion, function() this().health = 1; end); end;

local spell = Card:createSpell(326, 'Divine Favor', 2, 'Paladin', 'Draw cards until you have as many in hand as your opponent.', 'Rare');
spell.onCast = function() for i = 1, (this().owner.opponent.hand:size() - this().owner.hand:size()), 1 do this().owner:draw(); end end;

local spell = Card:createSpell(305, 'Blessing of Kings', 4, 'Paladin', 'Give a minion +4/+4.', 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(minion, function() this():gain(4, 4); end); end;


local spell = Card:createSpell(311, 'Consecration', 4, 'Paladin', 'Deal $SPELL_POWER:2$ damage to all enemies.', 'Basic');
spell.onCast = function() local source = this(); game:spellDamageForEach(enemy, 2, source.owner); end;


local spell = Card:createSpell(316, 'Hammer of Wrath', 4, 'Paladin', 'Deal $SPELL_POWER:3$ damage. Draw a card.', 'Basic');
spell.onCast = function() local source = this(); game:chooseTarget(character, function() this():spellDamage(3, source.owner); source.owner:draw(); end); end;

-- MINIONS

local spell = Card:createMinion(312, 'Aldor Peacekeeper', 3, 'Paladin', 'Battlecry: Change an enemy minion\'s Attack to 1.', 3, 3, 'Rare', '');
spell.onCast = function() game:chooseTarget(enemyMinion, function() this():gain(-this():getAttack() + 1, 0); end); end;

local spell = Card:createMinion(303, 'Guardian of Kings', 7, 'Paladin', 'Battlecry: Restore 6 Health to your hero.', 5, 6, 'Basic', '');
spell.onCast = function() this().owner:heal(6); end;

local spell = Card:createMinion(128, 'Tirion Fordring', 8, 'Paladin', 'Divine Shield, Taunt, Battlecry: Draw a card for each enemy minion.', 6, 6, 'Legendary');
spell.divineShield = true;
spell.taunt = true;
spell.onCast = function() local source = this(); game:forEach(enemyMinion, function() source.owner:draw(); end); end;

-- MISSING

local spell = Card:createSpell(0, 'Humility', 1, 'Paladin', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Blessing of Might', 1, 'Paladin', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Hand of Protection', 1, 'Paladin', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Holy Light', 2, 'Paladin', '', 'Basic');
spell.broken = true;

local spell = Card:createSpell(0, 'Avenging Wrath', 6, 'Paladin', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Lay on Hands', 8, 'Paladin', '', 'Epic');
spell.broken = true;

local spell = Card:createSpell(0, 'Blessed Champion', 5, 'Paladin', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Eye for an Eye', 1, 'Paladin', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(0, 'Holy Wrath', 5, 'Paladin', '', 'Rare');
spell.broken = true;

local spell = Card:createSpell(0, 'Noble Sacrifice', 1, 'Paladin', '', 'Common');
spell.broken = true;

local spell = Card:createSpell(0, 'Redemption', 1, 'Paladin', '', 'Common');
spell.broken = true;

local spell = Card:createMinion(0, 'Argent Protector', 2, 'Paladin', '', 2, 2, 'Common');
spell.broken = true;









