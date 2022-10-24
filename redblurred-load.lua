local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops

local BlurredMenu = library:CreateWindow({
    Name = "SWF - Menu By: RedBlurred",
    Themeable = {
    Info = "Menu Info"
    }
})
--[Vehicles Tab]
local VehiclesTab = BlurredMenu:CreateTab({
Name = "Vehicles"
})
local tWarning1 = VehiclesTab:CreateSection({
Name = "IMPORTANT"
})
tWarning1:AddLabel({
    Name = "Need at least one car spawned"
})
tWarning1:AddLabel({
    Name = "to load everything correctly!"
})

--[Vehicles Mods]
local vBasicSection = VehiclesTab:CreateSection({
Name = "Vehicle Basics"
})
vBasicSection:AddDropdown({
    Name = "Car Select",
    Flag = "carname",
    List = workspace.Cars,
    Callback = function(car, lastcar)
        if car and typeof(car) == "Instance" then
            print("Selected Car:", car)
        else
            print("Unselected Car from", lastcar)
        end
    end
})
vBasicSection:AddDropdown({
    Name = "Color Select",
    Flag = "colorname",
    Nothing = "No Selection",
    List = function()
    local Car = library.flags.carname
    if Car then
        return Car.Body.Main:GetChildren()
    end
end,
    Callback = function(color, lastcolor)
        if color and typeof(color) == "Instance" then
            print("Selected Vehicle Color:", color)
        else
            print("Unselected Vehicle Color from", lastcolor)
        end
    end
})

vBasicSection:AddToggle({
    Name = "Lock Vehicle",
    Flag = "lockstate",
    Keybind = 1,
    Callback = function(NewValue)
        if NewValue == true then
            print("Car Locked")
            local args = {
                [1] = "LockCar",
                [2] = true
            }

            game:GetService("ReplicatedStorage").settingsEvent:FireServer(unpack(args))
        else
            print("Car Unlocked")
            local args = {
                [1] = "LockCar",
                [2] = false
            }

            game:GetService("ReplicatedStorage").settingsEvent:FireServer(unpack(args))
        end
    end
})
vBasicSection:AddToggle({
    Name = "Vehicle Collision",
    Flag = "collisionstate",
    Keybind = 1,
    Callback = function(NewValue)
        if NewValue == true then
            print("Vehicle Collision: Enabled")
            local args = {
                [1] = "collide",
                [2] = true
            }

            game:GetService("ReplicatedStorage").settingsEvent:FireServer(unpack(args))
        else
            print("Vehicle Collision: Disabled")
            local args = {
                [1] = "collide",
                [2] = false
            }

            game:GetService("ReplicatedStorage").settingsEvent:FireServer(unpack(args))
        end
    end
})
vBasicSection:AddButton({
    Name = "Teleport to Vehicle",
    Callback = function()
        print("Teleported to:", library.flags.carname)
        local args = {
            [1] = "DriveRequest",
            [2] = library.flags.carname.DriveSeat
        }

        game:GetService("ReplicatedStorage").PromptEvent:FireServer(unpack(args))
    end
})

--[Radio]
local vRadioSection = VehiclesTab:CreateSection({
Name = "Radio"
})
vRadioSection:AddToggle({
    Name = "Toggle Own Radio",
    Flag = "radiostate",
    Keybind = 1,
    Callback = function(NewValue)
        if NewValue == true then
            print("Radio ON:", library.flags.carname)
            local args = {
                [1] = library.flags.carname,
                [2] = library.flags.carname.Body.campos.radioStat,
                [3] = "rOwn"
            }

            game:GetService("ReplicatedStorage").songControlEvent:FireServer(unpack(args))
        else
            print("Radio OFF:", library.flags.carname)
            local args = {
                [1] = library.flags.carname,
                [2] = library.flags.carname.Body.campos.radioStat,
                [3] = "rOff"
            }

            game:GetService("ReplicatedStorage").songControlEvent:FireServer(unpack(args))
        end
    end
})
vRadioSection:AddTextbox({
    Name = "Own Radio ID",
    Flag = "AudioID",
    Value = "Enter Audio ID",
    Callback = function(NewValue, OldValue)
        print("ID:", NewValue)
        print("Type:",typeof(NewValue))
        local args = {
            [1] = library.flags.carname,
            [2] = library.flags.carname.Body.campos.ownIDConfirm,
            [3] = tostring(NewValue)
        }

        game:GetService("ReplicatedStorage").songControlEvent:FireServer(unpack(args))
    end
})
vRadioSection:AddSlider({
    Name = "Radio Volume",
    Flag = "radiovolume",
    Min = 0,
    Max = 0.5,
    Value = 0.3,
    Precise = 1,
    Callback = function(Value)
        print("Radio Volume", Value)
        local args = {
            [1] = library.flags.carname,
            [2] = library.flags.carname.Body.campos.lastVol,
            [3] = Value
        }

        game:GetService("ReplicatedStorage").songControlEvent:FireServer(unpack(args))
    end
})

