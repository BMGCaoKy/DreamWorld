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
    position = packet.pos,
    rotation = {x = 0, y =0, z =0},
    width = 1,
    height = 1,
    isCullBack = false,
    objID = 0,
    flags = 4}, "layouts", {x = 1}
  )
end)
PackageHandlers.registerClientHandler("showLoadByPos",function(player,packet)
  UI:openSceneWindow("GiveItemByPos", "GiveItemByPos", {
    position = packet.pos,
    rotation = {x = 0, y =0, z =0},
    width = 2,
    height = 2,
    isCullBack = false,
    objID = 0,
    flags = 4}, "layouts", {id=packet.id,count=packet.count,pos=packet.pos,time=packet.time}
  )
end)

PackageHandlers.registerClientHandler("openFurnace",function(player,packet)
  UI:openWindow("Furnace","Furnace","layouts",{pos=packet.pos})
end)
PackageHandlers.registerClientHandler("closeFurnace",function(player,packet)
  UI:closeWindow("Furnace")
end)

PackageHandlers.registerClientHandler("openNotificationItem",function(player,packet)
  UI:openWindow("NotificationItem","NotificationItem","layouts",{name=packet.name,count=packet.count})
end)