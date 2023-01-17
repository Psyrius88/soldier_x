settings {
    "main": {
        "description": "Discover new ways to play with Soldier: 76! Level up and choose talents that change the way you play. Some talent examples: Sneak around in Stealth - Blast other players with Fireball - Heal yourself with Healing Potions -------------------------------- Big thanks to everyone that has helped me in the Elo Hell Workshops Discord. This wouldn't be possible without you guys!",
        "modeName": "Soldier: X [v2.625]"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "ffaSlots": 8,
        "spectatorSlots": 1,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "ffa": {
            "disabledMaps": [
                "castillo",
                "havana",
                "lijiangControlCenter",
                "lijiangGarden",
                "lijiangNightMarket",
                "route66",
                "workshopChamber",
                "workshopExpanse",
                "workshopGreenScreen",
                "workshopIsland"
            ]
        },
        "general": {
            "enableHeroSwitching": false,
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableKillFeed": false,
            "scoreToWin": 100,
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "brigitte": {
                "enableAbility2": false,
                "combatUltGen%": 175,
                "passiveUltGen%": 175,
                "ultGen%": 175,
                "ability1Kb%": 25
            },
            "reaper": {
                "damageDealt%": 50,
                "enableUlt": false
            },
            "reinhardt": {
                "secondaryFireCooldown%": 50,
                "ability1Cooldown%": 25,
                "combatUltGen%": 180,
                "passiveUltGen%": 180,
                "ultGen%": 180
            },
            "soldier": {
                "combatUltGen%": 0,
                "passiveUltGen%": 0,
                "ultGen%": 10
            },
            "winston": {
                "ultDuration%": 500,
                "combatUltGen%": 0,
                "passiveUltGen%": 0,
                "ultGen%": 10
            },
            "hammond": {
                "ability3Cooldown%": 25,
                "enableRollOnly": true
            },
            "zarya": {
                "enableAbility1": false,
                "combatUltGen%": 250,
                "passiveUltGen%": 250,
                "ultGen%": 250
            },
            "enabledHeroes": [
                "soldier"
            ]
        }
    }
}

#Global variables
globalvar talent_names 4
globalvar unique_talents 5
globalvar always_available_talents 6
globalvar talent_descriptions 7
globalvar orb_rarity_colors 8
globalvar talent_rarity_colors 9
globalvar xp_orb_locations 10
globalvar xp_orb_effects 11
globalvar antiCrashActivated 12
globalvar xp_orb_values 13
globalvar xp_orb_mines 14
globalvar dummy_bot_spawn_position 15
globalvar dummy_bot_spawn_facing 16
globalvar upgrade_information 17
globalvar amount_of_dummy_bots 19
globalvar vote_cooldown 22
globalvar lifesteal_total_healing 33
globalvar lifesteal_time_in_combat 34
globalvar health_regen_total_healing 36
globalvar health_regen_time_in_combat 37
globalvar health_potions_total_healing 38
globalvar health_potions_time_in_combat 39
globalvar ignore_pain_total_resisted 40
globalvar ignore_pain_time_in_combat 41
globalvar additional_information 43
globalvar pathfinding_positions 45
globalvar pathfinding_connections 46
globalvar talent_information_unique 48
globalvar talent_information_expand_mind 49
globalvar xp_code 50
globalvar endless_mode 18
globalvar match_is_in_showdown 28
globalvar player_who_started_vote 27
globalvar players_that_voted_yes 21
globalvar players_that_voted_no 25
globalvar someone_is_voting_to_change_map 20

#Player variables

playervar pathfinding_pos_pre_current_next 11
playervar which_unique_talents_unlocked 15
playervar juggernaut_cooldown 27
playervar dive_bomb_cooldown 30
playervar is_electrified 39
playervar poison_vial_effects 40
playervar juggernaut_charge 68
playervar time_since_poison_vial_exploded 76
playervar player_name 87
playervar luck 92
playervar typing_in_xp_code 94
playervar code_cooldown 96
playervar poison_vial_clouds_spawned 98
playervar cloudData 99
playervar indexMemory 101
playervar interactablePlayers 105
playervar javelin_middle_position 107
playervar health_potion_cooldown_memory 108
playervar projPos 109
playervar projPosIn0032 110
playervar healing_done_in_combat 119
playervar xp_orb_destination 124
playervar dropped_xp_orb 125
playervar replace_replacing_or_cancelled 47
playervar talents_you_do_not_have 43
playervar bought_and_upgraded_talents 13
playervar player_temp_effects 25
playervar browsing_shop 0
playervar is_using_ability 28
playervar talent_counter_or_position_etc 12
playervar in_combat 20
playervar stats 24
playervar possible_talents 7
playervar stealth_cooldown 26
playervar offered_talents_in_shop 3
playervar selected_talent 1
playervar bought_talents 6
playervar is_using_hearthstone 60
playervar amount_of_potions_or_vials 35
playervar amount_of_talents_purchased 8
playervar xp_boost_is_active 72
playervar can_enter_shop 18
playervar experience_current 85
playervar experience_max 93
playervar skipped_a_talent 32
playervar random_integer_between_0_to_5 4
playervar canVote_hasVoted_canStartVote 31
playervar time_since_joined_match 23
playervar using_one_of_the_hearthstones 95

#Subroutine names

subroutine create_talent_hud_texts 3
subroutine create_talent_helpers 4
subroutine If_map 27
subroutine juggernaut_effects 47
subroutine start_pathfinding 56
subroutine map_black_forest 57
subroutine map_blizzard_world 58
subroutine map_chateau_guillard 60
subroutine map_antarctica 62
subroutine map_eichenwalde 63
subroutine map_hollywood 64
subroutine map_kanezaka 65
subroutine map_kings_row 66
subroutine map_malevento 67
subroutine map_paris 68
subroutine map_petra 69
subroutine map_necropolis 70
subroutine bloodthirst_effects 71
subroutine shadowstrike 73
subroutine dropped_burning_soul_orb 74
subroutine replace_talent 75
subroutine juggernaut_knockback 78
subroutine juggernaut_impulse_sound_cd 79
subroutine cancel_juggernaut 80
subroutine cancel_shop_camera 81
subroutine new_reaper_pathfinding 83
subroutine dropped_xp_orb 85
subroutine break_stealth 1
subroutine using_one_of_the_hearthstones 82
subroutine stopped_using_hearthstone 84
subroutine spawned_with_fireball 46

#Activated extensions

#!extension buffStatusEffects
#!extension debuffStatusEffects
#!extension energyExplosionEffects
#!extension kineticExplosionEffects
#!extension explosionSounds
#!extension buffAndDebuffSounds

#!include "bots.opy"
#!include "endless_mode.opy"
#!include "xp.opy"
#!include "shop.opy"
#!include "talents.opy"

