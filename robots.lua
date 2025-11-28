require("stats")
local soundsnew = require("sounds")

function util.insert_mini_corner_icon(main_icon, mini_icon)
  local icons =
  {
    {
      icon = main_icon,
      icon_size = 64, icon_mipmaps = 4
    },
    {
      icon = mini_icon,
      icon_size = 64,
      scale = 0.25,
      shift = {-8, 8}
    }
  }
  return icons
end

data.raw["construction-robot"]["construction-robot"].speed = 0.1
data.raw["logistic-robot"]["logistic-robot"].speed = 0.1


data.raw["construction-robot"]["construction-robot"].trigger_target_mask = {"flying-robot"}
data.raw["construction-robot"]["construction-robot"].resistances =
    {
      {
        type = "fire",
		decrease = 2,
        percent = 95
      },
      {
        type = "acid",
        decrease = 2,
        percent = 95
      }
    }

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local robot_animations = {}

local shadow_shift = {-0.75, -0.40}
local animation_shift = {0, 0}

robot_animations.defender =
{

  idle =
  {
    layers =
    {
      {

          filename = "__base__/graphics/entity/defender-robot/defender-robot.png",
          priority = "high",
          line_length = 16,
          width = 56,
          height = 59,
          frame_count = 1,
          direction_count = 16,
          shift = util.by_pixel(0, 0.25),
          scale = 0.5
        
      },
      {

          filename = "__base__/graphics/entity/defender-robot/defender-robot-mask.png",
          priority = "high",
          line_length = 16,
          width = 28,
          height = 21,
          frame_count = 1,
          direction_count = 16,
          shift = util.by_pixel(0, -4.75),
          apply_runtime_tint = true,
          scale = 0.5
        
      }
    }
  },
  shadow_idle =
  {

      filename = "__base__/graphics/entity/defender-robot/defender-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 88,
      height = 50,
      frame_count = 1,
      direction_count = 16,
      shift = util.by_pixel(25.5, 19),
      scale = 0.5,
      draw_as_shadow = true
    
  },
  in_motion =
  {
    layers =
    {
      {

          filename = "__base__/graphics/entity/defender-robot/defender-robot.png",
          priority = "high",
          line_length = 16,
          width = 56,
          height = 59,
          frame_count = 1,
          animation_speed = 1,
          direction_count = 16,
          shift = util.by_pixel(0, 0.25),
          y = 59,
          scale = 0.5
        
      },
      {

          filename = "__base__/graphics/entity/defender-robot/defender-robot-mask.png",
          priority = "high",
          line_length = 16,
          width = 28,
          height = 21,
          frame_count = 1,
          animation_speed = 1,
          direction_count = 16,
          shift = util.by_pixel(0, -4.75),
          apply_runtime_tint = true,
          y = 21,
          scale = 0.5
        
      }
    }
  },
  shadow_in_motion =
  {

      filename = "__base__/graphics/entity/defender-robot/defender-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 88,
      height = 50,
      frame_count = 1,
      animation_speed = 1,
      direction_count = 16,
      shift = util.by_pixel(25.5, 19),
      scale = 0.5,
      draw_as_shadow = true
    
  }
}

robot_animations.sparks =
{
  {
    filename = "__base__/graphics/entity/sparks/sparks-01.png",
    width = 39,
    height = 34,
    frame_count = 19,
    line_length = 19,
    shift = {-0.109375, 0.3125},
    tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-02.png",
    width = 36,
    height = 32,
    frame_count = 19,
    line_length = 19,
    shift = {0.03125, 0.125},
    tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-03.png",
    width = 42,
    height = 29,
    frame_count = 19,
    line_length = 19,
    shift = {-0.0625, 0.203125},
    tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-04.png",
    width = 40,
    height = 35,
    frame_count = 19,
    line_length = 19,
    shift = {-0.0625, 0.234375},
    tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-05.png",
    width = 39,
    height = 29,
    frame_count = 19,
    line_length = 19,
    shift = {-0.109375, 0.171875},
    tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
    animation_speed = 0.3
  },
  {
    filename = "__base__/graphics/entity/sparks/sparks-06.png",
    width = 44,
    height = 36,
    frame_count = 19,
    line_length = 19,
    shift = {0.03125, 0.3125},
    tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
    animation_speed = 0.3
  }
}

