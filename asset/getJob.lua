print("startup ui")
function self:onOpen(packet)
  local inform=packet.inform
  
  local txt=require "script_common.Text"
  if inform.role.id==1 then
    self.BG.Text:setText(Lang:toText(txt[4]))
  else
    self.BG.Text:setText(Lang:toText(txt[5]))
  end
  for i=2,4 do
    self.BG.GridView:child("Button"..i).onMouseClick=function()
      UI:openWindow("costJob","costJob","layouts",{id=i})
    end
  end
  self.BG.CloseBtn.onMouseClick = function()
    UI:closeWindow(self)
  end
end

  