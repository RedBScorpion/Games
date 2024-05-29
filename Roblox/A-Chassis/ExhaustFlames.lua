--[[ 

//How it Works
ExhaustFlames > ExhaustHandler > FlamesController

//Credits: 
.made by cc567 
.modded by RedByMoon

--]]

--//Information
local car = script.Parent.Car.Value
local Values = script.Parent:WaitForChild("Values")
local _Tune = require(car["A-Chassis Tune"])
local Handler = car:WaitForChild("ExhaustHandler")
local IsFlaming = false --Exhaust flame debounce.  Debounces are important so code block doesn't run too quickly

--//Script
Values.Throttle.Changed:Connect(function() -- This is where all the magic happens.  Flames are determined by when you release the throttle
	
	local RPMRatio = Values.RPM.Value / _Tune.Redline

	if RPMRatio > 0.8 and not IsFlaming and car.DriveSeat.Throttle < 1 then

		IsFlaming = true
		Handler:FireServer("Flames",true)
		wait(.15)
		Handler:FireServer("Flames",false)
		Handler:FireServer("FlamesSmall",true)
		wait(.6)
		Handler:FireServer("FlamesSmall",false)
		IsFlaming = false
	elseif Values.Throttle.Value < 0.5 then
		Handler:FireServer("FlamesSmall",false)
		
	end
end)
