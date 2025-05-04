
function spawner_integration(size)
size = size or 1;
return
  {
      filename = "__factorioplus__/graphics/entity/spawner/hr-spawner-idle-integration.png",
      variation_count = 4,
      width = 522,
      height = 380,
      shift = util.by_pixel(3 * size, -3 * size),
      frame_count = 1,
      line_length = 1,
      scale = size * 0.5
  }
end

function spawner_idle_animation(variation, tint, size)
size = size or 1;
return
  {
    layers =
    {

      {
		filename = "__base__/graphics/entity/spawner/spawner-idle.png",
		line_length = 4,
		width = 520,
		height = 376,
		frame_count = 8,
		animation_speed = 0.18,
		direction_count = 1,
		run_mode = "forward-then-backward",
		shift = util.by_pixel( 4.0 * size, -3.0  * size),
		y = variation * 376 * 2,
		scale = size * 0.5
      },
  
      {
		filename = "__factorioplus__/graphics/entity/spawner/spawner-idle-mask.png",
		flags = { "mask" },
		width = 270,
		height = 230,
		frame_count = 8,
		animation_speed = 0.18,
		run_mode = "forward-then-backward",
		shift = util.by_pixel( 0.0 * size, -12.5 * size),
		line_length = 4,
		tint = tint,
		y = variation * 230 * 2,
		scale = size * 0.5	
      },

      {
		filename = "__base__/graphics/entity/spawner/spawner-idle-shadow.png",
		draw_as_shadow = true,
		width = 496,
		height = 358,
		frame_count = 8,
		animation_speed = 0.18,
		run_mode = "forward-then-backward",
		shift = util.by_pixel( 3.5 * size, -0.5 * size),
		line_length = 4,
		y = variation * 358 * 2,
		scale = size * 0.5
      }
    }
  }
end

function spawner_die_animation(variation, tint, scale)
local scale = scale or 1
return
  {


    layers =
    {
      {
          filename = "__base__/graphics/entity/spawner/spawner-death-v1.png",
          line_length = 6,
          width = 486,
		  height = 304,
          frame_count = 18,
          direction_count = 1,
          shift = util.by_pixel( -5.5, -4.5),
         -- y = variation * 354,
          scale = scale*0.5
      },
      {
          filename = "__base__/graphics/entity/spawner/spawner-death-mask-v1.png",
          flags = { "mask" },
	      width = 300,
		  height = 240,
          frame_count = 18,
          direction_count = 1,
          shift = util.by_pixel( -1.0, -15.0),
          line_length = 6,
          tint = tint,
          --y = variation * 234,
          scale = scale*0.5
      },
      {
          filename = "__base__/graphics/entity/spawner/spawner-death-shadow-v1.png",
          draw_as_shadow = true,
			width = 480,
			height = 286,
          frame_count = 18,
          direction_count = 1,
          shift = util.by_pixel( -0.5, -0.5),
          line_length = 6,
          -- y = variation * 406,
          scale = scale*0.5
      }
    }
  }
end

