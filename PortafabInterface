local v1 = {};
local l__Parent__2 = script.Parent;
v1.Range = 16;
local u1 = require(game.ReplicatedStorage.Shared.Utilities.StructureUtil);
function v1.CanInterface(p1, p2)
	local v3 = v1:FindStructure(p2);
	if (v3 and v3:GetAttribute("CurrentIridium")) == nil then
		return false;
	end;
	local v4 = u1:getStructure(p2);
	if v4 and not u1:playerCanInteract(v4, (game.Players:GetPlayerFromCharacter(l__Parent__2.Parent))) then
		return false;
	end;
	return not v3:GetAttribute("NoInterface");
end;
function v1.FindStructure(p3, p4)
	if not p4 then
		return;
	end;
	if not p4.Parent then
		return;
	end;
	if p4.Parent == workspace.Terrain then
		return p4;
	end;
	local v5 = p4.Parent;
	while v5 ~= workspace do
		if v5.Parent == workspace.Structures then
			return v5;
		end;
		if v5.Name == "RefillConsole" then
			return v5;
		end;
		v5 = v5.Parent;	
	end;
	return p4.Parent;
end;
local l__Handle__2 = l__Parent__2:WaitForChild("Handle");
function Distance(p5)
	return (p5 - l__Handle__2.Position).magnitude;
end;
function v1.IsInRange(p6, p7)
	local v6 = p7 and Distance(p7) < v1.Range;
	return v6;
end;
return v1;
