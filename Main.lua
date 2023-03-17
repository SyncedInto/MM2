wait(10)

if game.PlaceId ~= 142823291 then
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local CollectiblesManager = Instance.new("StringValue", workspace)
CollectiblesManager.Value = "None"

local SavingBase = Instance.new("Part", workspace)
SavingBase.Size = Vector3.new(30, 3, 30)
SavingBase.Position = Vector3.new(490, -70, 2452)
SavingBase.Anchored = true
SavingBase.Material = Enum.Material.SmoothPlastic
SavingBase.Transparency = .6
SavingBase.CastShadow = false

local Speed = 19
local Outlines = true
local ESP = true

local Keys = {
    ["Nametags"] = Enum.KeyCode.Z,
    ["Outlines"] = Enum.KeyCode.X,
    ["Run"] = Enum.KeyCode.LeftControl,
    ["Speed Up"] = Enum.KeyCode.E,
    ["Speed Down"] = Enum.KeyCode.Q,
    ["TP to gun"] = Enum.KeyCode.R,
    ["Lag"] = Enum.KeyCode.G,
    ["Coins ESP"] = Enum.KeyCode.T,
}

local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/DMfEDWTE"))()
local FinityWindow = Finity.new(true, "MM2 | Press RightControl", true)

local KeyBind = FinityWindow:Category("Keybinds")
local Configurations = FinityWindow:Category("Configurations")
local Credits = FinityWindow:Category("Credits")
local Sector = KeyBind:Sector("Keybinds")
local SectorConfig = Configurations:Sector("Configurations")
local CreditsSector = Credits:Sector("Credits")

local DeletingHearts = false
local DeletingCoins = false

--

Sector:Cheat(
	"Keybind",
	"Nametags",
	function(NewValue)
		Keys.Nametags = NewValue
	end,
	{bind = Keys.Nametags}
)

Sector:Cheat(
	"Keybind",
	"Outlines",
	function(NewValue)
		Keys.Outlines = NewValue
	end,
	{bind = Keys.Outlines}
)

Sector:Cheat(
	"Keybind",
	"Run",
	function(NewValue)
		Keys.Run = NewValue
	end,
	{bind = Keys.Run}
)

Sector:Cheat(
	"Keybind",
	"Speed Up",
	function(NewValue)
		Keys["Speed Up"] = NewValue
	end,
	{bind = Keys["Speed Up"]}
)

Sector:Cheat(
	"Keybind",
	"Speed Down",
	function(NewValue)
		Keys["Speed Down"] = NewValue
	end,
	{bind = Keys["Speed Down"]}
)

Sector:Cheat(
	"Keybind",
	"TP to gun",
	function(NewValue)
		Keys["TP to gun"] = NewValue
	end,
	{bind = Keys["TP to gun"]}
)

Sector:Cheat(
	"Keybind",
	"Lag",
	function(NewValue)
		Keys.Lag = NewValue
	end,
	{bind = Keys.Lag}
)

Sector:Cheat(
	"Keybind",
	"Coins ESP",
	function(NewValue)
		Keys["Coins ESP"] = NewValue
	end,
	{bind = Keys["Coins ESP"]}
)

Sector:Cheat(
	"Keybind",
	"Popup Menu",
	function(NewValue)
		FinityWindow.ChangeToggleKey(NewValue)
	end,
	{bind = Enum.KeyCode.RightControl}
)

SectorConfig:Cheat(
	"Slider",
	"Speed",
	function(Value)
		Speed = Value
	end,
	{
		min = 0,
		max = 100,
		suffix = " Speed"
	}
)
	
SectorConfig:Cheat(
	"Toggle",
	"Delete Coins",
	function(Value)
		if Value then
		    DeletingCoins = true
		    
		    for _, v in pairs(workspace:GetDescendants()) do
		        if v.Name == "Coin_Server" and v:FindFirstChild("CoinType") and v:FindFirstChild("Coin") and v.CoinType.Value == "Coin" then
		            v:Destroy()
		        end
		    end
		else
		    DeletingCoins = false
		end
	end
)

