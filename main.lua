--[[
    Hush, little Zeal, don't you cry,
    Mama's gonna sing you a lullaby.
    And if that lullaby's too soft,
    Papa's gonna rock you back and forth.

    If those dreams should fade away,
    Mama's gonna hold you night and day.
    And if the stars don't shine so bright,
    Papa's gonna stay with you all night.

    So hush, little Zeal, close your eyes,
    In our arms, love never dies.
    Dream sweet dreams and sleep so tight,
    We'll be here till morning light.
]]
local goodnight_zeal_addon = {
    name = "Goodnight zeal",
    version = "1.0.1",
    author = "Fmp",
    desc = "Goodnight sweet zeal"
}

local windowWidth = 1200
local windowHeight = 800

-- Avoid global name collisions by declaring file locals
local canvas
local zealIconView
local hitbox

local function CalculatePhysics()
    -- Update ball positions
    hitbox.x = hitbox.x + hitbox.velocity.x 
    hitbox.y = hitbox.y + hitbox.velocity.y 

    -- Check collision with window
    if hitbox.y <= 0 or hitbox.y >= windowHeight - hitbox.size then
        hitbox.velocity.y = hitbox.velocity.y * -1
    end

    if hitbox.x <= 0 or hitbox.x >= windowWidth - hitbox.size then
        hitbox.velocity.x = hitbox.velocity.x * -1
    end
end

local function DrawView() 
    zealIconView:AddAnchor("TOPLEFT", canvas, "TOPLEFT", hitbox.x, hitbox.y)
end

local function OnDraw()
    CalculatePhysics()
    DrawView()
end

local function OnLoad() 
    -- Create canvas
    canvas = api.Interface:CreateWindow("Canvas", "", windowWidth, windowHeight)
    canvas:Show(true)
    canvas:AddAnchor("CENTER", "UIParent", 0, 0)
    
    -- Create icon
    zealIconView = CreateItemIconButton("zealIcon", canvas)
	zealIconView:Show(true)
    local trackedBuffInfo = api.Ability:GetBuffTooltip(495)
	F_SLOT.ApplySlotSkin(zealIconView, zealIconView.back, SLOT_STYLE.BUFF)
    F_SLOT.SetIconBackGround(zealIconView, trackedBuffInfo.path)

    -- Create hitbox
    hitbox = {}
    hitbox.size = 43

    -- Generate random starting position
    hitbox.x = math.random(1, windowWidth - hitbox.size)
    hitbox.y = math.random(1, windowHeight - hitbox.size)

    hitbox.velocity = {x = 1.3, y = 0.4}

    -- Register frame callback
    api.On("UPDATE", OnDraw)
end

local function OnUnload()
	if canvas ~= nil then
		canvas:Show(false)
		canvas = nil
	end
end

-- The following will let the game know about the OnLoad function
goodnight_zeal_addon.OnLoad = OnLoad
goodnight_zeal_addon.OnUnload = OnUnload

return goodnight_zeal_addon