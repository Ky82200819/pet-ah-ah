
wait(1)

local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke

-- Hooking the _check function in the module to bypass the anticheat.

local old
old = hookfunction(getupvalue(Fire, 1), function(...)
   return true
end)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
    game:GetService("RunService").Heartbeat:Wait();
end;
 
while 1 do
    local Ccount = 0
    for i, v in pairs(Invoke("Get Coins")) do
        Ccount = Ccount + 1
    end
    if Ccount >= 10 then break end
    wait(3)
end

function GetPetDataById(id2)
    for i2, v2 in pairs(game:GetService("ReplicatedStorage")["__DIRECTORY"].Pets:GetChildren()) do
        
        if string.match(v2.Name, "%d+") == tostring(id2) then
            for i3, v3 in pairs(v2:GetChildren()) do
                if v3:IsA("ModuleScript") then
                    return require(v3)
                end
            end
        end
    end
end

Settings = {
    AutoCompleteGame = {
        BankInvite = false,
        ForestUpgrades = true,
        Bank = {
            Gems = 5000000,
            Pets = 4
        }
    },
    Mailbox = {
        Username = "",
        Message = "All My Gems!"
    },
    Fruits = {
        Apple = true,
        Banana = true,
        Pear = true,
        Orange = true,
        Pineapple = true,
        RainbowFruit = true
    },
    AutoFarm = {
        Area = "Kawaii Tokyo",
        Mode = "Highest Health",
        Delay = 0.1,
        Enabled = false
    },
    AutoOpen = {
        Egg = "Cracked Egg",
        Enabled = false,
        Mode = "Single"
    },
    Withdraw = {
        Gems = true,
        Huges = true,
        Leave = true
    },
    Boosts = {
        UltraLuck = false,
        SuperLuck = false,
        TripleDamage = false,
        TripleCoins = false,
        ServerLuck = false,
        ServerCoins = false,
        ServerDamage = false
    },
    Delete = {
        DeleteDupePets = false
    },
    EnchantDelete = {
        Enchant = "",
        Level = 1,
        Royalty = false,
        Enabled = false
    }
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local InputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local ContentProvider = game:GetService("ContentProvider")
local banSuccess, banError = pcall(function() 
		local Blunder = require(game:GetService("ReplicatedStorage"):WaitForChild("X", 10):WaitForChild("Blunder", 10):WaitForChild("BlunderList", 10))
		if not Blunder or not Blunder.getAndClear then LocalPlayer:Kick("Error while bypassing the anti-cheat! (Didn't find blunder)") end
		
		local OldGet = Blunder.getAndClear
		setreadonly(Blunder, false)
		local function OutputData(Message)
		   print("-- PET SIM X BLUNDER --")
		   print(Message .. "\n")
		end
		
		Blunder.getAndClear = function(...)
		   local Packet = ...
			for i,v in next, Packet.list do
			   if v.message ~= "PING" then
				   OutputData(v.message)
				   table.remove(Packet.list, i)
			   end
		   end
		   return OldGet(Packet)
		end
		
		setreadonly(Blunder, true)
	end)

	if not banSuccess then
		LocalPlayer:Kick("Error while bypassing the anti-cheat! (".. banError ..")")
		return
	end
	
	local Library = require(game:GetService("ReplicatedStorage").Library)
	assert(Library, "Oopps! Library has not been loaded. Maybe try re-joining?") 
	while not Library.Loaded do task.wait() end
	
	Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	
	
	local bypassSuccess, bypassError = pcall(function()
		if not Library.Network then 
			LocalPlayer:Kick("Network not found, can't bypass!")
		end
		
		if not Library.Network.Invoke or not Library.Network.Fire then
			LocalPlayer:Kick("Network Invoke/Fire was not found! Failed to bypass!")
		end
		
		hookfunction(debug.getupvalue(Library.Network.Invoke, 1), function(...) return true end)
		-- Currently we don't need to hook Fire, since both Invoke/Fire have the same upvalue, this may change in future.
		-- hookfunction(debug.getupvalue(Library.Network.Fire, 1), function(...) return true end)
		
		local originalPlay = Library.Audio.Play
		Library.Audio.Play = function(...) 
			if checkcaller() then
				local audioId, parent, pitch, volume, maxDistance, group, looped, timePosition = unpack({ ... })
				if type(audioId) == "table" then
					audioId = audioId[Random.new():NextInteger(1, #audioId)]
				end
				if not parent then
					warn("Parent cannot be nil", debug.traceback())
					return nil
				end
				if audioId == 0 then return nil end
				
				if type(audioId) == "number" or not string.find(audioId, "rbxassetid://", 1, true) then
					audioId = "rbxassetid://" .. audioId
				end
				if pitch and type(pitch) == "table" then
					pitch = Random.new():NextNumber(unpack(pitch))
				end
				if volume and type(volume) == "table" then
					volume = Random.new():NextNumber(unpack(volume))
				end
				if group then
					local soundGroup = game.SoundService:FindFirstChild(group) or nil
				else
					soundGroup = nil
				end
				if timePosition == nil then
					timePosition = 0
				else
					timePosition = timePosition
				end
				local isGargabe = false
				if not pcall(function() local _ = parent.Parent end) then
					local newParent = parent
					pcall(function()
						newParent = CFrame.new(newParent)
					end)
					parent = Instance.new("Part")
					parent.Anchored = true
					parent.CanCollide = false
					parent.CFrame = newParent
					parent.Size = Vector3.new()
					parent.Transparency = 1
					parent.Parent = workspace:WaitForChild("__DEBRIS")
					isGargabe = true
				end
				local sound = Instance.new("Sound")
				sound.SoundId = audioId
				sound.Name = "sound-" .. audioId
				sound.Pitch = pitch and 1
				sound.Volume = volume and 0.5
				sound.SoundGroup = soundGroup
				sound.Looped = looped and false
				sound.MaxDistance = maxDistance and 100
				sound.TimePosition = timePosition
				sound.RollOffMode = Enum.RollOffMode.Linear
				sound.Parent = parent
				if not require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client")).Settings.SoundsEnabled then
					sound:SetAttribute("CachedVolume", sound.Volume)
					sound.Volume = 0
				end
				sound:Play()
				getfenv(originalPlay).AddToGarbageCollection(sound, isGargabe)
				return sound
			end
			
			return originalPlay(...)
		end
	
	end)
	
	if not bypassSuccess then
		print(bypassError)
		LocalPlayer:Kick("Error while bypassing network, try again or wait for an update!")
		return
	end

function FrTeleportToWorld(world, area)
        local Library = require(game:GetService("ReplicatedStorage").Library)
		Library.WorldCmds.Load(world)
		wait(0.25)
		local areaTeleport = Library.WorldCmds.GetMap().Teleports:FindFirstChild(area)
		Library.Signal.Fire("Teleporting")
		task.wait(0.25)
		local Character = game.Players.LocalPlayer.Character
		local Humanoid = Character.Humanoid
		local HumanoidRootPart = Character.HumanoidRootPart
		Character:PivotTo(areaTeleport.CFrame + areaTeleport.CFrame.UpVector * (Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2))
		Library.Network.Fire("Performed Teleport", area)
		task.wait(0.25)
end
function FrTeleportToArea(world, area)
    local areaTeleport = Library.WorldCmds.GetMap().Teleports:FindFirstChild(area)
		local Character = game.Players.LocalPlayer.Character
		local Humanoid = Character.Humanoid
		local HumanoidRootPart = Character.HumanoidRootPart
		Character:PivotTo(areaTeleport.CFrame + areaTeleport.CFrame.UpVector * (Humanoid.HipHeight + HumanoidRootPart.Size.Y / 2))
		Library.Network.Fire("Performed Teleport", area)
    
end

function indexbank()
    local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke
    
    -- Hooking the _check function in the module to bypass the anticheat.
    

    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-389.273651, 98.0880356, 97.2807617, 0.988577247, -1.05826228e-08, -0.150714993, 1.43523975e-08, 1, 2.39248354e-08, 0.150714993, -2.58146695e-08, 0.988577247)
    wait(0.5)
    Invoke("Buy Upgrade", "Pet Storage")
    Invoke("Buy Upgrade", "Pet Storage")
    Invoke("Buy Upgrade", "Pet Storage")
    Invoke("Buy Upgrade", "Pet Storage")
    Invoke("Buy Upgrade", "Pet Storage")
    wait(1)
    local inv = game:GetService("Players").LocalPlayer.PlayerGui.Inventory
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(231.388885, 98.2168579, 356.876953, -0.976782918, 1.37872318e-08, 0.214231476, 2.94478699e-08, 1, 6.99101008e-08, -0.214231476, 7.45956541e-08, -0.976782918)
    game:GetService("Players").LocalPlayer.PlayerGui.Bank.Enabled = true
    wait(3)
    local BankHolder = game:GetService("Players").LocalPlayer.PlayerGui.Bank.Frame.Side.Holder
    local bankName = ""
    for i, v in pairs(BankHolder:GetChildren(BankHolder)) do
        if string.find(v.Name, "INVITE") then
            bankId = string.gsub(v.Name,"INVITE%-", "")
            print(bankId)
            Invoke("Accept Bank Invite", bankId)
            break
        end
    end
    wait(5)
    local pets = {}
    local temppets = {}
    local count = 0
    wait(1)
    for i, v in pairs(Invoke("Get Bank", bankId).Storage.Pets) do
        table.insert(temppets, v.uid)
        count = count + 1
        if count >= 40 then
            table.insert(pets, temppets)
            temppets = {}
            count = 0
        end
    end
    table.insert(pets, temppets)
    for i, v in pairs(pets) do
        Invoke("Bank Withdraw", bankId, v, 0)
        print("Withdrew 40 Pets. Indexing.")
        inv.Enabled = true
        wait(30)
        Invoke("Bank Deposit", bankId, v, 0)
        print("Deposited Pets Back To Bank")
    end
    print("Finished Indexing.")
    Invoke("Leave Bank", bankId)
end
function depall()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(231.388885, 98.2168579, 356.876953, -0.976782918, 1.37872318e-08, 0.214231476, 2.94478699e-08, 1, 6.99101008e-08, -0.214231476, 7.45956541e-08, -0.976782918)
    game:GetService("Players").LocalPlayer.PlayerGui.Bank.Enabled = true
    wait(3)
    bankId = ""
    local inv = game:GetService("Players").LocalPlayer.PlayerGui.Inventory
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui.Bank.Frame.Side.Holder:GetChildren()) do
    	if v:FindFirstChild("Owner") then
    		if v.Owner.Text == "My Bank" then
    			bankId = v.Name
    		end
    	end
    end
    local pets = {}
    local temppets = {}
    local count = 0
    wait(1)
    local Library = require(game:GetService("ReplicatedStorage").Library)
    for i, v in pairs(Library.Save.Get().Pets) do
        table.insert(temppets, v.uid)
        count = count + 1
        if count >= 49 then
            table.insert(pets, temppets)
            temppets = {}
            count = 0
        end
    end
    table.remove(temppets, 1)
    table.insert(pets, temppets)
    for i, v in pairs(pets) do
        Invoke("Bank Deposit", bankId, v, 0)
        inv.Enabled = true
        wait(1)
    end
end
function withall()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(231.388885, 98.2168579, 356.876953, -0.976782918, 1.37872318e-08, 0.214231476, 2.94478699e-08, 1, 6.99101008e-08, -0.214231476, 7.45956541e-08, -0.976782918)
    game:GetService("Players").LocalPlayer.PlayerGui.Bank.Enabled = true
    wait(3)
    bankId = ""
    local inv = game:GetService("Players").LocalPlayer.PlayerGui.Inventory
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui.Bank.Frame.Side.Holder:GetChildren()) do
    	if v:FindFirstChild("Owner") then
    		if v.Owner.Text == "My Bank" then
    			bankId = v.Name
    		end
    	end
    end
    local pets = {}
    local temppets = {}
    local count = 0
    wait(1)
    local Library = require(game:GetService("ReplicatedStorage").Library)
    for i, v in pairs(Invoke("Get Bank", bankId).Storage.Pets) do
        table.insert(temppets, v.uid)
        count = count + 1
        if count >= 49 then
            table.insert(pets, temppets)
            temppets = {}
            count = 0
        end
    end
    table.insert(pets, temppets)
    for i, v in pairs(pets) do
        Invoke("Bank Withdraw", bankId, v, 0)
        inv.Enabled = true
        wait(1)
    end
