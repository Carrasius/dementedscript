-- Herobrine

mobs:register_mob("dementedscript:herobrine", {

    type = "monster",

    passive = false,

    damage = 6,

    attack_type = "dogfight",

    pathfinding = true,

    reach = 2,

    attack_players = true,

    hp_min = 3000,

    hp_max = 4000,

    armor = 90,

    collisionbox = {-0.3, -0.01, -0.3, 0.3, 1.8, 0.3},

    visual = "mesh",

    mesh = "character.b3d",

    textures = {"herobrine.png"},

    makes_footstep_sound = true,

    sounds = {

        random = "ghost",

        attack = "default_punch",

    },

    walk_velocity = 2,

    run_velocity = 3,

    stepheight = 1.1,

    view_range = 20,

    jump = true,

    fear_height = 3,

    drops = {

        {name = "default:diamond_block", chance = 5, min = 5, max = 9},

        {name = "default:mese_block", chance = 3, min = 5, max = 9},

    },

    water_damage = 0,

    lava_damage = 5,

    light_damage = 0,

    animation = {

        speed_normal = 30, speed_run = 30,

        stand_start = 0, stand_end = 79,

        walk_start = 168, walk_end = 187,

        run_start = 168, run_end = 187,

        punch_start = 189, punch_end = 198,

    },

    -- Custom behavior

    do_custom = function(self, dtime)

        -- === Summon Jimmy ghosts every 5s ===

        self.jimmy_timer = (self.jimmy_timer or 0) + dtime

        if self.jimmy_timer >= 5 then

            self.jimmy_timer = 0

            if math.random(1, 8) == 1 then

                local pos = self.object:get_pos()

                if pos then

                    local num = math.random(4, 5)

                    for i = 1, num do

                        local offset = {

                            x = pos.x + math.random(-3, 3),

                            y = pos.y + 1,

                            z = pos.z + math.random(-3, 3)

                        }

                        minetest.add_entity(offset, "dementedscript:jimmy")

                        minetest.sound_play("ghost", {

                            pos = offset,

                            gain = 1.0,

                            max_hear_distance = 16

                        })

                    end

                end

            end

        end

-- teleport and invis 

        self.teleport_timer = (self.teleport_timer or 0) + dtime

        if self.teleport_timer >= 10 then

            self.teleport_timer = 0

            local pos = self.object:get_pos()

            if pos then

                local nearest_player

                local min_dist = 20

                for _, player in ipairs(minetest.get_connected_players()) do

                    local ppos = player:get_pos()

                    local dist = vector.distance(pos, ppos)

                    if dist < min_dist then

                        min_dist = dist

                        nearest_player = player

                    end

                end

                if nearest_player then

                    local ppos = nearest_player:get_pos()

                    local yaw = nearest_player:get_look_horizontal()

                    local offset = {

                        x = ppos.x - math.sin(yaw) * 2,

                        y = ppos.y + 1,

                        z = ppos.z - math.cos(yaw) * 2

                    }

                    local node_here = minetest.get_node(offset)

                    local node_below = minetest.get_node({x=offset.x, y=offset.y-1, z=offset.z})

                    if node_here.name == "air" and node_below.name ~= "air" then

                        self.object:set_pos(offset)

                        minetest.sound_play("ghost", {

                            pos = offset,

                            gain = 2.0,

                            max_hear_distance = 24

                        })

                        -- Become invisible for 5 seconds

                        self.object:set_properties({textures = {"invisible.png"}})

                        self.invisible_timer = 5

                        self.is_invisible = true

                    end

                end

            end

        end

        -- === Handle invisibility timeout ===

        if self.is_invisible then

            self.invisible_timer = self.invisible_timer - dtime

            if self.invisible_timer <= 0 then

                self.object:set_properties({textures = {"herobrine.png"}})

                self.is_invisible = false

            end

        end

    end,

})

-- Spawn egg for Herobrine

mobs:register_egg("dementedscript:herobrine", "Herobrine", "default_obsidian.png", 1)

-- Jimmy Ghost entity

mobs:register_mob("dementedscript:jimmy", {

    type = "monster",

    passive = false,

    attack_type = "dogfight",

    pathfinding = true,

    damage = 1,          -- attack damage

    reach = 2,

    hp_min = 3,          -- health (min)

    hp_max = 4,          -- health (max)

    armor = 120,

    collisionbox = {-0.4, -0.4, -0.4, 0.4, 0.8, 0.4},

    visual = "sprite",

    textures = {"jimmy.png"},

    visual_size = {x = 0.75, y = 0.75},

    glow = 10,

        

    physical = false,

    collide_with_objects = true,

    makes_footstep_sound = false,

    walk_velocity = 2,

    run_velocity = 3,

    fly = true,                 -- can fly

    fly_in = {"air"},           -- ghost moves in air

    view_range = 20,

    water_damage = 0,

    lava_damage = 1,

    light_damage = 0,

    sounds = {

        random = "ghost",   -- random ambient sound

        attack = "ghost",

        damage = "ghost",

        death = "ghost",

    },

    animation = {

        stand_start = 0, stand_end = 0,

        walk_start = 0, walk_end = 0,

        run_start = 0, run_end = 0,

    },

    on_step = function(self, dtime)

        -- Keep floating / simple wandering when no target

        if not self.target then

            if self.object:get_velocity().y < 0.5 then

                local vel = self.object:get_velocity()

                vel.y = vel.y + 0.02 -- gentle float up

                self.object:set_velocity(vel)

            end

        end

    end,

})

-- Spawn egg for Jimmy

mobs:register_egg("dementedscript:jimmy", "Jimmy Ghost", "jimmy.png", 1)

-- Blimey!

mobs:register_mob("aardrooms:blimey", {

    -- Basic info

    type = "monster",

    passive = false,

    damage = 4,              -- damage to players

    attack_type = "dogfight", -- chases and attacks

    attack_players = true,    -- attacks players

    attack_monsters = false,  -- does not attack other monsters

    attack_npcs = false,

    pathfinding = true,       -- uses pathfinding

    hp_min = 2000,

    hp_max = 2500,

    armor = 100,

    collisionbox = {-0.5, -1, -0.5, 0.5, 1, 0.5},

    -- Visuals

    visual = "sprite",

    textures = {"blimey.png"},

    visual_size = {x = 2, y = 2},

    glow = 10, -- visible in the dark

    -- Movement

    walk_velocity = 1.5,

    run_velocity = 3,

    jump = true,

    fear_height = 3,

    -- Sounds

    makes_footstep_sound = true,

    sounds = {

        random = "blimey_idle",

        attack = "blimey_idle"

    },

    -- Drops

    drops = {

        {name = "default:steel_block", chance = 1, min = 5, max = 10},

    },

    -- Behavior

    follow = {}, -- optional: items it can follow

    view_range = 20,

    -- Called when spawned

    on_spawn = function(self)

        minetest.log("action", "[Blimey] Spawned at " .. minetest.pos_to_string(self.object:get_pos()))

    end,

})