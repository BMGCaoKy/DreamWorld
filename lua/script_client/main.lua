print('script_client:hello world')
UI:openWindow("Interface")
World.Timer(10, function()
    --local guiMgr = GUIManager:Instance()
	--local window = UI:openWindow("")
  if UI:isOpenWindow("Interface")==false then
    UI:openWindow("Interface")
  end
end)
PackageHandlers.registerClientHandler("showGuideTarget",function(player,packet)
  player:setGuideTarget(packet.pos,'arrow.png',0.1)
end)

PackageHandlers.registerClientHandler("closeGuideTarget",function(player,packet)
  player:delGuideTarget()
end)
PackageHandlers.registerClientHandler("showTutorial_1",function(player,packet)
  UI:openWindow("tutorial_1")
end)

PackageHandlers.registerClientHandler("closeTutorial_1",function(player,packet)
  UI:closeWindow("tutorial_1")
end)

PackageHandlers.registerClientHandler("closeUIMiner",function(player,packet)
  UI:closeSceneWindow("UIMiner")
end)
PackageHandlers.registerClientHandler("showNotification",function(player,packet)
  UI:openWindow("Notification","Notification","layouts",{text=packet.text, time=packet.time})
end)
PackageHandlers.registerClientHandler("showUIMiner",function(player,packet)
  UI:openSceneWindow("UIMiner", "UIMiner", {
    position = {x = -29.68, y =53+1.5, z = 62.38},
    rotation = {x = 0, y =0, z =0},
    width = 1,
    height = 1,
    isCullBack = false,
    objID = 0,
    flags = 4}, "layouts", {x = 1}
  )
end)