rule "GENERAL - - - Global Variables":
    disableInspector()
    endless_mode = createWorkshopSetting(bool, "Endless Mode", "Endless Mode (Not recommended)", false, 0)
    spawn_bots = createWorkshopSetting(bool, "Bots", "Spawn bots (Recommended)", true, 0)
    amount_of_dummy_bots = 0
    If_map()
    createInWorldText(localPlayer if localPlayer.browsing_shop == true else null, "YES {0}                        {2} NO".format(buttonString(Button.PRIMARY_FIRE), null, buttonString(Button.SECONDARY_FIRE)) if (someone_is_voting_to_change_map == true and localPlayer.canVote_hasVoted_canStartVote[1] == false and map_is_changing == false or localPlayer.replace_replacing_or_cancelled[0] == true) == true else "{0}            {1}            {2}".format(buttonString(Button.PRIMARY_FIRE) if localPlayer.replace_replacing_or_cancelled[1] == true else buttonString(Button.PRIMARY_FIRE) if localPlayer.selected_talent[0] >= 1 and localPlayer.amount_of_talents_purchased < 25 else "    ", buttonString(Button.INTERACT), buttonString(Button.SECONDARY_FIRE) if localPlayer.replace_replacing_or_cancelled[1] == true else buttonString(Button.SECONDARY_FIRE) if localPlayer.selected_talent[0] <= 1 and localPlayer.amount_of_talents_purchased < 25 else "    "), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 0.375, 0), 1.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    orb_rarity_colors = [Color.WHITE, Color.GREEN, Color.BLUE, Color.PURPLE, Color.ORANGE, Color.RED]
    talent_rarity_colors = [Color.WHITE, Color.WHITE, Color.GREEN, Color.BLUE, Color.PURPLE, Color.ORANGE]
    xp_orb_locations = [null, null, null, null, null, null, null, null]
    xp_orb_effects = [null, null, null, null, null, null, null, null]
    xp_orb_values = [null, null, null, null, null, null, null, null]
    xp_orb_mines = [null, null, null, null, null, null, null, null]
    async(create_talent_hud_texts, AsyncBehavior.NOOP)
    async(create_talent_helpers, AsyncBehavior.NOOP)
    unique_talents = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, true, true, true, true]
    always_available_talents = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
    talent_names = ["{0} [Bloodthirst]".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1)), "{0} [Purity Field]".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_2)), "{0} [Cybernetics]".format(abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE)), "{0} [Engineer]".format(abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE)), "{0} [Shadowstrike]".format(abilityIconString(Hero.GENJI, Button.ABILITY_1)), "{0} [Stealth]".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_1)), "{0} [Juggernaut]".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), "{0} [Dive Bomb]".format(abilityIconString(Hero.HAMMOND, Button.CROUCH)), "{0} [Cryogenics]".format(abilityIconString(Hero.MEI, Button.ULTIMATE)), "{0} [Railgun]".format(abilityIconString(Hero.ECHO, Button.ABILITY_2)), "{0} [Predator]".format(abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE)), "{0} [Jetpack]".format(abilityIconString(Hero.DVA, Button.ABILITY_1)), "{0} [Lifesteal Ammo]".format(abilityIconString(Hero.BAPTISTE, Button.SECONDARY_FIRE)), "{0} [Health Regen]".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), "{0} [Health Potions]".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_2)), "{0} [Start a Showdown & Change Map?]".format(iconString(Icon.RECYCLE)), "{0} [Ignite]".format(iconString(Icon.FIRE)), "{0} [Overclock]".format(abilityIconString(Hero.TORBJORN, Button.ABILITY_2)), "{0} [Shadowstep]".format(abilityIconString(Hero.MOIRA, Button.ABILITY_1)), "{0} [Burning Soul]".format(abilityIconString(Hero.REAPER, Button.ABILITY_1)), "{0} [Berserker]".format(iconString(Icon.SKULL)), "{0} [Fireball]".format(abilityIconString(Hero.PHARAH, Button.ABILITY_1)), "{0} [Ignore Pain]".format(abilityIconString(Hero.ZARYA, Button.ABILITY_1)), "{0} [Are you sure you want to replace one of your talents?]".format(iconString(Icon.WARNING)), "{0} [What talent would you like to replace?]".format(iconString(Icon.WARNING)), "{0} [Weird Flex]".format(abilityIconString(Hero.ZARYA, Button.ULTIMATE)), "{0} [For Glory!]".format(abilityIconString(Hero.REINHARDT, Button.ULTIMATE)), "{0} [Mace to the Face!]".format(abilityIconString(Hero.BRIGITTE, Button.ABILITY_1)), "{0} [Pinball!]".format(abilityIconString(Hero.HAMMOND, Button.ABILITY_1)), "{0} [Soul Siphon]".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)), "{0} [Pyromaniac]".format(abilityIconString(Hero.REAPER, Button.ULTIMATE)), "{0} [Poison Vials]".format(iconString(Icon.POISON_2)), "{0} [Crazy Alchemist]".format(iconString(Icon.RADIOACTIVE))]
    talent_descriptions = ["Heal yourself based on how much damage you dealt during berserker. Overhealed health will decay over a long period of time.", "Activate to exit combat, become immune and increase your healing received. Can not use damage abilities while immune.", "Add permanent shields to your health. Shields regenerate automatically and can't be healed with healing abilities.", "Gain scrap when dealing damage with your primary fire and picking up xp orbs. When at 100% scrap, turn it into armor.", "Pierce through the shadows and swiftly strike all enemies you sweep through.", "Enter stealth when crouching out of combat. Melee from stealth: damage & stun. Targets hit can't heal for 4 sec.", "Activate to start charging. Hitting a player will stun them and pick them up. Hitting a wall will damage players around you.", "Gain the ability to dive down on players from the air. Targets hit will be knocked away and take damage.", "Your secondary fire will slow enemies", "Replace your secondary fire with a railgun attachment. Railgun will count as your secondary fire.", "When the cooldown of predator is ready: Low health targets will light up and your melee will execute them.", "Equip a Jetpack that will let you fly.", "The damage you deal with primary fire or secondary fire will heal you.", "Passively regenerate health over time. Healing is tripled in stealth. Can not regen health if you are poisoned.", "Buy 3 Health Potions. Each potion vial refills one at a time after 15 seconds.", "Gain the ability to activate immunity. You can't use your gun while immune. Healing and movement abilities are still possible.", "The damage you deal with secondary fire also deals fire damage over time.", "Increases the charge amount of your railgun.", "Step through the shadows, become invisible and dodge attacks against you for 0.5 sec.", "Deal fire damage to nearby visible players. The orb you drop on death will explode when picked up or after 4 seconds.", "Activate to Deal 25% more damage and receive 10% more damage temporarily.", "Install a weapon attachment that will let you launch fireballs.", "Resist a lot of damage while you are reloading, sprinting or is stunned. Also works during Juggernaut.", "Winston is raging again for some reason...", "Roadhog is hungry. Very hungry. He really needs food fast!", "Zarya doesn't feel people appreciate her biceps enough. It's time to flex on them haters!", "Reinhardt thinks you are all just standing around. Let him show you the path to glory!", "Brigitte has borrowed Jetpack Cat's Jetpack and would like to try it out", "Hammond would like to play some pinball...", "After using predator on a target, stand near the victim to siphon their soul and heal youself over 5 seconds.", "Your Fireball will heal you if you stand near the explosion radius.", "Targets hit will take damage over time and will be unable to gain the benefit of the talent Health Regen for the duration.", "Reduces the cooldown of your Potions or Vials and gives you a chance to pick up another when picking up XP Orbs."]
    leave_shop_messages = ["Latest patch notes at: workshop.codes/ZEKK3", "Got any feedback? Join the Discord!", "Got an idea for a new talent? Join the Discord!", "Want to show your support? Click the {0} at: workshop.codes/ZEKK3".format(iconString(Icon.HEART)), "Found a bug? Join the Discord!", "Want to help the community grow? Join the Discord!"]
    chase(vote_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    map_is_changing = false
    players_that_voted_yes = []
    players_that_voted_no = []
    someone_is_voting_to_change_map = false
    max_experience_per_level = [250, 275, 303, 333, 366, 403, 443, 487, 536, 589, 648, 713, 785, 863, 949, 1044, 1149, 1264, 1390, 1529, 1682, 1850, 2035, 2239, 2462, 2709]
    match_is_in_showdown = false
    chase(vote_to_change_map_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    additional_information = ["The healing amount is adjusted if the max duration of berserker is increased.", "", "", "", "Hitting 1 enemy will reduce the cooldown by half. Hitting at least 2 enemies will reduce the cooldown to 1 sec.", "", "When using the ability: Immune to knockback and slows.", "", "Walking speed will gradually go up from the slow amount to 100% over the duration.", "", "", "", "", "", "The healing of the potions stack.", null, "", "", "XP Orbs resets the cooldown.", "", "", "", "", null, null, null, null, null, null, "", "", "The damage of the vials stack.", ""]
    #Additional Talent Descriptions
    createInWorldText(localPlayer if localPlayer.browsing_shop == true and localPlayer.replace_replacing_or_cancelled[0] == false and localPlayer.replace_replacing_or_cancelled[1] == false and someone_is_voting_to_change_map == false else null, "Hold {0} for more information...".format(buttonString(Button.JUMP)) if localPlayer.isHoldingButton(Button.JUMP) == false else "{0}".format(additional_information[talent_names.index(localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]])]), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.25, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    talent_information_unique = ["", "", "", "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[22]), "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[18]), "", "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[21]), "", "", "", "", "", "", "", "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[31]), null, "", "", "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[4]), "", "", "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[6]), "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[3]), null, null, null, null, null, null, "", "", "[Unique]: You can not learn {0} when you learn this ability.".format(talent_names[14]), ""]
    talent_information_expand_mind = ["", "", "", "", "", "", "", "", "", "[Expand Mind]: Learning this ability allows you to also learn {0}".format(talent_names[17]), "[Expand Mind]: Learning this ability allows you to also learn {0}".format(talent_names[29]), "", "", "", "[Expand Mind]: Learning this ability allows you to also learn {0}".format(talent_names[32]), null, "", "", "", "", "[Expand Mind]: Learning this ability allows you to also learn {0}".format(talent_names[0]), "[Expand Mind]: Learning this ability allows you to also learn {0}".format(talent_names[30]), "", null, null, null, null, null, null, "", "", "[Expand Mind]: Learning this ability allows you to also learn {0}".format(talent_names[32]), ""]
    #Talent Information Unique
    createInWorldText(localPlayer if (localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.JUMP) == true and localPlayer.replace_replacing_or_cancelled[0] == false and localPlayer.replace_replacing_or_cancelled[1] == false and localPlayer.canVote_hasVoted_canStartVote[1] == true) == true else null, "{0}".format(talent_information_unique[talent_names.index(localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]])]), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.5, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    #Talent Information Expand Mind
    createInWorldText(localPlayer if (localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.JUMP) == true and localPlayer.replace_replacing_or_cancelled[0] == false and localPlayer.replace_replacing_or_cancelled[1] == false and localPlayer.canVote_hasVoted_canStartVote[1] == true) == true else null, "{0}".format(talent_information_expand_mind[talent_names.index(localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]])]), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.375, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(localPlayer if (localPlayer.browsing_shop == true and localPlayer.replace_replacing_or_cancelled[0] == false and localPlayer.replace_replacing_or_cancelled[1] == false and localPlayer.canVote_hasVoted_canStartVote[1] == true) == true and localPlayer.isHoldingButton(Button.JUMP) == true else null, "Rank {0}: Amount healed: {1}% of the damage you dealt during {2}.".format(localPlayer.bought_and_upgraded_talents[0] + 1, round((100 * (0.187 + ((localPlayer.bought_and_upgraded_talents[0] + 1) * 0.063))) * (2.25 - ((localPlayer.bought_and_upgraded_talents[20] + 1) * 0.25))), talent_names[20]) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[0] else "Rank {0}: Duration: {1} sec, {2}".format(localPlayer.bought_and_upgraded_talents[1] + 1, 3.75 + ((localPlayer.bought_and_upgraded_talents[1] + 1) * 1.25), "Healing Received: {0}%, Cooldown: {1} sec.".format(125 + ((localPlayer.bought_and_upgraded_talents[1] + 1) * 25), 45)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[1] else "Rank {0}: Total Shields: {1}.".format(localPlayer.bought_and_upgraded_talents[2] + 1, 40 * (localPlayer.bought_and_upgraded_talents[1] + 1)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[2] else "Rank {0}: Charge Rate: {1}% of the damage you deal with primary fire, Total Armor Repaired: 100.".format(localPlayer.bought_and_upgraded_talents[3] + 1, round(100 * (0.037 + ((localPlayer.bought_and_upgraded_talents[3] + 1) * 0.013)))) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[3] else "Rank {0}: Damage: {1}, Cooldown without hitting any targets: 20 sec.".format(localPlayer.bought_and_upgraded_talents[4] + 1, round(56.25 + ((localPlayer.bought_and_upgraded_talents[4] + 1) * 18.75))) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[4] else "Rank {0}: Duration: {1} sec, {2}.".format(localPlayer.bought_and_upgraded_talents[5] + 1, round(10 + ((localPlayer.bought_and_upgraded_talents[5] + 1) * 2)), "Cooldown: {0} sec, Anti Healing Duration: 4 sec, Damage: 50.".format(20 - ((localPlayer.bought_and_upgraded_talents[5] + 1) * 4))) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[5] else "Rank {0}: Damage: {1}, Cooldown: 20 sec, Charge Duration: 10 sec, Stun Duration: Charge duration + 1.5 sec.".format(localPlayer.bought_and_upgraded_talents[6] + 1, 125 + ((localPlayer.bought_and_upgraded_talents[6] + 1) * 25)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[6] else "Rank {0}: Damage: {1}, Cooldown: 20 sec.".format(localPlayer.bought_and_upgraded_talents[7] + 1, 125 + ((localPlayer.bought_and_upgraded_talents[7] + 1) * 25)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[7] else "Rank {0}: Slow Amount: {2}%, Slow Duration: {1} sec.".format(localPlayer.bought_and_upgraded_talents[7] + 1, 2 + ((localPlayer.bought_and_upgraded_talents[8] + 1) * 0.2), 50 + ((localPlayer.bought_and_upgraded_talents[8] + 1) * 10)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[8] else "Rank {0}: Damage {1}, Charge Rate: {2}% of the damage you deal with primary fire.".format(localPlayer.bought_and_upgraded_talents[9] + 1, 81.25 + ((localPlayer.bought_and_upgraded_talents[9] + 1) * 18.75), 100 * 0.375) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[9] else "Rank {0}: Cooldown: {1}, Execution range: <25% Health.".format(localPlayer.bought_and_upgraded_talents[10] + 1, 40 - ((localPlayer.bought_and_upgraded_talents[10] + 1) * 6)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[10] else "Rank {0}: Time to deplete fuel from 100-0%: {1} sec, Time to recharge fuel from 0-100%: 10 sec.".format(localPlayer.bought_and_upgraded_talents[11] + 1, 4 + ((localPlayer.bought_and_upgraded_talents[11] + 1) * 1.2)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[11] else "Rank {0}: Healing: {1}% of damage you deal with primary or secondary fire.".format(localPlayer.bought_and_upgraded_talents[12] + 1, (11.2 + ((localPlayer.bought_and_upgraded_talents[12] + 1) * 3.8)) / 100) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[12] else "Rank {0}: Healing: {1}/sec.".format(localPlayer.bought_and_upgraded_talents[13] + 1, 4.5 + ((localPlayer.bought_and_upgraded_talents[13] + 1) * 0.9)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[13] else "Rank {0}: Healing: {1}/potion. Potion Recharge: 15 sec.".format(localPlayer.bought_and_upgraded_talents[14] + 1, 43.75 + ((localPlayer.bought_and_upgraded_talents[14] + 1) * 17.5)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[14] else "Rank {0}: Damage: {1}-{2}. Cooldown: 6 sec.".format(localPlayer.bought_and_upgraded_talents[16] + 1, floor(((localPlayer.bought_and_upgraded_talents[16] + 1) * 0.168) * 40), floor(((localPlayer.bought_and_upgraded_talents[16] + 1) * 0.168) * 120)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[16] else "Rank {0}: Additional Charge Rate: {1}% of the damage you deal with primary fire.".format(localPlayer.bought_and_upgraded_talents[17] + 1, 100 * localPlayer.bought_and_upgraded_talents[17] * 0.075) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[17] else "Rank {0}: Cooldown: {1} sec.".format(localPlayer.bought_and_upgraded_talents[18] + 1, 22.5 - ((localPlayer.bought_and_upgraded_talents[18] + 1) * 2.5)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[18] else "Rank {0}: Damage: {1}, Orb Damage: {2}.".format(localPlayer.bought_and_upgraded_talents[19] + 1, 12 + ((localPlayer.bought_and_upgraded_talents[19] + 1) * 2.4), 75 + ((localPlayer.bought_and_upgraded_talents[19] + 1) * 25)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[19] else "Rank {0}: Duration: {1}, Cooldown: 45 sec, Damage Done: 125%, Damage Taken: 110%.".format(localPlayer.bought_and_upgraded_talents[20] + 1, 3.75 + ((localPlayer.bought_and_upgraded_talents[20] + 1) * 1.25)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[20] else "Rank {0}: Damage: {1}, Cooldown: 12 sec, Radius: 4m.".format(localPlayer.bought_and_upgraded_talents[21] + 1, 75 + ((localPlayer.bought_and_upgraded_talents[21] + 1) * 25)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[21] else "Rank {0}: Damage taken when active: {1}%.".format(localPlayer.bought_and_upgraded_talents[22] + 1, 66.666 - ((localPlayer.bought_and_upgraded_talents[22] + 1) * 6.666)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[22] else "Rank {0}: Healing: {1}.".format(localPlayer.bought_and_upgraded_talents[29] + 1, 150 + ((localPlayer.bought_and_upgraded_talents[29] + 1) * 50)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[29] else "Rank {0}: Healing: {1}.".format(localPlayer.bought_and_upgraded_talents[30] + 1, 75 + ((localPlayer.bought_and_upgraded_talents[21] + 1) * 25)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[30] else "Rank {0}: Damage: {1}/Vial, Vial Recharge: 15 sec, Radius: 3m.".format(localPlayer.bought_and_upgraded_talents[31] + 1, 56.25 + ((localPlayer.bought_and_upgraded_talents[31] + 1) * 18.75)) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[31] else "Rank {0}: Cooldown reduced: {1} sec, Chance to get an extra charge when picking up an xp orb: {2}%.".format(localPlayer.bought_and_upgraded_talents[32] + 1, localPlayer.bought_and_upgraded_talents[32] + 1, (localPlayer.bought_and_upgraded_talents[32] + 1) * 20) if localPlayer.offered_talents_in_shop[localPlayer.selected_talent[0]] == talent_names[32] else "", localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.625, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    xp_code = [true, iconString(Icon.ARROW_LEFT), iconString(Icon.ARROW_RIGHT), iconString(Icon.CIRCLE), iconString(Icon.ARROW_LEFT)]


rule "GENERAL - - - [EACH PLAYER] INIT":
    @Event eachPlayer
    
    if eventPlayer.isDummy() == false:
        eventPlayer.typing_in_xp_code[0] = false
        eventPlayer.possible_talents = [null, "{0} [Purity Field]".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_2)), "{0} [Cybernetics]".format(abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE)), "{0} [Engineer]".format(abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE)), null, "{0} [Stealth]".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_1)), null, "{0} [Dive Bomb]".format(abilityIconString(Hero.HAMMOND, Button.CROUCH)), "{0} [Cryogenics]".format(abilityIconString(Hero.MEI, Button.ULTIMATE)), "{0} [Railgun]".format(abilityIconString(Hero.ECHO, Button.ABILITY_2)), "{0} [Predator]".format(abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE)), "{0} [Jetpack]".format(abilityIconString(Hero.DVA, Button.ABILITY_1)), "{0} [Lifesteal Ammo]".format(abilityIconString(Hero.BAPTISTE, Button.SECONDARY_FIRE)), "{0} [Health Regen]".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), "{0} [Health Potions]".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_2)), null, "{0} [Ignite]".format(iconString(Icon.FIRE)), "{0} [Overclock]".format(abilityIconString(Hero.TORBJORN, Button.ABILITY_2)), "{0} [Shadowstep]".format(abilityIconString(Hero.MOIRA, Button.ABILITY_1)), "{0} [Burning Soul]".format(abilityIconString(Hero.REAPER, Button.ABILITY_1)), "{0} [Berserker]".format(iconString(Icon.SKULL)), "{0} [Fireball]".format(abilityIconString(Hero.PHARAH, Button.ABILITY_1)), "{0} [Ignore Pain]".format(abilityIconString(Hero.ZARYA, Button.ABILITY_1)), null, null, null, null, null, null, null, null, null, null]
        wait()
        eventPlayer.amount_of_talents_purchased = 0
        eventPlayer.selected_talent[1] = 0
        eventPlayer.talents_you_do_not_have = [null, talent_names[1], talent_names[2], talent_names[3], talent_names[4], talent_names[5], null, null, talent_names[8], talent_names[9], talent_names[10], talent_names[11], talent_names[12], talent_names[13], talent_names[14], null, talent_names[16], null, talent_names[18], talent_names[19], talent_names[20], talent_names[21], talent_names[22], null, null, null, null, null, null, null, null, null, null]
        wait()
        eventPlayer.replace_replacing_or_cancelled[0] = false
        eventPlayer.replace_replacing_or_cancelled[1] = false
        eventPlayer.replace_replacing_or_cancelled[2] = false
        eventPlayer.canVote_hasVoted_canStartVote[0] = false
        eventPlayer.canVote_hasVoted_canStartVote[1] = true
        eventPlayer.canVote_hasVoted_canStartVote[2] = false
        eventPlayer.time_since_joined_match = 0
        #Chase to 15 minutes to be able to vote on changing map.
        chase(eventPlayer.time_since_joined_match, 900, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.has_hit_the_ground = true
        eventPlayer.setAbility2Enabled(false)
        eventPlayer.setUltEnabled(false)
        progressBarHud(eventPlayer, showdown_duration / 180 * 100 if match_is_in_showdown == true else 100 if endless_mode == false and eventPlayer.amount_of_talents_purchased == 25 else eventPlayer.experience_current / eventPlayer.experience_max * 100, "Enter Shop To Vote!" if endless_mode == true and someone_is_voting_to_change_map == true and vote_to_change_map_duration != null and localPlayer.canVote_hasVoted_canStartVote[1] == false and localPlayer.experience_current < localPlayer.experience_max else "Showdown!" if match_is_in_showdown == true else "Max Level - XP Boost: Active" if eventPlayer.amount_of_talents_purchased == 25 else "You have a talent point" if eventPlayer.can_enter_shop == true else "You skipped a talent! XP Boost: Active" if eventPlayer.skipped_a_talent == true else "Too far behind! XP Boost: Active" if eventPlayer.can_enter_shop == false and eventPlayer.xp_boost_is_active == true and eventPlayer.amount_of_talents_purchased > 0 else "First Level! XP Boost: Active" if (eventPlayer.can_enter_shop == false and eventPlayer.amount_of_talents_purchased == 0) == true else "", HudPosition.TOP, 1, Color.RED if match_is_in_showdown == true else Color.ORANGE, Color.RED if match_is_in_showdown == true else Color.ORANGE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
        wait()
        #[0] = Damage, [1] = Health, [2] = Speed, [3] = Armor, [4] = Shields, [5] = XP, [6] = Voice, [7] = Berserker Helper
        eventPlayer.stats = [100, 250, 100, 0, 0, 0.65, 1, 0]
        eventPlayer.setMaxHealth(eventPlayer.stats[1])
        #Upgrade Information (or selected talent of bought talents when replacing talents)
        createInWorldText(eventPlayer if eventPlayer.browsing_shop == true and ((eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])] > 0 or eventPlayer.replace_replacing_or_cancelled[1] == true) == true) else null, "{0}".format(eventPlayer.bought_talents[eventPlayer.selected_talent[1]]) if eventPlayer.replace_replacing_or_cancelled[1] == true else "{0}".format(upgrade_information[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])]), eventPlayer.selected_talent_location + vect(0, 0.125, 0) if eventPlayer.replace_replacing_or_cancelled[1] == true else eventPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1, 0), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE if eventPlayer.replace_replacing_or_cancelled[1] == true else orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])]], SpecVisibility.DEFAULT)
        wait()
        #Talent Descriptions
        createInWorldText(eventPlayer if eventPlayer.browsing_shop == true and eventPlayer.replace_replacing_or_cancelled[0] == false and eventPlayer.replace_replacing_or_cancelled[1] == false else null, "" if endless_mode == true and eventPlayer.canVote_hasVoted_canStartVote[1] == false and someone_is_voting_to_change_map == true else "{0}".format(talent_descriptions[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])]), eventPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.125, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        #Left Orb
        createEffect(null if (eventPlayer.canVote_hasVoted_canStartVote[1] == false and map_is_changing == false or (((eventPlayer.replace_replacing_or_cancelled[0] == true or eventPlayer.replace_replacing_or_cancelled[1] == true) == true) and eventPlayer.selected_talent[0] != 0)) == true else eventPlayer if eventPlayer.browsing_shop == true else null, Effect.ORB, orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.bought_talents[eventPlayer.selected_talent[1]])] - 1] if eventPlayer.replace_replacing_or_cancelled[1] == true else orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.offered_talents_in_shop[0])]], shop_talent_left_location, 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        wait()
        #Middle Orb
        createEffect(null if (endless_mode == true and ((eventPlayer.replace_replacing_or_cancelled[0] == true or eventPlayer.replace_replacing_or_cancelled[1] == true) == true)) and eventPlayer.selected_talent[0] != 1 else eventPlayer if eventPlayer.browsing_shop == true else null, Effect.ORB, Color.WHITE if someone_is_voting_to_change_map == true and eventPlayer.canVote_hasVoted_canStartVote[1] == false else Color.WHITE if eventPlayer.replace_replacing_or_cancelled[0] == true and eventPlayer.replace_replacing_or_cancelled[1] == false else orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.bought_talents[eventPlayer.selected_talent[1]])] - 1] if eventPlayer.replace_replacing_or_cancelled[1] == true else orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.offered_talents_in_shop[1])]], shop_talent_middle_location, 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        wait()
        #Right Orb
        createEffect(null if (eventPlayer.canVote_hasVoted_canStartVote[1] == false and map_is_changing == false or (((eventPlayer.replace_replacing_or_cancelled[0] == true or eventPlayer.replace_replacing_or_cancelled[1] == true) == true) and eventPlayer.selected_talent[0] != 2)) == true else eventPlayer if eventPlayer.browsing_shop == true else null, Effect.ORB, orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.bought_talents[eventPlayer.selected_talent[1]])] - 1] if eventPlayer.replace_replacing_or_cancelled[1] == true else orb_rarity_colors[eventPlayer.bought_and_upgraded_talents[talent_names.index(eventPlayer.offered_talents_in_shop[2])]], shop_talent_right_location, 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        wait()
        #Left Talent
        createInWorldText(null if (eventPlayer.canVote_hasVoted_canStartVote[1] == false and map_is_changing == false or (((eventPlayer.replace_replacing_or_cancelled[0] == true or eventPlayer.replace_replacing_or_cancelled[1] == true) == true) and eventPlayer.selected_talent[0] != 0)) == true else eventPlayer if eventPlayer.browsing_shop == true else null, "{0}".format(talent_names[23]) if eventPlayer.replace_replacing_or_cancelled[0] == true else "{0}".format(talent_names[24]) if eventPlayer.replace_replacing_or_cancelled[1] == true else "{0}".format(eventPlayer.offered_talents_in_shop[0]), shop_talent_left_location + vect(0, 0.375, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        #Middle Talent
        createInWorldText(null if (endless_mode == true and ((eventPlayer.replace_replacing_or_cancelled[0] == true or eventPlayer.replace_replacing_or_cancelled[1] == true) == true)) and eventPlayer.selected_talent[0] != 1 else eventPlayer if eventPlayer.browsing_shop == true else null, "{0}".format(talent_names[23]) if eventPlayer.replace_replacing_or_cancelled[0] == true else "{0}".format(talent_names[24]) if eventPlayer.replace_replacing_or_cancelled[1] == true else "{0}".format(eventPlayer.offered_talents_in_shop[1]), shop_talent_middle_location + vect(0, 0.375, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        #Right Talent
        createInWorldText(null if (eventPlayer.canVote_hasVoted_canStartVote[1] == false and map_is_changing == false or (((eventPlayer.replace_replacing_or_cancelled[0] == true or eventPlayer.replace_replacing_or_cancelled[1] == true) == true) and eventPlayer.selected_talent[0] != 2)) == true else eventPlayer if eventPlayer.browsing_shop == true else null, "{0}".format(talent_names[23]) if eventPlayer.replace_replacing_or_cancelled[0] == true else "{0}".format(talent_names[24]) if eventPlayer.replace_replacing_or_cancelled[1] == true else "{0}".format(eventPlayer.offered_talents_in_shop[2]), shop_talent_right_location + vect(0, 0.375, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        eventPlayer.selected_talent[0] = 1
        eventPlayer.selected_talent_location = shop_talent_middle_location
        eventPlayer.bought_talents = []
        eventPlayer.is_using_ability = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
        eventPlayer.using_hearthstone_timer = 0
        eventPlayer.player_name = "{0}".format(eventPlayer)
        eventPlayer.luck = 70
        eventPlayer.bought_and_upgraded_talents = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0]
        eventPlayer.which_unique_talents_unlocked = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    eventPlayer.disableGamemodeHud()
    eventPlayer.experience_current = 0
    eventPlayer.experience_max = 250
    eventPlayer.can_enter_shop = false
    eventPlayer.in_combat = 0
    chase(eventPlayer.in_combat, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    createEffect(getAllPlayers() if eventPlayer.is_using_ability[9] == true or eventPlayer.hit_by_talent[9] != null else null, Effect.WINSTON_TESLA_CANNON_TARGET, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer if eventPlayer.bought_and_upgraded_talents[9] > 0 and eventPlayer.railgun_charge >= 100 or eventPlayer.hit_by_talent[9] != null else null, Effect.WINSTON_TESLA_CANNON_TARGET_SOUND, Color.TEAM_1, eventPlayer, 50, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.is_electrified = 0
    chase(eventPlayer.is_electrified, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.predator_effects = null
    eventPlayer.is_respawning = false
    wait()
    eventPlayer.slow_amount = 100
    eventPlayer.slow_duration = 0
    eventPlayer.hit_by_talent[31] = null
    createEffect(getAllPlayers() if eventPlayer.is_using_ability[8] == true else null, Effect.MEI_FROZEN, Color.WHITE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers() if eventPlayer.is_using_ability[8] == true else null, Effect.MEI_FROZEN_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "GENERAL - - - Match Time":
    @Condition isAssemblingHeroes() == true
    @Condition map_is_changing == false
    
    setMatchTime(0)
    while map_is_changing == false:
        waitUntil((len(getPlayersOnHero(Hero.SOLDIER, Team.ALL)) > 0 or accurateTime > 14400) == true, 99999)
        if map_is_changing == true:
            return
        if accurateTime < 10800:
            setMatchTime(3600)
        waitUntil(len(getPlayersOnHero(Hero.SOLDIER, Team.ALL)) == 0 or accurateTime > 14400, 14400)
        if accurateTime < 10800:
            goto lbl_0
        if accurateTime > 14400 and map_is_changing == false:
            map_is_changing = true
            bigMessage(getAllPlayers(), "Game session lasted too long!")
            wait(7.5)
            bigMessage(getAllPlayers(), "Map will automatically change in 60 seconds!")
            setMatchTime(60)
            wait(7.5)
            bigMessage(getAllPlayers(), "Hope you enjoyed my game mode!")
            wait(7.5)
            bigMessage(getAllPlayers(), "Don't forget to join the Discord! :)")
            return
        if map_is_changing == true:
            return
        setMatchTime(1)
        return
        lbl_0:


rule "GENERAL - - - Add Bots":
    @Condition spawn_bots == true
    @Condition len(getAllPlayers()) < 8
    
    createDummy(Hero.REAPER, Team.ALL, -1 * 1 * 1 * 1, dummy_bot_spawn_position, dummy_bot_spawn_facing)
    wait(1)
    if RULE_CONDITION:
        goto RULE_START


rule "GENERAL - - - Upgrade Descriptions":
    upgrade_information = ["[Upgrade: +Healing]", "[Upgrade: +Duration, +Healing Received]", "[Upgrade: +Shields]", "[Upgrade: +Charge Rate]", "[Upgrade: +Damage]", "[Upgrade: +Duration, -Cooldown]", "[Upgrade: +Damage]", "[Upgrade: +Damage]", "[Upgrade: +Slow Amount, +Slow Duration]", "[Upgrade: +Damage]", "[Upgrade: -Cooldown]", "[Upgrade: +Fuel Efficiency]", "[Upgrade: +Healing]", "[Upgrade: +Healing]", "[Upgrade: +Healing]", "[15]", "[Upgrade: +Damage]", "[Upgrade: +Charge Amount]", "[Upgrade: -Cooldown]", "[Upgrade: +Damage]", "[Upgrade: +Duration]", "[Upgrade: +Damage]", "[Upgrade: +Damage Resistance]", "[23]", "[24]", "[25]", "[26]", "[27]", "[28]", "[Upgrade: +Healing]", "[Upgrade: +Healing]", "[Upgrade: +Damage]", "[Upgrade: -Cooldown, +Chance]"]


rule "GENERAL - - - Is Match Complete?":
    @Condition isMatchComplete() == true
    
    bigMessage(getAllPlayers(), "{0} Join the discord! {1}".format(iconString(Icon.ARROW_RIGHT), iconString(Icon.ARROW_LEFT)))


def If_map():
    @Name "GENERAL - - - [SUBROUTINE] if Map"
    
    if getCurrentMap() == Map.EICHENWALDE or getCurrentMap() == Map.EICHENWALDE_HALLOWEEN:
        map_eichenwalde()
        dummy_bot_spawn_position = vect(99.42, 13.121, -1 * 1 * 1 * 71.747)
        dummy_bot_spawn_facing = vect(99.42, 13.121, -1 * 1 * 1 * 71.747)
        shop_location = vect(13.219, 5.89, -1 * 1 * 1 * 49.768)
        shop_talent_left_location = vect(16.177, 8.003, -1 * 1 * 1 * 45.05)
        shop_talent_middle_location = vect(13.174, 8.287, -1 * 1 * 1 * 44.887)
        shop_talent_right_location = vect(10.425, 8.09, -1 * 1 * 1 * 44.999)
    elif getCurrentMap() == Map.BLACK_FOREST or getCurrentMap() == Map.BLACK_FOREST_WINTER:
        map_black_forest()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 25.204, 12.546, 3.92)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 19.306, 13.739, 3.922)
        shop_location = vect(-1 * 1 * 1 * 33.308, 4.599, 1.094)
        shop_talent_left_location = vect(-1 * 1 * 1 * 38.288, 6.869, 2.713)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 38.063, 6.77, -1 * 1 * 1 * 0.092)
        shop_talent_right_location = vect(-1 * 1 * 1 * 36.726, 6.549, -1 * 1 * 1 * 2.176)
    elif getCurrentMap() == Map.HOLLYWOOD:
        map_hollywood()
        dummy_bot_spawn_position = vect(28.865, 7.252, -1 * 1 * 1 * 77.34)
        dummy_bot_spawn_facing = vect(28.865, 7.252, -1 * 1 * 1 * 77.34)
        shop_location = vect(-1 * 1 * 1 * 5.95, 4.611, -1 * 1 * 1 * 102.526)
        shop_talent_left_location = vect(-1 * 1 * 1 * 7.025, 4.948, -1 * 1 * 1 * 108.214)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 4.132, 5.164, -1 * 1 * 1 * 107.363)
        shop_talent_right_location = vect(-1 * 1 * 1 * 1.687, 4.883, -1 * 1 * 1 * 106.065)
    elif getCurrentMap() == Map.ECOPOINT_ANTARCTICA:
        map_antarctica()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 33.601, 9.455, -1 * 1 * 1 * 0.077)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 29.427, 10.582, 0.021)
        shop_location = vect(-1 * 1 * 1 * 11.287, 27.001, 22.31)
        shop_talent_left_location = vect(-1 * 1 * 1 * 15.965, 29.219, 25.678)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 16.535, 29.46, 22.783)
        shop_talent_right_location = vect(-1 * 1 * 1 * 16.45, 29.219, 19.92)
    elif getCurrentMap() == Map.CHATEAU_GUILLARD or getCurrentMap() == Map.CHATEAU_GUILLARD_HALLOWEEN:
        map_chateau_guillard()
        dummy_bot_spawn_position = vect(206.444, 15.955, 86.831)
        dummy_bot_spawn_facing = vect(206.444, 15.955, 86.831)
        shop_location = vect(247.531, -1 * 1 * 1 * 0.506, 50.543)
        shop_talent_left_location = vect(252.604, 1.63, 48.43)
        shop_talent_middle_location = vect(252.429, 2.033, 51.359)
        shop_talent_right_location = vect(251.716, 1.586, 53.944)
    elif getCurrentMap() == Map.KINGS_ROW or getCurrentMap() == Map.KINGS_ROW_WINTER:
        map_kings_row()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 95.498, 7.937, -1 * 1 * 1 * 30.638)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 95.498, 7.937, -1 * 1 * 1 * 30.638)
        shop_location = vect(-1 * 1 * 1 * 140.793, 6.939, 22.963)
        shop_talent_left_location = vect(-1 * 1 * 1 * 144.654, 7.111, 26.609)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 145.924, 7.492, 23.767)
        shop_talent_right_location = vect(-1 * 1 * 1 * 145.762, 7.073, 20.701)
    elif getCurrentMap() == Map.BLIZZ_WORLD or getCurrentMap() == Map.BLIZZ_WORLD_WINTER:
        map_blizzard_world()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 45.778, 4.981, 95.978)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 45.778, 4.981, 95.978)
        shop_location = vect(-1 * 1 * 1 * 140.141, 1.684, 105.206)
        shop_talent_left_location = vect(-1 * 1 * 1 * 145.471, 3.066, 106.655)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 144.712, 3.141, 103.87)
        shop_talent_right_location = vect(-1 * 1 * 1 * 143.468, 2.792, 101.504)
    elif getCurrentMap() == Map.HANAMURA or getCurrentMap() == Map.HANAMURA_WINTER:
        dummy_bot_spawn_position = vect(11.903, 11.666, 21.966)
        dummy_bot_spawn_facing = vect(11.903, 11.666, 21.966)
        shop_location = vect(1.859, 0.68, 19.337)
        shop_talent_left_location = vect(-1 * 1 * 1 * 1.152, 1.611, 15.181)
        shop_talent_middle_location = vect(1.875, 1.631, 14.133)
        shop_talent_right_location = vect(4.708, 1.483, 15.417)
    elif getCurrentMap() == Map.NECROPOLIS:
        map_necropolis()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 27.407, 9.455, -1 * 1 * 1 * 0.003)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 27.407, 9.455, -1 * 1 * 1 * 0.003)
        shop_location = vect(42.975, 8.571, -1 * 1 * 1 * 0.079)
        shop_talent_left_location = vect(46.729, 9.457, -1 * 1 * 1 * 4.042)
        shop_talent_middle_location = vect(48.006, 9.655, -1 * 1 * 1 * 1.553)
        shop_talent_right_location = vect(48.256, 9.406, 1.45)
    elif getCurrentMap() == Map.PETRA:
        map_petra()
        dummy_bot_spawn_position = vect(43.642, 13.747, 33.965)
        dummy_bot_spawn_facing = vect(43.642, 13.747, 33.965)
        shop_location = vect(-1 * 1 * 1 * 52.288, -1 * 1 * 1 * 18.045, 5.863)
        shop_talent_left_location = vect(-1 * 1 * 1 * 56.327, -1 * 1 * 1 * 16.669, 9.215)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 57.335, -1 * 1 * 1 * 16.73, 5.903)
        shop_talent_right_location = vect(-1 * 1 * 1 * 56.46, -1 * 1 * 1 * 16.67, 2.626)
    elif getCurrentMap() == Map.KANEZAKA:
        map_kanezaka()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 8.115, 6.507, -1 * 1 * 1 * 38.928)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 8.115, 6.507, -1 * 1 * 1 * 38.928)
        shop_location = vect(-1 * 1 * 1 * 22.798, 23.978, 54.659)
        shop_talent_left_location = vect(-1 * 1 * 1 * 21.18, 24.327, 48.941)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 18.936, 24.588, 51.056)
        shop_talent_right_location = vect(-1 * 1 * 1 * 17.535, 24.302, 53.351)
    elif getCurrentMap() == Map.CASTILLO:
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 112.424, 33.763, 59.87)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 112.424, 33.763, 59.87)
        shop_location = vect(-1 * 1 * 1 * 60.288, 22.011, 50.687)
        shop_talent_left_location = vect(-1 * 1 * 1 * 55.86, 22.533, 46.725)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 54.774, 22.706, 49.529)
        shop_talent_right_location = vect(-1 * 1 * 1 * 54.935, 22.481, 52.534)
    elif getCurrentMap() == Map.DORADO:
        dummy_bot_spawn_position = vect(27.568, 4.221, -1 * 1 * 1 * 17.033)
        dummy_bot_spawn_facing = vect(27.568, 4.221, -1 * 1 * 1 * 17.033)
        shop_location = vect(78.814, -1 * 1 * 1 * 7.22, 60.419)
        shop_talent_left_location = vect(78.019, -1 * 1 * 1 * 6.203, 66.255)
        shop_talent_middle_location = vect(75.547, -1 * 1 * 1 * 6.043, 64.771)
        shop_talent_right_location = vect(73.356, -1 * 1 * 1 * 6.27, 62.604)
    elif getCurrentMap() == Map.HAVANA:
        dummy_bot_spawn_position = vect(107.152, 2.067, -1 * 1 * 1 * 27.697)
        dummy_bot_spawn_facing = vect(107.152, 2.067, -1 * 1 * 1 * 27.697)
        shop_location = vect(108.634, -1 * 1 * 1 * 6.72, -1 * 1 * 1 * 98.952)
        shop_talent_left_location = vect(109.618, -1 * 1 * 1 * 6.593, -1 * 1 * 1 * 104.188)
        shop_talent_middle_location = vect(112.271, -1 * 1 * 1 * 6.455, -1 * 1 * 1 * 103.031)
        shop_talent_right_location = vect(113.836, -1 * 1 * 1 * 6.6, -1 * 1 * 1 * 100.569)
    elif getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 5.277, 8.455, -1 * 1 * 1 * 0.963)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 5.277, 8.455, -1 * 1 * 1 * 0.963)
        shop_location = vect(-1 * 1 * 1 * 38.034, 19.101, -1 * 1 * 1 * 98.472)
        shop_talent_left_location = vect(-1 * 1 * 1 * 40.56, 20.427, -1 * 1 * 1 * 94.246)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 42.443, 20.629, -1 * 1 * 1 * 96.138)
        shop_talent_right_location = vect(-1 * 1 * 1 * 42.719, 20.427, -1 * 1 * 1 * 98.671)
    elif getCurrentMap() == Map.PARIS:
        map_paris()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 15.892, 11.764, -1 * 1 * 1 * 28.584)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 15.892, 11.765, -1 * 1 * 1 * 28.584)
        shop_location = vect(-1 * 1 * 1 * 57.281, 15, 16.922)
        shop_talent_left_location = vect(-1 * 1 * 1 * 58.455, 15.865, 20.72)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 59.898, 16.065, 19.441)
        shop_talent_right_location = vect(-1 * 1 * 1 * 61.128, 15.865, 18)
    elif getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        dummy_bot_spawn_position = vect(9.821, 1.229, -1 * 1 * 1 * 34.382)
        dummy_bot_spawn_facing = vect(9.821, 1.229, -1 * 1 * 1 * 34.382)
        shop_location = vect(-1 * 1 * 1 * 11.913, 9.69, 140.21)
        shop_talent_left_location = vect(-1 * 1 * 1 * 14.907, 10.161, 136.422)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 12.276, 10.256, 135.274)
        shop_talent_right_location = vect(-1 * 1 * 1 * 9.479, 10.212, 135.867)
    elif getCurrentMap() == Map.VOLSKAYA:
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 5.23, -1 * 1 * 1 * 5.49, 20.299)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 5.23, -1 * 1 * 1 * 5.49, 20.299)
        shop_location = vect(29.638, 0.967, 135.899)
        shop_talent_left_location = vect(34.473, 1.742, 133.502)
        shop_talent_middle_location = vect(35.005, 1.942, 136.165)
        shop_talent_right_location = vect(34.623, 1.742, 139)
    elif getCurrentMap() == Map.MALEVENTO:
        map_malevento()
        dummy_bot_spawn_position = vect(19.218, 9.455, 36.238)
        dummy_bot_spawn_facing = vect(19.218, 9.455, 36.238)
        shop_location = vect(-1 * 1 * 1 * 37.854, -1 * 1 * 1 * 3.482, 27.558)
        shop_talent_left_location = vect(-1 * 1 * 1 * 42.108, -1 * 1 * 1 * 2.527, 30.596)
        shop_talent_middle_location = vect(-1 * 1 * 1 * 43.465, -1 * 1 * 1 * 2.309, 28.296)
        shop_talent_right_location = vect(-1 * 1 * 1 * 43.142, -1 * 1 * 1 * 2.372, 25.602)


