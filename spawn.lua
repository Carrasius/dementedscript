mobs:spawn({

  name = "dementedscript:jimmy",

  nodes = {"default:stone", "default:dirt"},

  min_light = 0,

  max_light = 15,

  chance = 2000, 

  active_object_count = 5,

  min_height = -31000,

  max_height = 31000,

  day_toggle = nil,

 })

mobs:spawn({

  name = "dementedscript:herobrine",

  nodes = {"default:stone", "default:dirt"},

  min_light = 0,

  max_light = 15,

  chance = 200000, 

  active_object_count = 1,

  min_height = -31000,

  max_height = 31000,

  day_toggle = nil,

 })

mobs:spawn({

    name = "aardrooms:blimey",

    nodes = {"default:stone", "default:dirt_with_grass", },

    min_light = 0,   -- minimum light level for spawning (dark)

    max_light = 5,   -- maximum light level for spawning

    chance = 1000,   -- lower value = more frequent spawning

    active_object_count = 2, -- max Blimey per area

    min_height = -32000,  -- underground minimum height

    max_height = 32000,   -- surface maximum height

})