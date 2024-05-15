jumpToggleButton = nil
jumpWindow = nil

function init()
  jumpToggleButton = modules.client_topmenu.addRightToggleButton('jumpToggleButton', tr('Jump!'), '/images/topbuttons/spelllist', closing)
  jumpToggleButton:setOn(false)

  jumpWindow = g_ui.displayUI('jump')
  jumpWindow:setVisible(false)
end

function terminate()
  jumpToggleButton:destroy()
  jumpWindow:destroy()
end

function closing()
  if jumpToggleButton:isOn() then
    jumpWindow:setVisible(false)
    jumpToggleButton:setOn(false)
  else
    jumpWindow:setVisible(true)
    jumpToggleButton:setOn(true)
  end
end

function jump()
  local button = jumpWindow:recursiveGetChildById('jumpButton')
  if button then
    print('button')
    button:setStyle('margin-top: 9')
  else
    print('NO BUTTON')
  end
  print('boopy')
end

function onMiniWindowClose()
  jumpToggleButton:setOn(false)
end
