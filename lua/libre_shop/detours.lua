// nice things

LibreSCOriginalSetCreditsFor = LibreSCOriginalSetCreditsFor or LibreSC.SetCreditsFor

function LibreSC:SetCreditsFor(steamid, credits)
    local before = self:GetCreditsFor(steamid)

    LibreSCOriginalSetCreditsFor(self, steamid, credits)

    hook.Run("LibreSC::OnBalanceChange", steamid, before, self:GetCreditsFor(steamid))
end
