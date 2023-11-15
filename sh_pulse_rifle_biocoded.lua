ITEM.name = "Импульсная винтовка AR2"
ITEM.baseDescription = "Самая сексуальная винтовка в мире." -- Основное описание
ITEM.description = ITEM.baseDescription .. "\nНомер: 00000 \nБиокодировано: ❌"
ITEM.model = "models/weapons/w_irifle.mdl"
ITEM.class = "weapon_ar2"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.height = 2
ITEM.owner = nil -- ВЛАДЕЛЕЦ, НЕ УДАЛЯТЬ, НЕ ЗАБЫВАТЬ, НЕ СРАТЬ
ITEM.bioEncoded = false
ITEM.number = "00000" -- Номер оружия
ITEM.iconCam = {
	ang	= Angle(-0.70499622821808, 268.25439453125, 0),
	fov	= 12.085652091515,
	pos	= Vector(0, 200, 0)
}

function ITEM:GetDescription()
	return self:GetData("description", self.description)
end

local function removeLastTwoLines(str) -- очистка двух последних линий
    local t = {}
    local i = 0
    for s in str:gmatch("[^\r\n]+") do
        i = i + 1
        t[i] = s
    end
    t[i-1] = nil
    t[i] = nil
    return table.concat(t, "\n")
end


ITEM.functions.BioEncode = {
	name = "Биошифровать",
	tip = "Биошифруйте это оружие.",
	icon = "icon16/wrench.png",
	OnCanRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		if item.bioEncoded then
			return false, client:NotifyLocalized("Оружие уже биокодировано!")
		end

		for _, v in pairs(inventory:GetItems()) do
			if v.name == "Биошифратор" then
				return true
			end
		end

		return false, "У вас нет биошифратора."
	end,
	OnRun = function(item)
		local client = item.player
		item.owner = client
		item.bioEncoded = true
		item.number = tostring(math.random(10000, 99999)) -- ГЕНЕРАТОР НОМЕРА
		item.description = removeLastTwoLines(item.baseDescription)
		item:SetData("description", item.baseDescription .. "\nНомер: " .. item.number .. "\nБиокодировано: ✔")
		client:NotifyLocalized("Оружие успешно биокодировано.")
		return false
	end
}
