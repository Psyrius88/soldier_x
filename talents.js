var talents = [
    { 
      id: "bloodthirst",
      name: "Bloodthirst",
      icon: "abilityIconString(Hero.JUNKER_QUEEN, Button.ABILITY_1)",
      keybind: '"[Passive]"',
      description: "Heal yourself based on how much damage you dealt during berserker. Overhealed health will decay over a long period of time.",
      comment: "The healing amount is adjusted if the max duration of berserker is increased.",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Healing]",
      cd_reduction_per_rank: 0,
      requires_any_of: ["berserker"],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "purity_field",
      name: "Purity Field",
      icon: "abilityIconString(Hero.BAPTISTE, Button.ABILITY_2)",
      keybind: '"[Press: [CTRL]+[E]]"',
      description: "Activate to exit combat, become immune and increase your healing received. Can not use damage abilities while immune.",
      comment: "",
      cooldown: 45,
      upgrade_information: "[Upgrade: +Duration, +Healing Received]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "cybernetics",
      name: "Cybernetics",
      icon: "abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE)",
      keybind: '"[Passive]"',
      description: "Add permanent shields to your health. Shields regenerate automatically and can't be healed with healing abilities.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Shields]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "engineer",
      name: "Engineer",
      icon: "abilityIconString(Hero.BASTION, Button.ABILITY_1)",
      keybind: '"[Passive]"',
      description: "Gain scrap when dealing damage with your primary fire and picking up xp orbs. When at 100% scrap, turn it into armor.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Charge Rate]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "ignore_pain",
      expand_mind: null,
    },
    { 
      id: "shadowstrike",
      name: "Shadowstrike",
      icon: "abilityIconString(Hero.GENJI, Button.ABILITY_1)",
      keybind: '"[Double Tap: [SPACEBAR]]"',
      description: "Pierce through the shadows and swiftly strike all enemies you sweep through.",
      comment: "Hitting 1 enemy will reduce the cooldown down to 10 sec. Hitting at least 2 enemies will reduce the cooldown down to 0.5 sec.",
      cooldown: 20,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "shadowstep",
      expand_mind: null,
  
    },
    { 
      id: "stealth",
      name: "Stealth",
      icon: "abilityIconString(Hero.SOMBRA, Button.ABILITY_1)",
      keybind: '"[Hold: [CTRL] (Out of Combat)]"',
      description: "Enter stealth when crouching out of combat. Melee from stealth: damage & stun. Targets hit can't heal for 4 sec.",
      comment: "Damage dealing abilities will break stealth.",
      cooldown: 20,
      upgrade_information: "[Upgrade: +Duration, -Cooldown]",
      cd_reduction_per_rank: 4,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "juggernaut",
      name: "Juggernaut",
      icon: "abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)",
      keybind: '"[Press: [F]]"',
      description: "Activate to start sprinting. Hitting a player will stun them and pick them up. Hitting a wall will damage players around you.",
      comment: "When using the ability: Immune to knockback and slows.",
      cooldown: 20,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "fireball",
      expand_mind: null,
    },
    { 
      id: "dive_bomb",
      name: "Dive Bomb",
      icon: "abilityIconString(Hero.HAMMOND, Button.CROUCH)",
      keybind: '"[Press: [CTRL] (While in Air)]"',
      description: "Gain the ability to dive down on players from the air. Targets hit will be knocked away and take damage.",
      comment: "",
      cooldown: 20,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "cryogenics",
      name: "Cryogenics",
      icon: "abilityIconString(Hero.MEI, Button.ULTIMATE)",
      keybind: '"[Press: [RIGHTCLICK]]"',
      description: "Your secondary fire will slow enemies. Affected targets can't use sprint.",
      comment: "Walking speed will gradually go up from the slow amount to 100% over the duration.",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Slow Amount, +Slow Duration]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "railgun",
      name: "Railgun",
      icon: "abilityIconString(Hero.SOJOURN, Button.SECONDARY_FIRE)",
      keybind: '"[Press: [RIGHTCLICK] (When 100% charged)]"',
      description: "Replace your secondary fire with a railgun attachment. Railgun will count as your secondary fire.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: "overclock",
    },
    { 
      id: "predator",
      name: "Predator",
      icon: "abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE)",
      keybind: '"[Press: [MELEE] (On Low Health Targets)]"',
      description: "When the cooldown of predator is ready: Low health targets will light up and your melee will execute them.",
      comment: "",
      cooldown: 40,
      upgrade_information: "[Upgrade: -Cooldown]",
      cd_reduction_per_rank: 6,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: "soul_siphon",
    },
    { 
      id: "jetpack",
      name: "Jetpack",
      icon: "abilityIconString(Hero.DVA, Button.ABILITY_1)",
      keybind: '"[Hold: [SPACEBAR]]"',
      description: "Equip a Jetpack that will let you fly.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Fuel Efficiency]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "lifesteal_ammo",
      name: "Lifesteal Ammo",
      icon: "abilityIconString(Hero.BAPTISTE, Button.SECONDARY_FIRE)",
      keybind: '"[Shoot enemies with: [LEFTCLICK] or [RIGHTCLICK]]"',
      description: "A portion of the damage you deal with primary fire or secondary fire will heal you.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Healing]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "health_regen",
      name: "Health Regen",
      icon: "abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)",
      keybind: '"[Passive]"',
      description: "Passively regenerate health over time. Healing is tripled in stealth. Can not regen health if you are poisoned.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Healing]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "health_potions",
      name: "Health Potions",
      icon: "abilityIconString(Hero.ROADHOG, Button.ABILITY_2)",
      keybind: '"[Press: [E]]"',
      description: "Buy 3 Health Potions. Each potion vial refills one at a time each 15 seconds.",
      comment: "Heals you over 2 seconds and the heal of the each potion stack.",
      cooldown: 15,
      upgrade_information: "[Upgrade: +Healing]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "poison_vials",
      expand_mind: "crazy_alchemist",
    },
    { 
      id: "ignite",
      name: "Ignite",
      icon: "iconString(Icon.FIRE)",
      keybind: '"[Shoot Enemies with: [RIGHTCLICK]]"',
      description: "The damage you deal with secondary fire also deals fire damage over time.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "overclock",
      name: "Overclock",
      icon: "abilityIconString(Hero.TORBJORN, Button.ABILITY_2)",
      keybind: '"[Passive]"',
      description: "Increases the charge amount of your railgun.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Charge Amount]",
      cd_reduction_per_rank: 0,
      requires_any_of: ["railgun"],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "shadowstep",
      name: "Shadowstep",
      icon: "abilityIconString(Hero.MOIRA, Button.ABILITY_1)",
      keybind: '"[Double Tap: [SPACEBAR]]"',
      description: "Step through the shadows, become invisible and dodge attacks against you for 0.5 sec.",
      comment: "XP Orbs resets the cooldown.",
      cooldown: 22.5,
      upgrade_information: "[Upgrade: -Cooldown]",
      cd_reduction_per_rank: 2.5,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "shadowstrike",
      expand_mind: null,
    },
    { 
      id: "burning_soul",
      name: "Burning Soul",
      icon: "abilityIconString(Hero.REAPER, Button.ABILITY_1)",
      keybind: '"[Passive]"',
      description: "Deal fire damage to nearby visible players. The orb you drop on death will explode when picked up or after 4 seconds.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "berserker",
      name: "Berserker",
      icon: "iconString(Icon.SKULL)",
      keybind: '"[Press: [Q]]"',
      description: "Activate to Deal 25% more damage and receive 10% more damage temporarily.",
      comment: "",
      cooldown: 45,
      upgrade_information: "[Upgrade: +Duration]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: "bloodthirst",
    },
    { 
      id: "fireball",
      name: "Fireball",
      icon: "abilityIconString(Hero.PHARAH, Button.ABILITY_1)",
      keybind: '"[Press: [F]]"',
      description: "Install a weapon attachment that will let you launch fireballs.",
      comment: "",
      cooldown: 12,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "juggernaut",
      expand_mind: "pyromaniac",
    },
    { 
      id: "ignore_pain",
      name: "Ignore Pain",
      icon: "abilityIconString(Hero.ZARYA, Button.ABILITY_1)",
      keybind: '"[Passive]"',
      description: "Resist a lot of damage while you are reloading, sprinting or is stunned.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Damage Resistance]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "engineer",
      expand_mind: null,
    },
    { 
      id: "javelin",
      name: "Javelin",
      icon: "abilityIconString(Hero.ORISA, Button.SECONDARY_FIRE)",
      keybind: '"[Passive]"',
      description: "Gain the ability to throw a javelin that deals damage, stuns and knocks back the player hit.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "soul_siphon",
      name: "Soul Siphon",
      icon: "abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)",
      keybind: '"[Passive]"',
      description: "After using predator on a target, stand near the victim to siphon their soul and heal youself over 5 seconds.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Healing]",
      cd_reduction_per_rank: 0,
      requires_any_of: ["predator"],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "pyromaniac",
      name: "Pyromaniac",
      icon: "abilityIconString(Hero.REAPER, Button.ULTIMATE)",
      keybind: '"[Passive]"',
      description: "Your Fireball will heal you if you stand near the explosion radius.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: +Healing]",
      cd_reduction_per_rank: 0,
      requires_any_of: ["fireball"],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
    { 
      id: "poison_vials",
      name: "Poison Vials",
      icon: "iconString(Icon.POISON_2)",
      keybind: '"[Press: [E]]"',
      description: "Targets hit will take damage over time and will be unable to gain the benefit of the talent Health Regen for the duration.",
      comment: "The damage of the vials stack.",
      cooldown: 15,
      upgrade_information: "[Upgrade: +Damage]",
      cd_reduction_per_rank: 0,
      requires_any_of: [],
      is_unique: true,
      conflicts_with: "health_potions",
      expand_mind: "crazy_alchemist",
    },
    { 
      id: "crazy_alchemist",
      name: "Crazy Alchemist",
      icon: "iconString(Icon.RADIOACTIVE)",
      keybind: '"[Passive]"',
      description: "Reduces the cooldown of your Potions or Vials and gives you a chance to pick up another when picking up XP Orbs.",
      comment: "",
      cooldown: -1,
      upgrade_information: "[Upgrade: -Cooldown, +Chance]",
      cd_reduction_per_rank: 1,
      requires_any_of: ["health_potions", "poison_vials"],
      is_unique: false,
      conflicts_with: null,
      expand_mind: null,
    },
  ]
  
  var result = ""
  result += "globalvar is_talent_unique = ["+talents.map(x => x.is_unique)+"]\n"
  result += "globalvar talent_base_cooldowns = ["+talents.map(x => x.cooldown)+"]\n"
  result += "globalvar talent_cd_reduction_p_rank = ["+talents.map(x => x.cd_reduction_per_rank)+"]\n"
  result += "globalvar talent_names = ["+talents.map(x => `"{} [${x.name}]".format(${x.icon})`)+"]\n"
  result += "globalvar talent_descriptions = ["+talents.map(x => JSON.stringify(x.description))+"]\n"
  result += "globalvar upgrade_information = ["+talents.map(x => JSON.stringify(x.upgrade_information))+"]\n"
  result += "globalvar additional_information = ["+talents.map(x => JSON.stringify(x.comment))+"]\n" 
  result += "globalvar talent_information_unique = ["+talents.map(x => x.conflicts_with ? "Talent."+x.conflicts_with.toUpperCase() : "null")+"]\n" 
  result += "globalvar talent_information_expand_mind = ["+talents.map(x => x.expand_mind ? "Talent."+x.expand_mind.toUpperCase() : "null")+"]\n" 
  result += "globalvar talent_requirements = ["+talents.map(x => "["+x.requires_any_of.map(x => "Talent."+x.toUpperCase())+"]")+"]\n"
  result += "globalvar talent_keybinds = ["+talents.map(x => x.keybind)+"]\n"

  
  result