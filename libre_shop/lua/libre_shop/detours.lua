// fuck you leme


local setcredits = LibreSC.SetCreditsFor

function LibreSC:SetCreditsFor(steamid, credits)
    local before = self:GetCreditsFor(steamid)

    setcredits(self, steamid, credits)

    hook.Run("LibreSC::OnBalanceChange", steamid, before, credits)
end