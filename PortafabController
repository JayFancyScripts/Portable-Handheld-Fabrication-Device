local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__ContentProvider__5 = game:GetService("ContentProvider");
local l__RunService__6 = game:GetService("RunService");
local l__LocalPlayer__7 = game:GetService("Players").LocalPlayer;
local v8 = require(l__ReplicatedStorage__3.Shared.Enums.Portafab);
local v9 = require(l__ReplicatedStorage__3.Shared.Utilities.StructureUtil);
local v10 = require(l__ReplicatedStorage__3.Shared.Utilities.TableUtility);
local v11 = require(script.Parent:WaitForChild("StructurePlacer"));
local v12 = require(l__ReplicatedStorage__3.Client.Loader.EffectsClient);
local v13 = require(l__ReplicatedStorage__3.Client.Loader.ContextHint);
local v14 = require(l__ReplicatedStorage__3.Client.Loader.TweenBlueprints);
local v15 = require(l__ReplicatedStorage__3.Client.Loader.ContextButtons);
local v16 = require(l__ReplicatedStorage__3.Client.Loader.HealthInterfaceController);
local v17 = require(l__ReplicatedStorage__3.Client.Loader.PortafabConstraintController);
local v18, v19 = l__ReplicatedStorage__3.Shared:WaitForChild("Remotes"):WaitForChild("GetBeaconRequirements"):InvokeServer();
local l__Handle__20 = script.Parent:WaitForChild("Handle");
local l__Barrel__21 = l__Handle__20.Barrel;
local l__Portafab__22 = l__ReplicatedStorage__3:WaitForChild("Client"):WaitForChild("Guis"):WaitForChild("Portafab");
local v23 = Instance.new("Attachment");
v23.Parent = l__Handle__20;
local v24 = { Enum.KeyCode.Q };
local v25 = {};
for v26, v27 in pairs({ { Enum.KeyCode.Z, Enum.KeyCode.DPadUp }, { Enum.KeyCode.X, Enum.KeyCode.DPadLeft }, { Enum.KeyCode.C, Enum.KeyCode.DPadRight }, { Enum.KeyCode.V, Enum.KeyCode.DPadDown } }) do
	for v28, v29 in pairs(v27) do
		table.insert(v24, v29);
		v25[v29] = v26;
	end;
end;
local v30 = {};
v30.__index = v30;
v30.instance = nil;
local l__Portafab__1 = l__ReplicatedStorage__3.Shared.Remotes.Portafab;
function v30.new(p1)
	local v31 = true;
	if typeof(p1) ~= "nil" then
		v31 = false;
		if typeof(p1) == "Instance" then
			v31 = p1:IsA("Folder");
		end;
	end;
	assert(v31, ("Bad argument #1 to PortafabServer.new, expected Folder or nil, got %s"):format(typeof(p1)));
	local v32 = setmetatable({}, v30);
	v32.remote = l__Portafab__1;
	local v33 = {};
	local v34 = {};
	v34[v8.States.Deactivated] = function()
		v32:stopIridiumEffect();
	end;
	v33[v8.Actions.Extract] = v34;
	v33[v8.Actions.Extrude] = {
		[v8.States.Deactivated] = function()
			v32:stopIridiumEffect();
		end
	};
	v33[v8.Actions.Place] = {
		[v8.States.Fired] = function(p2)
			v32:onPlaceModel(p2);
		end
	};
	v32.handlers = v33;
	v32.topLevelFolder = p1 or l__ReplicatedStorage__3.Server:WaitForChild("Structures");
	return v32;
end;
function v30.getUpgradeTier(p3)
	if not l__LocalPlayer__7.Character then
		return;
	end;
	return l__LocalPlayer__7.Character:GetAttribute("UpgradeTool");
end;
function v30.clampPoint(p4, p5, p6)
	local v35 = p5 - l__Handle__20.Position;
	if p6 < v35.magnitude then
		p5 = l__Handle__20.Position + v35.unit * p6;
	end;
	return p5;
end;
local l__BarrelAttachment__2 = l__Handle__20.BarrelAttachment;
function v30.startIridiumEffect(p7, p8, p9)
	p7:stopIridiumEffect();
	local v36 = v12:requestId();
	p7.portafabIridiumEffect = v36;
	v12:onEffectRequested("Portafab", {
		Name = "PortafabBeam", 
		Here = l__BarrelAttachment__2, 
		There = v23, 
		Pull = p8 and false, 
		Id = v36, 
		Beams = p7:getUpgradeTier() - 1, 
		Sound = l__Handle__20:WaitForChild("BeamSound")
	});
