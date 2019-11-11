

minetest.register_node("pipeworks_elbow:pipeworks_elbow", {
	description = "Airtight steelblock elbow tube",
	tiles = {
		"default_steel_block.png", "default_steel_block.png",
    "default_steel_block.png^pipeworks_tube_connection_metallic.png",
		"default_steel_block.png", "default_steel_block.png",
		"default_steel_block.png^pipeworks_tube_connection_metallic.png",
		},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand = 1, tubedevice = 1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	tube = {
		connect_sides = {front = 1, back = 1,},
		priority = 50,
		can_go = function(_, node)
      local dir = minetest.facedir_to_dir(node.param2)
      if dir == 0 then
        return { {x=0,y=0,z=0} }
        -- TODO: all directions
      end
    end,
		can_insert = function(_, node, _, direction)
			local dir = minetest.facedir_to_dir(node.param2)
			return vector.equals(dir, direction) or vector.equals(vector.multiply(dir, -1), direction)
		end,
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate,
})

minetest.register_craft( {
	output = "pipeworks_elbow:pipeworks_elbow 1",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "pipeworks:tube_1", "pipeworks:tube_1", "default:steel_ingot" },
		{ "default:steel_ingot", "pipeworks:tube_1", "default:steel_ingot" }
	},
})