robot_animations.logistic_robot =
{
  idle =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 80,
      height = 84,
      frame_count = 1,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      y = 84,
      scale = 0.5
  
  },
  idle_with_cargo =
  {
 
      filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 80,
      height = 84,
      frame_count = 1,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      scale = 0.5
  
  },
  in_motion =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 80,
      height = 84,
      frame_count = 1,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      y = 252,
      scale = 0.5
 
  },
  in_motion_with_cargo =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
      priority = "high",
      line_length = 16,
      width = 80,
      height = 84,
      frame_count = 1,
      shift = util.by_pixel(0, -3),
      direction_count = 16,
      y = 168,
      scale = 0.5
   
  },
  shadow_idle =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 115,
      height = 57,
      frame_count = 1,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      y = 57,
      scale = 0.5,
      draw_as_shadow = true
 
  },
  shadow_idle_with_cargo =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 115,
      height = 57,
      frame_count = 1,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      scale = 0.5,
      draw_as_shadow = true
   
  },
  shadow_in_motion =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 115,
      height = 57,
      frame_count = 1,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      y = 57*3,
      scale = 0.5,
      draw_as_shadow = true
    
  },
  shadow_in_motion_with_cargo =
  {

      filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 115,
      height = 57,
      frame_count = 1,
      shift = util.by_pixel(31.75, 19.75),
      direction_count = 16,
      y = 114,
      scale = 0.5,
      draw_as_shadow = true
    
  }
}


robot_animations.distractor =
{

  idle =
  {
    layers =
    {
      {
  
          filename = "__base__/graphics/entity/distractor-robot/distractor-robot.png",
          priority = "high",
          line_length = 16,
          width = 72,
          height = 62,
          frame_count = 1,
          direction_count = 16,
          shift = util.by_pixel(0, -2.5),
          scale = 0.5
        
      },
      {

          filename = "__base__/graphics/entity/distractor-robot/distractor-robot-mask.png",
          priority = "high",
          line_length = 16,
          width = 42,
          height = 37,
          frame_count = 1,
          direction_count = 16,
          shift = util.by_pixel(0, -6.25),
          apply_runtime_tint = true,
          scale = 0.5
        
      }
    }
  },
  shadow_idle =
  {

      filename = "__base__/graphics/entity/distractor-robot/distractor-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 96,
      height = 59,
      frame_count = 1,
      direction_count = 16,
      shift = util.by_pixel(32.5, 19.25),
      scale = 0.5,
      draw_as_shadow = true
    
  },
  in_motion =
  {
    layers =
    {
      {

          filename = "__base__/graphics/entity/distractor-robot/distractor-robot.png",
          priority = "high",
          line_length = 16,
          width = 72,
          height = 62,
          frame_count = 1,
          direction_count = 16,
          shift = util.by_pixel(0, -2.5),
          y = 62,
          scale = 0.5
        
      },
      {

          filename = "__base__/graphics/entity/distractor-robot/distractor-robot-mask.png",
          priority = "high",
          line_length = 16,
          width = 42,
          height = 37,
          frame_count = 1,
          direction_count = 16,
          shift = util.by_pixel(0, -6.25),
          apply_runtime_tint = true,
          y = 37,
          scale = 0.5
        
      }
    }
  },
  shadow_in_motion =
  {

      filename = "__base__/graphics/entity/distractor-robot/distractor-robot-shadow.png",
      priority = "high",
      line_length = 16,
      width = 96,
      height = 59,
      frame_count = 1,
      direction_count = 16,
      shift = util.by_pixel(32.5, 19.25),
      scale = 0.5,
      draw_as_shadow = true
    
  }
}

robot_animations.destroyer =
{

  idle =
  {
    layers =
    {
      {

          filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot.png",
          priority = "high",
          line_length = 32,
          width = 88,
          height = 77,
          y = 77,
          frame_count = 1,
          direction_count = 32,
          shift = util.by_pixel(2.5, -1.25),
          scale = 0.5
        
      },
      {

          filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-mask.png",
          priority = "high",
          line_length = 32,
          width = 52,
          height = 42,
          y = 42,
          frame_count = 1,
          direction_count = 32,
          shift = util.by_pixel(2.5, -7),
          apply_runtime_tint = true,
          scale = 0.5
        
      }
    }
  },
  shadow_idle =
  {

      filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-shadow.png",
      priority = "high",
      line_length = 32,
      width = 108,
      height = 66,
      frame_count = 1,
      direction_count = 32,
      shift = util.by_pixel(23.5, 19),
      scale = 0.5,
      draw_as_shadow = true
    
  },
  in_motion =
  {
    layers =
    {
      {

          filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot.png",
          priority = "high",
          line_length = 32,
          width = 88,
          height = 77,
          frame_count = 1,
          direction_count = 32,
          shift = util.by_pixel(2.5, -1.25),
          scale = 0.5
       
      },
      {

          filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-mask.png",
          priority = "high",
          line_length = 32,
          width = 52,
          height = 42,
          frame_count = 1,
          direction_count = 32,
          shift = util.by_pixel(2.5, -7),
          apply_runtime_tint = true,
          scale = 0.5

      }
    }
  },
  shadow_in_motion =
  {
      filename = "__base__/graphics/entity/destroyer-robot/destroyer-robot-shadow.png",
      priority = "high",
      line_length = 32,
      width = 108,
      height = 66,
      frame_count = 1,
      direction_count = 32,
      shift = util.by_pixel(23.5, 19),
      scale = 0.5,
      draw_as_shadow = true
 
  }
}