--[Radio]
local vFuel = VehiclesTab:CreateSection({
Name = "Fuel System"
})
vFuel:AddButton({
    Name = "Buy Fuel (Cost Money)",
    Callback = function()
    CarFuel = library.flags.carname.Fuel.Value
    MaxFuel = library.flags.carname.fCap.Value
    MinFuel = (MaxFuel - CarFuel)
    print("Current Fuel:", CarFuel)
    print("Max Fuel:", MaxFuel)
    --print("Refuel Amount:", MinFuel)
        local args = {
            [1] = "requestPurchase",
            [2] = library.flags.carname,
            [3] = MinFuel,
            [4] = workspace.gasWork.studGas1.gPetrolPrice,
            [5] = workspace.gasWork.studGas1.gDieselPrice
        }

        game:GetService("ReplicatedStorage").fuelEvent:FireServer(unpack(args))
    end
})


--[Vehicles Tab]
local VisualTab = BlurredMenu:CreateTab({
Name = "Visual"
})
--Visual
local vVisualSection = VisualTab:CreateSection({
Name = "Color Options",
Side = "Left"
})

vVisualSection:AddTextbox({
    Name = "Red",
    Flag = "redcolor",
    Placeholder = "0-255",
    Value = "",
    Type = "number",
    Max = 255,
    Callback = function(Red)
        print("Red:", Red)
end
})
vVisualSection:AddTextbox({
    Name = "Green",
    Flag = "greencolor",
    Placeholder = "0-255",
    Value = "",
    Type = "number",
    Max = 255,
    Callback = function(Green)
       print("Green:", Green)
end
})
vVisualSection:AddTextbox({
    Name = "Blue",
    Flag = "bluecolor",
    Placeholder = "0-255",
    Value = "",
    Type = "number",
    Max = 255,
    Callback = function(Blue)
        print("Blue:", Blue)
end
})
--Color Buttons
--Main Color
vVisualSection:AddButton({
    Name = "Selected Part Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.colorname,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})
vVisualSection:AddButton({
    Name = "Main Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.Body.Main.Color,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})
vVisualSection:AddButton({
    Name = "Main Color 2",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.Body.Main.Color,
    [3] = "",
    [4] = library.flags.redcolor,
    [5] = library.flags.greencolor,
    [6] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--Roof Color
vVisualSection:AddButton({
    Name = "Roof Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.Body.Main.Roof.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--WE1
vVisualSection:AddButton({
    Name = "WE1 Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.WE1.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--WE
vVisualSection:AddButton({
    Name = "WE Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.WE.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--SE
vVisualSection:AddButton({
    Name = "SE Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.SE.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--DE
vVisualSection:AddButton({
    Name = "DE Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.DE.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--FE
vVisualSection:AddButton({
    Name = "FE Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.FE.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})

--LE
vVisualSection:AddButton({
    Name = "LE Color",
    Callback = function()
local args = {
    [1] = "UpdateColor",
    [2] = library.flags.carname.LE.M5,
    [3] = library.flags.redcolor,
    [4] = library.flags.greencolor,
    [5] = library.flags.bluecolor
}

library.flags.carname.Prop_FE:FireServer(unpack(args))
end
})


--[Tunning]
local TunningTab = BlurredMenu:CreateTab({
Name = "Tunning"
})

local tWarning = TunningTab:CreateSection({
Name = "IMPORTANT"
})
tWarning:AddLabel({
    Name = "Select your vehicle before"
})
tWarning:AddLabel({
    Name = "using the script, otherwise"
})
tWarning:AddLabel({
    Name = "you won't be able to use it"
})

--[Vehicle Tunning Info]
local tInfo = TunningTab:CreateSection({
Name = "Vehicle Info"
})
tInfo:AddButton({
    Name = "Print Tunning (F9)",
    Callback = function()
    carmod = require(library.flags.carname["A-Chassis Tune"])
        print("")
        print("")
        print("")
        print("")
        print(">> ENGINE <<")
        print("Horsepower:", carmod.Horsepower)
        print("")
        print(">> GEARS <<")
        print("FinalDrive", carmod.FinalDrive)
        print("")
        print(">> TRACTION <<")
        print("Conversion:", carmod.Config)
        print("TCS:", carmod.TCSEnabled)
        print("ABS:", carmod.ABSEnabled)
        print("BrakeForce:", carmod.BrakeForce)
        print("")
        print(">> STEERING <<")
        print("SteerRatio:", carmod.SteerRatio)
        print("LockToLock::", carmod.LockToLock)
        print("Ackerman:", carmod.Ackerman)
        print("")
        print("")
    end
})

--[Engine Tunning]
local tVehicle = TunningTab:CreateSection({
Name = "Vehicle"
})
tVehicle:AddTextbox({
    Name = "Horsepower",
    Flag = "tHP",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.Horsepower = NewValue
end
})
tVehicle:AddTextbox({
    Name = "FinalDrive",
    Flag = "tFDrive",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.FinalDrive = NewValue
    end
})
tVehicle:AddTextbox({
    Name = "Conversion",
    Flag = "tTConversion",
    Placeholder = "AWD/RWD/FWD",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.Config = NewValue
    end
})
tVehicle:AddTextbox({
    Name = "Brake Force",
    Flag = "bForce",
    Placeholder = "4000 - 8000",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.BrakeForce = NewValue
    end
})

--[Steering Tunning]
local tSteering = TunningTab:CreateSection({
Name = "Steering"
})
tSteering:AddTextbox({
    Name = "Steering Ratio",
    Flag = "tSRatio",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.SteerRatio = NewValue
    end
})
tSteering:AddTextbox({
    Name = "Lock to Lock",
    Flag = "tSLock",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.LockToLock = NewValue
    end
})
tSteering:AddTextbox({
    Name = "Ackerman",
    Flag = "tSAckerman",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.Ackerman = NewValue
    end
})


--[Tunning Options]
local tOptions = TunningTab:CreateSection({
Name = "More Options",
Side = "Right"
})
tOptions:AddButton({
    Name = "Unlock TCS/ABS",
    Callback = function()
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.TCSEnabled = true
        carmod.ABSEnabled = true
    end
})
tOptions:AddButton({
    Name = "Unlock Transmission Modes",
    Callback = function()
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.TransModes = { "Auto", "Semi", "Manual" }
    end
})
tOptions:AddButton({
    Name = "Fast Shifting",
    Callback = function()
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.ShiftUpTime = 0
        carmod.ShiftDnTime = 0
    end
})
tOptions:AddButton({
    Name = "Drift Steering (2.8)",
    Callback = function()
    carmod = require(library.flags.carname["A-Chassis Tune"])
    carmod.FCamber = -6
    carmod.RCamber = -5
    carmod.Weight = 1800
    carmod.WeightBSize = { 9, 5, 17 }
    carmod.WeightDist = 50
    carmod.TransModes = { "Auto", "Semi", "Manual" }
    carmod.Config = "RWD"
    carmod.SteerRatio = 15
    carmod.LockToLock = 2.8
    carmod.Ackerman = 0.9
    carmod.SteerInner = 76 
    carmod.SteerOuter = 73 
    carmod.FGyroDamp = 100 
    carmod.RGyroDamp = 100 
    carmod.SteeringType = "Old"
    carmod.SteerSpeed = 0.7 
    carmod.ReturnSpeed = 0.3 
    carmod.SteerDecay = 325 
    carmod.MinSteer = 10 
    carmod.SteerD = 1000 
    carmod.SteerMaxTorque = 5000 
    carmod.SteerP = 3000 
    carmod.RSteerDecay = 330 
    carmod.TCSEnabled = true
    carmod.ABSEnabled = true
    end
})

--[Misc Tunning]
local tSteering = TunningTab:CreateSection({
Name = "Misc Settings",
Side = "Right"
})
tSteering:AddTextbox({
    Name = "Torque Vector (AWD ONLY)",
    Flag = "mTVector",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname["A-Chassis Tune"])
        carmod.TorqueVector = NewValue
    end
})

--[Misc Tunning]
local tMotorcycle = TunningTab:CreateSection({
Name = "Motorcycle (ONLY MOTORCYCLE)",
Side = "Right"
})
tMotorcycle:AddButton({
    Name = "Print Tunning (F9)",
    Callback = function()
    carmod = require(library.flags.carname.Tuner)
        print("")
        print("")
        print("")
        print("")
        print(">> ENGINE <<")
        print("Horsepower:", carmod.Horsepower)
        print("")
        print(">> GEARS <<")
        print("FinalDrive", carmod.FinalDrive)
        print("")
        print(">> TRACTION <<")
        print("Conversion:", carmod.Config)
        print("TCS:", carmod.TCSEnabled)
        print("ABS:", carmod.ABSEnabled)
        print("")
        print(">> STEERING <<")
        print("SteerRatio", carmod.SteerRatio)
        print("LockToLock", carmod.LockToLock)
        print("Ackerman", carmod.Ackerman)
        print("")
        print("")
        print("")
    end
})
tMotorcycle:AddTextbox({
    Name = "Horsepower",
    Flag = "mtHP",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname.Tuner)
        carmod.Horsepower = NewValue
end
})
tMotorcycle:AddTextbox({
    Name = "FinalDrive",
    Flag = "mtFDrive",
    Placeholder = "Value",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname.Tuner)
        carmod.FinalDrive = NewValue
    end
})
tMotorcycle:AddTextbox({
    Name = "Brake Force",
    Flag = "mbForce",
    Placeholder = "4000 - 8000",
    Value = "",
    Callback = function(NewValue, OldValue)
    carmod = require(library.flags.carname.Tuner)
        carmod.BrakeForce = NewValue
    end
})
tMotorcycle:AddButton({
    Name = "Unlock TCS/ABS",
    Callback = function()
    carmod = require(library.flags.carname.Tuner)
        carmod.TCSEnabled = true
        carmod.ABSEnabled = true
    end
})


--[Scripts]
local ScriptsTab = BlurredMenu:CreateTab({
Name = "Scripts"
})
--[Starblox Shop]
local sStarblox = ScriptsTab:CreateSection({
Name = "Starblox"
})
sStarblox:AddDropdown({
    Name = "Starblox Item Select",
    Flag = "starbloxprice",
    List = {"Coffee/Iced Coffee", "Strawberry Frappuccino", "Mocha Frappuccino", "BdayCakepop", "ChocCakepop", "CookieCakepop", "Burrito", "Doughnut"},
    Callback = function(item, lastitem)
        print("Selected Starblox item:", item)
    end
})
sStarblox:AddButton({
    Name = "Buy Starblox Item",
    Callback = function(starbloxprice)
        print("Starblox Purchased Item:", library.flags.starbloxprice)
        local args = {
            [1] = "Confirm",
            [2] = true,
            [3] = library.flags.starbloxprice
        }

        game:GetService("ReplicatedStorage").RequestPurchase:FireServer(unpack(args))
    end
})
--[Seaside Shop]
local sSeaside = ScriptsTab:CreateSection({
Name = "Seaside"
})
sSeaside:AddDropdown({
    Name = "Seaside Item Select",
    Flag = "seasideprice",
    List = {"Seaside Coffee", "Seaside Tea", "Seaside Fries", "Seaside Burger", "Seaside Cheeseburger", "Seaside Hotdog", "", "", "", "", "", "", "", "",},
    Callback = function(item, lastitem)
        print("Selected Seaside item:", item)
    end
})
sSeaside:AddButton({
    Name = "Buy Seaside Item",
    Callback = function(seasideprice)
        print("Seaside Purchased Item:", library.flags.seasideprice)
        local args = {
            [1] = "Confirm",
            [2] = true,
            [3] = library.flags.seasideprice
        }

        game:GetService("ReplicatedStorage").RequestPurchase:FireServer(unpack(args))
    end
})

--[Vehicles Mods]
local swfScripts = ScriptsTab:CreateSection({
Name = "Scripts",
Side = "Right"
})

swfScripts:AddButton({
    Name = "UnnamedESP",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "UnnamedESP";
            Text = "Made By: ic3w0lf";
            Duration = 4;
        })
        wait(5)
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/leonardostefanello/Games/main/Roblox/Tools/UnnamedESP.lua'),true))()
    end
})

swfScripts:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Infinite Yield";
            Text = "Loading...";
            Duration = 4;
        })
        wait(5)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
--[Vehicles Mods]
local swfMaps = ScriptsTab:CreateSection({
Name = "Modded Maps",
Side = "Right"
})
swfMaps:AddButton({
    Name = "Stunt Map",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Stunt Map";
            Text = "Loading Ramps...";
            Duration = 4;
        })
        wait(5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedBScorpion/Roblox/main/swf-stuntmap", true))()
    end
})
swfMaps:AddButton({
    Name = "Environment Map",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Environment Map";
            Text = "Loading Environments...";
            Duration = 4;
        })
        wait(5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedBScorpion/Roblox/main/swf-environmentmap", true))()
    end
})
