local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = nil;
local u2 = require(script.Dragger.Snapping);
local u3 = require(script:WaitForChild("Dragger"));
local u4 = {};
local u5 = nil;
local u6 = false;
local l__RunService__7 = game:GetService("RunService");
function u4.enterPlacementMode(p1, p2)
	u1 = p2;
	u2.rotation = 0;
	u2.snapPoint = 0;
	u2.cachedSnapPoints = nil;
	u3.pipePoints = {};
	u3.WorldSnapPart = nil;
	u3.StructureSnapPartName = nil;
	local v2 = u4:getStructureModel(p2);
	if not v2 then
		error("No structure model found of type " .. tostring(p2));
	end;
	if p2 == "Pipe" then
		v2 = v2.InitialPlaceModel:Clone();
		v2.Name = "Pipe";
	end;
	u3:setModel(v2:Clone());
	if u5 then
		u5:Disconnect();
	end;
	u6 = true;
	u5 = l__RunService__7.Heartbeat:Connect(u3.update);
end;
function u4.getStructureModel(p3, p4)
	if u4.structureHash == nil then
		u4.structureHash = u4:generateStructureHash();
	end;
	return u4.structureHash[p4];
end;
local l__Structures__8 = l__ReplicatedStorage__1.Server.Structures;
function u4.generateStructureHash(p5)
	local function u9(p6, p7)
		local v3, v4, v5 = ipairs(p6:GetChildren());
		while true do
			v3(v4, v5);
			if not v3 then
				break;
			end;
			v5 = v3;
			if v4:IsA("Model") then
				p7(v4);
			elseif v4:IsA("Folder") then
				u9(v4, p7);
			elseif v4:IsA("Configuration") then
				u9(v4, p7);
			end;		
		end;
	end;
	local u10 = {};
	u9(l__Structures__8, function(p8)
		u10[p8.Name] = p8;
	end);
	return u10;
end;
function u4.rotate(p9, p10)
	u2.rotation = (u2.rotation + (p10 and 90)) % 360;
end;
function u4.changeSnapPoint(p11)
	u2.snapPoint = u2.snapPoint + 1;
end;
function u4.abortPlacement(p12)
	if u3.model then
		u3.model:Destroy();
	end;
	if u5 then
		u5:Disconnect();
	end;
	u6 = false;
end;
local u11 = l__ReplicatedStorage__1.Shared.Remotes.IsTutorial:InvokeServer();
local l__PlaceStructure__12 = l__ReplicatedStorage__1.Shared.Remotes.PlaceStructure;
function u4.confirmPlacement(p13)
	if not u6 then
		return;
	end;
	if u3.canPlace then
		if u1 ~= "Pipe" then
			u4:abortPlacement();
			l__PlaceStructure__12:FireServer(u1, u3.placementInfo, u3.StructureSnapPartName, u3.WorldSnapPart);
			return true;
		end;
		if #u3.pipePoints == 0 then
			u3.model:Destroy();
			u3.model = Instance.new("Model");
			u3.model.Name = "Pipe";
			u4:rotate(180);
			if u11 then
				game.ReplicatedStorage.Shared.Remotes.EventReported:FireServer({
					Name = "PortafabBlueprintPlaced"
				});
			end;
		end;
		table.insert(u3.pipePoints, u3.placementInfo);
		if #u3.pipePoints == 2 then
			u4:abortPlacement();
			l__PlaceStructure__12:FireServer("Pipe", u3.pipePoints);
			u6 = false;
			return true;
		end;
	end;
	return false;
end;
return u4;
