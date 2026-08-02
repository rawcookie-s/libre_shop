local ITEMICON = {}

local overlaynormal = Material("gui/ContentIcon-normal.png")
local overlayhovered = Material("gui/ContentIcon-hovered.png")
local crossmaterial = Material("icon16/cross.png")

local shadow = Color(0, 0, 0, 200)

local function DrawShadowText(text, x, y)
    draw.SimpleText(text, "DermaDefault", x + 1, y + 1, shadow)
    draw.SimpleText(text, "DermaDefault", x, y, color_white)
end

function ITEMICON:Init()
    self:SetText("")
    self:SetSize(128, 128)

    self.Image = self:Add("DImage")
    self.Image:SetPos(3, 3)
    self.Image:SetSize(122, 122)
    self.Image:SetVisible(false)

    self.CanAfford = true

    self.Border = 0
    self.Name = ""
end

function ITEMICON:SetMaterial(name)
    local mat = type(name) == "IMaterial" and name or Material(name)

    if !mat or mat:IsError() then
        name = name:Replace("entities/", "VGUI/entities/")
        mat = Material(name)
    end

    if !mat or mat:IsError() then return end

    self.Image:SetMaterial(mat)
end

function ITEMICON:SetName(name)
    self.Name = name
end

function ITEMICON:Paint(w, h)
    self.Border = (self.Depressed and !self.Dragging) and 8 or 0

    render.PushFilterMag(TEXFILTER.ANISOTROPIC)
    render.PushFilterMin(TEXFILTER.ANISOTROPIC)

    self.Image:PaintAt(3 + self.Border, 3 + self.Border, 128 - 8 - self.Border * 2, 128 - 8 - self.Border * 2)

    render.PopFilterMin()
    render.PopFilterMag()

    surface.SetDrawColor(color_white)

    if self:IsHovered() or self.Depressed or self:IsChildHovered() then
        surface.SetMaterial(overlayhovered)
    else
        surface.SetMaterial(overlaynormal)
    end

    surface.DrawTexturedRect(self.Border, self.Border, w - self.Border * 2, h - self.Border * 2)

    if !self.CanAfford then
		surface.SetMaterial(crossmaterial)
		surface.DrawTexturedRect( self.Border + 8, self.Border + 8, 16, 16 )
	end

    if self.Name == "" then return end

    local buffer = self.Border + 10

    local px, py = self:LocalToScreen(buffer, 0)
    local pw, ph = self:LocalToScreen(w - buffer, h)

    render.SetScissorRect(px, py, pw, ph, true)

    surface.SetFont("DermaDefault")

    local tw, th = surface.GetTextSize(self.Name)

    local x = w * 0.5 - tw * 0.5

    if tw > (w - buffer * 2) then
        local mx = select(1, self:ScreenToLocal(input.GetCursorPos()))
        local diff = tw - w + buffer * 2

        x = buffer + math.Remap(math.Clamp(mx, 0, w), 0, w, 0, -diff)
    end

    DrawShadowText(self.Name, x, h - th - 9)

    render.SetScissorRect(0, 0, 0, 0, false)
end

vgui.Register("LibreShop::ItemIcon", ITEMICON, "DButton")