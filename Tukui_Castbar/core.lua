-- Standalone Castbar for Tukui by Krevlorne @ EU-Ulduar
-- Credits to Tukz, Syne, Elv22, Sweeper and all other great people of the Tukui community.

local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales

if ( TukuiUF ~= true and ( C == nil or C["unitframes"] == nil or not C["unitframes"]["enable"] ) ) then return; end

if (C["unitframes"].unitcastbar ~= true) then return; end

local addon, ns=...
config = ns.config

local function placeCastbar(unit)
    local font1 = C["media"].uffont
    local castbar = nil
    local castbarpanel = nil
    
    if (unit == "player") then
        castbar = TukuiPlayerCastBar
    else
        castbar = TukuiTargetCastBar
     end

    local castbarpanel = CreateFrame("Frame", castbar:GetName().."_Panel", castbar)
    local anchor = CreateFrame("Button", castbar:GetName().."_PanelAnchor", UIParent)
    anchor:SetAlpha(0)
    anchor:SetTemplate("Default")
    anchor:SetBackdropBorderColor(1, 0, 0, 1)
    anchor:SetMovable(true)
    anchor:SetSize(250, 21)
    anchor.text = T.SetFontString(anchor, font1, 12)
    anchor.text:SetPoint("CENTER")
    anchor.text:SetText(castbar:GetName())
    anchor.text.Show = function() anchor:SetAlpha(1) end
    anchor.text.Hide = function() anchor:SetAlpha(0) end
    
    if unit == "player" then
        anchor:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
        castbarpanel:CreatePanel("Default", 250, 21, "CENTER", anchor, "CENTER", 0, 0)
    else
        anchor:SetPoint("CENTER", UIParent, "CENTER", 0, -150)
        castbarpanel:CreatePanel("Default", 250, 21, "CENTER", anchor, "CENTER", 0, 0)
    end
    
    castbar:SetPoint("TOPLEFT", castbarpanel, TukuiDB.Scale(2), TukuiDB.Scale(-2))
    castbar:SetPoint("BOTTOMRIGHT", castbarpanel, TukuiDB.Scale(-2), TukuiDB.Scale(2))

    castbar.time = TukuiDB.SetFontString(castbar, font1, 12)
    castbar.time:SetPoint("RIGHT", castbarpanel, "RIGHT", TukuiDB.Scale(-4), 0)
    castbar.time:SetTextColor(0.84, 0.75, 0.65)
    castbar.time:SetJustifyH("RIGHT")

    castbar.Text = TukuiDB.SetFontString(castbar, font1, 12)
    castbar.Text:SetPoint("LEFT", castbarpanel, "LEFT", TukuiDB.Scale(4), 0)
    castbar.Text:SetTextColor(0.84, 0.75, 0.65)

    if C["unitframes"].cbicons == true then
        if unit == "player" then
            castbar.button:SetPoint("LEFT", TukuiDB.Scale(-40), 0)
        elseif unit == "target" then
            castbar.button:SetPoint("RIGHT", TukuiDB.Scale(40), 0)
        end
    end
    
    -- cast bar latency
    local normTex = C["media"].normTex;
    if C["unitframes"].cblatency == true then
        castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
        castbar.safezone:SetTexture(normTex)
        castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
        castbar.SafeZone = castbar.safezone
    end

    if (unit == "player") then
        TukuiPlayerCastBar.Castbar = castbar    
        TukuiPlayerCastBar.Castbar.Time = castbar.time
        TukuiPlayerCastBar.Castbar.Icon = castbar.icon
    else
        TukuiTargetCastBar.Castbar = castbar
        TukuiTargetCastBar.Castbar.Time = castbar.time
        TukuiTargetCastBar.Castbar.Icon = castbar.icon
    end
end


if (config.separateplayer) then
    placeCastbar("player")
end

if (config.separatetarget) then
    placeCastbar("target")
end

table.insert(T.MoverFrames, TukuiPlayerCastBar_PanelAnchor)
table.insert(T.MoverFrames, TukuiTargetCastBar_PanelAnchor)
