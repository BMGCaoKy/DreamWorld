print("startup ui")
function self:onOpen(packet)
  
  local txt=require "script_common.Text"
  local role=require "script_common.Role"
  local name,cost
  for k,v in pairs(role) do
    if v.id==packet.id then
      name=v.name
      cost=v.cost
      break
    end
  end
  self.BG.Text:setText(Lang:toText(txt[6])..name.."\n"..Lang:toText(txt[9])..cost.."$")
  self.BG.HorizontalLayout.No.onMouseClick=function()
    UI:closeWindow(self)
  end
  self.BG.HorizontalLayout.Yes.onMouseClick=function()
    PackageHandlers.sendClientHandler("changeJob",{cost=cost,id=packet.id,name=name})
    UI:closeWindow(self)
  end
end

  