def create_talent_hud_texts():
    @Name "GENERAL - - - [SUBROUTINE] Create HUD Texts"
    
    hudText(getAllPlayers(), null, "Soldier: X [v2.625] - - - Made By Psyrius#21775 - - - Workshop Code: ZEKK3", "[Discord: 3MBymdF (ymd is lower case)]", HudPosition.RIGHT, 0, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), null, "", "[More info: workshop.codes/ZEKK3]", HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #Stats
    hudSubheader(localPlayer, "{0}".format("[Skip showdown & Change map? Hold: {0}] [{1} Players voted yes, Need a total of {2}]".format(buttonString(Button.RELOAD), len(players_that_voted_yes), ceil(len(getPlayersOnHero(Hero.SOLDIER, Team.ALL)) * 0.501)) if match_is_in_showdown == true else "[Start a showdown?] [{0} Players voted yes, {1} voted no] {2}".format(len(players_that_voted_yes), len(players_that_voted_no), "[{0} more players can vote] [{1}]".format(((len([player for player in getAllPlayers() if player.canVote_hasVoted_canStartVote[0] == true])) - len(players_that_voted_yes)) - len(players_that_voted_no), ceil(vote_to_change_map_duration))) if endless_mode == true and someone_is_voting_to_change_map == true and vote_to_change_map_duration != null else "" if endless_mode == true and someone_is_voting_to_change_map == false else ""), HudPosition.TOP, 0, Color.RED if match_is_in_showdown == true else Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(localPlayer if (endless_mode == true and someone_is_voting_to_change_map == true and vote_to_change_map_duration != null and localPlayer.canVote_hasVoted_canStartVote[1] == false and localPlayer.experience_current < localPlayer.experience_max) == true else null if localPlayer.browsing_shop == true and localPlayer.canVote_hasVoted_canStartVote[1] == false else localPlayer if localPlayer.can_enter_shop == true and localPlayer.replace_replacing_or_cancelled[0] == false and localPlayer.replace_replacing_or_cancelled[1] == false else null, "[Hold: {0} to use Hearthstone]".format(buttonString(Button.RELOAD)) if endless_mode == true and someone_is_voting_to_change_map == true and vote_to_change_map_duration != null and localPlayer.canVote_hasVoted_canStartVote[1] == false and localPlayer.experience_current < localPlayer.experience_max else "[Hold: {0} to use Hearthstone]".format(buttonString(Button.RELOAD)) if localPlayer.browsing_shop == false and localPlayer.amount_of_talents_purchased < 25 else "[Hold: {0} to replace a talent or start a showdown & change map]".format(buttonString(Button.RELOAD)) if endless_mode == true and localPlayer.browsing_shop == false and localPlayer.amount_of_talents_purchased == 25 else "[Hold: {0} to skip a talent, exit shop and get a XP boost]".format(buttonString(Button.RELOAD)) if localPlayer.browsing_shop == true else "", HudPosition.TOP, 2, Color.RED if match_is_in_showdown == true else Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #Stealth
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[5] > 0 else null, "{0}".format(talent_names[5]), "Cooldown: {0}".format(localPlayer.stealth_cooldown) if localPlayer.stealth_cooldown > 0 else "", "[Damage & Stun: {0}]".format(buttonString(Button.MELEE)) if localPlayer.is_using_ability[5] == true else "[Hold: {0} (Out of Combat)]".format(buttonString(Button.CROUCH)), HudPosition.LEFT, 5, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[5]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[5]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[7] Dive Bomb
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[7] > 0 else null, "{0}".format(talent_names[7]), "Cooldown: {0}".format(localPlayer.dive_bomb_cooldown) if localPlayer.dive_bomb_cooldown > 0 else "", "[Press: {0} (In Air)]".format(buttonString(Button.CROUCH)), HudPosition.LEFT, 7, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[7]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[7]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[8] Cryogenics
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[8] > 0 else null, "{0}".format(talent_names[8]), null, "[Press: {0}]".format(buttonString(Button.SECONDARY_FIRE)), HudPosition.LEFT, 8, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[8]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[8]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[9] Railgun
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[9] > 0 else null, "{0}".format(talent_names[9]), "Charge: {0}".format(localPlayer.railgun_charge), "[Press: {0} (When 100% charged)]".format(buttonString(Button.SECONDARY_FIRE)), HudPosition.LEFT, 9, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[9]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[9]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[16] Ignite
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[16] > 0 else null, "{0}".format(talent_names[16]), null, "[Shoot Enemies with: {0}]".format(buttonString(Button.SECONDARY_FIRE)), HudPosition.LEFT, 16, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[16]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[16]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #Overclock
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[17] > 0 else null, "{0}".format(talent_names[17]), null, "[Passive]", HudPosition.LEFT, 17, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[17]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[17]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #Berserker
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[20] > 0 else null, "{0}".format(talent_names[20]), "Cooldown: {0}".format(localPlayer.berserker_cooldown) if localPlayer.berserker_cooldown > 0 else "", "[Press: {0}]".format(buttonString(Button.ULTIMATE)), HudPosition.LEFT, 20, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[20]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[20]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[22] Ignore Pain
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[22] > 0 else null, "{0}".format(talent_names[22]), null, "[Passive]", HudPosition.LEFT, 22, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[22]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[22]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[19] Burning Soul
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[19] > 0 else null, "{0}".format(talent_names[19]), null, "[Passive]", HudPosition.LEFT, 19, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[19]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[19]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[13] Health Regen
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[13] > 0 else null, "{0} Call to the void".format(abilityIconString(Hero.ZENYATTA, Button.ULTIMATE)) if localPlayer.is_using_ability[5] == true else talent_names[13], "Health regen healing tripled in stealth" if localPlayer.is_using_ability[5] == true else "", "[Passive]", HudPosition.LEFT, 13, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[13]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[13]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[12] Lifesteal Ammo
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[12] > 0 else null, "{0}".format(talent_names[12]), null, "[Shoot enemies with: {0} or {1}]".format(buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE)), HudPosition.LEFT, 12, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[12]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[12]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[14] Health Potions
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[14] > 0 else null, "{0}".format(talent_names[14]), "Health Potion Recharge: {0}".format(localPlayer.health_potion_cooldown) if localPlayer.health_potion_cooldown > 0 else "", "[Press: {0}]".format(buttonString(Button.ABILITY_2)), HudPosition.LEFT, 14, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[14]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[14]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[11] Jetpack
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[11] > 0 else null, "{0}".format(talent_names[11]), "Jetpack Fuel: {0}".format(localPlayer.jetpack_fuel), "[Hold: {0}]".format(buttonString(Button.JUMP)), HudPosition.LEFT, 11, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[11]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[11]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[10] Predator
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[10] > 0 else null, "{0}".format(talent_names[10]), "Cooldown: {0}".format(localPlayer.predator_cooldown) if localPlayer.predator_cooldown > 0 else "", "[Press: {0} (On Low Health Targets)]".format(buttonString(Button.MELEE)), HudPosition.LEFT, 10, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[10]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[10]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[21] Fireball
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[21] > 0 else null, "{0}".format(talent_names[21]), "Cooldown: {0}".format(localPlayer.fireball_cooldown) if localPlayer.fireball_cooldown > 0 else "", "[Press: {0}]".format(buttonString(Button.INTERACT)), HudPosition.LEFT, 21, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[21]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[21]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[18] Shadowstep
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[18] > 0 else null, "{0}".format(talent_names[18]), "Cooldown: {0}".format(localPlayer.shadowstep_cooldown) if localPlayer.shadowstep_cooldown > 0 else "", "[Double Tap: {0}]".format(buttonString(Button.JUMP)), HudPosition.LEFT, 18, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[18]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[18]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[29] Soul Siphon
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[29] > 0 else null, "{0}".format(talent_names[29]), null, "[Passive]", HudPosition.LEFT, 29, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[29]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[29]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[31] Poison Vials
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[31] > 0 else null, "{0}".format(talent_names[31]), "Poison Vial Recharge: {0}".format(localPlayer.health_potion_cooldown) if localPlayer.health_potion_cooldown > 0 else "", "[Press: {0}]".format(buttonString(Button.ABILITY_2)), HudPosition.LEFT, 31, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[31]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[31]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[32] Crazy Alchemist
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[32] > 0 else null, "{0}".format(talent_names[32]), null, "[Passive]", HudPosition.LEFT, 32, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[32]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[32]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[30] Pyromaniac
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[30] > 0 else null, "{0}".format(talent_names[30]), null, "[Passive]", HudPosition.LEFT, 30, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[30]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[30]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[3] Engineer
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[3] > 0 else null, "{0}".format(talent_names[3]), "Scrap: {0}%".format(localPlayer.engineer_scrap), "[Press: {0} (When 100% Scrap)]".format(buttonString(Button.RELOAD)), HudPosition.LEFT, 3, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[3]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[3]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[2] Cybernetics
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[2] > 0 else null, "{0}".format(talent_names[2]), null, "[Passive]", HudPosition.LEFT, 2, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[2]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[2]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #Bloodthirst
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[0] > 0 else null, "{0}".format(talent_names[0]), null, "[Passive]", HudPosition.LEFT, 0, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[0]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[0]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[1] Purity Field
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[1] > 0 else null, "{0}".format(talent_names[1]), "Cooldown: {0}".format(localPlayer.purity_field_cooldown) if localPlayer.purity_field_cooldown > 0 else "", "[Press: {0}+{1}]".format(buttonString(Button.CROUCH), buttonString(Button.ABILITY_2)), HudPosition.LEFT, 1, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[1]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[1]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #Juggernaut
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[6] > 0 else null, "{0}".format(talent_names[6]), ("Cooldown: {0}".format(20 if localPlayer.juggernaut_cooldown > 20 else localPlayer.juggernaut_cooldown)) if localPlayer.juggernaut_cooldown > 0 else "", "[Press: {0}]".format(buttonString(Button.INTERACT)), HudPosition.LEFT, 6, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[6]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[6]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)
    #[4] Shadowstrike
    hudText(localPlayer if localPlayer.bought_and_upgraded_talents[4] > 0 else null, "{0}".format(talent_names[4]), "Cooldown: {0}".format(localPlayer.shadowstep_cooldown) if localPlayer.shadowstep_cooldown > 0 else "", "[Double Tap: {0}]".format(buttonString(Button.JUMP)), HudPosition.LEFT, 4, talent_rarity_colors[localPlayer.bought_and_upgraded_talents[4]], talent_rarity_colors[localPlayer.bought_and_upgraded_talents[4]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.NEVER)


def create_talent_helpers():
    @Name "GENERAL - - - [SUBROUTINE] Create Cooldown Ready Icons"
    
    #Health Potions or Poison Vials
    createInWorldText(localPlayer if ((localPlayer.bought_and_upgraded_talents[14] > 0 or localPlayer.bought_and_upgraded_talents[31] > 0) and localPlayer.browsing_shop == false) and localPlayer.is_using_ability[6] == false else null, "{0}   {1}   {2}".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_2) if localPlayer.amount_of_potions_or_vials >= 1 and localPlayer.bought_and_upgraded_talents[14] > 0 else iconString(Icon.POISON_2) if localPlayer.amount_of_potions_or_vials >= 1 and localPlayer.bought_and_upgraded_talents[31] > 0 else "", abilityIconString(Hero.ROADHOG, Button.ABILITY_2) if localPlayer.amount_of_potions_or_vials >= 2 and localPlayer.bought_and_upgraded_talents[14] > 0 else iconString(Icon.POISON_2) if localPlayer.amount_of_potions_or_vials >= 2 and localPlayer.bought_and_upgraded_talents[31] > 0 else "", abilityIconString(Hero.ROADHOG, Button.ABILITY_2) if localPlayer.amount_of_potions_or_vials == 3 and localPlayer.bought_and_upgraded_talents[14] > 0 else iconString(Icon.POISON_2) if localPlayer.amount_of_potions_or_vials >= 3 and localPlayer.bought_and_upgraded_talents[31] > 0 else ""), updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((-1 * 1 * 1 * 0.3 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    #Jetpack
    createProgressBarInWorldText(localPlayer if localPlayer.jetpack_fuel < 100 and localPlayer.browsing_shop == false and localPlayer.bought_and_upgraded_talents[11] > 0 and localPlayer.is_using_ability[6] == false else null, localPlayer.jetpack_fuel, "LOW FUEL!" if localPlayer.jetpack_fuel < 25 else "FUEL", updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((-1 * 1 * 1 * 0.5 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 0.625, Clip.NONE, Color.RED if localPlayer.jetpack_fuel < 25 else Color.WHITE, Color.RED if localPlayer.jetpack_fuel < 25 else Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    #Entering Stealth
    createProgressBarInWorldText(localPlayer if localPlayer.bought_and_upgraded_talents[5] > 0 and localPlayer.browsing_shop == false and (localPlayer.entering_stealth == true or localPlayer.is_using_ability[5] == true) else null, localPlayer.entering_stealth_timer / 1 * 100, "Entering Stealth" if localPlayer.is_using_ability[5] == false else "Stealthed", updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((-1 * 1 * 1 * 0.75 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 0.75, Clip.NONE, Color.VIOLET if localPlayer.is_using_ability[5] == true else Color.WHITE, Color.VIOLET if localPlayer.is_using_ability[5] == true else Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.NEVER)
    #Talent Cooldown Icons
    createInWorldText(localPlayer if localPlayer.browsing_shop == false and localPlayer.getCurrentHero() == Hero.SOLDIER and localPlayer.is_using_ability[6] == false else null, "{0}{1}{2}".format("{0}{1}{2}".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_1) if localPlayer.bought_and_upgraded_talents[5] > 0 and localPlayer.stealth_cooldown == 0 else "", abilityIconString(Hero.REINHARDT, Button.ABILITY_1) if localPlayer.bought_and_upgraded_talents[6] > 0 and localPlayer.juggernaut_cooldown == 0 else "", abilityIconString(Hero.HAMMOND, Button.CROUCH) if localPlayer.bought_and_upgraded_talents[7] > 0 and localPlayer.dive_bomb_cooldown == 0 else ""), "{0}{1}{2}".format(abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE) if localPlayer.bought_and_upgraded_talents[10] > 0 and localPlayer.predator_cooldown == 0 else "", iconString(Icon.SKULL) if localPlayer.bought_and_upgraded_talents[20] > 0 and localPlayer.berserker_cooldown == 0 else "", abilityIconString(Hero.PHARAH, Button.ABILITY_1) if localPlayer.bought_and_upgraded_talents[21] > 0 and localPlayer.fireball_cooldown == 0 else ""), "{0}{1}{2}".format((abilityIconString(Hero.MOIRA, Button.ABILITY_1) if localPlayer.bought_and_upgraded_talents[18] > 0 else abilityIconString(Hero.GENJI, Button.ABILITY_1)) if ((localPlayer.bought_and_upgraded_talents[18] or localPlayer.bought_and_upgraded_talents[4]) > 0) and localPlayer.shadowstep_cooldown == 0 else "", abilityIconString(Hero.BAPTISTE, Button.ABILITY_2) if localPlayer.bought_and_upgraded_talents[1] > 0 and localPlayer.purity_field_cooldown == 0 else "", abilityIconString(Hero.PHARAH, Button.ABILITY_1) if localPlayer.bought_and_upgraded_talents[0] > 100 and localPlayer.browsing_shop == 100 else "")), updateEveryTick(localPlayer.getEyePosition() + (100 * (0.5 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0.05 - 0.25) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.NEVER)
    #Hearthstone
    createProgressBarInWorldText(localPlayer if (localPlayer.is_using_hearthstone[0] == true or localPlayer.is_using_hearthstone[1] == true or localPlayer.is_using_hearthstone[2] == true or localPlayer.is_using_hearthstone[3] == true or localPlayer.is_using_hearthstone[4] == true) == true else null, localPlayer.using_hearthstone_timer / 2.75 * 100, "{0} Voting To Skip Showdown".format(iconString(Icon.ARROW_RIGHT)) if localPlayer.browsing_shop == false and match_is_in_showdown == true else "{0} Using Hearthstone".format(iconString(Icon.SPIRAL)) if localPlayer.browsing_shop == false else "{0} YES".format(iconString(Icon.CHECKMARK)) if (localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true and (someone_is_voting_to_change_map == true and localPlayer.canVote_hasVoted_canStartVote[1] == false or localPlayer.replace_replacing_or_cancelled[0] == true)) == true else "{0} NO".format(iconString(Icon.NO)) if (localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true and someone_is_voting_to_change_map == true and localPlayer.canVote_hasVoted_canStartVote[1] == false or localPlayer.replace_replacing_or_cancelled[0] == true) == true else "{0} Voting yes to start a showdown & change map".format(iconString(Icon.CHECKMARK)) if localPlayer.browsing_shop == true and endless_mode == true and someone_is_voting_to_change_map == false and localPlayer.canVote_hasVoted_canStartVote[2] == true and localPlayer.isHoldingButton(Button.JUMP) == true else "{0} Skipping Talents For XP Boost".format(iconString(Icon.TRASHCAN)) if localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.RELOAD) == true else "", updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0.75 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))) if localPlayer.browsing_shop == false else localPlayer.selected_talent_location + Vector.UP, 1, Clip.NONE, Color.WHITE, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.NEVER)
    #What button to press in Stealth or Berserker
    createInWorldText(localPlayer if ((localPlayer.bought_and_upgraded_talents[5] > 0 or localPlayer.bought_and_upgraded_talents[20] > 0) and localPlayer.browsing_shop == false) and localPlayer.is_using_ability[6] == false else null, "{0}".format("{0} {1} = Cancel".format(iconString(Icon.SKULL), buttonString(Button.ULTIMATE)) if localPlayer.is_using_ability[20] == true else "{0} {1} = Damage & Stun".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_1), buttonString(Button.MELEE)) if localPlayer.is_using_ability[5] == true else ""), updateEveryTick(localPlayer.getEyePosition() + (100 * (1.625 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0.05 - 0.25) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    #Railgun charge
    createInWorldText(localPlayer if localPlayer.bought_and_upgraded_talents[9] > 0 and localPlayer.isCommunicatingEmote() == false and localPlayer.browsing_shop == false and localPlayer.is_using_ability[6] == false else null, "{0} {1}%".format(iconString(Icon.BOLT), localPlayer.railgun_charge if localPlayer.railgun_charge < 100 else 100), updateEveryTick(localPlayer.getEyePosition() + (100 * (1 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0 - 0.3) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE if localPlayer.railgun_charge < 100 else Color.SKY_BLUE, SpecVisibility.NEVER)
    #Engineer scrap
    createInWorldText(localPlayer if localPlayer.bought_and_upgraded_talents[3] > 0 and localPlayer.isCommunicatingEmote() == false and localPlayer.browsing_shop == false and localPlayer.is_using_ability[6] == false else null, "{0} {1}%".format(abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE), localPlayer.engineer_scrap if localPlayer.engineer_scrap < 100 else 100), updateEveryTick(localPlayer.getEyePosition() + (100 * (1 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE if localPlayer.engineer_scrap < 100 else Color.ORANGE, SpecVisibility.NEVER)
    #Cancel Juggernaut
    createInWorldText(localPlayer if localPlayer.is_using_ability[6] == true and localPlayer.has_hit_the_ground == true else null, "{0} {1} = Cancel".format(abilityIconString(Hero.REINHARDT, Button.ABILITY_1), buttonString(Button.INTERACT)), updateEveryTick(localPlayer.getEyePosition()), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.NEVER)


rule "GENERAL - - - Has Spawned":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.is_respawning == true
    
    if map_is_changing == false:
        setMatchTime(3599)
    eventPlayer.is_using_ability[33] = false
    eventPlayer.is_respawning = false
    if eventPlayer.is_using_ability[5] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    if eventPlayer.stats[4] > 0:
        removeHealthPool(eventPlayer.health_pool_id_or_hot_id[7])
        eventPlayer.addHealthPool(Health.SHIELDS, eventPlayer.stats[4], true, true)
        eventPlayer.health_pool_id_or_hot_id[7] = getLastCreatedHealthPool()
    if eventPlayer.can_enter_shop == true and eventPlayer.amount_of_talents_purchased < 25 and match_is_in_showdown == false:
        async(open_shop, AsyncBehavior.NOOP)
    else:
        wait(0.125)
        eventPlayer.stopCamera()
    if eventPlayer.getCurrentHero() == Hero.SOLDIER:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    eventPlayer.enableHeroHud()
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    if eventPlayer.bought_and_upgraded_talents[9] == 0:
        eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.hit_by_talent[8] = null
    destroyEffect(eventPlayer.hearthstone_effects_id[0])
    destroyEffect(eventPlayer.hearthstone_effects_id[1])
    if eventPlayer.getCurrentHero() == Hero.REAPER:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    eventPlayer.setMaxHealth(eventPlayer.stats[1])
    heal(eventPlayer, null, eventPlayer.getMaxHealth())


rule "GENERAL - - - OW2 Temporary Health Fix [Needs proper solution when I got time]":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isAlive() == true
    
    eventPlayer.setMaxHealth(eventPlayer.stats[1])
    heal(eventPlayer, null, eventPlayer.getMaxHealth())


rule "GENERAL - - - Player Died":
    @Event playerDied
    
    if attacker.getCurrentHero() == Hero.REAPER:
        attacker.random_integer_between_0_to_5 = random.randint(0, 9)
        if attacker.random_integer_between_0_to_5 <= 1 and attacker.stealth_cooldown == 0:
            attacker.communicate(Comms.SORRY)
            attacker.stealth_cooldown = 10
    if eventPlayer.xp_boost_is_active == true:
        stopChasingVariable(eventPlayer.experience_current)
    if eventAbility == Button.PRIMARY_FIRE:
        eventPlayer.applyImpulse(worldVector(angleToDirection(0, -1 * 1 * 1 * 45), attacker, Transform.ROTATION), 9.8, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    elif eventAbility == Button.SECONDARY_FIRE:
        eventPlayer.applyImpulse(eventDirection + Vector.UP, 9.8, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    eventPlayer.dropped_xp_orb = true
    eventPlayer.is_using_ability[33] = true
    destroyEffect(eventPlayer.player_temp_effects[42])
    stopChasingVariable(eventPlayer.xp_orb_location)
    eventPlayer.in_combat = 0
    async(dropped_xp_orb, AsyncBehavior.NOOP)
    if eventPlayer.is_using_ability[5] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    #Burning Soul
    if eventPlayer.bought_and_upgraded_talents[19] > 0:
        eventPlayer.burning_soul_orb_timer = 4
        wait()
        async(dropped_burning_soul_orb, AsyncBehavior.RESTART)
        createEffect(getAllPlayers().exclude(eventPlayer), Effect.WIDOWMAKER_VENOM_MINE_TARGET_SOUND, Color.WHITE, eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, 66, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[54] = getLastCreatedEntity()
        xp_orb_mines[eventPlayer.getSlot()] = eventPlayer
    createEffect(getAllPlayers().exclude(eventPlayer) if eventPlayer.dropped_xp_orb == true else null, Effect.ORB, orb_rarity_colors[round(eventPlayer.amount_of_talents_purchased / 5.56)], updateEveryTick(eventPlayer.getPosition() + Vector.UP * 0.25) if eventPlayer.is_using_ability[33] == true else updateEveryTick(eventPlayer.xp_orb_location), 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    eventPlayer.player_temp_effects[42] = getLastCreatedEntity()
    eventPlayer.is_respawning = true
    if attacker == victim:
        eventPlayer.addToScore(1)
    waitUntil(eventPlayer.isInAir() == true, 0.25)
    waitUntil(eventPlayer.isOnGround() == true, 2.75)
    eventPlayer.xp_orb_location = eventPlayer.getPosition() + Vector.UP * 0.25
    if eventPlayer.isOnGround() == true:
        return
    eventPlayer.xp_orb_destination = eventPlayer.xp_orb_location + Vector.DOWN * 100
    chase(eventPlayer.xp_orb_location, raycast(eventPlayer.xp_orb_location, eventPlayer.xp_orb_destination, null, getAllPlayers(), true).getHitPosition() + Vector.UP * 0.25, rate=9.8, ChaseReeval.DESTINATION_AND_RATE)


rule "GENERAL - - - Player Dealt Damage":
    @Event playerDealtDamage
    @Hero soldier
    
    if eventPlayer.bought_and_upgraded_talents[0] > 0 and eventPlayer.is_using_ability[20] == true:
        eventPlayer.bloodthirst_shield[0] += (eventDamage * (0.187 + eventPlayer.bought_and_upgraded_talents[0] * 0.063)) * (2.25 - eventPlayer.bought_and_upgraded_talents[0] * 0.25)
    attacker.using_hearthstone_timer = 0
    if attacker.is_using_ability[1] == false:
        attacker.in_combat = 3
    if eventPlayer.experience_current < eventPlayer.experience_max and attacker != victim:
        eventPlayer.experience_current += eventDamage / 5 * eventPlayer.stats[5]
    if attacker.bought_and_upgraded_talents[5] > 0 and attacker.is_using_ability[1] == false:
        attacker.entering_stealth = false
        stopChasingVariable(attacker.entering_stealth_timer)
        attacker.entering_stealth_timer = 0
    #MELEE
    if eventAbility == Button.MELEE:
        if eventPlayer.bought_and_upgraded_talents[5] > 0 and eventPlayer.is_using_ability[5] == true:
            async(break_stealth, AsyncBehavior.NOOP)
        #Dealt Stealth damage?
        if victim.is_using_ability[1] == false and eventPlayer.is_using_ability[5] == true and eventAbility != null:
            playEffect([player for player in getAllPlayers() if player != victim], DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION, Color.TEAM_1, victim, 1)
            playEffect([player for player in getAllPlayers() if player != victim], DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, Color.TEAM_1, victim, 100)
            victim.hit_by_talent[5] = attacker
            victim.setStatusEffect(attacker, Status.STUNNED, 0.5)
            #Wait so that Ignore Pain can trigger before damage
            wait()
            damage(victim, attacker, 50)
            playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT_SOUND, Color.WHITE, victim.getPosition(), 100)
            playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 100)
        #Dealt Predator damage?
        if eventPlayer.bought_and_upgraded_talents[10] > 0 and eventPlayer.predator_cooldown == 0 and victim.can_be_executed == true and victim.is_using_ability[1] == false and victim.getHealth() <= victim.getMaxHealth() * 0.25 == true and attacker.is_using_ability[1] == false:
            smallMessage(eventPlayer, "{0} Executed {1}!".format(abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), victim))
            if attacker.bought_and_upgraded_talents[29] > 0:
                victim.hit_by_talent[29] = attacker
            victim.hit_by_talent[10] = attacker
            attacker.predator_cooldown = 40 - attacker.bought_and_upgraded_talents[10] * 6
            playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, Color.WHITE, victim.getPosition() + Vector.UP, 100)
            playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.WHITE, victim.getPosition() + Vector.UP, 1)
        #PRIMARY FIRE || ULTIMATE
    elif (eventAbility == Button.PRIMARY_FIRE or eventAbility == Button.ULTIMATE) == true:
        #Railgun?
        if attacker.bought_and_upgraded_talents[9] > 0:
            eventPlayer.railgun_discharge = 6
            if attacker.railgun_charge < 100:
                attacker.railgun_charge += eventDamage * 0.375 + eventDamage * attacker.bought_and_upgraded_talents[17] * 0.038
        #Engineer?
        if attacker.bought_and_upgraded_talents[3] > 0:
            if attacker.engineer_scrap < 100:
                attacker.engineer_scrap += eventDamage * (0.037 + attacker.bought_and_upgraded_talents[3] * 0.013)
        if attacker.bought_and_upgraded_talents[12] > 0 and attacker.getHealthOfType(Health.NORMAL) < attacker.getMaxHealthOfType(Health.NORMAL):
            heal(attacker, attacker, min(eventDamage * (0.112 + eventPlayer.bought_and_upgraded_talents[12] * 0.038), eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)))
            eventPlayer.is_lifestealing = 1.5
            lifesteal_hps()
        #SECONDARY FIRE
    elif eventAbility == Button.SECONDARY_FIRE:
        if eventPlayer.bought_and_upgraded_talents[8] > 0 and victim.is_using_ability[6] == false and victim.is_using_ability[1] == false and victim.is_using_ability[18] == false:
            victim.hit_by_talent[8] = attacker
        if attacker.bought_and_upgraded_talents[16] > 0:
            if victim.is_using_ability[1] == false:
                victim.setStatusEffect(attacker, Status.BURNING, 3)
                victim.startDoT(attacker, 3, floor(attacker.bought_and_upgraded_talents[16] * 0.056 * eventDamage))
        if attacker.bought_and_upgraded_talents[12] > 0:
            heal(attacker, attacker, min(eventDamage * (0.112 + eventPlayer.bought_and_upgraded_talents[12] * 0.038), eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)))
            eventPlayer.is_lifestealing = 1.5
            playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.TEAM_1, attacker.getPosition(), 100)
            lifesteal_hps()
        if attacker.bought_and_upgraded_talents[16] > 0 and attacker.is_using_ability[16] == true:
            attacker.is_using_ability[16] = false


rule "GENERAL - - - Player Took Damage":
    @Event playerTookDamage
    
    attacker.using_hearthstone_timer = 0
    if victim.is_using_ability[1] == false:
        victim.in_combat = 3
    if victim.bought_and_upgraded_talents[5] > 0 and victim.is_using_ability[1] == false:
        stopChasingVariable(victim.entering_stealth_timer)
        victim.entering_stealth_timer = 0
        if eventPlayer.is_using_ability[5] == true:
            async(break_stealth, AsyncBehavior.NOOP)
    if victim.is_using_ability[22] == true and attacker.getCurrentHero() == Hero.SOLDIER and victim.is_using_ability[1] == false:
        eventPlayer.ignore_pain_damage_resisted[0] += eventDamage


rule "GENERAL - - - Player Slowed (Hit by Cryogenics Talent)":
    @Event eachPlayer
    @Condition eventPlayer.slow_amount < eventPlayer.stats[2]
    @Condition eventPlayer.refresh_slow == true
    
    stopChasingVariable(eventPlayer.slow_amount)
    eventPlayer.refresh_slow = false
    eventPlayer.setAbility1Enabled(false)
    chase(eventPlayer.slow_amount, eventPlayer.stats[2], duration=eventPlayer.slow_duration, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.isAlive() == true and eventPlayer.slow_amount != eventPlayer.stats[2] and eventPlayer.is_using_ability[1] == false and eventPlayer.is_using_ability[6] == false and eventPlayer.is_using_ability[18] == false:
        eventPlayer.setMoveSpeed(eventPlayer.slow_amount)
        wait(0.032, Wait.RESTART_WHEN_TRUE)
    stopChasingVariable(eventPlayer.slow_amount)
    eventPlayer.slow_amount = eventPlayer.stats[2]
    if eventPlayer.is_using_ability[1] == true:
        eventPlayer.setMoveSpeed(25)
    elif eventPlayer.is_using_ability[6] == true:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2] * 3)
    else:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.slow_duration = 0


def dropped_xp_orb():
    @Name "GENERAL - - - Dropped XP Orb"
    
    while eventPlayer.dropped_xp_orb == true:
        if (len([player for player in (getPlayersInRadius(eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, 2, Team.ALL, LosCheck.OFF)) if player.getCurrentHero() == Hero.SOLDIER and player != eventPlayer])) > 0:
            waitUntil(((((sorted([player for player in (getPlayersInRadius(eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, 2, Team.ALL, LosCheck.OFF)) if player.getCurrentHero() == Hero.SOLDIER and player != eventPlayer], lambda i: distance(eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, i.getPosition())))[0]).hit_by_talent)[33]) == null, 99999)
            (((sorted([player for player in (getPlayersInRadius(eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, 2, Team.ALL, LosCheck.OFF)) if player.getCurrentHero() == Hero.SOLDIER and player != eventPlayer], lambda i: distance(eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, i.getPosition())))[0]).hit_by_talent)[33] = eventPlayer
        wait(0.25)


rule "GENERAL - - - Picked Up XP Orb":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.hit_by_talent[33] != null
    
    if eventPlayer.experience_current < eventPlayer.experience_max:
        smallMessage(eventPlayer, "{0} +{1} XP!".format(abilityIconString(Hero.GENJI, Button.JUMP), round(eventPlayer.hit_by_talent[33].experience_max * 0.2 * eventPlayer.stats[5])))
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 75)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, orb_rarity_colors[round(eventPlayer.hit_by_talent[33].amount_of_talents_purchased / 5.56)], eventPlayer.getPosition(), 1)
    #EXPERIENCE
    if eventPlayer.experience_current < eventPlayer.experience_max:
        eventPlayer.experience_current += eventPlayer.hit_by_talent[33].experience_max * 0.2 * eventPlayer.stats[5]
    #MINE?
    if eventPlayer.hit_by_talent[33].bought_and_upgraded_talents[19] > 0 and eventPlayer.hit_by_talent[33].burning_soul_orb_timer > 0:
        eventPlayer.hit_by_talent[33].burning_soul_orb_timer = 0
    eventPlayer.hit_by_talent[33].dropped_xp_orb = false
    wait()
    eventPlayer.hit_by_talent[33] = null
    if eventPlayer.bought_and_upgraded_talents[32] > 0 and eventPlayer.amount_of_potions_or_vials < 3 and random.randint(0 + eventPlayer.bought_and_upgraded_talents[32] * 13.2, 100) > 66:
        eventPlayer.health_potion_cooldown_memory = eventPlayer.health_potion_cooldown
        eventPlayer.health_potion_cooldown = 0
        wait()
        if eventPlayer.amount_of_potions_or_vials < 3:
            eventPlayer.health_potion_cooldown = eventPlayer.health_potion_cooldown_memory
        eventPlayer.health_potion_cooldown_memory = 0
        smallMessage(eventPlayer, "{0} +1 {1}".format(iconString(Icon.RADIOACTIVE), "Health Potion!" if eventPlayer.bought_and_upgraded_talents[14] > 0 else "Poison Vial!"))
    if eventPlayer.bought_and_upgraded_talents[18] > 0:
        eventPlayer.shadowstep_cooldown = 0
    if eventPlayer.bought_and_upgraded_talents[3] > 0 and eventPlayer.engineer_scrap < 100:
        eventPlayer.engineer_scrap += 25


rule "GENERAL - - - Anti Crash Enable":
    @Condition antiCrashActivated == false
    @Condition getServerLoad() > 200
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), "Anti crash system activated")
    setSlowMotion(10)
    antiCrashActivated = true


rule "GENERAL - - - Anti Crash Disable":
    @Condition antiCrashActivated == true
    @Condition getServerLoad() < 175
    
    setSlowMotion(100)
    antiCrashActivated = false