end
function fruitfarm()
    local TimeElapsed = 0
    local ThingsBroke = 0
    local STOP = false
    local MADE = false
    
    HttpService = game:GetService("HttpService")
    
    local timer = coroutine.create(function()
        while 1 do
            TimeElapsed = TimeElapsed + 1
            wait(1)
        end
    end)
    
    coroutine.resume(timer)
    SettingsBreakable = {
        WorldHop = true, -- If This Is True It Will Break Stuff In Every World Up To Cat World
        Area = "", -- If World Hop Is False And This Isnt Blank It Will Only Farm In This Area
        AutoCollectOrbs = true, -- If This Is True It Will Collect The Orbs Automatically
        Loop = false, -- If This Is True It Will Happen All Again And Again (Only Enable If Server Hop Is False)
        WaitTime = 20, -- If Something Isnt Broken Past This Time Then Move On To The Next Thing 1 = 0.1s
        ThingsToBreak = {
        } -- List Of Things To Break, If The Name Of The Breakable Contains Any Of These It Will Break It
    }
    for i, v in pairs(Settings.Fruits) do
        if v == true then
            table.insert(SettingsBreakable.ThingsToBreak, i)
        end
    end
    if Settings.Fruits.RainbowFruit then
        table.insert(SettingsBreakable.ThingsToBreak, "Rainbow Fruit")
    end
    WebhookLayout = { -- {amount} | shows the amount of breakables broken {time} | Shows the time it took finish (seconds)
        Title = "Breakables Farmed", -- The Title Of The Webhook
        Description = "You Broke ``{amount}`` **Things** In ``{time}`` **Seconds**!", -- Description Of The Webhook
        Color = tonumber(0x6967d5) -- The Color Of The Webhook
    } -- Will be sent after each server hop if the Webhook thing in SettingsBreakable has a link
    
    function PostWebhook(amount, seconds)
        local StatsPath = game:GetService("Players").LocalPlayer.PlayerGui.Main.Right
        function GetCoinsAmount(name)
            return StatsPath[name].Amount.Text
        end
        local thingsfarming = ""
        local coins = ":coin: **Coins: ** ``" .. GetCoinsAmount("Coins") .. "``\n:coin: **Fantasy Coins: ** ``" .. GetCoinsAmount("Fantasy Coins") .. "``\n:coin: **Tech Coins: ** ``" .. GetCoinsAmount("Tech Coins") .. "``\n:coin: **Rainbow Coins: ** ``" .. GetCoinsAmount("Rainbow Coins") .. "``\n:coin: **Cartoon Coins: ** ``" .. GetCoinsAmount("Cartoon Coins") .. "``\n:gem: **Diamonds: ** ``" .. GetCoinsAmount("Diamonds") .. "``"
        local title = WebhookLayout.Title
        title = string.gsub(title, "{amount}", tostring(amount))
        title = string.gsub(title, "{time}", tostring(seconds))
        local desc = WebhookLayout.Description
        desc = string.gsub(desc, "{amount}", tostring(amount))
        desc = string.gsub(desc, "{time}", tostring(seconds))
        for i, v in pairs(SettingsBreakable.ThingsToBreak) do
            thingsfarming = thingsfarming .. ":rock: ``" .. v .. "``\n"
        end
        syn.request({
            Url = SettingsBreakable.Webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode{
                ["content"] = "Username: " .. game.Players.LocalPlayer.Name,
                ["embeds"] = {{
                    ["title"] = title,
                    ["description"] = desc,
                    ["type"] = "rich",
                    ["color"] = WebhookLayout.Color,
                    ["thumbnail"] = {
                        ["url"] = "https://www.biggames.io/_next/static/media/bigGames.66f7ea84.svg",
                        ["height"] = 350,
                        ["width"] = 270
                    },
                    ["author"] = {
                        ["name"] = "Breakable Farmer",
                        ["icon_url"] = "https://tr.rbxcdn.com/d8055fdc4f5c0cb1f7d40f5e10e93eed/150/150/Image/Png"
                    },
                    ["fields"] = {{
                        ["name"] = "Things Farming",
                        ["value"] = thingsfarming,
                        ["inline"] = true
                    },{
                        ["name"] = "Coins",
                        ["value"] = coins,
                        ["inline"] = true
                    }}
                }}
            }
        })
    end
    local WebhookLayout
    local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
    while not v1.Loaded do
    	game:GetService("RunService").Heartbeat:Wait();
    end;
    
    function WaitUntilAllThingsHaveLoaded()
        while 1 do
            if #game.Workspace["__THINGS"].Coins:GetChildren() <= 100 then
                break
            end
            wait(0.1)
        end
        if true then
            return
        end
        while 1 do
            oldcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            wait(1)
            newcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            if newcount ~= oldcount then
                break
            end
        end
        while 1 do
            oldcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            wait(1)
            newcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            if newcount == oldcount then
                break
            end
        end
    end
    
    function ShouldBreak(coin)
        for i2, v2 in pairs(SettingsBreakable.ThingsToBreak) do
            if string.find(coin, v2) then
                return true
            end
        end
        return false
    end
    
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke
    

    
    while 1 do
        local Ccount = 0
        for i, v in pairs(Invoke("Get Coins")) do
            Ccount = Ccount + 1
        end
        if Ccount >= 10 then break end
        wait(3)
    end
    
    function ForeverPickupOrbs()
      while true do
        orbs = {}
        for i, v in pairs (game.Workspace['__THINGS'].Orbs:GetChildren()) do
            table.insert(orbs, v.Name)
        end
        Fire("Claim Orbs", orbs)
        wait(0.1)
      end
    end
    foreverpickup = coroutine.create(ForeverPickupOrbs)
    if SettingsBreakable.AutoCollectOrbs then
        coroutine.resume(foreverpickup)
    end
    
    
    
    game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = true
    wait(1)
    game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = false
    
    if not SettingsBreakable.WorldHop then
        while 1 do
            wait(0.01)
            if SettingsBreakable.Area == "" then
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(Invoke("Get Coins")) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            else
            pcall(function()
                anycoins = true
                if anycoins then
                    FrTeleportToArea("", SettingsBreakable.Area)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == SettingsBreakable.Area then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea(SettingsBreakable.Area, SettingsBreakable.Area)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
            end
            if not SettingsBreakable.Loop then
                break
            end
            if STOP then break end
            if SettingsBreakable.Loop and not MADE then
                MADE = true
                local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
                
                -- Create the button
                local myButton = Instance.new("TextButton")
                myButton.Parent = game.Players.LocalPlayer.PlayerGui.Main -- Assumes the script is a child of a ScreenGui
                myButton.Position = UDim2.new(0.5, -50, 0.5, -50) -- Set the button's position to the center of the screen
                myButton.Size = UDim2.new(0, 100, 0, 100)
                myButton.TextWrapped = true
                myButton.Text = "Stop Farm"
                myButton.Font = Enum.Font.SourceSansBold
                myButton.FontSize = Enum.FontSize.Size48 -- Set a big cartoony font
                myButton.TextColor3 = Color3.new(1, 1, 1) -- Set the button's text color to white
                myButton.BackgroundTransparency = 0 -- Make the button fill visible
                myButton.BackgroundColor3 = Color3.new(1, 0, 0) -- Set the button's background color to red
                myButton.BorderColor3 = Color3.new(0, 0, 0) -- Set the button's border color to black
                myButton.BorderSizePixel = 10 -- Set the button's border size
                
                -- Add an event listener to the button
                myButton.MouseButton1Click:Connect(function()
                    STOP = true
                    myButton:Destroy()
                end)
            end
        end
    else
        while 1 do
            wait(0.01)
            FrTeleportToWorld("Spawn", "Shop")
            WaitUntilAllThingsHaveLoaded()
            AllCs = Invoke("Get Coins")
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Fantasy", "Fantasy Shop")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Fantasy"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Tech", "Tech Shop")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Tech"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Axolotl Ocean", "Axolotl Cave")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Axolotl Ocean"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Pixel", "Pixel Forest")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Pixel"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Cat", "Cat Paradise")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Cat"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Doodle", "Doodle Shop")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Doodle"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            if not SettingsBreakable.Loop then break end
            if STOP then break end
            if SettingsBreakable.Loop and not MADE then
                MADE = true
                local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
                
                -- Create the button
                local myButton = Instance.new("TextButton")
                myButton.Parent = game.Players.LocalPlayer.PlayerGui.Main -- Assumes the script is a child of a ScreenGui
                myButton.Position = UDim2.new(0.5, -50, 0.5, -50) -- Set the button's position to the center of the screen
                myButton.Size = UDim2.new(0, 100, 0, 100)
                myButton.TextWrapped = true
                myButton.Text = "Stop Farm"
                myButton.Font = Enum.Font.SourceSansBold
                myButton.FontSize = Enum.FontSize.Size48 -- Set a big cartoony font
                myButton.TextColor3 = Color3.new(1, 1, 1) -- Set the button's text color to white
                myButton.BackgroundTransparency = 0 -- Make the button fill visible
                myButton.BackgroundColor3 = Color3.new(1, 0, 0) -- Set the button's background color to red
                myButton.BorderColor3 = Color3.new(0, 0, 0) -- Set the button's border color to black
                myButton.BorderSizePixel = 10 -- Set the button's border size
                
                -- Add an event listener to the button
                myButton.MouseButton1Click:Connect(function()
                    STOP = true
                    myButton:Destroy()
                end)
            end
        end
    end
end

function pfarm()
    local TimeElapsed = 0
    local ThingsBroke = 0
    local STOP = false
    local MADE = false
    
    HttpService = game:GetService("HttpService")
    
    local timer = coroutine.create(function()
        while 1 do
            TimeElapsed = TimeElapsed + 1
            wait(1)
        end
    end)
    
    coroutine.resume(timer)
    SettingsBreakable = {
        WorldHop = true, -- If This Is True It Will Break Stuff In Every World Up To Cat World
        Area = "", -- If World Hop Is False And This Isnt Blank It Will Only Farm In This Area
        AutoCollectOrbs = true, -- If This Is True It Will Collect The Orbs Automatically
        Loop = false, -- If This Is True It Will Happen All Again And Again (Only Enable If Server Hop Is False)
        WaitTime = 20, -- If Something Isnt Broken Past This Time Then Move On To The Next Thing 1 = 0.1s
        ThingsToBreak = {
            "Pinata"
        } -- List Of Things To Break, If The Name Of The Breakable Contains Any Of These It Will Break It
    }
    WebhookLayout = { -- {amount} | shows the amount of breakables broken {time} | Shows the time it took finish (seconds)
        Title = "Breakables Farmed", -- The Title Of The Webhook
        Description = "You Broke ``{amount}`` **Things** In ``{time}`` **Seconds**!", -- Description Of The Webhook
        Color = tonumber(0x6967d5) -- The Color Of The Webhook
    } -- Will be sent after each server hop if the Webhook thing in SettingsBreakable has a link
    
    function PostWebhook(amount, seconds)
        local StatsPath = game:GetService("Players").LocalPlayer.PlayerGui.Main.Right
        function GetCoinsAmount(name)
            return StatsPath[name].Amount.Text
        end
        local thingsfarming = ""
        local coins = ":coin: **Coins: ** ``" .. GetCoinsAmount("Coins") .. "``\n:coin: **Fantasy Coins: ** ``" .. GetCoinsAmount("Fantasy Coins") .. "``\n:coin: **Tech Coins: ** ``" .. GetCoinsAmount("Tech Coins") .. "``\n:coin: **Rainbow Coins: ** ``" .. GetCoinsAmount("Rainbow Coins") .. "``\n:coin: **Cartoon Coins: ** ``" .. GetCoinsAmount("Cartoon Coins") .. "``\n:gem: **Diamonds: ** ``" .. GetCoinsAmount("Diamonds") .. "``"
        local title = WebhookLayout.Title
        title = string.gsub(title, "{amount}", tostring(amount))
        title = string.gsub(title, "{time}", tostring(seconds))
        local desc = WebhookLayout.Description
        desc = string.gsub(desc, "{amount}", tostring(amount))
        desc = string.gsub(desc, "{time}", tostring(seconds))
        for i, v in pairs(SettingsBreakable.ThingsToBreak) do
            thingsfarming = thingsfarming .. ":rock: ``" .. v .. "``\n"
        end
        syn.request({
            Url = SettingsBreakable.Webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode{
                ["content"] = "Username: " .. game.Players.LocalPlayer.Name,
                ["embeds"] = {{
                    ["title"] = title,
                    ["description"] = desc,
                    ["type"] = "rich",
                    ["color"] = WebhookLayout.Color,
                    ["thumbnail"] = {
                        ["url"] = "https://www.biggames.io/_next/static/media/bigGames.66f7ea84.svg",
                        ["height"] = 350,
                        ["width"] = 270
                    },
                    ["author"] = {
                        ["name"] = "Breakable Farmer",
                        ["icon_url"] = "https://tr.rbxcdn.com/d8055fdc4f5c0cb1f7d40f5e10e93eed/150/150/Image/Png"
                    },
                    ["fields"] = {{
                        ["name"] = "Things Farming",
                        ["value"] = thingsfarming,
                        ["inline"] = true
                    },{
                        ["name"] = "Coins",
                        ["value"] = coins,
                        ["inline"] = true
                    }}
                }}
            }
        })
    end
    local WebhookLayout
    local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
    while not v1.Loaded do
    	game:GetService("RunService").Heartbeat:Wait();
    end;
    
    function WaitUntilAllThingsHaveLoaded()
        while 1 do
            if #game.Workspace["__THINGS"].Coins:GetChildren() <= 100 then
                break
            end
            wait(0.1)
        end
        if true then
            return
        end
        while 1 do
            oldcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            wait(1)
            newcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            if newcount ~= oldcount then
                break
            end
        end
        while 1 do
            oldcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            wait(1)
            newcount = #game.Workspace["__THINGS"].Coins:GetChildren()
            if newcount == oldcount then
                break
            end
        end
    end
    
    function ShouldBreak(coin)
        for i2, v2 in pairs(SettingsBreakable.ThingsToBreak) do
            if string.find(coin, v2) then
                return true
            end
        end
        return false
    end
    
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke
    
    while 1 do
        local Ccount = 0
        for i, v in pairs(Invoke("Get Coins")) do
            Ccount = Ccount + 1
        end
        if Ccount >= 10 then break end
        wait(3)
    end
    
    function ForeverPickupOrbs()
      while true do
        orbs = {}
        for i, v in pairs (game.Workspace['__THINGS'].Orbs:GetChildren()) do
            table.insert(orbs, v.Name)
        end
        Fire("Claim Orbs", orbs)
        wait(0.1)
      end
    end
    foreverpickup = coroutine.create(ForeverPickupOrbs)
    if SettingsBreakable.AutoCollectOrbs then
        coroutine.resume(foreverpickup)
    end
    
    
    
    game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = true
    wait(1)
    game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = false
    
    if not SettingsBreakable.WorldHop then
        while 1 do
            wait(0.01)
            if SettingsBreakable.Area == "" then
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(Invoke("Get Coins")) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            else
            pcall(function()
                anycoins = true
                if anycoins then
                    FrTeleportToArea("", SettingsBreakable.Area)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == SettingsBreakable.Area then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea(SettingsBreakable.Area, SettingsBreakable.Area)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
            end
            if not SettingsBreakable.Loop then
                break
            end
            if STOP then break end
            if SettingsBreakable.Loop and not MADE then
                MADE = true
                local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
                
                -- Create the button
                local myButton = Instance.new("TextButton")
                myButton.Parent = game.Players.LocalPlayer.PlayerGui.Main -- Assumes the script is a child of a ScreenGui
                myButton.Position = UDim2.new(0.5, -50, 0.5, -50) -- Set the button's position to the center of the screen
                myButton.Size = UDim2.new(0, 100, 0, 100)
                myButton.TextWrapped = true
                myButton.Text = "Stop Farm"
                myButton.Font = Enum.Font.SourceSansBold
                myButton.FontSize = Enum.FontSize.Size48 -- Set a big cartoony font
                myButton.TextColor3 = Color3.new(1, 1, 1) -- Set the button's text color to white
                myButton.BackgroundTransparency = 0 -- Make the button fill visible
                myButton.BackgroundColor3 = Color3.new(1, 0, 0) -- Set the button's background color to red
                myButton.BorderColor3 = Color3.new(0, 0, 0) -- Set the button's border color to black
                myButton.BorderSizePixel = 10 -- Set the button's border size
                
                -- Add an event listener to the button
                myButton.MouseButton1Click:Connect(function()
                    STOP = true
                    myButton:Destroy()
                end)
            end
        end
    else
        while 1 do
            wait(0.01)
            FrTeleportToWorld("Spawn", "Shop")
            WaitUntilAllThingsHaveLoaded()
            AllCs = Invoke("Get Coins")
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Fantasy", "Fantasy Shop")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Fantasy"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Tech", "Tech Shop")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Tech"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Axolotl Ocean", "Axolotl Cave")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Axolotl Ocean"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Pixel", "Pixel Forest")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Pixel"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Cat", "Cat Paradise")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Cat"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            FrTeleportToWorld("Doodle", "Doodle Shop")
            WaitUntilAllThingsHaveLoaded()
            FarmWorld = "Doodle"
            AllCs = Invoke("Get Coins")
            wait(2)
            pcall(function()
            for i, v in pairs(game:GetService("Workspace")["__MAP"].Teleports:GetChildren()) do
                local anycoins = false
                for i2, v2 in pairs(AllCs) do
                    if (v2.a) == v.Name and ShouldBreak(v2.n) then
                        anycoins = true
                    end
                end
                if anycoins then
                    FrTeleportToArea("", v.Name)
                    Fire("Performed Teleport")
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        pcall(function()
                            if (v2.a) == v.Name then
                                if ShouldBreak(v2.n) then
                                    FrTeleportToArea("", v.Name)
                                    local equippedpets = {}
                                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                                        if v3:IsA("TextButton") then
                                            if v3.Equipped.Visible == true then
                                                table.insert(equippedpets, v3.Name)
                                            end
                                        end
                                    end
                                    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
                                    local Fire, Invoke = Network.Fire, Network.Invoke
                                    n = v2.Name
                                    local v86 = Invoke("Join Coin", i2, equippedpets)
                                    for v88, v89 in pairs(v86) do
                                        Fire("Farm Coin", i2, v88);
                                    end
                                    ThingsBroke = ThingsBroke + 1
                                    count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i2 == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= SettingsBreakable.WaitTime then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            end)
            if not SettingsBreakable.Loop then break end
            if STOP then break end
            if SettingsBreakable.Loop and not MADE then
                MADE = true
                local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
                
                -- Create the button
                local myButton = Instance.new("TextButton")
                myButton.Parent = game.Players.LocalPlayer.PlayerGui.Main -- Assumes the script is a child of a ScreenGui
                myButton.Position = UDim2.new(0.5, -50, 0.5, -50) -- Set the button's position to the center of the screen
                myButton.Size = UDim2.new(0, 100, 0, 100)
                myButton.TextWrapped = true
                myButton.Text = "Stop Farm"
                myButton.Font = Enum.Font.SourceSansBold
                myButton.FontSize = Enum.FontSize.Size48 -- Set a big cartoony font
                myButton.TextColor3 = Color3.new(1, 1, 1) -- Set the button's text color to white
                myButton.BackgroundTransparency = 0 -- Make the button fill visible
                myButton.BackgroundColor3 = Color3.new(1, 0, 0) -- Set the button's background color to red
                myButton.BorderColor3 = Color3.new(0, 0, 0) -- Set the button's border color to black
                myButton.BorderSizePixel = 10 -- Set the button's border size
                
                -- Add an event listener to the button
                myButton.MouseButton1Click:Connect(function()
                    STOP = true
                    myButton:Destroy()
                end)
            end
        end
    end
end

function autobeatgame()
    local Library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
    local WCmds = require(game:GetService("ReplicatedStorage").Library.Client.WorldCmds)
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke
    
    -- Hooking the _check function in the module to bypass the anticheat.
    

    
    local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
    while not v1.Loaded do
    	game:GetService("RunService").Heartbeat:Wait();
    end;
    
    while 1 do
        local Ccount = 0
        for i, v in pairs(Invoke("Get Coins")) do
            Ccount = Ccount + 1
        end
        if Ccount >= 10 then break end
        wait(3)
    end
    
    
    
    FrTeleportToWorld("Spawn", "Shop")
    wait(3)
    
    if Settings.AutoCompleteGame.BankInvite == true then
        pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(231.388885, 98.2168579, 356.876953, -0.976782918, 1.37872318e-08, 0.214231476, 2.94478699e-08, 1, 6.99101008e-08, -0.214231476, 7.45956541e-08, -0.976782918)
        game:GetService("Players").LocalPlayer.PlayerGui.Bank.Enabled = true
        wait(3)
        local BankHolder = game:GetService("Players").LocalPlayer.PlayerGui.Bank.Frame.Side.Holder
        local bankName = ""
        for i, v in pairs(BankHolder:GetChildren(BankHolder)) do
            if string.find(v.Name, "INVITE") then
                bankId = string.gsub(v.Name,"INVITE%-", "")
                print(bankId)
                Invoke("Accept Bank Invite", bankId)
                break
            end
        end
        wait(5)
        pets = {}
        count = 0
        for i, v in pairs(Invoke("Get Bank", bankId).Storage.Pets) do
            table.insert(pets, v.uid)
            count = count + 1
            if count >= Settings.AutoCompleteGame.Bank.Pets then break end
        end
        Invoke("Bank Withdraw", bankId, pets, Settings.AutoCompleteGame.Bank.Gems)
        wait(2)
        Invoke("Leave Bank", bankId)
        wait(2)
        end)
    end
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke
    
    -- Hooking the _check function in the module to bypass the anticheat.
    

    if Settings.AutoCompleteGame.ForestUpgrades then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-389.273651, 98.0880356, 97.2807617, 0.988577247, -1.05826228e-08, -0.150714993, 1.43523975e-08, 1, 2.39248354e-08, 0.150714993, -2.58146695e-08, 0.988577247)
        wait(0.5)
        pcall(function()
	        Invoke("Buy Upgrade", "Orb Pickup Distance")
	        Invoke("Buy Upgrade", "Orb Pickup Distance")
	        Invoke("Buy Upgrade", "Orb Pickup Distance")
	        Invoke("Buy Upgrade", "Orb Pickup Distance")
	        Invoke("Buy Upgrade", "Orb Pickup Distance")
	        Invoke("Buy Upgrade", "More Diamonds")
	        Invoke("Buy Upgrade", "More Diamonds")
	        Invoke("Buy Upgrade", "More Diamonds")
	        Invoke("Buy Upgrade", "More Diamonds")
	        Invoke("Buy Upgrade", "More Diamonds")
	        Invoke("Buy Upgrade", "Pet Strength")
	        Invoke("Buy Upgrade", "Pet Strength")
	        Invoke("Buy Upgrade", "Pet Strength")
	        Invoke("Buy Upgrade", "Pet Strength")
	        Invoke("Buy Upgrade", "Pet Strength")
	        Invoke("Buy Upgrade", "Pet Walkspeed")
	        Invoke("Buy Upgrade", "Pet Walkspeed")
	        Invoke("Buy Upgrade", "Pet Walkspeed")
	        Invoke("Buy Upgrade", "Pet Walkspeed")
	        Invoke("Buy Upgrade", "Pet Walkspeed")
	        Invoke("Buy Upgrade", "Pet Storage")
	        Invoke("Buy Upgrade", "Pet Storage")
	        Invoke("Buy Upgrade", "Pet Storage")
	        Invoke("Buy Upgrade", "Pet Storage")
	        Invoke("Buy Upgrade", "Pet Storage")
	        Invoke("Buy Upgrade", "Player Walkspeed")
	        Invoke("Buy Upgrade", "Player Walkspeed")
	        Invoke("Buy Upgrade", "Player Walkspeed")
	        Invoke("Buy Upgrade", "Player Walkspeed")
	        Invoke("Buy Upgrade", "Player Walkspeed")
        end)
        wait(0.5)
    end
    function GetPlayerCash(coin)
        amountstr = game.Players.LocalPlayer.PlayerGui.Main.Right[coin].Amount.Text
        amountstrnocomas = amountstr:gsub("%D", "")
        return tonumber(amountstrnocomas)
    end
    GetPlayerCash("Coins")
    function BreakCoinsInAreaUntillAmountAndBuyArea(area, areatobuy, world, amountneeded, amountneededcurrency)
        if GetPlayerCash(amountneededcurrency) >= amountneeded then
            Invoke("Buy Area", areatobuy)
            return
        else
            FrTeleportToArea(area, area)
            wait(0.1)
            Fire("Performed Teleport")
            while 1 do
            for i, v in pairs(Invoke("Get Coins")) do
                if v.a == area then
                    local equippedpets = {}
                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                        if v3:IsA("TextButton") then
                            if v3.Equipped.Visible == true then
                                table.insert(equippedpets, v3.Name)
                            end
                        end
                    end
                    local fO1 = false
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        if i2 == i then
                            fO1 = true
                        end
                    end
                    if fO1 then
                        local v86 = Invoke("Join Coin", i, equippedpets)
                        for v88, v89 in pairs(v86) do
                            Fire("Farm Coin", i, v88);
                        end
                        count = 0
                                    while 1 do
                                        wait(0.01)
                                        local f = false
                                        for i3, v3 in pairs(Invoke("Get Coins")) do
                                            if i == i3 then
                                                f = true
                                            end
                                        end
                                        if count >= 500 then break end
                                        if not f then break end
                                        count = count + 1
                                    end
                        if GetPlayerCash(amountneededcurrency) >= amountneeded then
                            Invoke("Buy Area", areatobuy)
                            return
                        end
                        wait(0.05)
                    end
                end
            end
            end
        end
    end
    
    function ForeverPickupOrbs()
      while true do
        orbs = {}
        for i, v in pairs (game.Workspace['__THINGS'].Orbs:GetChildren()) do
            table.insert(orbs, v.Name)
        end
        Fire("Claim Orbs", orbs)
        wait(0.1)
        for i, v in pairs(game.Workspace['__THINGS'].Lootbags:GetChildren()) do
            Fire("Collect Lootbag", v.Name, v.Position)
        end
      end
    end
    c1 = coroutine.create(ForeverPickupOrbs)
    coroutine.resume(c1)
    
    function AutoCompleteGame()
        game.Players.LocalPlayer.PlayerGui.Inventory.Enabled = true
        Invoke("Equip Best Pets")
        wait(1)
        BreakCoinsInAreaUntillAmountAndBuyArea("Town", "Forest", "Spawn", 10000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Forest", "Beach", "Spawn", 75000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Beach", "Mine", "Spawn", 400000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Mine", "Winter", "Spawn", 1250000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Winter", "Glacier", "Spawn", 5500000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Glacier", "Desert", "Spawn", 16500000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Desert", "Volcano", "Spawn", 50000000, "Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Volcano", "Cave", "Spawn", 250000000, "Coins")
        wait(0.5)
        FrTeleportToWorld("Fantasy", "Enchanted Forest")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Enchanted Forest", "Fantasy Portals", "Fantasy", 50000, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Enchanted Forest", "Ancient Island", "Fantasy", 85000, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Ancient Island", "Samurai Island", "Fantasy", 525000, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Samurai Island", "Candy Island", "Fantasy", 3500000, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Candy Island", "Haunted Island", "Fantasy", 18500000, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Haunted Island", "Hell Island", "Fantasy", 66666666, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Hell Island", "Heaven Island", "Fantasy", 150000000, "Fantasy Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Heaven Island", "Ice Tech", "Fantasy", 7500000000, "Fantasy Coins")
        wait(0.5)
        FrTeleportToWorld("Tech", "Tech City")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Tech City", "Dark Tech", "Tech", 50000, "Tech Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Dark Tech", "Steampunk", "Tech", 625000, "Tech Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Steampunk", "Alien Lab", "Tech", 8250000, "Tech Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Alien Lab", "Alien Forest", "Tech", 72500000, "Tech Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Alien Forest", "Glitch", "Tech", 350000000, "Tech Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Glitch", "Hacker Portal", "Tech", 7500000000, "Tech Coins")
        wait(0.5)
        Fire("Start Hacker Portal Quests")
        wait(0.5)
        FrTeleportToArea("Hacker Portal", "Hacker Portal")
        Fire("Performed Teleport")
        local chestsbroken = 0
        for i, v in pairs(Invoke("Get Coins")) do
                if v.a == "Hacker Portal" then
                    local equippedpets = {}
                    for i3, v3 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                        if v3:IsA("TextButton") then
                            if v3.Equipped.Visible == true then
                                table.insert(equippedpets, v3.Name)
                            end
                        end
                    end
                    local fO1 = false
                    for i2, v2 in pairs(Invoke("Get Coins")) do
                        if i2 == i then
                            fO1 = true
                        end
                    end
                    if fO1 then
                        if string.find(v.n, "Chest") then
                            local v86 = Invoke("Join Coin", i, equippedpets)
                            for v88, v89 in pairs(v86) do
                                Fire("Farm Coin", i, v88);
                            end
                        end
                        count = 0
                        while 1 do
                            wait(0.01)
                            if not string.find(v.n, "Chest") then break end
                            local f = false
                            for i3, v3 in pairs(Invoke("Get Coins")) do
                                if i == i3 then
                                    f = true
                                end
                            end
                            if count >= 1000 then break end
                            if not f then
                                chestsbroken = chestsbroken + 1
                                break
                            end
                            count = count + 1
                        end
                        wait(0.05)
                    end
                    if chestsbroken >= 3 then
                        break
                    end
                end
            end
        Invoke("Finish Hacker Portal Quest")
        wait(0.5)
        Fire("Hacker Portal Unlocked")
        wait(0.5)
        FrTeleportToWorld("Void", "The Void")
        wait(4)
        FrTeleportToWorld("Axolotl Ocean", "Axolotl Cave")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Axolotl Ocean", "Axolotl Deep Ocean", "Axolotl Ocean", 95000, "Rainbow Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Axolotl Deep Ocean", "Axolotl Cave", "Axolotl Ocean", 525000, "Rainbow Coins")
        wait(0.5)
        FrTeleportToWorld("Pixel", "Pixel Forest")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Pixel Forest", "Pixel Kyoto", "Pixel", 15000000, "Rainbow Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Pixel Kyoto", "Pixel Alps", "Pixel", 75000000, "Rainbow Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Pixel Alps", "Pixel Vault", "Pixel", 1000000000, "Rainbow Coins")
        wait(0.5)
        FrTeleportToWorld("Cat", "Cat Paradise")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Cat Paradise", "Cat Backyard", "Cat", 1250000000, "Rainbow Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Cat Backyard", "Cat Taiga", "Cat", 6500000000, "Rainbow Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Cat Taiga", "Cat Kingdom", "Cat", 70000000000, "Rainbow Coins")
        wait(0.5)
        FrTeleportToWorld("Limbo", "Limbo")
        wait(4)
        FrTeleportToWorld("Doodle", "Doodle Meadow")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Meadow", "Doodle Peaks", "Pixel", 17500, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Peaks", "Doodle Farm", "Pixel", 75000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Farm", "Doodle Oasis", "Pixel", 360000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Oasis", "Doodle Woodlands", "Pixel", 1700000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Woodlands", "Doodle Safari", "Pixel", 6800000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Safari", "Doodle Fairyland", "Pixel", 28000000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Doodle Fairyland", "Doodle Cave", "Pixel", 200000000, "Cartoon Coins")
        wait(0.5)
        FrTeleportToWorld("Kawaii", "Kawaii Tokyo")
        wait(4)
        BreakCoinsInAreaUntillAmountAndBuyArea("Kawaii Tokyo", "Kawaii Village", "Pixel", 175000000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Kawaii Village", "Kawaii Candyland", "Pixel", 875000000, "Cartoon Coins")
        wait(0.5)
        BreakCoinsInAreaUntillAmountAndBuyArea("Kawaii Candyland", "Kawaii Temple", "Pixel", 6500000000, "Cartoon Coins")
        wait(0.5)
    end
    
    AutoCompleteGame()
end

function GetPlayerCash(coin)
    amountstr = game.Players.LocalPlayer.PlayerGui.Main.Right[coin].Amount.Text
    amountstrnocomas = amountstr:gsub("%D", "")
    return tonumber(amountstrnocomas)
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Frag", HidePremium = false, SaveConfig = true, ConfigFolder = "Psx"})

local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local AutoCompleteSection = Misc:AddSection({
	Name = "Auto Complete Game"
})

AutoCompleteSection:AddToggle({
	Name = "Do Forest Upgrades",
	Default = true,
	Callback = function(Value)
		Settings.AutoCompleteGame.ForestUpgrades = Value
	end    
})
AutoCompleteSection:AddToggle({
	Name = "Accept First Bank Invite",
	Default = false,
	Callback = function(Value)
		Settings.AutoCompleteGame.BankInvite = Value
	end    
})
AutoCompleteSection:AddTextbox({
	Name = "Gems To Take From Bank",
	Default = "5000000",
	Callback = function(Value)
		Settings.AutoCompleteGame.Bank.Gems = tonumber(Value)
	end    
})
AutoCompleteSection:AddTextbox({
	Name = "Pets To Take From Bank",
	Default = "4",
	Callback = function(Value)
		Settings.AutoCompleteGame.Bank.Pets = tonumber(Value)
	end    
})


AutoCompleteSection:AddButton({
	Name = "Complete Game",
	Callback = function()
        autobeatgame()
  	end    
})
local ForestSection = Misc:AddSection({
	Name = "Forest Upgrades"
})
ForestSection:AddButton({
	Name = "Instantly Upgrade All Forest Upgrades",
	Callback = function()
        local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
        local Fire, Invoke = Network.Fire, Network.Invoke
        
        -- Hooking the _check function in the module to bypass the anticheat.
        
        local old
        old = hookfunction(getupvalue(Fire, 1), function(...)
           return true
        end)
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-389.273651, 98.0880356, 97.2807617, 0.988577247, -1.05826228e-08, -0.150714993, 1.43523975e-08, 1, 2.39248354e-08, 0.150714993, -2.58146695e-08, 0.988577247)
        wait(0.5)
        Invoke("Buy Upgrade", "Orb Pickup Distance")
        Invoke("Buy Upgrade", "Orb Pickup Distance")
        Invoke("Buy Upgrade", "Orb Pickup Distance")
        Invoke("Buy Upgrade", "Orb Pickup Distance")
        Invoke("Buy Upgrade", "Orb Pickup Distance")
        Invoke("Buy Upgrade", "More Diamonds")
        Invoke("Buy Upgrade", "More Diamonds")
        Invoke("Buy Upgrade", "More Diamonds")
        Invoke("Buy Upgrade", "More Diamonds")
        Invoke("Buy Upgrade", "More Diamonds")
        Invoke("Buy Upgrade", "Pet Strength")
        Invoke("Buy Upgrade", "Pet Strength")
        Invoke("Buy Upgrade", "Pet Strength")
        Invoke("Buy Upgrade", "Pet Strength")
        Invoke("Buy Upgrade", "Pet Strength")
        Invoke("Buy Upgrade", "Pet Walkspeed")
        Invoke("Buy Upgrade", "Pet Walkspeed")
        Invoke("Buy Upgrade", "Pet Walkspeed")
        Invoke("Buy Upgrade", "Pet Walkspeed")
        Invoke("Buy Upgrade", "Pet Walkspeed")
        Invoke("Buy Upgrade", "Pet Storage")
        Invoke("Buy Upgrade", "Pet Storage")
        Invoke("Buy Upgrade", "Pet Storage")
        Invoke("Buy Upgrade", "Pet Storage")
        Invoke("Buy Upgrade", "Pet Storage")
        Invoke("Buy Upgrade", "Player Walkspeed")
        Invoke("Buy Upgrade", "Player Walkspeed")
        Invoke("Buy Upgrade", "Player Walkspeed")
        Invoke("Buy Upgrade", "Player Walkspeed")
        Invoke("Buy Upgrade", "Player Walkspeed")
  	end    
})
local MailSection = Misc:AddSection({
	Name = "Mailbox"
})
MailSection:AddTextbox({
	Name = "Recipient",
	Default = "",
	Callback = function(Value)
		Settings.Mailbox.Username = Value
	end    
})
MailSection:AddTextbox({
	Name = "Message",
	Default = "All My Gems!",
	Callback = function(Value)
		Settings.Mailbox.Message = Value
	end    
})
MailSection:AddButton({
	Name = "Mail All Gems",
	Callback = function()
	    user = Settings.Mailbox.Username
	    msg = Settings.Mailbox.Message
	    gems = GetPlayerCash("Diamonds") - 100000
	    FrTeleportToWorld("Spawn")
	    wait(5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(254.149002, 98.2168579, 349.55304, 0.965907216, -6.73597569e-08, -0.258888513, 6.48122409e-08, 1, -1.83752729e-08, 0.258888513, 9.69664127e-10, 0.965907216)
        wait(1)
        Invoke("Send Mail", {
        ["Recipient"] = user,
        ["Diamonds"] = gems,
        ["Pets"] = {},
        ["Message"] = msg
    }
)
  	end    
})
local FarmingTab = Window:MakeTab({
	Name = "Farming",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local FruitsSection = FarmingTab:AddSection({
    Name = "Fruit Farm"
})
FruitsSection:AddToggle({
    Name = "Apple",
    Default = true,
    Callback = function(Value)
		Settings.Fruits.Apple = Value
	end
})
FruitsSection:AddToggle({
    Name = "Banana",
    Default = true,
    Callback = function(Value)
		Settings.Fruits.Banana = Value
	end
})
FruitsSection:AddToggle({
    Name = "Pear",
    Default = true,
    Callback = function(Value)
		Settings.Fruits.Pear = Value
	end
})
FruitsSection:AddToggle({
    Name = "Orange",
    Default = true,
    Callback = function(Value)
		Settings.Fruits.Orange = Value
	end
})
FruitsSection:AddToggle({
    Name = "Pineapple",
    Default = true,
    Callback = function(Value)
		Settings.Fruits.Pineapple = Value
	end
})
FruitsSection:AddToggle({
    Name = "Rainbow Fruit",
    Default = true,
    Callback = function(Value)
		Settings.Fruits.RainbowFruit = Value
	end
})
FruitsSection:AddButton({
    Name = "Break All Fruits (Spawn - Doodle)",
    Callback = function()
        fruitfarm()
    end
})
local AutoFarmSection = FarmingTab:AddSection({
    Name = "Advanced Auto Farm"
})
AutoFarmSection:AddTextbox({
    Name = "Area",
	Default = "Area Name",
	TextDisappear = false,
	Callback = function(Value)
	    Settings.AutoFarm.Area = Value
	end
})
autofarmco = coroutine.create(function()
    while 1 do
        if Settings.AutoFarm.Enabled then
            local AllCoins2 = Invoke("Get Coins")
            local AllCoins = {}
            for i, v in pairs(Invoke("Get Coins")) do
                if v.a == Settings.AutoFarm.Area then
                    AllCoins[i] = v
                end
            end
            local equippedpets = {}
            for i2, v2 in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal:GetChildren()) do
                if v2:IsA("TextButton") then
                    if v2.Equipped.Visible == true then
                        table.insert(equippedpets, v2.Name)
                    end
                end
            end
            if Settings.AutoFarm.Mode == "Highest Health" then
                local highestCoin = {"", 0}
                for i, v in pairs(AllCoins) do
                    if tonumber(v.h) >= tonumber(highestCoin[2]) then
                        highestCoin = {i, tonumber(v.h)}
                    end
                end
                print(highestCoin[1])
                local v86 = Invoke("Join Coin", highestCoin[1], equippedpets)
                for v88, v89 in pairs(v86) do
                    Fire("Farm Coin", highestCoin[1], v88);
                end
            end
            if Settings.AutoFarm.Mode == "Lowest Health" then
                local highestCoin = {"", 999999999999999999999999999999999}
                for i, v in pairs(AllCoins) do
                    if tonumber(v.h) <= tonumber(highestCoin[2]) then
                        highestCoin = {i, tonumber(v.h)}
                    end
                end
                print(highestCoin[1])
                local v86 = Invoke("Join Coin", highestCoin[1], equippedpets)
                for v88, v89 in pairs(v86) do
                    Fire("Farm Coin", highestCoin[1], v88);
                end
            end
            if Settings.AutoFarm.Mode == "Highest Max Health" then
                local highestCoin = {"", 0}
                for i, v in pairs(AllCoins) do
                    if tonumber(v.mh) >= tonumber(highestCoin[2]) then
                        highestCoin = {i, tonumber(v.h)}
                    end
                end
                print(highestCoin[1])
                local v86 = Invoke("Join Coin", highestCoin[1], equippedpets)
                for v88, v89 in pairs(v86) do
                    Fire("Farm Coin", highestCoin[1], v88);
                end
            end
        end
        
        wait(Settings.AutoFarm.Delay)
    end
end)
coroutine.resume(autofarmco)
AutoFarmSection:AddDropdown({
	Name = "Priority",
	Default = "Highest Health",
	Options = {"Highest Health", "Lowest Health", "Highest Max Health"},
	Callback = function(Value)
		Settings.AutoFarm.Mode = Value
	end
})
AutoFarmSection:AddSlider({
	Name = "Delay",
	Min = 0.01,
	Max = 0.50,
	Default = 0.10,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Seconds",
	Callback = function(Value)
		Settings.AutoFarm.Delay = Value
	end
})
AutoFarmSection:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(Value)
        Settings.AutoFarm.Enabled = Value
    end
})
local PinataSection = FarmingTab:AddSection({
    Name = "Pinata Farm"
})
PinataSection:AddButton({
    Name = "Break All Pinatas (Spawn - Doodle)",
    Callback = function()
        pfarm()
    end
})
local EggsTab = Window:MakeTab({
	Name = "Eggs",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local AutoOpenSection = EggsTab:AddSection({
    Name = "Fast Hatch"
})
autoopenco = coroutine.create(function()
    while 1 do
        wait(0.1)
        if Settings.AutoOpen.Enabled then
            if Settings.AutoOpen.Mode == "Octuple" then
            pcall(function()Invoke("Buy Egg", Settings.AutoOpen.Egg, 1, 1)end)
            end
            if Settings.AutoOpen.Mode == "Triple" then
            pcall(function()Invoke("Buy Egg", Settings.AutoOpen.Egg, 1)end)
            end
            if Settings.AutoOpen.Mode == "Single" then
            pcall(function()Invoke("Buy Egg", Settings.AutoOpen.Egg)end)
            end
        end
    end
end)
coroutine.resume(autoopenco)
AutoOpenSection:AddTextbox({
    Name = "Egg Name",
    Default = "Cracked Egg",
	TextDisappear = false,
	Callback = function(Value)
	    Settings.AutoOpen.Egg = Value
	end
})
AutoOpenSection:AddDropdown({
	Name = "Type",
	Default = "Single",
	Options = {"Single", "Triple", "Octuple"},
	Callback = function(Value)
		Settings.AutoOpen.Mode = Value
	end
})
AutoOpenSection:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(Value)
        Settings.AutoOpen.Enabled = Value
    end
})
local BankTab = Window:MakeTab({
	Name = "Bank",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local WithdrawSection = BankTab:AddSection({
    Name = "Withdraw"
})

WithdrawSection:AddToggle({
    Name = "Withdraw Gems",
    Default = true,
    Callback = function(Value)
        Settings.Withdraw.Gems = Value
    end
})
WithdrawSection:AddToggle({
    Name = "Withdraw Huges And Titanics",
    Default = true,
    Callback = function(Value)
        Settings.Withdraw.Huges = Value
    end
})
WithdrawSection:AddToggle({
    Name = "Leave When Finished",
    Default = true,
    Callback = function(Value)
        Settings.Withdraw.Leave = Value
    end
})
WithdrawSection:AddButton({
    Name = "Accept Random Invite And Withdraw",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(231.388885, 98.2168579, 356.876953, -0.976782918, 1.37872318e-08, 0.214231476, 2.94478699e-08, 1, 6.99101008e-08, -0.214231476, 7.45956541e-08, -0.976782918)
        wait(1)
        local BankHolder = game:GetService("Players").LocalPlayer.PlayerGui.Bank.Frame.Side.Holder
        local bankName = ""
        for i, v in pairs(BankHolder:GetChildren(BankHolder)) do
            if string.find(v.Name, "INVITE") then
                bankId = string.gsub(v.Name,"INVITE%-", "")
                print(bankId)
                Invoke("Accept Bank Invite", bankId)
                break
            end
        end
        wait(5)
        pets = {}
        count = 0
        for i, v in pairs(Invoke("Get Bank", bankId).Storage.Pets) do
            for i2, v2 in pairs(game:GetService("ReplicatedStorage")["__DIRECTORY"].Pets:GetChildren()) do
                if string.find(v2.Name, v.id) then
                    for i3, v3 in pairs(v2:GetChildren()) do
                        if v3:IsA("ModuleScript") then
                            local petNAME = require(v3).name
                            if string.find(petNAME, "Huge") or string.find(petNAME, "Titanic") then
                                table.insert(pets, v.uid)
                            end
                        end
                    end
                end
            end
        end
        if not Settings.Withdraw.Huges then
            pets = {}
        end
        gems = 0
        if Settings.Withdraw.Gems then
            gems = Invoke("Get Bank", bankId).Storage.Currency.Diamonds
        end
        Invoke("Bank Withdraw", bankId, pets, gems)
        wait(2)
        if Settings.Withdraw.Leave then
        Invoke("Leave Bank", bankId)
        end
    end
})
local IndexSection = BankTab:AddSection({
    Name = "Index Bank"
})
IndexSection:AddButton({
    Name = "Accept First Invite And And Index All Pets",
    Callback = function()
        pcall(indexbank())
    end
})
local AllDepWithSection = BankTab:AddSection({
    Name = "Withdraw/Deposit All"
})
AllDepWithSection:AddButton({
    Name = "Deposit All",
    Callback = function()
        pcall(depall())
    end
})
AllDepWithSection:AddButton({
    Name = "Withdraw All",
    Callback = function()
        pcall(withall())
    end
})
local BoostTab = Window:MakeTab({
	Name = "Boosts",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local NormalBoostSection = BoostTab:AddSection({
    Name = "Auto Activate Boosts"
})
NormalBoostSection:AddToggle({
    Name = "Ultra Lucky",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.UltraLuck = Value
    end
})
NormalBoostSection:AddToggle({
    Name = "Super Lucky",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.SuperLuck = Value
    end
})
NormalBoostSection:AddToggle({
    Name = "Triple Damage",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.TripleDamage = Value
    end
})
NormalBoostSection:AddToggle({
    Name = "Triple Coins",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.TripleCoins = Value
    end
})
local ServerBoostSection = BoostTab:AddSection({
    Name = "Auto Activate Server Boosts"
})
ServerBoostSection:AddToggle({
    Name = "Server Lucky",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.ServerLuck = Value
    end
})
ServerBoostSection:AddToggle({
    Name = "Server Triple Damage",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.ServerDamage = Value
    end
})
ServerBoostSection:AddToggle({
    Name = "Server Triple Coins",
    Default = false,
    Callback = function(Value)
        Settings.Boosts.ServerCoins = Value
    end
})
boostco = coroutine.create(function()
    while 1 do
        wait(2)
        if Settings.Boosts.UltraLuck then
            boostName = "Ultra Lucky"
            local Library = require(game.ReplicatedStorage.Framework.Library)
            local save = Library.Save.Get()
            found = false
            for i, v in pairs(save.Boosts) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Boost", boostName)
            end
        end
        if Settings.Boosts.SuperLuck then
            boostName = "Super Lucky"
            local Library = require(game.ReplicatedStorage.Framework.Library)
            local save = Library.Save.Get()
            found = false
            for i, v in pairs(save.Boosts) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Boost", boostName)
            end
        end
        if Settings.Boosts.TripleDamage then
            boostName = "Triple Damage"
            local Library = require(game.ReplicatedStorage.Framework.Library)
            local save = Library.Save.Get()
            found = false
            for i, v in pairs(save.Boosts) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Boost", boostName)
            end
        end
        if Settings.Boosts.TripleCoins then
            boostName = "Triple Coins"
            local Library = require(game.ReplicatedStorage.Framework.Library)
            local save = Library.Save.Get()
            found = false
            for i, v in pairs(save.Boosts) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Boost", boostName)
            end
        end
        if Settings.Boosts.ServerLuck then
            boostName = "Super Lucky"
            local Library = require(game.ReplicatedStorage.Library)
            Library.Load()
            found = false
            for i, v in pairs(Library.ServerBoosts.GetActiveBoosts()) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Server Boost", boostName)
            end
        end
        if Settings.Boosts.ServerDamage then
            boostName = "Triple Damage"
            local Library = require(game.ReplicatedStorage.Library)
            Library.Load()
            found = false
            for i, v in pairs(Library.ServerBoosts.GetActiveBoosts()) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Server Boost", boostName)
            end
        end
        if Settings.Boosts.ServerCoins then
            boostName = "Triple Coins"
            local Library = require(game.ReplicatedStorage.Library)
            Library.Load()
            found = false
            for i, v in pairs(Library.ServerBoosts.GetActiveBoosts()) do
                if i == boostName then
                    found = true
                end
            end
            if not found then
                Fire("Activate Server Boost", boostName)
            end
        end
    end
end)
coroutine.resume(boostco)
local DeleteTab = Window:MakeTab({
	Name = "Auto Delete",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local DupeDeleteSection = DeleteTab:AddSection({
    Name = "Delete Duplicate Pets (Good For Index)"
})
DupeDeleteSection:AddToggle({
    Name = "Delete Pets That Are The Same (DELETES HUGES)",
    Default = false,
    Callback = function(Value)
        v1 = require(game.ReplicatedStorage.Framework.Library)
        Settings.Delete.DeleteDupePets = Value
    end
})

dupedeleteco = coroutine.create(function()
    while 1 do
        wait(10)
        if Settings.Delete.DeleteDupePets then
            pcall(function()
            local petstodelete = {}
            local petsfound = {}
            local Library = require(game:GetService("ReplicatedStorage").Library)
            local allPets = Library.Save.Get().Pets
            for i, v in pairs(allPets) do
                found = false
                local fullName = GetPetDataById(v.id).name
                pcall(function()
                    if v.g then fullName = "Golden " .. fullName end
                end)
                pcall(function()
                    if v.r then fullName = "Rainbow " .. fullName end
                end)
                pcall(function()
                    if v.dm then fullName = "Dark Matter " .. fullName end
                end)
                for i2, v2 in pairs(petsfound) do
                    if v2 == fullName then found = true end
                end
                if not found then
                    table.insert(petsfound, fullName)
                end
                if found then
                    table.insert(petstodelete, v.uid)
                end
            end
            Invoke("Delete Several Pets", petstodelete)
            end)
        end
        if Settings.EnchantDelete.Enabled then
            pcall(function()
            local Library = require(game:GetService("ReplicatedStorage").Library)
            local allPets = Library.Save.Get().Pets
            petstodelete = {}
            for i, v in pairs(allPets) do
                hasenchant = false
                hasroyal = false
                if not Settings.EnchantDelete.Royalty then hasroyal = true end
                ench = Settings.EnchantDelete.Enchant
                lvl = Settings.EnchantDelete.Level
                if v.powers ~= nil then
                for i2, v2 in pairs(v.powers) do
                    if v2[1] == ench and v2[2] >= lvl then hasenchant = true end
                    if v[1] == "Royalty" then hasroyal = true end
                end
                end
                if not hasenchant and not hasroyal then
                    table.insert(petstodelete, v.uid)
                end
            end
            print(#petstodelete)
            Invoke("Delete Several Pets", petstodelete)
            end)
        end
    end
end)
local EnchantDeleteSection = DeleteTab:AddSection({
    Name = "Keep Certain Enchants"
})
EnchantDeleteSection:AddTextbox({
    Name = "Enchant",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        Settings.EnchantDelete.Enchant = Value
    end
})
EnchantDeleteSection:AddSlider({
	Name = "Minimum Level",
	Min = 1,
	Max = 5,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Level",
	Callback = function(Value)
		Settings.EnchantDelete.Level = Value
	end    
})
EnchantDeleteSection:AddToggle({
    Name = "Needs Royalty",
    Default = false,
    Callback = function(Value)
        Settings.EnchantDelete.Royalty = Value
    end
})
EnchantDeleteSection:AddToggle({
    Name = "Enchant Delete (ALSO DELETES HUGES)",
    Default = false,
    Callback = function(Value)
        Settings.EnchantDelete.Enabled = Value
    end
})
local CollectionTab = Window:MakeTab({
	Name = "Pet Index",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
function startindex()
    local Library = require(game:GetService("ReplicatedStorage").Library)
    function indexEGG(eggName, eggPart)
        function getPetsInEggByModule(moduleS)
            local petsInEggLocal = {}
            local req = require(moduleS)
            local drops = req.drops
            for i, v in pairs(drops) do
                local petName = GetPetDataById(v[1]).name
                table.insert(petsInEggLocal, petName)
                table.insert(petsInEggLocal, "Golden " .. petName)
                table.insert(petsInEggLocal, "Rainbow " .. petName)
            end
            return petsInEggLocal
        end
        function FindEggModuleByName(EName)
            local eggModule
            for i, v in pairs(game:GetService("ReplicatedStorage")["__DIRECTORY"].Eggs:GetDescendants()) do
                if v.Name == EName then
                    if v:IsA("Folder") then
                        eggModule = v[v.Name]
                    else
                        eggModule = v
                    end
                end
            end
            return eggModule
        end
        function CheckIfHasAllPets(EName)
            local EggModule = FindEggModuleByName(EName)
            local PetsInEgg = getPetsInEggByModule(EggModule)
            local Library = require(game:GetService("ReplicatedStorage").Library)
            local PlayerPets = Library.Save.Get().Pets
            local RealPlrPets = {}
            for i, v in pairs(PlayerPets) do
                local PN = GetPetDataById(v.id).name
                pcall(function()
                    if v.g then PN = "Golden " .. PN end
                end)
                pcall(function()
                    if v.r then PN = "Rainbow " .. PN end
                end)
                if GetPetDataById(v.id).rarity ~= "Mythical" or GetPetDataById(v.id).rarity ~= "Secret" or GetPetDataById(v.id).rarity ~= "Exclusive" then
                    table.insert(RealPlrPets, PN)
                end
            end
            local hasallpets = true
            for i, v in pairs(PetsInEgg) do
                local found = false
                for i2, v2 in pairs(RealPlrPets) do
                    if v2 == v then found = true end
                end
                if not found then hasallpets = false end
            end
            return hasallpets
        end
        function TpPlr(Part)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Part.Position)
        end
        wait(10)
        TpPlr(eggPart)
        wait(0.1)
        while 1 do
            pcall(function()Invoke("Buy Egg", eggName, 1, 1)end)
            pcall(function()Invoke("Buy Egg", eggName, 1)end)
            pcall(function()Invoke("Buy Egg", eggName)end)
            wait(1.5)
            if CheckIfHasAllPets(eggName) then break end
        end
    end
    FrTeleportToWorld("Spawn", "Shop")
    indexEGG("Cracked Egg", game:GetService("Workspace")["__MAP"].Eggs.Town.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Spotted Egg", game:GetService("Workspace")["__MAP"].Eggs.Town.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Wood Egg", game:GetService("Workspace")["__MAP"].Eggs.Forest.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Grass Egg", game:GetService("Workspace")["__MAP"].Eggs.Forest.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Beachball Egg", game:GetService("Workspace")["__MAP"].Eggs.Beach.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Coconut Egg", game:GetService("Workspace")["__MAP"].Eggs.Beach.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Rock Egg", game:GetService("Workspace")["__MAP"].Eggs.Mine.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Geode Egg", game:GetService("Workspace")["__MAP"].Eggs.Mine.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Snow Egg", game:GetService("Workspace")["__MAP"].Eggs.Winter.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Ice Egg", game:GetService("Workspace")["__MAP"].Eggs.Winter.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Icicle Egg", game:GetService("Workspace")["__MAP"].Eggs.Glacier.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Yeti Egg", game:GetService("Workspace")["__MAP"].Eggs.Glacier.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Cactus Egg", game:GetService("Workspace")["__MAP"].Eggs.Desert.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Spiked Egg", game:GetService("Workspace")["__MAP"].Eggs.Desert.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Obsidian Egg", game:GetService("Workspace")["__MAP"].Eggs.Volcano.Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Magma Egg", game:GetService("Workspace")["__MAP"].Eggs.Volcano.Eggs["Egg Capsule"].PriceHUD)
    FrTeleportToWorld("Fantasy", "Fantasy Shop")
    wait(10)
    indexEGG("Enchanted Egg", game:GetService("Workspace")["__MAP"].Eggs['Enchanted Forest'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Relic Egg", game:GetService("Workspace")["__MAP"].Eggs['Ancient Island'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Samurai Egg", game:GetService("Workspace")["__MAP"].Eggs['Samurai Island'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Rainbow Egg", game:GetService("Workspace")["__MAP"].Eggs['Candy Island'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Haunted Egg", game:GetService("Workspace")["__MAP"].Eggs['Haunted Island'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Hell Egg", game:GetService("Workspace")["__MAP"].Eggs['Hell Island'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Heaven Egg", game:GetService("Workspace")["__MAP"].Eggs['Heaven Island'].Eggs["Egg Capsule"].PriceHUD)
    indexEGG("Empyrean Egg", game:GetService("Workspace")["__MAP"].Eggs['Empyrean Eggs'].Eggs["Egg Capsule"].PriceHUD)
end
local AutoIndexSection = CollectionTab:AddSection({
    Name = "Auto Index (Enable Delete Dupe Pets In Auto Delete Tab)"
})
AutoIndexSection:AddButton({
    Name = "Start Indexing",
    Callback = function()
        startindex()
    end
})
coroutine.resume(dupedeleteco)
OrionLib:Init()
