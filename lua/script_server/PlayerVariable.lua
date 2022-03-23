Entity.addValueDef('NewPlayer',{
  isLogin=false,
  dateJoin={
    day=0,
    month=0,
    year=0
  }
}
,false,false,true)

Entity.addValueDef('Bag',{
  maxSlot=4,
  bag={
    {
    type="Material",
    id=4,
    name="Da tho",
    image="gameres|asset/Texture/Gui/datho.png",
    describe="Da vua dao duoc",
    count=2
  },
    {
      type="Material",
      id=1,
      name="Go nguyen",
      image="gameres|asset/Texture/Gui/gonguyen.png",
      describe="Go chua qua che tao",
      count=10
    },
    {
      type="Material",
      id=2,
      name="Sat",
      image="gameres|asset/Texture/Gui/sat.png",
      describe="Day la Sat",
      count=5
    },
    {
      type="Material",
      id=3,
      name="Vai",
      image="gameres|asset/Texture/Gui/vai.png",
      describe="Day la Vai",
      count=5
    }
  }
}
,false,false,true)


