local item=params.player:getHandItem()
if item~=nil and item:full_name()=="myplugin/cup_dao_da" then
  PackageHandlers.sendServerHandler(params.player,"showUIMiner",{pos=params.pos+Lib.v3(0,2, 0)})
else
  PackageHandlers.sendServerHandler(params.player,"showNotification",{text=3,time=1})
end