----------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------  ROBOT CAPSULES  -------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

data:extend
({
 {
    type = "capsule",
    name = "defender-capsule",
    icon = "__base__/graphics/icons/defender.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
		activation_type = "throw",
        ammo_category = "capsule",
        cooldown = robot_deploy_cooldown,
        projectile_creation_distance = 0.6,
        range = robot_deploy_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "defender-capsule",
                starting_speed = 0.3
              }
            },
            {
              type = "direct",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "d[defender-capsule]",
    stack_size = robot_stacksize
  },
  
    {
    type = "capsule",
    name = "disruptor-capsule",
    icons = util.insert_mini_corner_icon("__base__/graphics/icons/distractor.png","__base__/graphics/icons/rocket.png"),
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = robot_deploy_cooldown,
        projectile_creation_distance = 0.6,
        range = robot_deploy_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "disruptor-capsule",
                starting_speed = 0.3
              }
            },
            {
              type = "direct",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "e[defender-capsule]",
    stack_size = robot_stacksize
  },
  
  
  {
    type = "projectile",
    name = "disruptor-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            show_in_tooltip = true,
            entity_name = "disruptor",
            offsets = {{0, 0}}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    enable_drawing_with_mask = true,
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 36,
          height = 30,
          priority = "high"
        },
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-mask.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 36,
          height = 30,
          priority = "high",
          apply_runtime_tint = true
        }
      }
    },
    shadow =
    {
      filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-shadow.png",
      flags = { "no-crop" },
      frame_count = 1,
      width = 40,
      height = 26,
      priority = "high"
    },
    smoke = capsule_smoke
  },
  
  -----------
  
  {
    type = "capsule",
    name = "distractor-capsule",
	icons = util.insert_mini_corner_icon("__base__/graphics/icons/distractor.png","__factorioplus__/graphics/icons/laser.png"),
   --icon =  util.insert_mini_corner_icon("__base__/graphics/icons/distractor.png","__factorioplus_/graphics/icons/laser.png"),
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = robot_deploy_cooldown,
        projectile_creation_distance = 0.6,
        range = robot_deploy_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "distractor-capsule",
                starting_speed = 0.3
              }
            },
            {
              type = "direct",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "e[defender-capsule]",
    stack_size = robot_stacksize
  },
  
  
  {
    type = "projectile",
    name = "distractor-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            show_in_tooltip = true,
            entity_name = "distractor",
            offsets = {{0, 0}}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    enable_drawing_with_mask = true,
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 36,
          height = 30,
          priority = "high"
        },
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-mask.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 36,
          height = 30,
          priority = "high",
          apply_runtime_tint = true
        }
      }
    },
    shadow =
    {
      filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-shadow.png",
      flags = { "no-crop" },
      frame_count = 1,
      width = 40,
      height = 26,
      priority = "high"
    },
    smoke = capsule_smoke
  },
  
    -----------
  
  {
    type = "capsule",
    name = "denier-capsule",
	icons = util.insert_mini_corner_icon("__base__/graphics/icons/distractor.png","__factorioplus__/graphics/icons/magazine-piercing.png"),
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = robot_deploy_cooldown,
        projectile_creation_distance = 0.6,
        range = robot_deploy_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "denier-capsule",
                starting_speed = 0.3
              }
            },
            {
              type = "direct",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "e[defender-capsule]",
    stack_size = robot_stacksize
  },
  
  
  {
    type = "projectile",
    name = "denier-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            show_in_tooltip = true,
            entity_name = "denier",
            offsets = {{0, 0}}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    enable_drawing_with_mask = true,
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 36,
          height = 30,
          priority = "high"
        },
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-mask.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 36,
          height = 30,
          priority = "high",
          apply_runtime_tint = true
        }
      }
    },
    shadow =
    {
      filename = "__base__/graphics/entity/combat-robot-capsule/distractor-capsule-shadow.png",
      flags = { "no-crop" },
      frame_count = 1,
      width = 40,
      height = 26,
      priority = "high"
    },
    smoke = capsule_smoke
  },
  
  ----------
  
  {
    type = "capsule",
    name = "destroyer-capsule",
    icon = "__base__/graphics/icons/destroyer.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = robot_deploy_cooldown,
        projectile_creation_distance = 0.6,
        range = robot_deploy_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "destroyer-capsule",
                starting_speed = 0.3
              }
            },
            {
              type = "direct",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "f[destroyer-capsule]",
    stack_size = robot_stacksize
  },
  
  {
    type = "projectile",
    name = "destroyer-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "create-entity",
          show_in_tooltip = true,
          entity_name = "destroyer",
          offsets = {{0, 0}}
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    enable_drawing_with_mask = true,
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/destroyer-capsule.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 42,
          height = 34,
          priority = "high"
        },
        {
          filename = "__base__/graphics/entity/combat-robot-capsule/destroyer-capsule-mask.png",
          flags = { "no-crop" },
          frame_count = 1,
          width = 42,
          height = 34,
          priority = "high",
          apply_runtime_tint = true
        }
      }
    },
    shadow =
    {
      filename = "__base__/graphics/entity/combat-robot-capsule/destroyer-capsule-shadow.png",
      flags = { "no-crop" },
      frame_count = 1,
      width = 48,
      height = 32,
      priority = "high"
    },
    smoke = capsule_smoke
  },
  
  {
    type = "recipe",
    name = "defender-capsule",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="firearm-magazine", amount=30},
      {type="item", name="electronic-circuit", amount=30},
      {type="item", name="iron-gear-wheel", amount=30}
    },
    results = {{type="item", name="defender-capsule", amount=1}},
  },
  {
    type = "recipe",
    name = "distractor-capsule",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="defender-capsule", amount=1},
	  {type="item", name="laser", amount=20},
      {type="item", name="advanced-circuit", amount=30}
    },
    results = {{type="item", name="distractor-capsule", amount=1}},
  },
   {
    type = "recipe",
    name = "disruptor-capsule",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="defender-capsule", amount=1},
	  {type="item", name="rocket", amount=50},
      {type="item", name="advanced-circuit", amount=30}
    },
    results = {{type="item", name="disruptor-capsule", amount=1}},
  },
  {
    type = "recipe",
    name = "denier-capsule",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="defender-capsule", amount=1},
	  {type="item", name="piercing-rounds-magazine", amount=50},
      {type="item", name="advanced-circuit", amount=30}
    },
    results = {{type="item", name="denier-capsule", amount=1}},
  },
  {
    type = "recipe",
    name = "destroyer-capsule",
    enabled = false,
    energy_required = 60,
    ingredients =
    {
      {type="item", name="distractor-capsule", amount=1},
	  {type="item", name="accumulator", amount=30},
	  {type="item", name="processing-unit", amount=30} 
    },
    results = {{type="item", name="destroyer-capsule", amount=1}},
  },
})

