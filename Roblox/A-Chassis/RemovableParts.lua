--[[

       _____            __                 _   __      __  ______                      __
      / ___/__  _______/ /____  ____ ___  / | / /___  / /_/ ____/___  __  ______  ____/ /
      \__ \/ / / / ___/ __/ _ \/ __ `__ \/  |/ / __ \/ __/ /_  / __ \/ / / / __ \/ __  / 
     ___/ / /_/ (__  ) /_/  __/ / / / / / /|  / /_/ / /_/ __/ / /_/ / /_/ / / / / /_/ /  
    /____/\__, /____/\__/\___/_/ /_/ /_/_/ |_/\____/\__/_/    \____/\__,_/_/ /_/\__,_/   
         /____/                                                                          


.Made by Moonlight_
--]]

--------------------// variables //--------------------

local UserInputService = game:GetService("UserInputService") -- UserInputService for handling user input events
local car = script.Parent.Car.Value -- get vehicle model from "Car" value
local removableFolder = car.Body.removable -- model where all the removable parts are stored

--------------------// configurations //--------------------

----// edit below //----

local key = "L" -- key that will be used to toggle transparency

local keyBindings = { -- table containing different states for key bindings
	[1] = {removableFolder.bodyParts},
	[2] = {removableFolder.underpart},
	-- Add more states if needed
}

----// edit above //----

--------------------// setup //--------------------

local currentState = 1 -- variable to keep track of the current state
local statesCount = #keyBindings -- count of the states available

--------------------// functions //--------------------

local originalTransparency = {} -- to store the original transparency values

--[[ Function to toggle the transparency of parts.
• If the part is a model or folder, it will recursively call itself on the children.
• If the part is a BasePart or MeshPart, it will toggle between the original transparency and fully transparent (1).
]]
local function toggleTransparency(parts)
	if parts:IsA("Model") or parts:IsA("Folder") then
		-- iterate through the children of the model or folder
		for _, child in pairs(parts:GetChildren()) do
			-- recursive call to handle nested models or folders
			toggleTransparency(child)
		end
	elseif parts:IsA("BasePart") or parts:IsA("MeshPart") then
		-- check if the original transparency is already stored
		if originalTransparency[parts] then
			-- toggle between original transparency and 1 (fully transparent)
			parts.Transparency = (parts.Transparency == 1) and originalTransparency[parts] or 1
		else
			-- store the original transparency and set the part to fully transparent
			originalTransparency[parts] = parts.Transparency
			parts.Transparency = 1
		end
	end
end

-- connect function to handle input events
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	-- check if the input is a keyboard input, not already processed, and the correct key is pressed
	if input.UserInputType == Enum.UserInputType.Keyboard and not gameProcessedEvent and input.KeyCode.Name == key then
		-- toggle the transparency of the parts associated with the current state
		for _, part in ipairs(keyBindings[currentState]) do
			toggleTransparency(part)
		end
		-- update the current state to the next state, wrapping around if necessary
		currentState = currentState % statesCount + 1
	end
end)

--------------------// end //--------------------