SectorConfig:Cheat(
	"Toggle",
	"Delete Hearts",
	function(Value)
		if Value then
		    DeletingHearts = true
		    
		    for _, v in pairs(workspace:GetDescendants()) do
		        if v.Name == "Coin_Server" and v:FindFirstChild("CoinType") and v:FindFirstChild("Coin") and v.CoinType.Value == "Heart" then
		            v:Destroy()
		        end
		    end
		else
		    DeletingHearts = false
		end
	end
)

local CanChangeFov = true
SectorConfig:Cheat(
	"Toggle",
	"Can change FOV when running",
	function(Value)
            CanChangeFov = Value
	end,
	{enabled = true}
)

local CanChangeSpeedKnife = false
SectorConfig:Cheat(
	"Toggle",
	"Can change speed while holding knife",
	function(Value)
            CanChangeSpeedKnife = Value
	end,
	{enabled = false}
)

local FriendsDifferentColor = true
SectorConfig:Cheat(
	"Toggle",
	"Friends have different colors",
	function(Value)
            FriendsDifferentColor = Value
	end,
	{enabled = true}
)

CreditsSector:Cheat(
    "Label",
    "Special thanks to nat for being such an amazing wife <3"
)

function CreateESPPart(BodyPart, color, CoinType)
	local Box = Instance.new("BoxHandleAdornment", BodyPart)
	Box.Size = BodyPart.Size + Vector3.new(0.1, 0.1, 0.1)
	Box.Name = "ESPPart"
	Box.Adornee = BodyPart
	Box.Color3 = color
	Box.AlwaysOnTop = true
	Box.ZIndex = 10

	if Box and BodyPart and CoinType then
		if CollectiblesManager.Value == "None" then
			Box.Transparency = 1
		elseif CollectiblesManager.Value == "All" then
			Box.Transparency = .2
		elseif CollectiblesManager.Value == "Hearts" then
			if CoinType.Value == "Heart" then
				Box.Transparency = .2
			else
				Box.Transparency = 1
			end
		elseif CollectiblesManager.Value == "Coins" then
			if CoinType.Value == "Coin" then
				Box.Transparency = .2
			else
				Box.Transparency = 1
			end
		end
	end

	CollectiblesManager.Changed:Connect(function()
		if Box and BodyPart and CoinType then
			if CollectiblesManager.Value == "None" then
				Box.Transparency = 1
			elseif CollectiblesManager.Value == "All" then
				Box.Transparency = .2
			elseif CollectiblesManager.Value == "Hearts" then
				if CoinType.Value == "Heart" then
					Box.Transparency = .2
				else
					Box.Transparency = 1
				end
			elseif CollectiblesManager.Value == "Coins" then
				if CoinType.Value == "Coin" then
					Box.Transparency = .2
				else
					Box.Transparency = 1
				end
			end
		end
	end)
end