local robots = {

---------------------------------------------------  DEFENDER ROBOT  -------------------------------------------------------


{
    type = "combat-robot",
    name = "defender",
    icon = "__base__/graphics/icons/defender.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map", "not-repairable"},
    resistances =
    {
      {
        type = "fire",
	    decrease = 5,
        percent = 98
      },
      {
        type = "acid",
        decrease = 0,
        percent = 80
      }
    },
    subgroup="capsule",
    order="e-a-a",
    max_health = robot_defender_hp,
	healing_per_tick = 0.1,
    alert_when_damaged = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.1}, {0.1, -1.0}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "defender-robot-explosion",
    time_to_live = robot_lifetime,
    follows_player = true,
    friction = 0.025,
    range_from_player = 6.0,
    speed = robot_defender_speed,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/defender-robot-loop.ogg",
        volume = 0.7
      },
      apparent_volume = 1,
      persistent = true
    },
    destroy_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-entity",
          entity_name = "defender-robot-explosion"
        }
      }
    },
    attack_parameters =
    {
      type = "projectile",
	  ammo_category = "bullet",
      cooldown = firerate_pistol,
      cooldown_deviation = 0.2,
	  damage_modifier = robot_defender_damage_modifier,
      projectile_center = {0, 1},
      projectile_creation_distance = 0.6,
      range = robot_defender_range,
      sound = sounds.defender_gunshot,
      ammo_type =
      {
        category = "bullet",
        action =
        {
          type = "direct",
          action_delivery =
          {
			  {
				-- Bullet trail
				type = "beam",
				beam = "piercing_bullet_trail",
				max_length = 100,
				duration = 2,
				source_offset = {0, -0.0 },
				add_to_shooter = false,
				destroy_with_source_or_target = false
			 },
			  {
				type = "instant",
				source_effects =
				{
				  type = "create-explosion",
				  entity_name = "explosion-gunshot-small"
				},
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "explosion-hit"
				  },
				  {
					type = "damage",
					damage = { amount = bullet_piercing_physical , type = "physical"}
				  },
				  {
					type = "damage",
					damage = { amount = bullet_piercing_piercing , type = "piercing"}
				  },
				}
			  },
          }
        }
      }
    },
    water_reflection = robot_reflection(0.8),
    idle = robot_animations.defender.idle,
    in_motion = robot_animations.defender.in_motion,
    shadow_idle = robot_animations.defender.shadow_idle,
    shadow_in_motion = robot_animations.defender.shadow_in_motion
  },
  
  ---------------------------------------------------  DISTRACTOR ROBOT  -------------------------------------------------------

  {
    type = "combat-robot",
    name = "distractor",
    icon = "__base__/graphics/icons/distractor.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map", "not-repairable"},
    resistances =
    {
       {
        type = "fire",
	    decrease = 5,
        percent = 98
      },
      {
        type = "acid",
        decrease = 0,
        percent = 85
      },
	  {
        type = "laser",
        decrease = 2,
        percent = 55
      },
    },
    subgroup="capsule",
    order="e-a-b",
    max_health = robot_distractor_hp,
	healing_per_tick = 0.2,
    alert_when_damaged = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.1}, {0.1, -1.0}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "distractor-robot-explosion",
    time_to_live = robot_lifetime,
	follows_player = true,
    speed = robot_distractor_speed,
    follows_player = true,
    friction = 0.02,
    range_from_player = 4.0,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/distractor-robot-loop.ogg",
        volume = 0.7
      },
      persistent = true
    },
    destroy_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-entity",
          entity_name = "distractor-robot-explosion"
        }
      }
    },
    attack_parameters =
    {
      type = "beam",
      ammo_category = "laser",
      cooldown = laserbeam_red_firerate * 0.5,
      cooldown_deviation = 0.2,
      damage_modifier = robot_distractor_damage_modifier,
      range = robot_distractor_range,
      sound = make_laser_sounds(),
      ammo_type =
      {
        category = "laser",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "beam",
            beam = "laser-beam",
            max_length = robot_distractor_range,
            duration = laserbeam_red_duration,
            --starting_speed = 0.3
          }
        }
      }
    },
    water_reflection = robot_reflection(1),
    idle = robot_animations.distractor.idle,
    in_motion = robot_animations.distractor.in_motion,
    shadow_idle = robot_animations.distractor.shadow_idle,
    shadow_in_motion = robot_animations.distractor.shadow_in_motion
  },
  
  

  
  
   --------------------------------------------------- DISRUPTOR ROBOT  -------------------------------------------------------

