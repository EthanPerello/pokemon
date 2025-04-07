--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Pokemon = Class{}

function Pokemon:init(def, level)
    self.name = def.name

    self.battleSpriteFront = def.battleSpriteFront
    self.battleSpriteBack = def.battleSpriteBack

    self.baseHP = def.baseHP
    self.baseAttack = def.baseAttack
    self.baseDefense = def.baseDefense
    self.baseSpeed = def.baseSpeed

    self.HPIV = def.HPIV
    self.attackIV = def.attackIV
    self.defenseIV = def.defenseIV
    self.speedIV = def.speedIV

    self.HP = self.baseHP
    self.attack = self.baseAttack
    self.defense = self.baseDefense
    self.speed = self.baseSpeed

    self.level = level
    self.currentExp = 0
    self.expToLevel = self.level * self.level * 5 * 0.75

    self:calculateStats()

    self.currentHP = self.HP
end

function Pokemon:calculateStats()
    for i = 1, self.level do
        self:statsLevelUp()
    end
end

function Pokemon.getRandomDef()
    return POKEMON_DEFS[POKEMON_IDS[math.random(#POKEMON_IDS)]]
end

--[[
    Takes the IV (individual value) for each stat into consideration and rolls
    the dice 3 times to see if that number is less than or equal to the IV (capped at 5).
    The dice is capped at 6 just so no stat ever increases by 3 each time, but
    higher IVs will on average give higher stat increases per level. Returns all of
    the increases so they can be displayed in the TakeTurnState on level up.
]]
function Pokemon:statsLevelUp()
    self.HPX = self.HP
    self.HPIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.HPIV then
            self.HP = self.HP + 1
            self.HPIncrease = self.HPIncrease + 1
        end
    end

    self.HPZ = self.HP

    self.AttackX = self.attack
    self.AttackIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.attackIV then
            self.attack = self.attack + 1
            self.AttackIncrease = self.AttackIncrease + 1
        end
    end

    self.AttackZ = self.attack

    self.DefenseX = self.defense
    self.DefenseIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.defenseIV then
            self.defense = self.defense + 1
            self.DefenseIncrease = self.DefenseIncrease + 1
        end
    end

    self.DefenseZ = self.defense

    self.SpeedX = self.speed
    self.SpeedIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.speedIV then
            self.speed = self.speed + 1
            self.SpeedIncrease = self.SpeedIncrease + 1
        end
    end

    self.SpeedZ = self.speed

    return HPIncrease, attackIncrease, defenseIncrease, speedIncrease
end

function Pokemon:levelUp()
    self.level = self.level + 1
    self.expToLevel = self.level * self.level * 5 * 0.75

    return self:statsLevelUp()
end