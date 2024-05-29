--[[ 

//How it Works
ExhaustFlames > ExhaustHandler > FlamesController

//Credits: 
.made by cc567 
.modded by RedByMoon

--]]

--//Information
local car = script.Parent.Parent
local ExhaustPart = car.Body.ExhaustFlames
local Event = script.Parent

--Serverside logic
Event.OnServerEvent:Connect(function(player,ExhaustParticle,FireBool)

	if FireBool then

		local RanNum = tostring(math.random(1,3))
		ExhaustPart["Backfire"..RanNum]:Play()
		ExhaustPart.PointLight.Enabled = true
		ExhaustPart[ExhaustParticle].Enabled = true

		if ExhaustParticle == "FlamesSmall" then 
			
			ExhaustPart.PointLight.Range = 6  
			ExhaustPart.PointLight.Brightness = 5
			ExhaustPart.Sparks.Enabled = false

		else 

			ExhaustPart.PointLight.Range = 8
			ExhaustPart.PointLight.Brightness = 12
			ExhaustPart.Sparks.Enabled = true

		end	
	else
		
		ExhaustPart[ExhaustParticle].Enabled = false
		ExhaustPart.PointLight.Enabled = false

	end	
end)
