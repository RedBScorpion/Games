local STEER_SENSI = 12 -- Speed ​​at which the steering wheel is turned to the target steering angle
local FFB_GAIN = 3 -- Strength of FFB effect
local GYRO_GAIN = 2 -- Strength of gyro sensor

local steerAngle = 0 -- The current angle of the steering wheel
local steerVelocity = 0 -- The speed at which the steering angle is changing
local gasValue = 0 -- The amount of gas being applied (0 to 1)
local brakeValue = 0 -- The amount of brake being applied (0 to 1)

-- Reset steering angle when the car reset
ac.onCarJumped(0, function ()
  steerAngle = 0
  steerVelocity = 0
end)

-- Main update function, called every frame
function script.update(dt)
  local data = ac.getJoypadState() -- Get the current state of the controls (joypad, wheel, etc.)
  local ui = ac.getUI() -- Get UI-related information (like mouse position)

  -- Edit here for the accelerator and brake assignments!
  
  -- Throttle
  if ac.isKeyDown(ac.KeyIndex.W) then
    gasValue = gasValue + 2 * dt
  else
    gasValue = gasValue - 2 * dt
  end
  gasValue = math.clamp(gasValue, 0, 1) -- Clamp gas value between 0 and 1
  data.gas = gasValue -- Set the gas input

  -- Brake
  if ac.isKeyDown(ac.KeyIndex.S) then
    brakeValue = brakeValue + 3 * dt
  else
    brakeValue = brakeValue - 3 * dt
  end
  brakeValue = math.clamp(brakeValue, 0, 1)
  data.brake = brakeValue
  data.clutch = 1 - brakeValue

  -- Clutch
  if ac.isKeyDown(ac.KeyIndex.C) then
    data.clutch = 0
  else
    if data.clutch == 1 then
      data.clutch = 1
    end
  end
  
  
  
  -- Calculate the speed of the tyres for steering calculation
  local tyreSpeed = {}
  tyreSpeed[0] = car.wheels[0].angularSpeed * car.wheels[0].tyreRadius -- Speed of the front left wheel
  tyreSpeed[1] = car.wheels[1].angularSpeed * car.wheels[1].tyreRadius -- Speed of the front right wheel

  -- Determine if the car is driving forward and moving based on tyre speed and car speed
  local isDrive = math.min(data.speedKmh / 36, 1) -- Cap speed-related multiplier
  local isForward = math.clamp(tyreSpeed[0] + tyreSpeed[1], 0, 10) / 10 -- Calculate forward motion based on wheel speed

  -- Calculate the mouse steering input based on mouse X position
  local mouseSteer = (ui.mousePos.x - ui.windowSize.x / 2) / ui.windowSize.x * 2 -- Mouse input between -1 and 1

  -- Calculate the angle of the car's velocity relative to its forward direction
  local velocityAngle = math.atan2(car.localVelocity.x, car.localVelocity.z) / (math.pi / 2) * isDrive * isForward

  -- Calculate the speed at which the steering wheel should turn based on mouse input, FFB, and gyro
  steerVelocity = (mouseSteer - velocityAngle - steerAngle) * STEER_SENSI - data.ffb * FFB_GAIN + data.localAngularVelocity.y * GYRO_GAIN * isForward

  -- Update the steering angle and clamp it between -1 and 1
  steerAngle = math.clamp(steerAngle + steerVelocity * 450 / data.steerLock * dt, -1, 1)

  data.steer = steerAngle -- Set the steering input to the new angle

  -- Display for debugging
  ac.debug('mouseSteer', mouseSteer) -- Show the mouse steering value
  ac.debug('steerAngle', steerAngle) -- Show the current steering angle
  ac.debug('velocityAngle', velocityAngle) -- Show the calculated velocity angle
  ac.debug('gas', data.gas) -- Show the gas input value
  ac.debug('clutch', data.clutch) -- Show the clutch input value

  -- Processing to reset when the handle is blown away
  if data.steer ~= data.steer then
    steerAngle = 0 -- Reset steering angle
    data.steer = 0 -- Reset steering input
  end
end
