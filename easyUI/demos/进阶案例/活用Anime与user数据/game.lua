
-- 结束教程
function Game.Rule:OnPlayerSignal (player, signal)
	if signal == 0 then
		Game.Rule:Win(Game.TEAM.CT)
	end
end