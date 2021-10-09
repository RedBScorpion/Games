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
--[Vehicles Mods]
local vBasicSection = VehiclesTab:CreateSection({
Name = "Vehicle Basics"
})
vBasicSection:AddDropdown({
    Name = "Car Select",
    Flag = "carname",
    Nothing = "No Selection", -- You can optionaly allow the dropdown to have no value.
    List = workspace.Cars, -- calls 'Method' (or GetChildren) on specifyed instance
    Callback = function(car, lastcar)
        if car and typeof(car) == "Instance" then
            print("Selected Car:", car)
        else
            print("Unselected Car from", lastcar)
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
--[Suspension]
local vSuspensionSection = VehiclesTab:CreateSection({
Name = "Suspension"
})
vSuspensionSection:AddButton({
    Name = "Stock",
    Callback = function()
        print("Customization: Stock Suspension")
        local args = {
            [1] = "UpdateHeight",
            [2] = "norm"
        }
    
        library.flags.carname.rH_FE:FireServer(unpack(args))
    end
})
vSuspensionSection:AddButton({
    Name = "Sport",
    Callback = function()
        print("Customization: Sport Suspension")
        local args = {
            [1] = "UpdateHeight",
            [2] = "low"
        }
    
        library.flags.carname.rH_FE:FireServer(unpack(args))
    end
})
vSuspensionSection:AddButton({
    Name = "Race",
    Callback = function()
        print("Customization: Race Suspension")
        local args = {
            [1] = "UpdateHeight",
            [2] = "slam"
        }
    
        library.flags.carname.rH_FE:FireServer(unpack(args))
    end
})
--[Tires]
local vTiresSection = VehiclesTab:CreateSection({
Name = "Tires"
})
vTiresSection:AddButton({
    Name = "Stock",
    Callback = function()
        print("Customization: Stock Tires")
        local args = {
            [1] = "UpdateTires",
            [2] = "stock"
        }

        library.flags.carname.rH_FE:FireServer(unpack(args))
    end
})
vTiresSection:AddButton({
    Name = "Grip",
    Callback = function()
        print("Customization: Grip Tires")
        local args = {
            [1] = "UpdateTires",
            [2] = "grip"
        }

        library.flags.carname.rH_FE:FireServer(unpack(args))
    end
})
vTiresSection:AddButton({
    Name = "Drift",
    Callback = function()
        print("Customization: Drift Tires")
        local args = {
            [1] = "UpdateTires",
            [2] = "drift"
        }

        library.flags.carname.rH_FE:FireServer(unpack(args))
    end
})

--[SHOP]
local ShopTab = BlurredMenu:CreateTab({
Name = "Shop"
})

local sVehicles = ShopTab:CreateSection({
Name = "Vehicles"
})
sVehicles:AddDropdown({
    Name = "Car Select",
    Flag = "carprice",
    Nothing = "No Selection",
    List = game:GetService("ReplicatedStorage").carPrices,
    Callback = function(car, lastcar)
        if car and typeof(car) == "Instance" then
            print("Selected Car:", car)
        else
            print("Unselected Car from", lastcar)
        end
    end
})
sVehicles:AddButton({
    Name = "Buy Vehicle",
    Callback = function(carprice)
        print("Vehicle Purchased:", library.flags.carprice)
        local args = {
            [1] = "requestVehiclePurchase",
            [2] = library.flags.carprice.Name,
            [3] = game:GetService("Players").LocalPlayer.PlayerGui.menuSNew.menuFrame.vehicleMain.Frames
        }

        game:GetService("ReplicatedStorage").SpawnCar:FireServer(unpack(args))
    end
})
--[jPhones Shop]
local sPhones = ShopTab:CreateSection({
Name = "jPhones"
})
sPhones:AddDropdown({
    Name = "jPhone Select",
    Flag = "jphoneprice",
    List = {"jPhone 12 Pro Max Raft", "jPhone 12 Pro Max Platinum", "jPhone 12 Pro Max Gold", "jPhone 12 Pro Max Gray", "jPhone 12 Pro Max Tan", "jPhone 12 Pro Max Blue", "jPhone 12 Pro Max White", "jPhone 12 Black", "jPhone 12 White", "jPhone 12 Lavender", "jPhone 12 Red", "jPhone 12 Blue"},
    Callback = function(phone, lastphone)
        print("Selected jPhone:", phone)
    end
})
sPhones:AddButton({
    Name = "Buy jPhone",
    Callback = function(jphoneprice)
        print("jPhone Purchased:", library.flags.jphoneprice)
        local args = {
            [1] = "Confirm",
            [2] = true,
            [3] = library.flags.jphoneprice
        }

        game:GetService("ReplicatedStorage").RequestPurchase:FireServer(unpack(args))
    end
})
--[Starblox Shop]
local sStarblox = ShopTab:CreateSection({
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
local sSeaside = ShopTab:CreateSection({
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