end;
function v30.stopIridiumEffect(p10)
	if p10.portafabIridiumEffect then
		v12:onEffectRequested(nil, {
			Name = "EndEffect", 
			Id = p10.portafabIridiumEffect
		});
	end;
end;
function v30.fireServer(p11, ...)
	p11.lastUpdated = tick();
	p11.remote:FireServer(...);
end;
local u3 = l__ReplicatedStorage__3.Shared.Remotes.IsTutorial:InvokeServer();
function v30.reportEvent(p12, p13, p14)
	if not p14 and u3 then
		p13 = p13 or {};
		game.ReplicatedStorage.Shared.Remotes.EventReported:FireServer(p13);
	end;
end;
function v30.onRemote(p15, p16, p17, ...)
	if typeof(p16) == "number" and typeof(p17) == "number" and p15.handlers[p16] and p15.handlers[p16][p17] and typeof(p15.handlers[p16][p17]) == "function" then
		p15.handlers[p16][p17](...);
		return;
	end;
end;
function v30.serverUpdateMouse(p18)
	if not p18.mousePart or not p18.mousePoint then
		p18:updateMouse();
	end;
	if p18.state == v8.Actions.Extract and v17.exemptBlueprintPull and l__CollectionService__4:HasTag(v9:getRootModel(p18.mousePart), "Blueprint") then
		p18:onEDown(nil, Enum.UserInputState.End);
	end;
	if p18.state == v8.Actions.Destroy and v17.lockDestroy and not p18.mousePart:IsDescendantOf(v17.lockDestroy) then
		p18:onGDown(nil, Enum.UserInputState.End);
	end;
	if p18.state == v8.Actions.Extrude and v17.blueprintOnlyPush and not l__CollectionService__4:HasTag(v9:getRootModel(p18.mousePart), "Blueprint") then
		p18:onLClick(nil, Enum.UserInputState.End);
	end;
	p18:fireServer(v8.Actions.Target, v8.States.Fired, { p18.mousePoint, p18.mousePart });
end;
function v30.thumbnail(p19, p20)
	return "https://www.roblox.com/Thumbs/Asset.ashx?width=110&height=110&assetId=" .. p20;
end;
function v30.getConnections(p21, p22)
	return p21.slotConnections[p22];
end;
function v30.unbindConnection(p23, p24, p25)
	if p23.slotConnections[p24] and p23.slotConnections[p24][p25] then
		p23.slotConnections[p24][p25]:Disconnect();
		p23.slotConnections[p24][p25] = nil;
	end;
end;
function v30.bindConnection(p26, p27, p28, p29)
	p26.slotConnections[p27] = p26.slotConnections[p27] or {};
	p26.slotConnections[p27][p28] = p29;
end;
function v30.removeAllHints(p30)
	for v37, v38 in pairs(p30.hints) do
		p30:removeHint(v37);
	end;
end;
function v30.addHint(p31, p32, p33)
	if not p31.hints[p32] then
		p31.hints[p32] = v13:addHint(p33);
	end;
end;
function v30.removeHint(p34, p35)
	if p34.hints[p35] then
		p34.hints[p35]:Remove();
		p34.hints[p35] = nil;
	end;
end;
function v30.hintCondition(p36, p37, p38, p39)
	if not p37() then
		p36:removeHint(p38);
		return;
	end;
	p36:addHint(p38, p39);
end;
function v30.schemaHasStructure(p40, p41, p42)
	local function u4(p43)
		if not p43.Children then
			return p43.Name == p42;
		end;
		local v39, v40, v41 = ipairs(p43.Children);
		while true do
			v39(v40, v41);
			if not v39 then
				break;
			end;
			v41 = v39;
			if u4(v40) then
				return true;
			end;		
		end;
		return false;
	end;
	return u4(p41);
