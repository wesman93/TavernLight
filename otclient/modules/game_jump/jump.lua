jumpToggleButton = nil -- Toggle button in top menu to display or hide the window.
jumpWindow = nil -- The window containing the button.
button = nil -- Used to reference Jump! button in window.
topY = nil -- Minimum Y value for button.
botY = nil -- Maximum Y value for button.
leftX = nil -- Minimum X value for button.
rightX = nil -- Maximum X value for button.
event = nil -- Event that repeats to continually move the button.

-- It is initialized by adding a toggle button to the right of the top menu.
-- The toggle button defaults to an off state and the window it displays is not visible.
function init()
  jumpToggleButton = modules.client_topmenu.addRightToggleButton('jumpToggleButton', tr('Jump!'), '/images/topbuttons/spelllist', closing)
  jumpToggleButton:setOn(false)

  jumpWindow = g_ui.displayUI('jump')
  jumpWindow:setVisible(false)
end

-- Destroy elements on terminate
function terminate()
  jumpToggleButton:destroy()
  jumpWindow:destroy()
  button:destroy()
end

-- This function fires when the toggle button is toggled.
function closing()
  if jumpToggleButton:isOn() then
    -- If the toggle button was on, the window is hidden, the toggle is set off, and the event is removed.
    jumpWindow:setVisible(false)
    jumpToggleButton:setOn(false)

    removeEvent(event)
  else
    -- If the toggle was off, the window is shown, the toggle is set on, and values are assigned to global variables.
    jumpWindow:setVisible(true)
    jumpToggleButton:setOn(true)
    button = jumpWindow:recursiveGetChildById('jumpButton')

    topY = button:getY()
    botY = topY + 400
    leftX = button:getX()
    rightX = leftX + 400

    -- cycleEvent is used to call the slide function at regular intervals, creating a smooth animation effect.
    event = cycleEvent(slide, 2)
  end
end

-- The slide function simply updates the button position by subtracting 1 from the x coordinate.cycleEvent
-- If the x coordinate reaches the minimum x limit, then it calls the jump function.
function slide()
    button:setPosition({x = button:getX()-1, y = button:getY()})
    if button:getX() <= leftX then
        jump()
    end
end

-- The jump function sets a new position on the button using a random y coordinate between max and min limits.
function jump()
  if button then
    button:setPosition({x = rightX, y = math.random(topY, botY)})
  end
end

function onMiniWindowClose()
  jumpToggleButton:setOn(false)
end
