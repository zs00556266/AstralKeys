local a, e = ...
if not AstralKeys then AstralKeys = {} end
if not AstralCharacters then AstralCharacters = {} end
if not AstralKeySettings then
	AstralKeySettings = {}
	AstralKeySettings['minimized'] = false
end

function e.CheckForWeeklyClear(a1)
	local affix = tonumber(a1)

	local currentAffix = e.GetAffix(1)
	if currentAffix == 0 then return end

	if currentAffix == affix then return end

	AstralAffixes[1] = 0
	AstralAffixes[2] = 0
	AstralAffixes[3] = 0
	e.WipeFrames()
end


function e.DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[e.DeepCopy(orig_key)] = e.DeepCopy(orig_value)
        end
        setmetatable(copy, e.DeepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local SI = {}
SI[0] = ''
SI[1] = 'k'
SI[2] = 'M'
SI[3] = 'G'
SI[4] = 'T'
SI[5] = 'P'

local IMP = {}
IMP[0] = ''
IMP[1] = 'k'
IMP[2] = 'M'
IMP[3] = 'B'
IMP[4] = 'T'
IMP[5] = 'Q'

function e.ConvertToSI(quantity)
	local amount = quantity
	local index = 0

	while amount > 1000 do
		index = index + 1
		amount = amount /1000
	end

	if amount < 10 then
		return string.format('%.2f', amount) .. ' ' .. SI[index]
	else
		return math.floor(amount) .. ' ' .. SI[index]
	end

end

e.RegisterEvent('PLAYER_LOGIN', function()
	local isOlddata = false
	for i = 1, #AstralCharacters do
		if not AstralCharacters[i].realm then
			isOlddata = true
			break
		end
	end

	if isOlddata then wipe(AstralCharacters) end
	
	C_ChallengeMode.RequestMapInfo()
	e.SetPlayerName()
	e.SetPlayerClass()
	e.SetPlayerID()
	e.SetCharacterID()
	e.SetPlayerRealm()


end)