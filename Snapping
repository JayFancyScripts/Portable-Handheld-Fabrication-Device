local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local v2 = {};
local v3 = require(l__ReplicatedStorage__1.Shared.Utilities.DrawPipe);
v2.canPlace = false;
v2.rotation = 0;
v2.snapPoint = 0;
v2.cachedSnapPoints = nil;
local u1 = workspace.CurrentCamera;
local u2 = require(l__ReplicatedStorage__1.Client.Loader.PortafabConstraintController);
local function u3(p1)
	local v4, v5, v6 = p1:toEulerAnglesXYZ();
	return CFrame.new(p1.p) * CFrame.Angles(math.rad(math.floor(math.deg(v4) / 15 + 0.5) * 15), math.rad(math.floor(math.deg(v5) / 15 + 0.5) * 15), (function(p2)
		return math.rad(math.floor(math.deg(p2) / 15 + 0.5) * 15);
	end)(v6));
end;
local u4 = require(l__ReplicatedStorage__1.Shared.Utilities.StructureUtil);
local l__CollectionService__5 = game:GetService("CollectionService");
local function u6(p3, p4, p5, p6)
	if not p3 then
		return;
	end;
	if p6 == nil then
		p6 = true;
	end;
	u1 = workspace.CurrentCamera;
	if u2.lockRotation then
		local v7 = Vector3.new(1, 0, 0);
	else
		v7 = -u1.CFrame.LookVector;
	end;
	local l__unit__8 = v7:Cross(p5).unit;
	local l__unit__9 = l__unit__8:Cross(p5).unit;
	local v10 = CFrame.new(p4.x, p4.y, p4.z, l__unit__8.x, p5.x, l__unit__9.x, l__unit__8.y, p5.y, l__unit__9.y, l__unit__8.z, p5.z, l__unit__9.z);
	if p6 then
		v10 = p3.CFrame * u3((p3.CFrame:ToObjectSpace(v10)));
	end;
	if u2.lockRotation then
		return v10 * CFrame.Angles(0, math.rad(u2.lockRotation), 0);
	end;
	return v10 * CFrame.Angles(0, math.rad(v2.rotation), 0);
end;
local u7 = require(l__ReplicatedStorage__1.Shared.Utilities.ModelUtility);
local u8 = require(l__ReplicatedStorage__1.Shared.Utilities.TableUtility);
local l__Structures__9 = l__ReplicatedStorage__1.Server.Structures;
local l__LocalPlayer__10 = game:GetService("Players").LocalPlayer;
local u11 = require(l__ReplicatedStorage__1.Shared.Data.SnapStructureList);
local function u12(p7, p8)
	if p7 == p8 then
		return true;
	end;
	local v11 = l__Structures__9:FindFirstChild(p8, true);
	if not v11 then
		warn("No structure found of type " .. p8);
		return false;
	end;
	return l__Structures__9:FindFirstChild(p7, true):IsDescendantOf(v11);
end;
local function u13(p9, p10, p11, p12)
	local v12 = u4:getStructure(p10);
	if not table.find(p11.WorldSnap, p10.Name) or not (not u4:getSnapPointAttachment(v12, p10)) or v12 and l__CollectionService__5:HasTag(v12, "Blueprint") then
		if p11.OnlySnapsAllowed or u2.snapOnly then
			v2.canPlace = false;
		end;
		return;
	end;
	if p11.DontInvert then
		local v13 = 0;
	else
		v13 = math.pi;
	end;
	local v14 = p10.CFrame * u3((p10.CFrame:toObjectSpace(u6(p10, p12, p10.CFrame.upVector, false) * CFrame.Angles(0, 0, v13))));
	local v15 = v2.cachedSnapPoints;
	if not v15 then
		v15 = {};
		u7:recurse(p9, function(p13)
			if u8:tableHasValue(p11.ModelSnap, p13.Name) then
				table.insert(v15, p13);
			end;
		end);
		v2.cachedSnapPoints = v15;
	end;
	local v16 = v15[v2.snapPoint % #v15 + 1];
	return CFrame.new((p10.CFrame * CFrame.new(0, -(p11.CustomSnapLength or p10.Size.Y / 2 + v16.Size.Y / 2), 0)).p) * (v14 - v14.p) * v16.CFrame:toObjectSpace(p9.PrimaryPart.CFrame), v16.Name;
end;
function v2.getSnappedCFrame(p14, p15, p16, p17, p18)
	if not l__LocalPlayer__10.Character or not (l__LocalPlayer__10.Character.Humanoid.Health > 0) or not l__LocalPlayer__10.Character:FindFirstChild("Head") then
		v2.canPlace = false;
		return {
			CFrame = CFrame.new()
		}, nil;
	end;
	v2.canPlace = true;
	local v17 = nil;
	local v18 = nil;
	local v19 = nil;
	for v20, v21 in pairs(u11) do
		if not v21.SkipCheck and u12(p15.Name, v20) then
			local v22, v23 = u13(p15, p16, v21, p17);
			v17 = v22;
			v19 = v23;
			if v17 then
				if u2.allowedSnaps and not table.find(u2.allowedSnaps, p16) then
					v2.canPlace = false;
				end;
				v18 = p16;
			end;
			break;
		end;
	end;
	return {
		CFrame = p16.CFrame:toObjectSpace(v17 or u6(p16, p17, p18) * CFrame.new(0, p15.PrimaryPart.Size.Y / 2, 0)), 
		BasePart = p16
	}, v18, v19;
end;
function v2.getSnappedPipeCFrame(p19, p20, p21, p22)
	if not l__LocalPlayer__10.Character or not (l__LocalPlayer__10.Character.Humanoid.Health > 0) or not l__LocalPlayer__10.Character:FindFirstChild("Head") then
		v2.canPlace = false;
		return {
			CFrame = CFrame.new()
		};
	end;
	v2.canPlace = true;
	local v24 = u4:getStructure(p20);
	if (p20.Name == "FemaleFlange" or p20.Name == "FemaleFlange1" or p20.Name == "FemaleFlange2" or p20.Name == "FemaleFlange3" or p20.Name == "FemaleFlange4") and not u4:getSnapPointAttachment(v24, p20) and (not v24 or not l__CollectionService__5:HasTag(v24, "Blueprint")) then
		if u2.allowedSnaps and not table.find(u2.allowedSnaps, p20) then
			v2.canPlace = false;
		end;
		return {
			CFrame = p20.CFrame, 
			SnapPart = p20
		};
	end;
	if u2.snapOnly then
		v2.canPlace = false;
	end;
	return {
		CFrame = p20.CFrame:ToObjectSpace(u6(p20, p21, p22) * CFrame.new(0, 2, 0)), 
		BasePart = p20
	};
end;
return v2;