function Create(base, Color)
	local bb
	local Highlight

	if not base:FindFirstChild("ESP") then
	    if not base.Parent:FindFirstChild("Highlight") or not base:FindFirstChild("Highlight") then
	        if base.Name == "GunDrop" then
	            parent = base
	        else
	            parent = base.Parent
	        end
	        
		    Highlight = Instance.new("Highlight", parent)
		    Highlight.FillTransparency = 1
		    Highlight.OutlineColor = Color
		    
			bb = Instance.new("BillboardGui", base)
			bb.Adornee = base
			bb.ExtentsOffset = Vector3.new(0,1,0)
			bb.AlwaysOnTop = true
			bb.Size = UDim2.new(0,5,0,5)
			bb.StudsOffset = Vector3.new(0,1,0)
			--bb.TextLabel.TextColor3 = Color
			bb.Name = "ESP"

			local frame = Instance.new("Frame", bb)
			frame.ZIndex = 10
			frame.BackgroundTransparency = 0.3
			frame.Size = UDim2.new(1,0,1,0)
			local txtlbl = Instance.new("TextLabel",bb)
			txtlbl.ZIndex = 10
			txtlbl.Text = base.Parent.Name
			if base.Name == "GunDrop" then
				txtlbl.Text = base.Name
				--Highlight.OutlineTransparency = 1
			end
			txtlbl.BackgroundTransparency = 1
			txtlbl.Position = UDim2.new(0,0,0,-35)
			txtlbl.Size = UDim2.new(1,0,10,0)
			txtlbl.Font = "ArialBold"
			txtlbl.FontSize = "Size12"
			txtlbl.TextStrokeTransparency = 0.5
		end
	else
		bb = base:FindFirstChild("ESP")
		bb.TextLabel.TextColor3 = Color
		
		if base.Name == "GunDrop" then
            Highlight = base:FindFirstChild("Highlight")
        else
            Highlight = base.Parent:FindFirstChild("Highlight")
        end
		
		Highlight.OutlineColor = Color
		
		if Outlines then
		    Highlight.OutlineTransparency = 0
		else
		    Highlight.OutlineTransparency = 1
		end
		
		bb.Enabled = ESP
	end
end

function ChangeSpeed(SpeedArg)
	if Player and Player.Character and Player.Character:FindFirstChild("Humanoid") then
		if not SpeedArg then
			print(Speed)
			Player.Character.Humanoid.WalkSpeed = Speed
		else
			Player.Character.Humanoid.WalkSpeed = SpeedArg
		end
	end
end

function Check(v)
	if v and v.Name == "GunDrop" then
		Create(v, Color3.fromRGB(255, 255, 0))
		return
	end
	
	local InnocentColor = Color3.fromRGB(0, 255, 0)
	local SheriffColor = Color3.fromRGB(0, 0, 255)
	local MurdererColor = Color3.fromRGB(255, 0, 0)
	
	if v and v:IsFriendsWith(Player.UserId) and FriendsDifferentColor then
	    InnocentColor = Color3.fromRGB(255, 255, 0)
    	SheriffColor = Color3.fromRGB(0, 255, 255)
    	MurdererColor = Color3.fromRGB(255, 0, 255)
	end

	if v and v ~= Player and v.Backpack and v.Character and v.Character:FindFirstChild("Head") then
		if v.Backpack and v.Character:FindFirstChildOfClass("Tool") then
			if v.Backpack and v.Character:FindFirstChildOfClass("Tool").Name == "Gun" then
				Create(v.Character:FindFirstChild("Head"), SheriffColor)
			elseif v.Backpack and v.Character:FindFirstChildOfClass("Tool").Name == "Knife" then
				Create(v.Character:FindFirstChild("Head"), MurdererColor)
			end

			if v.Backpack and not v.Character:FindFirstChild("Gun") and not v.Character:FindFirstChild("Knife") then
				Create(v.Character:FindFirstChild("Head"), InnocentColor)
			end
		elseif v.Backpack and v.Backpack:FindFirstChildOfClass("Tool") then
			if v.Backpack and v.Backpack:FindFirstChildOfClass("Tool").Name == "Gun" then
				Create(v.Character:FindFirstChild("Head"), SheriffColor)
			elseif v.Backpack and v.Backpack:FindFirstChildOfClass("Tool").Name == "Knife" then
				Create(v.Character:FindFirstChild("Head"), MurdererColor)
			end

			if v.Backpack and not v.Backpack:FindFirstChild("Gun") and not v.Backpack:FindFirstChild("Knife") then
				Create(v.Character:FindFirstChild("Head"), InnocentColor)
			end
		end
	end
end