-- names: disruptor, dispenser, disarmer, director, detonator, deterrer, devestator, defiler, disparager, devourer, defamer, defier, denier, denouncer, demolisher
  {
    type = "combat-robot",
    name = "disruptor",
    icon = "__base__/graphics/icons/distractor.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {
	"placeable-player", 
	"player-creation", 
	"placeable-off-grid", 
	"not-on-map", 
	"not-repairable"
	},
    resistances =
    {
		{
        type = "explosion",
        decrease = 15,
        percent = 60
      },
      {
        type = "fire",
	    decrease = 5,
        percent = 98
      },
      {
        type = "acid",
        decrease = 0,
        percent = 85
      },

    },
    subgroup="capsule",
    order="e-a-b",
    max_health = robot_distractor_hp,
	healing_per_tick = 0.25,
    alert_when_damaged = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.1}, {0.1, -1.0}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "distractor-robot-explosion",
    time_to_live = robot_lifetime,
	follows_player = true,
    speed = robot_distractor_speed,
    follows_player = true,
    friction = 0.02,
    range_from_player = 6.0,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/distractor-robot-loop.ogg",
        volume = 0.7
      },
      persistent = true
    },
    destroy_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-entity",
          entity_name = "distractor-robot-explosion"
        }
      }
    },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "rocket",
      cooldown = firerate_rocketlauncher * 2.25,
      cooldown_deviation = 0.1,
      damage_modifier = robot_disruptor_damage_modifier,
	  min_range = robot_disruptor_range/6,
      range = robot_disruptor_range,
      sound = 
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.4,
		  speed = 1.5,
        }
      },
      ammo_type =
		 {
		  category = "rocket",
		  action =
		  {
			type = "direct",
			action_delivery =
			{
			  type = "projectile",
			  projectile = "rocket-disruptor",
			  direction_deviation = 3.14*2,
			  starting_speed = rocket_speed_initial/2,
			  source_effects =
			  {
				type = "create-entity",
				entity_name = "explosion-hit",
			  }
			}
		  }
		},
    },
    water_reflection = robot_reflection(1),
    idle = robot_animations.distractor.idle,
    in_motion = robot_animations.distractor.in_motion,
    shadow_idle = robot_animations.distractor.shadow_idle,
    shadow_in_motion = robot_animations.distractor.shadow_in_motion
  },
  
   --------------------------------------------------- DENIER ROBOT  -------------------------------------------------------