end;
local u5 = { "Configuration" };
local u6 = { "Folder" };
local u7 = { "Model" };
function v30.generateSchema(p44, p45)
	p44.schema = {};
	local function u8(p46, p47)
		for v42, v43 in pairs(p47) do
			if p46:IsA(v43) then
				return false;
			end;
		end;
		return true;
	end;
	local function u9(p48, p49)
		for v44, v45 in pairs(p49) do
			if p48:IsA(v45) then
				return true;
			end;
		end;
		return false;
	end;
	local function u10(p50, p51)
		local v46 = p50:GetChildren();
		table.sort(v46, function(p52, p53)
			p52 = p52:GetAttribute("Importance") and 0;
			p53 = p53:GetAttribute("Importance") and 0;
			return p52 < p53;
		end);
		for v47, v48 in pairs(v46) do
			if u8(v48, u5) then
				local v49 = #p51 + 1;
				if u9(v48, u6) then
					p51[v49] = {
						Name = v48.Name, 
						Description = v48:GetAttribute("Description"), 
						Children = {}, 
						Image = nil
					};
					u10(v48, p51[v49].Children);
				elseif u9(v48, u7) then
					if v48:GetAttribute("ImageId") and not p44.assetsLoaded then
						table.insert(p44.assetsToLoad, #p44.assetsToLoad + 1, p44:thumbnail(v48:GetAttribute("ImageId")));
					end;
					if v48.Name == "Priority Beacon" then
						task.spawn(function()
							p51[v49] = {
								Name = v48.Name, 
								Image = v48:GetAttribute("ImageId"), 
								Description = v48:GetAttribute("Description"), 
								Cost = "loading"
							};
							if not p44.priorityBeaconCost or not p44.priorityBeaconsRequired then
								while true do
									task.wait();
									if v18 and v19 then
										break;
									end;								
								end;
								p44.priorityBeaconsRequired = v18;
								p44.priorityBeaconCost = v19;
							end;
							p51[v49] = {
								Name = v48.Name, 
								Image = v48:GetAttribute("ImageId"), 
								Description = v48:GetAttribute("Description"), 
								Cost = ("%d (x%d)"):format(p44.priorityBeaconCost, p44.priorityBeaconsRequired)
							};
						end);
					else
						p51[v49] = {
							Name = v48.Name, 
							Description = v48:GetAttribute("Description"), 
							Image = v48:GetAttribute("ImageId"), 
							Cost = v48:GetAttribute("Cost")
						};
					end;
				end;
			end;
		end;
	end;
	u10(p45, p44.schema);
	return p44.schema;
end;
function v30.loadAssets(p54)
	if p54.assetsLoaded then
		return;
	end;
	task.spawn(function()
		l__ContentProvider__5:PreloadAsync(p54.assetsToLoad);
		p54.assetsLoaded = true;
	end);
end;
function v30.slotMouseEnter(p55, p56, p57)
	local v50 = Instance.new("TextLabel");
	v50.BackgroundColor3 = Color3.new(0, 0, 0);
	v50.BorderColor3 = Color3.new(0, 0, 0, 0);
	v50.BackgroundTransparency = 0.5;
	v50.TextColor3 = Color3.new(1, 1, 1);
	v50.Font = "SciFi";
	v50.TextSize = 16;
	v50.TextXAlignment = "Left";
	v50.TextWrapped = true;
	v50.Text = p57;
	v50.AnchorPoint = Vector2.new(0, 0.5);
	v50.Position = UDim2.new(1, 10, 0.5, 0);
	v50.Size = UDim2.new(0, 240, 0, v50.TextSize * 10);
	v50.Parent = p56.Button;
	v50.Size = UDim2.new(0, v50.TextBounds.X + 2, 0, v50.TextBounds.Y);
	p55.hoverText = v50;
end;
function v30.slotMouseLeave(p58)
	if p58.hoverText then
		p58.hoverText:Destroy();
	end;
end;
local l__Construction__11 = l__Portafab__22:WaitForChild("Construction");
local u12 = { "Z", "X", "C", "V" };
local l__Slot__13 = l__Portafab__22:WaitForChild("Slot");
function v30.render(p59, p60)
	if not p59.constructionMenuShown then
		local v51 = l__Construction__11:Clone();
		v51.Parent = l__LocalPlayer__7.PlayerGui.Gui;
		v51.BackBackgroundImage.Button.Activated:Connect(function()
			p59:previousSchema();
		end);
		p59.constructionMenuShown = true;
		p59.constructionMenu = v51;
	end;
	local function v52(p61, p62, p63, p64, p65)
		p61.Visible = true;
		p61.KeyImage.KeyText.Text = u12[p62] and "err";
		p61.LabelImage.LabelText.Text = p63 and "";
		p61.SlotImage.Image = p64 and p59:thumbnail(p64) or p61.SlotImage.Image;
		p61.CostImage.CostText.Text = p65 and "";
		if p64 then
			local v53 = true;
		else
			v53 = false;
		end;
		p61.SlotImage.Visible = v53;
		if p65 then
			local v54 = true;
		else
			v54 = false;
		end;
		p61.CostImage.Visible = v54;
	end;
	local v55 = {};
	local v56, v57, v58 = ipairs(p60);
	while true do
		v56(v57, v58);
		if not v56 then
			break;
		end;
		if p59.uiSlots[v56] then
			local v59 = p59.uiSlots[v56];
			v52(v59, v56, v57.Name, v57.Image, v57.Cost);
			v55[p59.uiSlots[v56]] = true;
		else
			v59 = l__Slot__13:Clone();
			v52(v59, v56, v57.Name, v57.Image, v57.Cost);
			v59.Parent = p59.constructionMenu.SlotsContainer;
			table.insert(p59.uiSlots, #p59.uiSlots + 1, v59);
			v55[p59.uiSlots[v56]] = true;
		end;
		if p59.uiSlots[v56] then
			p59:unbindConnection(v59, "MouseButton1Down");
			p59:bindConnection(v59, "MouseButton1Down", v59.Button.MouseButton1Down:Connect(function()
				p59:slotMouseLeave();
				if tick() - p59.lastPortafabClick < 0.05 then
					return;
				end;
				p59.lastPortafabClick = tick();
				if v17.lockSelect and not p59:schemaHasStructure(p59.activeSchema[v56], v17.lockSelect) then
					return;
				end;
				if not p59.activeSchema[v56].Children then
					p59:bindDragger();
					p59.placing = true;
					v11:enterPlacementMode(p59.activeSchema[v56].Name);
					p59:reportEvent({
						Name = "PortafabBlueprintChosen", 
						Blueprint = p59.activeSchema[v56].Name
					});
					return;
				end;
				p59:showBack();
				local v60 = v10:shallowCopy(p59.activeSchema[v56]);
				table.insert(p59.pastSchemas, 1, p59.activeSchema);
				p59:render(v60.Children);
				p59:reportEvent({
					Name = "PortafabCategoryChosen", 
					Category = v60.Name
				});
			end));
			p59:unbindConnection(v59, "MouseEnter");
			p59:bindConnection(v59, "MouseEnter", v59.Button.MouseEnter:Connect(function()
				v59.BackgroundImage.BackgroundTransparency = 0.5;
				p59:slotMouseLeave();
				p59:slotMouseEnter(v59, p59.activeSchema[v56].Description and "No description is available.");
			end));
			p59:unbindConnection(v59, "MouseLeave");
			p59:bindConnection(v59, "MouseLeave", v59.Button.MouseLeave:Connect(function()
				v59.BackgroundImage.BackgroundTransparency = 0;
				p59:slotMouseLeave();
			end));
		end;
		for v61, v62 in pairs(p59.uiSlots) do
			if not v55[v62] then
				v62.Visible = false;
			end;
		end;
		p59.activeSchema = p60;	
	end;
end;
function v30.clear(p66)
	p66.uiSlots = {};
	p66.constructionMenuShown = false;
	if p66.constructionMenu and p66.constructionMenu:IsA("Frame") then
		p66.constructionMenu:Destroy();
	end;
end;
function v30.previousSchema(p67)
	if v17.lockSelect and (p67:schemaHasStructure({
		Children = p67.activeSchema
	}, v17.lockSelect) or v17.lockSelect == "_") then
		return;
	end;
	if #p67.pastSchemas <= 1 then
		table.remove(p67.pastSchemas, 1);
		p67:hideBack();
		p67:render(p67.schema);
	else
		p67:render(p67.pastSchemas[1]);
		table.remove(p67.pastSchemas, 1);
	end;
	p67:reportEvent({
		Name = "PortafabCategoryBack"
	});
end;
local l__Enum_KeyCode_Q__14 = Enum.KeyCode.Q;
function v30.onGuiButtonDown(p68, p69, p70, p71)
	local v63 = nil;
	if p70 == Enum.UserInputState.Begin then
		if p71.KeyCode == l__Enum_KeyCode_Q__14 then
			p68:previousSchema();
			return;
		end;
		v63 = v25[p71.KeyCode];
		if not v63 or not p68.activeSchema or not p68.activeSchema[v63] then
			return;
		end;
		if v17.lockSelect and not p68:schemaHasStructure(p68.activeSchema[v63], v17.lockSelect) then
			return;
		end;
		if not p68.activeSchema[v63].Children then
			p68:bindDragger();
			p68.placing = true;
			v11:enterPlacementMode(p68.activeSchema[v63].Name);
			p68:reportEvent({
				Name = "PortafabBlueprintChosen", 
				Blueprint = p68.activeSchema[v63].Name
			});
			return;
		end;
	else
		return;
	end;
	p68:showBack();
	local v64 = v10:shallowCopy(p68.activeSchema[v63]);
	table.insert(p68.pastSchemas, 1, p68.activeSchema);
	p68:render(v64.Children);
	p68:reportEvent({
		Name = "PortafabCategoryChosen", 
		Category = v64.Name
	});
end;
function v30.showBack(p72)
	if p72.constructionMenuShown then
		p72.constructionMenu.BackBackgroundImage.Visible = true;
	end;
end;
function v30.hideBack(p73)
	if p73.constructionMenuShown then
		p73.constructionMenu.BackBackgroundImage.Visible = false;
	end;
end;
local l__Enum_KeyCode_R__15 = Enum.KeyCode.R;
local l__Enum_KeyCode_E__16 = Enum.KeyCode.E;
local l__Enum_KeyCode_T__17 = Enum.KeyCode.T;
function v30.onDraggerButtonDown(p74, p75, p76, p77)
	if v17.lockDraggerAction and not table.find(v17.lockDraggerAction, p77.UserInputType) and not table.find(v17.lockDraggerAction, p77.KeyCode) then
		return Enum.ContextActionResult.Pass;
	end;
	if p76 == Enum.UserInputState.Begin then
		if p77.KeyCode == l__Enum_KeyCode_R__15 then
			if l__UserInputService__2:IsKeyDown(Enum.KeyCode.LeftControl) then
				local v65 = 15;
			else
				v65 = 90;
			end;
			if l__UserInputService__2:IsKeyDown(Enum.KeyCode.LeftShift) then
				local v66 = -1;
			else
				v66 = 1;
			end;
			v11:rotate(v65 * v66);
		elseif p77.KeyCode == l__Enum_KeyCode_E__16 then
			p74:reportEvent({
				Name = "PortafabPlacementAbort"
			});
			p74:abortPlacement();
		elseif p77.KeyCode == l__Enum_KeyCode_T__17 then
			v11:changeSnapPoint();
		end;
		if p77.KeyCode == Enum.KeyCode.LeftShift then
			l__ContextActionService__1:BindAction("PortafabDraggerFineRotate", function(p78, p79, p80)
				if p80.Position.Z > 0 then
					v11:rotate(15);
				elseif p80.Position.Z < 0 then
					v11:rotate(-15);
				else
					warn("Error: MouseWheel delta is \"0\", unhandled case.");
				end;
				return Enum.ContextActionResult.Sink;
			end, false, Enum.UserInputType.MouseWheel);
			return;
		end;
	elseif p76 == Enum.UserInputState.End and p77.KeyCode == Enum.KeyCode.LeftShift then
		l__ContextActionService__1:UnbindAction("PortafabDraggerFineRotate");
	end;
end;
function v30.abortPlacement(p81)
	p81:unbindDragger();
	p81.placing = false;
	v11:abortPlacement();
end;
function v30.onEquipped(p82)
	if p82.skipSetup then
		p82.skipSetup = nil;
		return;
	end;
	v16:setPortafabEquipped(true);
	if not p82.schema then
		p82:generateSchema(p82.topLevelFolder);
		p82:loadAssets();
	end;
	p82:fireServer(v8.Actions.Extract, v8.States.Deactivated);
	p82.state = nil;
	p82.pastSchemas = {};
	p82:stopIridiumEffect();
	p82:render(p82.schema);
	p82:hideBack();
	p82:bind();
	p82:updateMouse();
	p82:updateContextHints();
	p82:reportEvent({
		Name = "PortafabEquipped"
	});
end;
function v30.onUnequipped(p83)
	if v17.preventUnequip then
		p83.skipSetup = true;
		local l__Character__67 = script.Parent.Parent.Parent.Character;
		if not l__Character__67 then
			return;
		else
			local v68 = l__Character__67:FindFirstChildOfClass("Humanoid");
			if not v68 then
				return;
			else
				task.defer(function()
					v68:EquipTool(p83.tool);
				end);
				return;
			end;
		end;
	end;
	v16:setPortafabEquipped(false);
	p83:abortPlacement();
	p83:stopIridiumEffect();
	p83:clear();
	p83:removeAllHints();
	p83:unbind();
end;
function v30.onLClick(p84, p85, p86)
	if p86 == Enum.UserInputState.Begin then
		if not p84.placing then
			if v17.blueprintOnlyPush and not l__CollectionService__4:HasTag(v9:getRootModel(p84.mousePart), "Blueprint") then
				return;
			else
				p84.state = v8.Actions.Extrude;
				p84:startIridiumEffect(false);
				p84:fireServer(v8.Actions.Extrude, v8.States.Activated, { p84.mousePoint, p84.mousePart });
				local v69 = v9:getRootModel(p84.mousePart);
				if v69 and l__CollectionService__4:HasTag(v69, "Blueprint") then
					v14.origin = p84.mousePoint;
					v14.interactingBlueprint = v69;
					return;
				else
					v14.origin = Vector3.new(0, 0, 0);
					v14.interactingBlueprint = nil;
					return;
				end;
			end;
		elseif v11:confirmPlacement() then
			p84:abortPlacement();
			p84:reportEvent({
				Name = "PortafabBlueprintPlaced"
			});
			return;
		end;
	elseif p86 == Enum.UserInputState.End and p84.state == v8.Actions.Extrude then
		p84.state = nil;
		p84:stopIridiumEffect();
		p84:fireServer(v8.Actions.Extrude, v8.States.Deactivated);
	end;
end;
function v30.onMClick(p87, p88, p89)
	if p89 ~= Enum.UserInputState.Begin then
		return;
	end;
	local v70 = v9:getRootModel(p87.mousePart, false);
	if not v70 then
		return;
	end;
	if not v11:getStructureModel(v70.Name) then
		return;
	end;
	p87:bindDragger();
	p87.placing = true;
	v11:enterPlacementMode(v70.Name);
	p87:reportEvent({
		Name = "PortafabBlueprintChosen", 
		Blueprint = v70.Name
	});
end;
function v30.onEDown(p90, p91, p92)
	if p92 == Enum.UserInputState.Begin then
		if v17.exemptBlueprintPull and l__CollectionService__4:HasTag(v9:getRootModel(p90.mousePart), "Blueprint") then
			return;
		end;
		if not p90.placing then
			p90.state = v8.Actions.Extract;
			p90:startIridiumEffect(true);
			p90:fireServer(v8.Actions.Extract, v8.States.Activated, { p90.mousePoint, p90.mousePart });
			return;
		end;
	elseif p92 == Enum.UserInputState.End and p90.state == v8.Actions.Extract then
		p90.state = nil;
		p90:stopIridiumEffect();
		p90:fireServer(v8.Actions.Extract, v8.States.Deactivated);
	end;
end;
function v30.onGDown(p93, p94, p95)
	if p95 ~= Enum.UserInputState.Begin then
		if p95 == Enum.UserInputState.End then
			p93.state = nil;
			p93:fireServer(v8.Actions.Destroy, v8.States.Deactivated);
		end;
		return;
	end;
	if v17.lockDestroy and not p93.mousePart:IsDescendantOf(v17.lockDestroy) then
		return;
	end;
	p93.state = v8.Actions.Destroy;
	p93:fireServer(v8.Actions.Destroy, v8.States.Activated, { p93.mousePoint, p93.mousePart });
end;
function v30.onBDown(p96, p97, p98)
	if p98 ~= Enum.UserInputState.Begin then
		return;
	end;
	p96:fireServer(v8.Actions.Upgrade, v8.States.Fired, { p96.mousePoint, p96.mousePart });
end;
function v30.onButtonBDown(p99, p100, p101)
	if p101 ~= Enum.UserInputState.Begin then
		return;
	end;
	if p99.placing then
		p99:reportEvent({
			Name = "PortafabPlacementAbort"
		});
		p99:abortPlacement();
		return;
	end;
	if #p99.pastSchemas > 0 then
		p99:previousSchema();
		return;
	end;
	local l__Parent__71 = script.Parent.Parent;
	if not l__Parent__71 then
		return;
	end;
	local v72 = l__Parent__71:FindFirstChildOfClass("Humanoid");
	if not v72 then
		return;
	end;
	v72:UnequipTools();
end;
function v30.onPlaceModel(p102, p103)
	p102:bindDragger();
	p102.placing = true;
	v11.structureHash = v11:generateStructureHash();
	v11:enterPlacementMode(p103.Name);
end;
function v30.isInRange(p104)
	local v73 = l__BarrelAttachment__2.WorldPosition - p104.mousePoint;
	if v73.X ^ 2 + v73.Y ^ 2 + v73.Z ^ 2 <= p104.range ^ 2 then
		return true;
	end;
	return false;
end;
local u18 = {
	[v8.Actions.Extrude] = true, 
	[v8.Actions.Extract] = true, 
	[v8.Actions.Destroy] = true
};
function v30.updateContextHints(p105)
	local v74 = v9:getRootModel(p105.mousePart, true);
	if not v74 then
		p105.previousStructureHovered = nil;
		p105:removeHint("UpgradeHint");
		p105:removeHint("DestroyHint");
		p105:removeHint("RepairHint");
		p105:removeHint("InterfaceHint");
		return;
	end;
	if not p105:isInRange() then
		p105:removeHint("UpgradeHint");
		p105:removeHint("DestroyHint");
		p105:removeHint("RepairHint");
		p105:removeHint("InterfaceHint");
		return;
	end;
	if u18[p105.state and ""] and p105.previousStructureHovered ~= v74 then
		p105:serverUpdateMouse();
		p105.previousStructureHovered = v74;
	end;
	if v9:canUpgradeStructure(v74) then
		p105:addHint("UpgradeHint", { { "B", "Upgrade" } });
	else
		p105:removeHint("UpgradeHint");
	end;
	if v9:playerCanInteract(v74, l__LocalPlayer__7) then
		p105:addHint("DestroyHint", { { "G", "Destroy" } });
	else
		p105:removeHint("DestroyHint");
	end;
	if v9:canRepairStructure(v74) and not v15.current then
		p105:addHint("RepairHint", { { "L Click", "Repair" } });
	else
		p105:removeHint("RepairHint");
	end;
	if not v9:canInterface(v74, l__LocalPlayer__7) and (not p105.mousePart or p105.mousePart.Parent ~= workspace.Terrain) then
		p105:removeHint("InterfaceHint");
		return;
	end;
	p105:addHint("InterfaceHint", { { "L Click", "Push" }, { "E", "Pull" } });
end;
function v30.updateMouse(p106)
	local l__mouse__75 = l__LocalPlayer__7:GetMouse();
	local v76 = workspace.CurrentCamera:ScreenPointToRay(l__mouse__75.X, l__mouse__75.Y);
	local v77 = Ray.new(v76.Origin, v76.Direction * 1024);
	local v78 = l__CollectionService__4:GetTagged("RayIgnore");
	table.insert(v78, l__LocalPlayer__7.Character);
	table.insert(v78, workspace:FindFirstChild("Effects"));
	local v79, v80, v81 = workspace:FindPartOnRayWithIgnoreList(v77, v78);
	p106.mousePart = v79;
	p106.mousePoint = v80;
	p106.mouseNormal = v81;
	v23.WorldPosition = p106:clampPoint(p106.mousePoint, p106.range);
	if p106.updateFrequency <= tick() - p106.lastUpdated and u18[p106.state and ""] then
		p106.lastUpdated = tick();
		p106:serverUpdateMouse();
	end;
end;
function v30.toggleScroll(p107, p108)
	if p108 then
		l__LocalPlayer__7.CameraMaxZoomDistance = p107.lastMaxZoom;
		l__LocalPlayer__7.CameraMinZoomDistance = p107.lastMinZoom;
		return;
	end;
	local l__Magnitude__82 = (workspace.CurrentCamera.CoordinateFrame.p - workspace.CurrentCamera.Focus.p).Magnitude;
	l__LocalPlayer__7.CameraMaxZoomDistance = l__Magnitude__82;
	l__LocalPlayer__7.CameraMinZoomDistance = l__Magnitude__82;
end;
function v30.bindDragger(p109)
	p109:unbindDragger();
	p109:addHint("DraggerHint", { { "L Click", "Place" }, { "E", "Cancel" }, { "R", "Rotate 90" }, { "Shift + Scroll", "Fine Rotate" }, { "T", "Change Snap" } });
	l__ContextActionService__1:BindAction("PortafabDragger", function(...)
		return p109:onDraggerButtonDown(...);
	end, false, table.unpack({ l__Enum_KeyCode_E__16, l__Enum_KeyCode_T__17, l__Enum_KeyCode_R__15, Enum.KeyCode.LeftShift }));
end;
function v30.unbindDragger(p110)
	p110:removeHint("DraggerHint");
	l__ContextActionService__1:UnbindAction("PortafabDraggerFineRotate");
	l__ContextActionService__1:UnbindAction("PortafabDragger");
end;
local u19 = {
	LClick = { Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2 }, 
	MClick = { Enum.UserInputType.MouseButton3, Enum.KeyCode.ButtonR3 }, 
	EDown = { Enum.KeyCode.E, Enum.KeyCode.ButtonL2 }, 
	GDown = { Enum.KeyCode.G, Enum.KeyCode.ButtonX }, 
	BDown = { Enum.KeyCode.B, Enum.KeyCode.ButtonY }, 
	ButtonBDown = { Enum.KeyCode.ButtonB, Enum.KeyCode.End }
};
function v30.bind(p111)
	p111:unbind();
	for v83, v84 in pairs(u19) do
		l__ContextActionService__1:BindAction(("Portafab%s"):format(v83), function(p112, p113, p114)
			if v17.lockAction and not table.find(v17.lockAction, v83) and p113 == Enum.UserInputState.Begin then
				return Enum.ContextActionResult.Pass;
			end;
			return p111[("on%s"):format(v83)](p111, p112, p113, p114);
		end, false, table.unpack(v84));
	end;
	l__ContextActionService__1:BindAction("PortafabUI", function(...)
		return p111:onGuiButtonDown(...);
	end, false, table.unpack(v24));
	l__RunService__6:BindToRenderStep("Portafab", Enum.RenderPriority.Input.Value, function(...)
		p111:updateMouse(...);
		p111:updateContextHints(...);
	end);
end;
function v30.unbind(p115)
	for v85, v86 in pairs(u19) do
		l__ContextActionService__1:UnbindAction(("Portafab%s"):format(v85));
	end;
	l__ContextActionService__1:UnbindAction("PortafabUI");
	l__RunService__6:UnbindFromRenderStep("Portafab");
end;
function v30.bindToTool(p116, p117)
	local v87 = false;
	if typeof(p117) == "Instance" then
		v87 = p117:IsA("Tool");
	end;
	assert(v87, ("Bad argument #1 to PortafabServer:BindTool, expected Tool, got %s"):format(typeof(p117)));
	p116.range = 20;
	p116.updateFrequency = 0.4;
	p116.lastUpdated = tick();
	p116.state = nil;
	p116.tool = p117;
	p116.uiSlots = {};
	p116.lastPortafabClick = tick();
	p116.schema = nil;
	p116.activeSchema = nil;
	p116.pastSchemas = {};
	p116.placing = false;
	p116.constructionMenuShown = false;
	p116.constructionMenu = nil;
	p116.hints = {};
	p116.assetsToLoad = {};
	p116.slotConnections = {};
	p116.assetsLoaded = false;
	p116.previousStructureHovered = nil;
	p116.inputBeganConnection = nil;
	p116.lastMaxZoom = l__LocalPlayer__7.CameraMaxZoomDistance;
	p116.lastMinZoom = l__LocalPlayer__7.CameraMinZoomDistance;
	p116.priorityBeaconsRequired = v18;
	p116.priorityBeaconCost = v19;
	p116.tool.Equipped:Connect(function(...)
		p116:onEquipped(...);
	end);
	p116.tool.Unequipped:Connect(function(...)
		p116:onUnequipped(...);
	end);
	p116.remote.OnClientEvent:Connect(function(...)
		p116:onRemote(...);
	end);
	local v88 = Instance.new("BindableFunction");
	v88.Name = "IsPlacing";
	function v88.OnInvoke()
		return p116.placing;
	end;
	v88.Parent = script;
end;
return v30;
