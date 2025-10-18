-- Demented Rune

minetest.register_craftitem("dementedscript:demented_rune", {

    description = "Demented Rune",

    inventory_image = "rune.png",

    on_place = function(itemstack, placer, pointed_thing)

        local pos = placer:get_pos()

        if not pos then return end
        minetest.chat_send_all("The world shifts...")
           minetest.chat_send_all("Something terrible has been unleashed.")
         minetest.chat_send_all("A presence lurks nearby...")

        -- Spawn Herobrine

        local hpos = {

            x = pos.x + math.random(-5, 5),

            y = pos.y,

            z = pos.z + math.random(-5, 5)

        }

        minetest.add_entity(hpos, "dementedscript:herobrine")

        -- Spawn 10 Jimmys

        for i = 1, 10 do

            local offset = {

                x = pos.x + math.random(-25, 25),

                y = pos.y + 1,

                z = pos.z + math.random(-25, 25)

            }

            minetest.add_entity(offset, "dementedscript:jimmy")

        end

        itemstack:take_item()

        return itemstack

    end,

})

minetest.register_craft({

    output = "dementedscript:demented_rune",

    recipe = {

        {"default:diamondblock", "default:obsidian", "default:diamondblock"},

        {"default:obsidian", "default:mese_block", "default:obsidian"},

        {"default:diamondblock", "default:obsidian", "default:diamondblock"},

    }

})