-- names: disruptor, dispenser, disarmer, director, detonator, deterrer, devestator, defiler, disparager, devourer, defamer, defier, denier, denouncer, demolisher
  {
    type = "combat-robot",
    name = "denier",
    icon = "__base__/graphics/icons/distractor.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {
	"placeable-player", 
	"player-creation", 
	"placeable-off-grid", 
	"not-on-map", 
	"not-repairable"
	},
    resistances =
    {
		{
        type = "physical",
        decrease = 4,
        percent = 20
      },
      {
        type = "fire",
	    decrease = 5,
        percent = 98
      },
      {
        type = "acid",
        decrease = 0,
        percent = 85
      },

    },
    subgroup="capsule",
    order="e-a-b",
    max_health = robot_distractor_hp,
	healing_per_tick = 0.25,
    alert_when_damaged = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.1}, {0.1, -1.0}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "distractor-robot-explosion",
    time_to_live = robot_lifetime,
	follows_player = true,
    speed = robot_distractor_speed,
    friction = 0.02,
    range_from_player = 4.0,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/distractor-robot-loop.ogg",
        volume = 0.7
      },
      persistent = true
    },
    destroy_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-entity",
          entity_name = "distractor-robot-explosion"
        }
      }
    },
   attack_parameters =
    {
      type = "projectile",
	  ammo_category = "bullet",
      cooldown = firerate_pistol/2,
      cooldown_deviation = 0.2,
	  damage_modifier = robot_denier_damage_modifier,
      projectile_center = {0, 1},
      projectile_creation_distance = 0.6,
      range = robot_denier_range,
      sound = soundsnew.gun_uzi,
      ammo_type =
      {
        category = "bullet",
        action =
        {
          type = "direct",
          action_delivery =
          {
			  {
				-- Bullet trail
				type = "beam",
				beam = "piercing_bullet_trail",
				max_length = 100,
				duration = 2,
				source_offset = {0, -0.0 },
				add_to_shooter = false,
				destroy_with_source_or_target = false
			 },
			  {
				type = "instant",
				source_effects =
				{
				  type = "create-explosion",
				  entity_name = "explosion-gunshot-small"
				},
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "explosion-hit"
				  },
				  {
					type = "damage",
					damage = { amount = bullet_piercing_physical , type = "physical"}
				  },
				  {
					type = "damage",
					damage = { amount = bullet_piercing_piercing , type = "piercing"}
				  },
				}
			  },
          }
        }
      }
    },
    water_reflection = robot_reflection(1),
    idle = robot_animations.distractor.idle,
    in_motion = robot_animations.distractor.in_motion,
    shadow_idle = robot_animations.distractor.shadow_idle,
    shadow_in_motion = robot_animations.distractor.shadow_in_motion
  },

  ---------------------------------------------------  DESTROYER ROBOT  -------------------------------------------------------
  
  {
    type = "combat-robot",
    name = "destroyer",
    icon = "__base__/graphics/icons/destroyer.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map", "not-repairable"},
    resistances =
    {
      {
        type = "fire",
	    decrease = 5,
        percent = 98
      },
      {
        type = "acid",
        decrease = 0,
        percent = 90
      }
    },
    subgroup="capsule",
    order="e-a-c",
    max_health = robot_destroyer_hp,
	healing_per_tick = 0.3,
    alert_when_damaged = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
    hit_visualization_box = {{-0.1, -1.4}, {0.1, -1.3}},
    damaged_trigger_effect = hit_effects.flying_robot(),
    dying_explosion = "destroyer-robot-explosion",
    time_to_live = robot_lifetime ,
    speed = robot_destroyer_speed,
    follows_player = true,
    friction = 0.015,
    range_from_player = 6.0,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/destroyer-robot-loop.ogg",
        volume = 0.7
      },
      persistent = true
    },
    destroy_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-entity",
          entity_name = "destroyer-robot-explosion"
        }
      }
    },
    attack_parameters =
    {
      type = "beam",
      ammo_category = "beam",
      cooldown = laserbeam_electric_firerate,
      cooldown_deviation = 0.2,
	  damage_modifier = robot_destroyer_damage_modifier,
      range = robot_destroyer_range,
      sound = make_laser_sounds(),
      ammo_type =
      {
        category = "beam",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "beam",
            beam = "electric-beam",
            max_length = robot_destroyer_range,
            duration = laserbeam_electric_duration,
            source_offset = {0.15, -0.5}
          }
        }
      }
    },
    water_reflection = robot_reflection(1.2),
    idle = robot_animations.destroyer.idle,
    in_motion = robot_animations.destroyer.in_motion,
    shadow_idle = robot_animations.destroyer.shadow_idle,
    shadow_in_motion = robot_animations.destroyer.shadow_in_motion
  }

}
	
