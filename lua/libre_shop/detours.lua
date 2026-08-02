// nice things

LibreSC.OriginalSetCreditsFor = LibreSC.OriginalSetCreditsFor or LibreSC.SetCreditsFor

function LibreSC:SetCreditsFor(steamid, credits)
    local before = self:GetCreditsFor(steamid)

    self:OriginalSetCreditsFor(steamid, credits)

    hook.Run("LibreSC::OnBalanceChange", steamid, before, credits)
end