RunService.Stepped:Connect(function()
	for _, v in pairs(Players:GetPlayers()) do
		if v then
			Check(v)
		end
	end

	if workspace:FindFirstChild("GunDrop") and Player.Character then --and Player.Backpack and not Player.Backpack:FindFirstChild("Get Gun") and not Player.Character:FindFirstChild("Get Gun") then
		Check(workspace:FindFirstChild("GunDrop"), Color3.fromRGB(255, 255, 0))
	end
	
	if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
	    SavingBase.Position = Vector3.new(Player.Character.HumanoidRootPart.Position.X, -70, Player.Character.HumanoidRootPart.Position.Z)
	end
end)

local CanRun = true
RunService.RenderStepped:Connect(function()
	if CanRun then
		CanRun = false
		if UserInputService:IsKeyDown(Keys.Run) then
			if Player and Player.Character and Player.Character:FindFirstChild("Humanoid") then
				ChangeSpeed()
				
				print(CanChangeFov)
				if CanChangeFov then
				    workspace.CurrentCamera.FieldOfView = 80
				end
			end
		end
		wait(.1)
		CanRun = true
	end
end)

UserInputService.InputEnded:Connect(function(Input, Paused)
	if Input.KeyCode == Keys.Run then
		if Player and Player.Character and Player.Character:FindFirstChild("Humanoid") then
			ChangeSpeed(16)
			workspace.CurrentCamera.FieldOfView = 70
		end
	end
end)

UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys["Coins ESP"] and not Paused then
		if CollectiblesManager.Value == "None" then
			CollectiblesManager.Value = "All"
		elseif CollectiblesManager.Value == "All" then
			CollectiblesManager.Value = "Hearts"
		elseif CollectiblesManager.Value == "Hearts" then
			CollectiblesManager.Value = "Coins"
		elseif CollectiblesManager.Value == "Coins" then
			CollectiblesManager.Value = "None"
		end
	end
end)

local CanGrabGun = true
UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys["TP to gun"] and workspace:FindFirstChild("GunDrop") and Player.Character and Player.Character.HumanoidRootPart and not Paused and CanGrabGun then
		CanGrabGun = false

		local OldPos = Player.Character.HumanoidRootPart.CFrame

		Player.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame
		wait(.05)
		Player.Character.Humanoid:MoveTo(OldPos.Position)
		wait(.23)
		Player.Character.HumanoidRootPart.CFrame = OldPos

		CanGrabGun = true
	end
end)

workspace.DescendantAdded:Connect(function(v)
    wait(.05)
	if v.Name == "Coin_Server" and v:FindFirstChild("CoinType") and v:FindFirstChild("Coin") then
		if v.CoinType.Value == "Heart" then
		    if DeletingHearts then
		        v:Destroy()
		        return
		    end
			CreateESPPart(v.Coin, Color3.fromRGB(250, 85, 162), v.CoinType)
		elseif v.CoinType.Value == "Coin" then
		    if DeletingCoins then
		        v:Destroy()
		        return
		    end
			CreateESPPart(v.Coin["MainCoin"], Color3.fromRGB(239, 247, 72), v.CoinType)
		end
	end
end)

local Lag = false
UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys.Lag and not Paused then
		Lag = not Lag

		if Lag then
			settings():GetService("NetworkSettings").IncomingReplicationLag = 9e9
		else
			settings():GetService("NetworkSettings").IncomingReplicationLag = 0
		end
	end
end)

UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys["Speed Up"] and not Paused then
	    if not CanChangeSpeedKnife and Player.Character:FindFirstChild("Knife") then
	        return
	    end
	    
		Speed += 1
	end
end)

UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys["Speed Down"] and not Paused then
	    if not CanChangeSpeedKnife and Player.Character:FindFirstChild("Knife") then
	        return
	    end
	    
		Speed -= 1
	end
end)

UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys.Outlines and not Paused then
		Outlines = not Outlines
	end
end)

UserInputService.InputBegan:Connect(function(Input, Paused)
	if Input.KeyCode == Keys.Nametags and not Paused then
		ESP = not ESP
	end
end)