data:extend(robots)


 data:extend({
  {
    type = "projectile",
    name = "rocket-disruptor",
    flags = {"not-on-map"},
    acceleration = rocket_speed_acceleration,
    turn_speed = 0.0006,
    turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
	  {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion",
			only_when_visible = true
          },
          {
            type = "damage",
            damage = {amount = rocket_damage_physical, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark-tintable",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 1.5 -- large radius for demostrative purposes
          },
		  
		  {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = rocket_radius/2,
			  show_in_tooltip = true,
			  force = "not-same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = rocket_damage_explosive, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            },
		  },
		  
		  {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = (rocket_radius/2)/friendly_fire_radius_reduction_factor,
			  show_in_tooltip = false,
			  force = "same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = rocket_damage_explosive * friendly_fire_modifier, type = "explosion"}
                  },
                }
              }
            },
		  },

        }
      }
	  },
	  {
		  type = "area",
		  radius = rocket_radius,
		  show_in_tooltip = true,
		  force = "not-same",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = rocket_damage_explosive/4, type = "explosion"}
				},
				{
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 2.5,
				repeat_count = 1 * 2 * 4
				},
			}
		  }
       },
	   {
		  type = "area",
		  radius = rocket_radius/friendly_fire_radius_reduction_factor,
		  show_in_tooltip = false,
		  force = "same",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = (rocket_damage_explosive/4) * friendly_fire_modifier, type = "explosion"}
				},
			}
		  }
       },
    },
    light = {intensity = 0.5, size = 2},
    animation = 
	{
      layers = {
        util.sprite_load("__base__/graphics/entity/rocket/rocket", {
          scale = 0.25,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high"
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-tinted-tip", {
          scale = 0.25,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high",
          tint = {1, 0.8, 0.3}
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-lights", {
          blend_mode = "additive",
          draw_as_glow = true,
          scale = 0.25,
          frame_count = 8,
          rotate_shift = true,
          priority = "high",
        }),
      }
    },
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "corpse",
    name = "disruptor-remnants",
    icon = "__base__/graphics/icons/distractor.png",
    flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
    hidden_in_factoriopedia = true,
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    subgroup = "remnants",
    order="d[remnants]-a[generic]-a[small]",
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet (3,
    {
      filename = "__base__/graphics/entity/distractor-robot/remnants/distractor-robot-remnants.png",
      line_length = 1,
      width = 112,
      height = 110,
      direction_count = 1,
      shift = util.by_pixel(-0.5, 0),
      scale = 0.5
    })
  },
  
    {
    type = "corpse",
    name = "denier-remnants",
    icon = "__base__/graphics/icons/distractor.png",
    flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
    hidden_in_factoriopedia = true,
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    subgroup = "remnants",
    order="d[remnants]-a[generic]-a[small]",
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet (3,
    {
      filename = "__base__/graphics/entity/distractor-robot/remnants/distractor-robot-remnants.png",
      line_length = 1,
      width = 112,
      height = 110,
      direction_count = 1,
      shift = util.by_pixel(-0.5, 0),
      scale = 0.5
    })
  },
  
 })
  

