local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local v3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared").Utilities.SettingsModule);
local l__LocalPlayer__4 = l__Players__2.LocalPlayer;
local v5 = {
	canPlace = false, 
	placementInfo = {}, 
	model = nil, 
	pipePoints = {}
};
local u1 = require(l__ReplicatedStorage__1.Shared.Utilities.ModelUtility);
local u2 = require(l__ReplicatedStorage__1.Shared.Data:WaitForChild("SnapStructureList"));
local l__CollectionService__3 = game:GetService("CollectionService");
function v5.setModel(p1, p2)
	if v5.model then
		v5.model:Destroy();
	end;
	v5.model = p2;
	local v6 = {};
	for v7, v8 in next, u2[p2.Name] and u2[p2.Name].WorldSnap or {} do
		v6[v8] = true;
	end;
	local l__next__9 = next;
	local v10, v11 = l__CollectionService__3:GetTagged("SnapPart");
	while true do
		local v12, v13 = l__next__9(v10, v11);
		if not v12 then
			break;
		end;
		v11 = v12;
		if v6[v13.Name] then
			l__CollectionService__3:RemoveTag(v13, "RayIgnore");
		else
			l__CollectionService__3:AddTag(v13, "RayIgnore");
		end;	
	end;
	u1:recurse(v5.model, function(p3)
		for v14, v15 in pairs(l__CollectionService__3:GetTags(p3)) do
			if v15:sub(1, 7) == "Texture" then
				l__CollectionService__3:RemoveTag(p3, v15);
			end;
		end;
		if p3:IsA("BasePart") and not p3:IsA("Seat") and not p3:IsA("VehicleSeat") then
			p3.Transparency = 1 - (1 - p3.Transparency) * 0.30000000000000004;
			p3.CanCollide = false;
			p3.Anchored = true;
			return;
		end;
		if not p3:IsA("Model") and not p3:IsA("DataModelMesh") and not p3:IsA("NumberValue") then
			pcall(function()
				p3:Destroy();
			end);
		end;
	end);
	Instance.new("Folder", v5.model).Name = "PlacementTag";
	v5.canPlace = false;
	u1:setProperties(v5.model, "BrickColor", BrickColor.new("Really red"), "BasePart");
end;
local u4 = workspace.CurrentCamera;
local l__mouse__5 = l__LocalPlayer__4:GetMouse();
local u6 = require(script:WaitForChild("Snapping"));
local u7 = require(l__ReplicatedStorage__1.Shared.Utilities.DrawPipe);
local u8 = require(l__ReplicatedStorage__1.Shared.Utilities.StructureUtil);
local u9 = require(l__ReplicatedStorage__1.Client.Loader.PortafabConstraintController);
local u10 = {
	Pipe = 20, 
	["Four-way"] = 20, 
	["T-Junction"] = 20, 
	Elbow = 20, 
	Cap = 20, 
	["Distributor Cap"] = 20, 
	Gauge = 20, 
	Valve = 20
};
local u11 = v3:settingOtherwise("Build Height Limit", 255);
local l__Head__12 = (l__LocalPlayer__4.Character or l__LocalPlayer__4.CharacterAdded:Wait()):WaitForChild("Head");
local function u13(p4)
	local v16 = p4.Parent;
	while v16 do
		if v16.Parent == workspace.Structures then
			return v16;
		end;
		if v16.Parent == workspace then
			return v16;
		end;
		v16 = v16.Parent;	
	end;
	return p4.Parent;
end;
function v5.update(p5)
	u4 = workspace.CurrentCamera;
	local v17 = u4:ScreenPointToRay(l__mouse__5.X, l__mouse__5.Y, 0);
	local v18 = Ray.new(v17.Origin, v17.Direction * 500);
	local v19 = l__CollectionService__3:GetTagged("RayIgnore");
	local l__next__20 = next;
	local v21, v22 = l__Players__2:GetPlayers();
	while true do
		local v23, v24 = l__next__20(v21, v22);
		if not v23 then
			break;
		end;
		v22 = v23;
		if v24.Character then
			table.insert(v19, v24.Character);
		end;	
	end;
	for v25, v26 in next, { workspace.Lucent, workspace.Terrain, workspace.Effects, workspace.Lasers, workspace.Barriers } do
		table.insert(v19, v26);
	end;
	local v27, v28, v29 = workspace:FindPartOnRayWithIgnoreList(v18, v19);
	if not v27 then
		v5.model.Parent = nil;
		return;
	end;
	v5.model.Parent = workspace.Effects;
	if v5.model.Name == "Pipe" and #v5.pipePoints > 0 then
		v5.placementInfo = u6:getSnappedPipeCFrame(v27, v28, v29);
		table.insert(v5.pipePoints, v5.placementInfo);
		local v30, v31 = u7(v5.pipePoints, v5.model);
		table.remove(v5.pipePoints);
		if not v5.model:FindFirstChild("PlacementTag") then
			v5.model = nil;
			v5:setModel(v5.model);
		end;
		local v32 = v31 and (u6.canPlace and (u8:regionCheck(v5.model, v5.WorldSnapPart, v5.pipePoints) and u9:checkPlacementBounds(v28)));
		v5.canPlace = v32;
		u1:setProperties(v5.model, "BrickColor", v32 and BrickColor.new("Teal") or BrickColor.new("Really red"), "BasePart");
	else
		if v5.model.Name == "Pipe" then
			local v33 = nil;
			v5.placementInfo = u6:getSnappedPipeCFrame(v27, v28, v29);
			v33 = v5.placementInfo.CFrame;
			if v5.placementInfo.SnapPart then
				local v34 = v33 * CFrame.Angles(-math.pi / 2, 0, math.pi / 2) * CFrame.new(0, 0, -0.2);
			else
				v34 = v5.placementInfo.BasePart.CFrame * v33;
			end;
			v5.model:PivotTo(v34 * CFrame.Angles(math.pi / 2, 0, math.pi));
		else
			local v35, v36, v37 = u6:getSnappedCFrame(v5.model, v27, v28, v29);
			v5.placementInfo = v35;
			v5.WorldSnapPart = v36;
			v5.StructureSnapPartName = v37;
			v5.model:PivotTo(v5.placementInfo.BasePart.CFrame * v5.placementInfo.CFrame);
		end;
		local v38 = u10[v5.model.Name];
		local v39 = false;
		if v28.Y < (v38 and u11 + v38 or u11) then
			v39 = u6.canPlace and (u8:regionCheck(v5.model, v5.WorldSnapPart, v5.pipePoints) and (not v3:structureRestricted(v5.model.Name) and u9:checkPlacementBounds(v5.model.PrimaryPart.Position)));
		end;
		v5.canPlace = v39;
		u1:setProperties(v5.model, "BrickColor", v39 and BrickColor.new("Teal") or BrickColor.new("Really red"), "BasePart");
	end;
	if not (not l__CollectionService__3:HasTag(v27, "NoBuilding")) or (v28 - l__Head__12.Position).Magnitude > 50 or (not (not u13(v27)) and not (not l__CollectionService__3:HasTag(u13(v27), "Blueprint")) or v28.X <= -1024 or v28.Z <= -1024 or v28.X >= 1024 or v28.Z >= 1024) then
		v5.canPlace = false;
		u1:setProperties(v5.model, "BrickColor", BrickColor.new("Really red"), "BasePart");
	end;
end;
return v5;
