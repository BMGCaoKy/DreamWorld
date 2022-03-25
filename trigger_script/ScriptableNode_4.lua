local player=params.player
local inform=player:getValue("Inform")
PackageHandlers.sendServerHandler(params.player,"openGetJob",{inform=inform})