local adjust_animation = function(animation)

  local animation = util.copy(animation)
  local layers = animation.layers or {animation}

  for k, layer in pairs (layers) do

    layer.frame_count = layer.direction_count
    layer.direction_count = 0
    layer.animation_speed = 1
    layer.shift = util.add_shift(layer.shift, animation_shift)

    if layer.hr_version then
      layer.hr_version.frame_count = layer.hr_version.direction_count
      layer.hr_version.direction_count = 0
      layer.hr_version.animation_speed = 1
      layer.hr_version.shift = util.add_shift(layer.hr_version.shift, animation_shift)
    end

  end

  return animation
end

local adjust_shadow = function(shadow_animation)

  local shadow_animation = util.copy(shadow_animation)
  local layers = shadow_animation.layers or {shadow_animation}

  for k, layer in pairs (layers) do

    layer.frame_count = layer.direction_count
    layer.direction_count = 0
    layer.animation_speed = 1
    layer.shift = util.add_shift(layer.shift, shadow_shift)

    if layer.hr_version then
      layer.hr_version.frame_count = layer.hr_version.direction_count
      layer.hr_version.direction_count = 0
      layer.hr_version.animation_speed = 1
      layer.hr_version.shift = util.add_shift(layer.hr_version.shift, shadow_shift)
    end

  end

  return shadow_animation
end

local reversed = function(animation)
  local animation = util.copy(animation)
  local layers = animation.layers or {animation}

  for k, layer in pairs (layers) do
    layer.run_mode = "backward"
    if layer.hr_version then
      layer.hr_version.run_mode = "backward"
    end
  end

  return animation
end

local make_robot_particle = function(prototype)

  local particle_name = prototype.name.."-dying-particle"

  local animation = adjust_animation(prototype.in_motion)
  local shadow_animation = adjust_shadow(prototype.shadow_in_motion)

  local particle =
  {
    type = "optimized-particle",
    name = particle_name,
    pictures = {animation, reversed(animation)},
    shadows = {shadow_animation, reversed(shadow_animation)},
    movement_modifier = 0.95,
    life_time = 1000,
    regular_trigger_effect_frequency = 2,
    regular_trigger_effect =
    {
      {
        type = "create-trivial-smoke",
        smoke_name = "smoke-fast",
        starting_frame_deviation = 5,
        probability = 0.5
      },
      {
        type = "create-particle",
        particle_name = "spark-particle",
        tail_length = 10,
        tail_length_deviation = 5,
        tail_width = 5,
        probability = 0.2,
        initial_height = 0.2,
        initial_vertical_speed = 0.15,
        initial_vertical_speed_deviation = 0.05,
        speed_from_center = 0.1,
        speed_from_center_deviation = 0.05,
        offset_deviation = {{-0.25, -0.25},{0.25, 0.25}}
      }
    },
    ended_on_ground_trigger_effect =
    {
      {
      type = "create-entity",
      entity_name = prototype.name.."-remnants",
      offsets = {{0, 0}}
      },
      {
        type = "play-sound",
        sound = sounds.robot_die_impact,
      },
    }
  }

  data:extend{particle}

  prototype.dying_trigger_effect =
  {
    {
      type = "create-particle",
      particle_name = particle_name,
      initial_height = 1.8,
      initial_vertical_speed = 0,
      frame_speed = 1,
      frame_speed_deviation = 0.5,
      speed_from_center = 0,
      speed_from_center_deviation = 0.2,
      offset_deviation = {{-0.01, -0.01},{0.01, 0.01}},
      offsets = {{0, 0.5}}
    },
    {
      type = "play-sound",
      sound = sounds.robot_die_whoosh,
    },
    {
      type = "play-sound",
      sound = sounds.robot_die_vox,
    },
  }

  if prototype.type == "construction-robot" or prototype.type == "logistic-robot" then return end

  prototype.destroy_action =
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      source_effects =
      {
        {
          type = "create-particle",
          particle_name = particle_name,
          initial_height = 1.8,
          initial_vertical_speed = 0,
          frame_speed = 0.5,
          frame_speed_deviation = 0.5,
          speed_from_center = 0,
          speed_from_center_deviation = 0.1,
          offset_deviation = {{-0.01, -0.01},{0.01, 0.01}},
          offsets = {{0, 0.5}}
        },
        {
          type = "play-sound",
          sound = sounds.robot_die_whoosh,
        },
        {
          type = "play-sound",
          sound = sounds.robot_die_vox,
        },
        {
          type = "play-sound",
          sound = sounds.robot_selfdestruct,
        },
      }
    }
  }

end

for k, robot in pairs (robots) do
  make_robot_particle(robot)
end

