local balo=params.player:getValue("Bag")
local inform=params.player:getValue("Inform")
PackageHandlers.sendServerHandler(params.player,"openShopMiner",{balo=balo,inform=inform})