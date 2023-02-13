settings {
    "main": {
        "description": "Discover new ways to play with Soldier: 76! Level up and choose talents that change the way you play. Some talent examples: Sneak around in Stealth - Blast other players with Fireball - Heal yourself with Healing Potions -------------------------------- Big thanks to everyone that has helped me in the Elo Hell Workshops Discord. This wouldn't be possible without you guys!",
        "modeName": "<fg00ffffff>S<fg2bffffff>o<fg55ffffff>l<fg80ffffff>d<fgaaffffff>i<fgd5ffffff>e<fgffffffff>r: X [v3.0]</fg>"
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
            "enabledMaps": [
                "blackForest",
            ]
            /*"disabledMaps": [
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
            ]*/
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

enum Talent:
    BLOODTHIRST,
    PURITY_FIELD,
    CYBERNETICS,
    ENGINEER,
    SHADOWSTRIKE,
    STEALTH,
    JUGGERNAUT,
    DIVE_BOMB,
    CRYOGENICS,
    RAILGUN,
    PREDATOR,
    JETPACK,
    LIFESTEAL_AMMO,
    HEALTH_REGEN,
    HEALTH_POTIONS,
    IGNITE,
    OVERCLOCK,
    SHADOWSTEP,
    BURNING_SOUL,
    BERSERKER,
    FIREBALL,
    IGNORE_PAIN,
    JAVELIN,
    SOUL_SIPHON,
    PYROMANIAC,
    POISON_VIALS,
    CRAZY_ALCHEMIST

#Global variables
globalvar debugging = false
globalvar amount_of_dummy_bots = 0
globalvar map_is_changing = false
globalvar antiCrashActivated
globalvar dummy_bot_spawn_facing
globalvar dummy_bot_spawn_position
globalvar health_potions_time_in_combat
globalvar health_potions_total_healing
globalvar health_regen_time_in_combat
globalvar health_regen_total_healing
globalvar ignore_pain_time_in_combat
globalvar ignore_pain_total_resisted
globalvar lifesteal_time_in_combat
globalvar lifesteal_total_healing
globalvar orb_rarity_colors = [Color.WHITE, Color.GREEN, Color.BLUE, Color.PURPLE, Color.ORANGE, Color.RED]
globalvar pathfinding_connections
globalvar pathfinding_positions
globalvar talent_rarity_colors = [Color.WHITE, Color.WHITE, Color.GREEN, Color.BLUE, Color.PURPLE, Color.ORANGE]
globalvar xp_orb_effects = [null, null, null, null, null, null, null, null]
globalvar xp_orb_locations = [null, null, null, null, null, null, null, null]
globalvar xp_orb_mines = [null, null, null, null, null, null, null, null]
globalvar xp_orb_values = [null, null, null, null, null, null, null, null]

#Player variables
playervar totalTimeElapsed
playervar dummy_var
playervar amount_of_potions_or_vials
playervar amount_of_talents_purchased = 0
playervar bought_talents = []
playervar browsing_shop
playervar can_enter_shop = false
playervar poison_vials_cloudData
playervar dropped_xp_orb
playervar experience_current = 0
playervar experience_max = 250
playervar healing_done_in_combat
playervar health_potion_cooldown_memory
playervar in_combat = 0
playervar indexMemory
playervar interactablePlayers
playervar is_electrified = 0
playervar is_using_ability = []
playervar is_using_hearthstone = [false, false]
playervar javelin_middle_position
playervar juggernaut_charge
playervar talents_offered_in_shop
playervar pathfinding_pos_pre_current_next
playervar player_name = "{0}".format(eventPlayer)
playervar player_temp_effects
playervar poison_vial_clouds_spawned
playervar poison_vial_effects
playervar possible_talents = [Talent.PURITY_FIELD, Talent.CYBERNETICS, Talent.ENGINEER, Talent.SHADOWSTRIKE, Talent.STEALTH, Talent.JUGGERNAUT, Talent.DIVE_BOMB, Talent.CRYOGENICS, Talent.RAILGUN, Talent.PREDATOR, Talent.JETPACK, Talent.LIFESTEAL_AMMO, Talent.HEALTH_REGEN, Talent.HEALTH_POTIONS, Talent.IGNITE, Talent.SHADOWSTEP, Talent.BURNING_SOUL, Talent.BERSERKER, Talent.FIREBALL, Talent.IGNORE_PAIN, Talent.POISON_VIALS]
playervar poison_vials_projPos
playervar poison_vials_projPosIn0032
playervar random_integer_between_0_to_5
/*playervar replace_replacing_or_cancelled = [false, false, false]*/
playervar selected_talent = [1, 0]
playervar skipped_a_talent
#[0] = Damage, [1] = Health, [2] = Speed, [3] = Armor, [4] = Shields, [5] = XP, [6] = Voice, [7] = Berserker Helper
playervar stats = [100, 250, 100, 0, 0, 0.65, 1, 0]
playervar talent_counter_or_position_etc
playervar talent_ranks = []
playervar talents_you_do_not_have = [Talent.PURITY_FIELD, Talent.CYBERNETICS, Talent.ENGINEER, Talent.SHADOWSTRIKE, Talent.STEALTH, Talent.JUGGERNAUT, Talent.DIVE_BOMB, Talent.CRYOGENICS, Talent.RAILGUN, Talent.PREDATOR, Talent.JETPACK, Talent.LIFESTEAL_AMMO, Talent.HEALTH_REGEN, Talent.HEALTH_POTIONS, Talent.IGNITE, Talent.SHADOWSTEP, Talent.BURNING_SOUL, Talent.BERSERKER, Talent.FIREBALL, Talent.IGNORE_PAIN, Talent.POISON_VIALS]
playervar time_since_poison_vial_exploded
playervar using_one_of_the_hearthstones
playervar which_is_talent_unique_unlocked = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
playervar xp_boost_is_active
playervar xp_orb_destination

#!defineMember is_using_hearthstone dummy_var[0]
#!defineMember is_using_skip_talent dummy_var[1]
#!defineMember is_using_vote_yes dummy_var[2]
#!defineMember is_using_vote_no dummy_var[3]
#!defineMember replacing_talent_show_confirmation dummy_var[4]
#!defineMember replacing_talent_show_bought_talents dummy_var[5]
#!defineMember replacing_talent_cancelled dummy_var[6]
#!defineMember totalTimeElapsed_alignment dummy_var[7]

#Subroutine names
subroutine bloodthirst_effects
subroutine break_stealth
subroutine cancel_juggernaut
subroutine cancel_shop_camera
subroutine create_talent_helpers
subroutine create_talent_hud_texts
subroutine dropped_burning_soul_orb
subroutine dropped_xp_orb
subroutine If_map
subroutine juggernaut_effects
subroutine juggernaut_impulse_sound_cd
subroutine juggernaut_knockback
subroutine map_antarctica
subroutine map_black_forest
subroutine map_blizzard_world
subroutine map_chateau_guillard
subroutine map_eichenwalde
subroutine map_hollywood
subroutine map_kanezaka
subroutine map_kings_row
subroutine map_malevento
subroutine map_necropolis
subroutine map_paris
subroutine map_petra
subroutine new_reaper_pathfinding
subroutine replace_talent
subroutine shadowstrike
subroutine spawned_with_fireball
subroutine start_pathfinding
subroutine stopped_using_hearthstone
subroutine using_one_of_the_hearthstones

#Activated extensions

#!extension buffStatusEffects
#!extension debuffStatusEffects
#!extension energyExplosionEffects
#!extension kineticExplosionEffects
#!extension explosionSounds
#!extension buffAndDebuffSounds

#!define generateTalents() __script__("talents.js")
generateTalents()

#!define SHADOWSTEP_BASE_COOLDOWN 22.5
#!define SHADOWSTEP_COOLDOWN_REDUCTION_PER_RANK 2.5
#!define STEALTH_BASE_COOLDOWN 20
#!define STEALTH_COOLDOWN_REDUCTION_PER_RANK 4
#!define PREDATOR_COOLDOWN_REDUCTION_PER_RANK 6
#!define HEALTH_POTIONS_COOLDOWN_REDUCTION_PER_RANK 1

#!include "bots.opy"
#!include "xp.opy"
#!include "shop.opy"
#!include "talents.opy"
#!include "debug.opy"

rule "GENERAL - - - Global Variables":
    /*disableInspector()*/
    If_map()
    createInWorldText(localPlayer if localPlayer.browsing_shop == true else null, "YES {0}                        {2} NO".format(buttonString(Button.PRIMARY_FIRE), null, buttonString(Button.SECONDARY_FIRE)) if localPlayer.replacing_talent_show_confirmation == true else "{0}            {1}            {2}".format(buttonString(Button.PRIMARY_FIRE) if localPlayer.replacing_talent_show_bought_talents == true else buttonString(Button.PRIMARY_FIRE) if localPlayer.selected_talent[0] >= 1 else "    ", buttonString(Button.INTERACT), buttonString(Button.SECONDARY_FIRE) if localPlayer.replacing_talent_show_bought_talents == true else buttonString(Button.SECONDARY_FIRE) if localPlayer.selected_talent[0] <= 1 else "    "), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 0.375, 0), 1.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    async(create_talent_hud_texts, AsyncBehavior.NOOP)
    async(create_talent_helpers, AsyncBehavior.NOOP)
    #Additional Talent Descriptions
    createInWorldText(localPlayer if localPlayer.browsing_shop == true and localPlayer.replacing_talent_show_confirmation == false and localPlayer.replacing_talent_show_bought_talents == false else null, "Hold {0} for more information...".format(buttonString(Button.JUMP)) if localPlayer.isHoldingButton(Button.JUMP) == false else "{0}".format(additional_information[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]]), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.25, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.GRAY if localPlayer.isHoldingButton(Button.JUMP) == false else Color.WHITE, SpecVisibility.DEFAULT)
    #Talent Information Unique
    createInWorldText(localPlayer if (localPlayer.browsing_shop and localPlayer.isHoldingButton(Button.JUMP) and not localPlayer.replacing_talent_show_confirmation and not localPlayer.replacing_talent_show_bought_talents and is_talent_unique[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]]) else null, "[Unique]: {} Can not be learned after learning {}".format(talent_names[talent_information_unique[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]]], talent_names[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]]), localPlayer.selected_talent_location + vect(0, -1.5, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    #Talent Information Expand Mind
    createInWorldText(localPlayer if localPlayer.browsing_shop and talent_information_expand_mind[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]] != null and localPlayer.isHoldingButton(Button.JUMP) and not localPlayer.replacing_talent_show_confirmation and not localPlayer.replacing_talent_show_bought_talents else null, "[Expand Mind]: {} can appear in shop after learning {}".format(talent_names[talent_information_expand_mind[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]]], talent_names[localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]]]), localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.375, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    /*createInWorldText(localPlayer if (localPlayer.browsing_shop == true and localPlayer.replacing_talent_show_confirmation == false and localPlayer.replacing_talent_show_bought_talents == false) == true and localPlayer.isHoldingButton(Button.JUMP) == true else null, "Rank {0}: Amount healed: {1}% of the damage you dealt during {2}.".format(localPlayer.talent_ranks[Talent.BLOODTHIRST] + 1, round((100 * (0.187 + ((localPlayer.talent_ranks[Talent.BLOODTHIRST] + 1) * 0.063))) * (2.25 - ((localPlayer.talent_ranks[Talent.BERSERKER] + 1) * 0.25))), talent_names[Talent.BERSERKER]) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.BLOODTHIRST] else "Rank {0}: Duration: {1} sec, {2}".format(localPlayer.talent_ranks[Talent.PURITY_FIELD] + 1, 3.75 + ((localPlayer.talent_ranks[Talent.PURITY_FIELD] + 1) * 1.25), "Healing Received: {0}%, Cooldown: {1} sec.".format(125 + ((localPlayer.talent_ranks[Talent.PURITY_FIELD] + 1) * 25), 45)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.PURITY_FIELD] else "Rank {0}: Total Shields: {1}.".format(localPlayer.talent_ranks[Talent.CYBERNETICS] + 1, 40 * (localPlayer.talent_ranks[Talent.PURITY_FIELD] + 1)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.CYBERNETICS] else "Rank {0}: Charge Rate: {1}% of the damage you deal with primary fire, Total Armor Repaired: 100.".format(localPlayer.talent_ranks[Talent.ENGINEER] + 1, round(100 * (0.037 + ((localPlayer.talent_ranks[Talent.ENGINEER] + 1) * 0.013)))) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.ENGINEER] else "Rank {0}: Damage: {1}, Cooldown without hitting any targets: 20 sec.".format(localPlayer.talent_ranks[Talent.SHADOWSTRIKE] + 1, round(56.25 + ((localPlayer.talent_ranks[Talent.SHADOWSTRIKE] + 1) * 18.75))) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.SHADOWSTRIKE] else "Rank {0}: Duration: {1} sec, {2}.".format(localPlayer.talent_ranks[Talent.STEALTH] + 1, round(10 + ((localPlayer.talent_ranks[Talent.STEALTH] + 1) * 2)), "Cooldown: {0} sec, Anti Healing Duration: 4 sec, Damage: 50.".format(20 - ((localPlayer.talent_ranks[Talent.STEALTH] + 1) * 4))) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.STEALTH] else "Rank {0}: Damage: {1}, Cooldown: 20 sec, Charge Duration: 10 sec, Stun Duration: Charge duration + 1.5 sec.".format(localPlayer.talent_ranks[Talent.JUGGERNAUT] + 1, 125 + ((localPlayer.talent_ranks[Talent.JUGGERNAUT] + 1) * 25)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.JUGGERNAUT] else "Rank {0}: Damage: {1}, Cooldown: 20 sec.".format(localPlayer.talent_ranks[Talent.DIVE_BOMB] + 1, 125 + ((localPlayer.talent_ranks[Talent.DIVE_BOMB] + 1) * 25)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.DIVE_BOMB] else "Rank {0}: Slow Amount: {2}%, Slow Duration: {1} sec.".format(localPlayer.talent_ranks[Talent.DIVE_BOMB] + 1, 2 + ((localPlayer.talent_ranks[Talent.CRYOGENICS] + 1) * 0.2), 50 + ((localPlayer.talent_ranks[Talent.CRYOGENICS] + 1) * 10)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.CRYOGENICS] else "Rank {0}: Damage {1}, Charge Rate: {2}% of the damage you deal with primary fire.".format(localPlayer.talent_ranks[Talent.RAILGUN] + 1, 81.25 + ((localPlayer.talent_ranks[Talent.RAILGUN] + 1) * 18.75), 100 * 0.375) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.RAILGUN] else "Rank {0}: Cooldown: {1}, Execution range: <25% Health.".format(localPlayer.talent_ranks[Talent.PREDATOR] + 1, 40 - ((localPlayer.talent_ranks[Talent.PREDATOR] + 1) * 6)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.PREDATOR] else "Rank {0}: Time to deplete fuel from 100-0%: {1} sec, Time to recharge fuel from 0-100%: 10 sec.".format(localPlayer.talent_ranks[Talent.JETPACK] + 1, 4 + ((localPlayer.talent_ranks[Talent.JETPACK] + 1) * 1.2)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.JETPACK] else "Rank {0}: Healing: {1}% of damage you deal with primary or secondary fire.".format(localPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] + 1, (11.2 + ((localPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] + 1) * 3.8)) / 100) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.LIFESTEAL_AMMO] else "Rank {0}: Healing: {1}/sec.".format(localPlayer.talent_ranks[Talent.HEALTH_REGEN] + 1, 4.5 + ((localPlayer.talent_ranks[Talent.HEALTH_REGEN] + 1) * 0.9)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.HEALTH_REGEN] else "Rank {0}: Healing: {1}/potion. Potion Recharge: 15 sec.".format(localPlayer.talent_ranks[Talent.HEALTH_POTIONS] + 1, 43.75 + ((localPlayer.talent_ranks[Talent.HEALTH_POTIONS] + 1) * 17.5)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.HEALTH_POTIONS] else "Rank {0}: Damage: {1}-{2}. Cooldown: 6 sec.".format(localPlayer.talent_ranks[Talent.IGNITE] + 1, floor(((localPlayer.talent_ranks[Talent.IGNITE] + 1) * 0.168) * 40), floor(((localPlayer.talent_ranks[Talent.IGNITE] + 1) * 0.168) * 120)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.IGNITE] else "Rank {0}: Additional Charge Rate: {1}% of the damage you deal with primary fire.".format(localPlayer.talent_ranks[Talent.OVERCLOCK] + 1, 100 * localPlayer.talent_ranks[Talent.OVERCLOCK] * 0.075) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.OVERCLOCK] else "Rank {0}: Cooldown: {1} sec.".format(localPlayer.talent_ranks[Talent.SHADOWSTEP] + 1, 22.5 - ((localPlayer.talent_ranks[Talent.SHADOWSTEP] + 1) * 2.5)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.SHADOWSTEP] else "Rank {0}: Damage: {1}, Orb Damage: {2}.".format(localPlayer.talent_ranks[Talent.BURNING_SOUL] + 1, 12 + ((localPlayer.talent_ranks[Talent.BURNING_SOUL] + 1) * 2.4), 75 + ((localPlayer.talent_ranks[Talent.BURNING_SOUL] + 1) * 25)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.BURNING_SOUL] else "Rank {0}: Duration: {1}, Cooldown: 45 sec, Damage Done: 125%, Damage Taken: 110%.".format(localPlayer.talent_ranks[Talent.BERSERKER] + 1, 3.75 + ((localPlayer.talent_ranks[Talent.BERSERKER] + 1) * 1.25)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.BERSERKER] else "Rank {0}: Damage: {1}, Cooldown: 12 sec, Radius: 4m.".format(localPlayer.talent_ranks[Talent.FIREBALL] + 1, 75 + ((localPlayer.talent_ranks[Talent.FIREBALL] + 1) * 25)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.FIREBALL] else "Rank {0}: Damage taken when active: {1}%.".format(localPlayer.talent_ranks[Talent.IGNORE_PAIN] + 1, 66.666 - ((localPlayer.talent_ranks[Talent.IGNORE_PAIN] + 1) * 6.666)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.IGNORE_PAIN] else "Rank {0}: Healing: {1}.".format(localPlayer.talent_ranks[Talent.SOUL_SIPHON] + 1, 150 + ((localPlayer.talent_ranks[Talent.SOUL_SIPHON] + 1) * 50)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.SOUL_SIPHON] else "Rank {0}: Healing: {1}.".format(localPlayer.talent_ranks[Talent.PYROMANIAC] + 1, 75 + ((localPlayer.talent_ranks[Talent.FIREBALL] + 1) * 25)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.PYROMANIAC] else "Rank {0}: Damage: {1}/Vial, Vial Recharge: 15 sec, Radius: 3m.".format(localPlayer.talent_ranks[Talent.POISON_VIALS] + 1, 56.25 + ((localPlayer.talent_ranks[Talent.POISON_VIALS] + 1) * 18.75)) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.POISON_VIALS] else "Rank {0}: Cooldown reduced: {1} sec, Chance to get an extra charge when picking up an xp orb: {2}%.".format(localPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] + 1, localPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] + 1, (localPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] + 1) * 20) if localPlayer.talents_offered_in_shop[localPlayer.selected_talent[0]] == [Talent.CRAZY_ALCHEMIST] else "", localPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.625, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)*/

rule "GENERAL - - - [EACH PLAYER] INIT":
    @Event eachPlayer

    if eventPlayer.isDummy() == false:
        #[HUD Text for talent slot 1]
        hudText(eventPlayer if len(eventPlayer.bought_talents) >= 1 else null, "{0}".format(talent_names[eventPlayer.bought_talents[0]]), "Cooldown: {0}".format(eventPlayer.talent_trigger_times[eventPlayer.bought_talents[0]] + talent_base_cooldowns[eventPlayer.bought_talents[0]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[0]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[0]]) - eventPlayer.totalTimeElapsed) if eventPlayer.talent_trigger_times[eventPlayer.bought_talents[0]] + talent_base_cooldowns[eventPlayer.bought_talents[0]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[0]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[0]]) > eventPlayer.totalTimeElapsed else "", "{0}".format(talent_keybinds[eventPlayer.bought_talents[0]].replace("[F]", buttonString(Button.INTERACT)).replace("[R]", buttonString(Button.RELOAD)).replace("[E]", buttonString(Button.ABILITY_2)).replace("[Q]", buttonString(Button.ULTIMATE)).replace("[SHIFT]", buttonString(Button.ABILITY_1)).replace("[CTRL]", buttonString(Button.CROUCH)).replace("[SPACEBAR]", buttonString(Button.JUMP)).replace("[LEFTCLICK]", buttonString(Button.PRIMARY_FIRE)).replace("[RIGHTCLICK]", buttonString(Button.SECONDARY_FIRE)).replace("[MELEE]", buttonString(Button.MELEE))), HudPosition.LEFT, 0, talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[0]]], talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[0]]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
        #[HUD Text for talent slot 2]
        hudText(eventPlayer if len(eventPlayer.bought_talents) >= 2 else null, "{0}".format(talent_names[eventPlayer.bought_talents[1]]), "Cooldown: {0}".format(eventPlayer.talent_trigger_times[eventPlayer.bought_talents[1]] + talent_base_cooldowns[eventPlayer.bought_talents[1]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[1]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[1]]) - eventPlayer.totalTimeElapsed) if eventPlayer.talent_trigger_times[eventPlayer.bought_talents[1]] + talent_base_cooldowns[eventPlayer.bought_talents[1]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[1]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[1]]) > eventPlayer.totalTimeElapsed else "", "{0}".format(talent_keybinds[eventPlayer.bought_talents[1]].replace("[F]", buttonString(Button.INTERACT)).replace("[R]", buttonString(Button.RELOAD)).replace("[E]", buttonString(Button.ABILITY_2)).replace("[Q]", buttonString(Button.ULTIMATE)).replace("[SHIFT]", buttonString(Button.ABILITY_1)).replace("[CTRL]", buttonString(Button.CROUCH)).replace("[SPACEBAR]", buttonString(Button.JUMP)).replace("[LEFTCLICK]", buttonString(Button.PRIMARY_FIRE)).replace("[RIGHTCLICK]", buttonString(Button.SECONDARY_FIRE)).replace("[MELEE]", buttonString(Button.MELEE))), HudPosition.LEFT, 1, talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[1]]], talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[1]]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
        #[HUD Text for talent slot 3]
        hudText(eventPlayer if len(eventPlayer.bought_talents) >= 3 else null, "{0}".format(talent_names[eventPlayer.bought_talents[2]]), "Cooldown: {0}".format(eventPlayer.talent_trigger_times[eventPlayer.bought_talents[2]] + talent_base_cooldowns[eventPlayer.bought_talents[2]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[2]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[2]]) - eventPlayer.totalTimeElapsed) if eventPlayer.talent_trigger_times[eventPlayer.bought_talents[2]] + talent_base_cooldowns[eventPlayer.bought_talents[2]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[2]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[2]]) > eventPlayer.totalTimeElapsed else "", "{0}".format(talent_keybinds[eventPlayer.bought_talents[2]].replace("[F]", buttonString(Button.INTERACT)).replace("[R]", buttonString(Button.RELOAD)).replace("[E]", buttonString(Button.ABILITY_2)).replace("[Q]", buttonString(Button.ULTIMATE)).replace("[SHIFT]", buttonString(Button.ABILITY_1)).replace("[CTRL]", buttonString(Button.CROUCH)).replace("[SPACEBAR]", buttonString(Button.JUMP)).replace("[LEFTCLICK]", buttonString(Button.PRIMARY_FIRE)).replace("[RIGHTCLICK]", buttonString(Button.SECONDARY_FIRE)).replace("[MELEE]", buttonString(Button.MELEE))), HudPosition.LEFT, 2, talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[2]]], talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[2]]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
        #[HUD Text for talent slot 4]
        hudText(eventPlayer if len(eventPlayer.bought_talents) >= 4 else null, "{0}".format(talent_names[eventPlayer.bought_talents[3]]), "Cooldown: {0}".format(eventPlayer.talent_trigger_times[eventPlayer.bought_talents[3]] + talent_base_cooldowns[eventPlayer.bought_talents[3]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[3]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[3]]) - eventPlayer.totalTimeElapsed) if eventPlayer.talent_trigger_times[eventPlayer.bought_talents[3]] + talent_base_cooldowns[eventPlayer.bought_talents[3]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[3]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[3]]) > eventPlayer.totalTimeElapsed else "", "{0}".format(talent_keybinds[eventPlayer.bought_talents[3]].replace("[F]", buttonString(Button.INTERACT)).replace("[R]", buttonString(Button.RELOAD)).replace("[E]", buttonString(Button.ABILITY_2)).replace("[Q]", buttonString(Button.ULTIMATE)).replace("[SHIFT]", buttonString(Button.ABILITY_1)).replace("[CTRL]", buttonString(Button.CROUCH)).replace("[SPACEBAR]", buttonString(Button.JUMP)).replace("[LEFTCLICK]", buttonString(Button.PRIMARY_FIRE)).replace("[RIGHTCLICK]", buttonString(Button.SECONDARY_FIRE)).replace("[MELEE]", buttonString(Button.MELEE))), HudPosition.LEFT, 3, talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[3]]], talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[3]]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)    
        #[HUD Text for talent slot 5]
        hudText(eventPlayer if len(eventPlayer.bought_talents) >= 5 else null, "{0}".format(talent_names[eventPlayer.bought_talents[4]]), "Cooldown: {0}".format(eventPlayer.talent_trigger_times[eventPlayer.bought_talents[4]] + talent_base_cooldowns[eventPlayer.bought_talents[4]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[4]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[4]]) - eventPlayer.totalTimeElapsed) if eventPlayer.talent_trigger_times[eventPlayer.bought_talents[4]] + talent_base_cooldowns[eventPlayer.bought_talents[4]] - (eventPlayer.talent_ranks[eventPlayer.bought_talents[4]] * talent_cd_reduction_p_rank[eventPlayer.bought_talents[4]]) > eventPlayer.totalTimeElapsed else "", "{0}".format(talent_keybinds[eventPlayer.bought_talents[4]].replace("[F]", buttonString(Button.INTERACT)).replace("[R]", buttonString(Button.RELOAD)).replace("[E]", buttonString(Button.ABILITY_2)).replace("[Q]", buttonString(Button.ULTIMATE)).replace("[SHIFT]", buttonString(Button.ABILITY_1)).replace("[CTRL]", buttonString(Button.CROUCH)).replace("[SPACEBAR]", buttonString(Button.JUMP)).replace("[LEFTCLICK]", buttonString(Button.PRIMARY_FIRE)).replace("[RIGHTCLICK]", buttonString(Button.SECONDARY_FIRE)).replace("[MELEE]", buttonString(Button.MELEE))), HudPosition.LEFT, 4, talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[4]]], talent_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[4]]], Color.YELLOW, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
        wait()
        eventPlayer.setAbility2Enabled(false)
        eventPlayer.setUltEnabled(false)
        progressBarHud(eventPlayer, eventPlayer.experience_current / eventPlayer.experience_max * 100, "Max Level - XP Boost: Active" if eventPlayer.amount_of_talents_purchased == 25 and eventPlayer.experience_current < eventPlayer.experience_max else "You can replace a talent" if eventPlayer.amount_of_talents_purchased == 25 and eventPlayer.experience_current >= eventPlayer.experience_max else "You have a talent point" if eventPlayer.can_enter_shop == true else "You skipped a talent! XP Boost: Active" if eventPlayer.skipped_a_talent == true else "Too far behind! XP Boost: Active" if eventPlayer.can_enter_shop == false and eventPlayer.xp_boost_is_active == true and eventPlayer.amount_of_talents_purchased > 0 else "First Level! XP Boost: Active" if (eventPlayer.can_enter_shop == false and eventPlayer.amount_of_talents_purchased == 0) == true else "", HudPosition.TOP, 1, Color.ORANGE, Color.ORANGE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
        wait()
        #Upgrade Information (or selected talent of bought talents when replacing talents)
        createInWorldText(eventPlayer if eventPlayer.browsing_shop == true and ((eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] > 0 or eventPlayer.replacing_talent_show_bought_talents == true) == true) else null, "{0}".format(talent_names[eventPlayer.bought_talents[eventPlayer.selected_talent[1]]]) if eventPlayer.replacing_talent_show_bought_talents == true else "{0}".format(upgrade_information[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]]), eventPlayer.selected_talent_location + vect(0, 0.125, 0) if eventPlayer.replacing_talent_show_bought_talents == true else eventPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1, 0), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE if eventPlayer.replacing_talent_show_bought_talents == true else orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]]], SpecVisibility.DEFAULT)
        wait()
        #Talent Descriptions
        createInWorldText(eventPlayer if eventPlayer.browsing_shop and not eventPlayer.replacing_talent_show_confirmation and not eventPlayer.replacing_talent_show_bought_talents else null, "{0}".format(talent_descriptions[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]]), eventPlayer.selected_talent_location + vect(0, -1 * 1 * 1 * 1.125, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        #Left Orb
        createEffect(eventPlayer if eventPlayer.browsing_shop and not eventPlayer.replacing_talent_show_confirmation and not eventPlayer.replacing_talent_show_bought_talents else null, Effect.ORB, orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[eventPlayer.selected_talent[1]]] - 1] if eventPlayer.replacing_talent_show_bought_talents == true else orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[0]]], shop_talent_positions[0], 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        wait()
        #Middle Orb
        createEffect(eventPlayer if eventPlayer.browsing_shop == true else null, Effect.ORB, Color.WHITE if eventPlayer.replacing_talent_show_confirmation == true and eventPlayer.replacing_talent_show_bought_talents == false else orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[eventPlayer.selected_talent[1]]] - 1] if eventPlayer.replacing_talent_show_bought_talents == true else orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[1]]], shop_talent_positions[eventPlayer.selected_talent] if eventPlayer.replacing_talent_show_confirmation or eventPlayer.replacing_talent_show_bought_talents else shop_talent_positions[1], 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        wait()
        #Right Orb
        createEffect(eventPlayer if eventPlayer.browsing_shop and not eventPlayer.replacing_talent_show_confirmation and not eventPlayer.replacing_talent_show_bought_talents else null, Effect.ORB, orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.bought_talents[eventPlayer.selected_talent[1]]] - 1] if eventPlayer.replacing_talent_show_bought_talents == true else orb_rarity_colors[eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[2]]], shop_talent_positions[2], 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        wait()
        #Left Talent
        createInWorldText(eventPlayer if eventPlayer.browsing_shop and not eventPlayer.replacing_talent_show_confirmation and not eventPlayer.replacing_talent_show_bought_talents else null, "{0}".format(talent_names[eventPlayer.talents_offered_in_shop[0]]), shop_talent_positions[0] + vect(0, 0.375, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        #Middle Talent
        createInWorldText(eventPlayer if eventPlayer.browsing_shop else null, "{0} Are you sure you want to replace one of your talents?".format(iconString(Icon.WARNING)) if eventPlayer.replacing_talent_show_confirmation else "{0} What talent would you like to replace?".format(iconString(Icon.WARNING)) if eventPlayer.replacing_talent_show_bought_talents else "{0}".format(talent_names[eventPlayer.talents_offered_in_shop[1]]), shop_talent_positions[eventPlayer.selected_talent] + vect(0, 0.375, 0) if eventPlayer.replacing_talent_show_confirmation or eventPlayer.replacing_talent_show_bought_talents else shop_talent_positions[1] + vect(0, 0.375, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
        wait()
        #Right Talent
        createInWorldText(eventPlayer if eventPlayer.browsing_shop and not eventPlayer.replacing_talent_show_confirmation and not eventPlayer.replacing_talent_show_bought_talents else null, "{0}".format(talent_names[eventPlayer.talents_offered_in_shop[2]]), shop_talent_positions[2] + vect(0, 0.375, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    eventPlayer.hit_by_talent[Talent.POISON_VIALS] = null
    eventPlayer.disableGamemodeHud()
    eventPlayer.setMaxHealth(eventPlayer.stats[1])
    chase(eventPlayer.in_combat, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.RAILGUN] == true or eventPlayer.hit_by_talent[Talent.RAILGUN] != null else null, Effect.WINSTON_TESLA_CANNON_TARGET, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer if eventPlayer.talent_ranks[Talent.RAILGUN] > 0 and eventPlayer.railgun_charge >= 100 or eventPlayer.hit_by_talent[Talent.RAILGUN] != null else null, Effect.WINSTON_TESLA_CANNON_TARGET_SOUND, Color.TEAM_1, eventPlayer, 50, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    chase(eventPlayer.is_electrified, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.CRYOGENICS] == true else null, Effect.MEI_FROZEN, Color.WHITE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.CRYOGENICS] == true else null, Effect.MEI_FROZEN_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

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
            continue
        if accurateTime > 14400 and map_is_changing == false:
            map_is_changing = true
            bigMessage(getAllPlayers(), "Game session lasted too long!")
            wait(7.5)
            bigMessage(getAllPlayers(), "Map will automatically change in 60 seconds...")
            setMatchTime(60)
            wait(7.5)
            bigMessage(getAllPlayers(), "Hope you enjoyed my game mode!")
            wait(7.5)
            bigMessage(getAllPlayers(), "Don't forget to join the Discord :)")
            return
        if map_is_changing == true:
            return
        #change map if no players and server time is above 3 hours
        setMatchTime(1)
        return

rule "GENERAL - - - Add Bots":
    @Condition spawn_bots == true
    @Condition len(getAllPlayers()) < 8
    
    createDummy(Hero.REAPER, Team.ALL, -1 * 1 * 1 * 1, dummy_bot_spawn_position, dummy_bot_spawn_facing)
    wait(1)
    if RULE_CONDITION:
        goto RULE_START

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
        shop_talent_positions[0] = vect(16.177, 8.003, -1 * 1 * 1 * 45.05)
        shop_talent_positions[1] = vect(13.174, 8.287, -1 * 1 * 1 * 44.887)
        shop_talent_positions[2] = vect(10.425, 8.09, -1 * 1 * 1 * 44.999)
    elif getCurrentMap() == Map.BLACK_FOREST or getCurrentMap() == Map.BLACK_FOREST_WINTER:
        map_black_forest()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 25.204, 12.546, 3.92)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 19.306, 13.739, 3.922)
        shop_location = vect(-1 * 1 * 1 * 33.308, 4.599, 1.094)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 38.288, 6.869, 2.713)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 38.063, 6.77, -1 * 1 * 1 * 0.092)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 36.726, 6.549, -1 * 1 * 1 * 2.176)
    elif getCurrentMap() == Map.HOLLYWOOD:
        map_hollywood()
        dummy_bot_spawn_position = vect(28.865, 7.252, -1 * 1 * 1 * 77.34)
        dummy_bot_spawn_facing = vect(28.865, 7.252, -1 * 1 * 1 * 77.34)
        shop_location = vect(-1 * 1 * 1 * 5.95, 4.611, -1 * 1 * 1 * 102.526)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 7.025, 4.948, -1 * 1 * 1 * 108.214)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 4.132, 5.164, -1 * 1 * 1 * 107.363)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 1.687, 4.883, -1 * 1 * 1 * 106.065)
    elif getCurrentMap() == Map.ECOPOINT_ANTARCTICA:
        map_antarctica()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 33.601, 9.455, -1 * 1 * 1 * 0.077)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 29.427, 10.582, 0.021)
        shop_location = vect(-1 * 1 * 1 * 11.287, 27.001, 22.31)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 15.965, 29.219, 25.678)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 16.535, 29.46, 22.783)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 16.45, 29.219, 19.92)
    elif getCurrentMap() == Map.CHATEAU_GUILLARD or getCurrentMap() == Map.CHATEAU_GUILLARD_HALLOWEEN:
        map_chateau_guillard()
        dummy_bot_spawn_position = vect(206.444, 15.955, 86.831)
        dummy_bot_spawn_facing = vect(206.444, 15.955, 86.831)
        shop_location = vect(247.531, -1 * 1 * 1 * 0.506, 50.543)
        shop_talent_positions[0] = vect(252.604, 1.63, 48.43)
        shop_talent_positions[1] = vect(252.429, 2.033, 51.359)
        shop_talent_positions[2] = vect(251.716, 1.586, 53.944)
    elif getCurrentMap() == Map.KINGS_ROW or getCurrentMap() == Map.KINGS_ROW_WINTER:
        map_kings_row()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 95.498, 7.937, -1 * 1 * 1 * 30.638)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 95.498, 7.937, -1 * 1 * 1 * 30.638)
        shop_location = vect(-1 * 1 * 1 * 140.793, 6.939, 22.963)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 144.654, 7.111, 26.609)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 145.924, 7.492, 23.767)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 145.762, 7.073, 20.701)
    elif getCurrentMap() == Map.BLIZZ_WORLD or getCurrentMap() == Map.BLIZZ_WORLD_WINTER:
        map_blizzard_world()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 45.778, 4.981, 95.978)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 45.778, 4.981, 95.978)
        shop_location = vect(-1 * 1 * 1 * 140.141, 1.684, 105.206)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 145.471, 3.066, 106.655)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 144.712, 3.141, 103.87)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 143.468, 2.792, 101.504)
    elif getCurrentMap() == Map.HANAMURA or getCurrentMap() == Map.HANAMURA_WINTER:
        dummy_bot_spawn_position = vect(11.903, 11.666, 21.966)
        dummy_bot_spawn_facing = vect(11.903, 11.666, 21.966)
        shop_location = vect(1.859, 0.68, 19.337)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 1.152, 1.611, 15.181)
        shop_talent_positions[1] = vect(1.875, 1.631, 14.133)
        shop_talent_positions[2] = vect(4.708, 1.483, 15.417)
    elif getCurrentMap() == Map.NECROPOLIS:
        map_necropolis()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 27.407, 9.455, -1 * 1 * 1 * 0.003)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 27.407, 9.455, -1 * 1 * 1 * 0.003)
        shop_location = vect(42.975, 8.571, -1 * 1 * 1 * 0.079)
        shop_talent_positions[0] = vect(46.729, 9.457, -1 * 1 * 1 * 4.042)
        shop_talent_positions[1] = vect(48.006, 9.655, -1 * 1 * 1 * 1.553)
        shop_talent_positions[2] = vect(48.256, 9.406, 1.45)
    elif getCurrentMap() == Map.PETRA:
        map_petra()
        dummy_bot_spawn_position = vect(43.642, 13.747, 33.965)
        dummy_bot_spawn_facing = vect(43.642, 13.747, 33.965)
        shop_location = vect(-1 * 1 * 1 * 52.288, -1 * 1 * 1 * 18.045, 5.863)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 56.327, -1 * 1 * 1 * 16.669, 9.215)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 57.335, -1 * 1 * 1 * 16.73, 5.903)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 56.46, -1 * 1 * 1 * 16.67, 2.626)
    elif getCurrentMap() == Map.KANEZAKA:
        map_kanezaka()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 8.115, 6.507, -1 * 1 * 1 * 38.928)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 8.115, 6.507, -1 * 1 * 1 * 38.928)
        shop_location = vect(-1 * 1 * 1 * 22.798, 23.978, 54.659)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 21.18, 24.327, 48.941)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 18.936, 24.588, 51.056)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 17.535, 24.302, 53.351)
    elif getCurrentMap() == Map.CASTILLO:
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 112.424, 33.763, 59.87)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 112.424, 33.763, 59.87)
        shop_location = vect(-1 * 1 * 1 * 60.288, 22.011, 50.687)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 55.86, 22.533, 46.725)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 54.774, 22.706, 49.529)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 54.935, 22.481, 52.534)
    elif getCurrentMap() == Map.DORADO:
        dummy_bot_spawn_position = vect(27.568, 4.221, -1 * 1 * 1 * 17.033)
        dummy_bot_spawn_facing = vect(27.568, 4.221, -1 * 1 * 1 * 17.033)
        shop_location = vect(78.814, -1 * 1 * 1 * 7.22, 60.419)
        shop_talent_positions[0] = vect(78.019, -1 * 1 * 1 * 6.203, 66.255)
        shop_talent_positions[1] = vect(75.547, -1 * 1 * 1 * 6.043, 64.771)
        shop_talent_positions[2] = vect(73.356, -1 * 1 * 1 * 6.27, 62.604)
    elif getCurrentMap() == Map.HAVANA:
        dummy_bot_spawn_position = vect(107.152, 2.067, -1 * 1 * 1 * 27.697)
        dummy_bot_spawn_facing = vect(107.152, 2.067, -1 * 1 * 1 * 27.697)
        shop_location = vect(108.634, -1 * 1 * 1 * 6.72, -1 * 1 * 1 * 98.952)
        shop_talent_positions[0] = vect(109.618, -1 * 1 * 1 * 6.593, -1 * 1 * 1 * 104.188)
        shop_talent_positions[1] = vect(112.271, -1 * 1 * 1 * 6.455, -1 * 1 * 1 * 103.031)
        shop_talent_positions[2] = vect(113.836, -1 * 1 * 1 * 6.6, -1 * 1 * 1 * 100.569)
    elif getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 5.277, 8.455, -1 * 1 * 1 * 0.963)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 5.277, 8.455, -1 * 1 * 1 * 0.963)
        shop_location = vect(-1 * 1 * 1 * 38.034, 19.101, -1 * 1 * 1 * 98.472)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 40.56, 20.427, -1 * 1 * 1 * 94.246)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 42.443, 20.629, -1 * 1 * 1 * 96.138)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 42.719, 20.427, -1 * 1 * 1 * 98.671)
    elif getCurrentMap() == Map.PARIS:
        map_paris()
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 15.892, 11.764, -1 * 1 * 1 * 28.584)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 15.892, 11.765, -1 * 1 * 1 * 28.584)
        shop_location = vect(-1 * 1 * 1 * 57.281, 15, 16.922)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 58.455, 15.865, 20.72)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 59.898, 16.065, 19.441)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 61.128, 15.865, 18)
    elif getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        dummy_bot_spawn_position = vect(9.821, 1.229, -1 * 1 * 1 * 34.382)
        dummy_bot_spawn_facing = vect(9.821, 1.229, -1 * 1 * 1 * 34.382)
        shop_location = vect(-1 * 1 * 1 * 11.913, 9.69, 140.21)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 14.907, 10.161, 136.422)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 12.276, 10.256, 135.274)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 9.479, 10.212, 135.867)
    elif getCurrentMap() == Map.VOLSKAYA:
        dummy_bot_spawn_position = vect(-1 * 1 * 1 * 5.23, -1 * 1 * 1 * 5.49, 20.299)
        dummy_bot_spawn_facing = vect(-1 * 1 * 1 * 5.23, -1 * 1 * 1 * 5.49, 20.299)
        shop_location = vect(29.638, 0.967, 135.899)
        shop_talent_positions[0] = vect(34.473, 1.742, 133.502)
        shop_talent_positions[1] = vect(35.005, 1.942, 136.165)
        shop_talent_positions[2] = vect(34.623, 1.742, 139)
    elif getCurrentMap() == Map.MALEVENTO:
        map_malevento()
        dummy_bot_spawn_position = vect(19.218, 9.455, 36.238)
        dummy_bot_spawn_facing = vect(19.218, 9.455, 36.238)
        shop_location = vect(-1 * 1 * 1 * 37.854, -1 * 1 * 1 * 3.482, 27.558)
        shop_talent_positions[0] = vect(-1 * 1 * 1 * 42.108, -1 * 1 * 1 * 2.527, 30.596)
        shop_talent_positions[1] = vect(-1 * 1 * 1 * 43.465, -1 * 1 * 1 * 2.309, 28.296)
        shop_talent_positions[2] = vect(-1 * 1 * 1 * 43.142, -1 * 1 * 1 * 2.372, 25.602)


def create_talent_hud_texts():
    @Name "GENERAL - - - [SUBROUTINE] Create HUD Texts"
    
    hudText(getAllPlayers(), null, "Soldier: X [v3.0 BETA] - Made By Psyrius#21775 - Workshop Code: ZEKK3", "[Discord In Description]", HudPosition.RIGHT, 0, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), null, "", "[More info: workshop.codes/ZEKK3]", HudPosition.RIGHT, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(localPlayer if localPlayer.can_enter_shop == true and localPlayer.replacing_talent_show_confirmation == false and localPlayer.replacing_talent_show_bought_talents == false else null, "[Hold: {0} to use Hearthstone]".format(buttonString(Button.RELOAD)) if localPlayer.browsing_shop == false else "[Hold: {0} to skip a talent, exit shop and get a XP boost]".format(buttonString(Button.RELOAD)) if localPlayer.browsing_shop == true else "", HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

def create_talent_helpers():
    @Name "GENERAL - - - [SUBROUTINE] Create Cooldown Ready Icons"
    
    #Health Potions or Poison Vials
    createInWorldText(localPlayer if ((localPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 or localPlayer.talent_ranks[Talent.POISON_VIALS] > 0) and localPlayer.browsing_shop == false) and localPlayer.is_using_ability[Talent.JUGGERNAUT] == false else null, "{0}   {1}   {2}".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_2) if localPlayer.amount_of_potions_or_vials >= 1 and localPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 else iconString(Icon.POISON_2) if localPlayer.amount_of_potions_or_vials >= 1 and localPlayer.talent_ranks[Talent.POISON_VIALS] > 0 else "", abilityIconString(Hero.ROADHOG, Button.ABILITY_2) if localPlayer.amount_of_potions_or_vials >= 2 and localPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 else iconString(Icon.POISON_2) if localPlayer.amount_of_potions_or_vials >= 2 and localPlayer.talent_ranks[Talent.POISON_VIALS] > 0 else "", abilityIconString(Hero.ROADHOG, Button.ABILITY_2) if localPlayer.amount_of_potions_or_vials == 3 and localPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 else iconString(Icon.POISON_2) if localPlayer.amount_of_potions_or_vials >= 3 and localPlayer.talent_ranks[Talent.POISON_VIALS] > 0 else ""), updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + (-0.3 * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    #Jetpack
    createProgressBarInWorldText(localPlayer if localPlayer.jetpack_fuel < 100 and localPlayer.browsing_shop == false and localPlayer.talent_ranks[Talent.JETPACK] > 0 and localPlayer.is_using_ability[Talent.JUGGERNAUT] == false else null, localPlayer.jetpack_fuel, "{0} THRUST".format(abilityIconString(Hero.DVA, Button.ABILITY_1)), updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + (-0.625 * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 0.75, Clip.NONE, Color.RED if localPlayer.jetpack_fuel < 33 else Color.ORANGE if localPlayer.jetpack_fuel < 66 else Color.WHITE, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    #Entering Stealth
    createProgressBarInWorldText(localPlayer if localPlayer.talent_ranks[Talent.STEALTH] > 0 and localPlayer.browsing_shop == false and (localPlayer.entering_stealth == true or localPlayer.is_using_ability[Talent.STEALTH] == true) else null, localPlayer.entering_stealth_timer / 1 * 100, "Entering Stealth" if localPlayer.is_using_ability[Talent.STEALTH] == false else "Stealthed", updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + (-0.75 * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 0.75, Clip.NONE, Color.VIOLET if localPlayer.is_using_ability[Talent.STEALTH] == true else Color.WHITE, Color.VIOLET if localPlayer.is_using_ability[Talent.STEALTH] == true else Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.NEVER)

    #Talent Cooldown Icons
    createInWorldText(localPlayer if localPlayer.browsing_shop == false and localPlayer.getCurrentHero() == Hero.SOLDIER and localPlayer.is_using_ability[Talent.JUGGERNAUT] == false else null, 
        "{0}{1}{2}".format(
            "{0}{1}{2}".format(
                abilityIconString(Hero.SOMBRA, Button.ABILITY_1) if localPlayer.talent_ranks[Talent.STEALTH] > 0 and localPlayer.talent_trigger_times[Talent.STEALTH] + talent_base_cooldowns[Talent.STEALTH] - localPlayer.talent_ranks[Talent.STEALTH] * STEALTH_COOLDOWN_REDUCTION_PER_RANK <= localPlayer.totalTimeElapsed else "",
                abilityIconString(Hero.REINHARDT, Button.ABILITY_1) if localPlayer.talent_ranks[Talent.JUGGERNAUT] > 0 and localPlayer.talent_trigger_times[Talent.JUGGERNAUT] + talent_base_cooldowns[Talent.JUGGERNAUT] <= localPlayer.totalTimeElapsed else "", abilityIconString(Hero.HAMMOND, Button.CROUCH) if localPlayer.talent_ranks[Talent.DIVE_BOMB] > 0 and localPlayer.talent_trigger_times[Talent.DIVE_BOMB] + talent_base_cooldowns[Talent.DIVE_BOMB] <= localPlayer.totalTimeElapsed else ""
            ), 
            "{0}{1}{2}".format(
                abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE) if localPlayer.talent_ranks[Talent.PREDATOR] > 0 and localPlayer.talent_trigger_times[Talent.PREDATOR] + talent_base_cooldowns[Talent.PREDATOR] <= localPlayer.totalTimeElapsed else "",
                iconString(Icon.SKULL) if localPlayer.talent_ranks[Talent.BERSERKER] > 0 and localPlayer.talent_trigger_times[Talent.BERSERKER] + talent_base_cooldowns[Talent.BERSERKER] <= localPlayer.totalTimeElapsed else "", 
                abilityIconString(Hero.PHARAH, Button.ABILITY_1) if localPlayer.talent_ranks[Talent.FIREBALL] > 0 and localPlayer.talent_trigger_times[Talent.FIREBALL] + talent_base_cooldowns[Talent.FIREBALL] <= localPlayer.totalTimeElapsed else ""
            ), 
            "{0}{1}{2}".format(
                abilityIconString(Hero.MOIRA, Button.ABILITY_1) if localPlayer.talent_ranks[Talent.SHADOWSTEP] > 0 and localPlayer.talent_trigger_times[Talent.SHADOWSTEP] + talent_base_cooldowns[Talent.SHADOWSTEP] - localPlayer.talent_ranks[Talent.SHADOWSTEP] * SHADOWSTEP_COOLDOWN_REDUCTION_PER_RANK <= localPlayer.totalTimeElapsed else   abilityIconString(Hero.GENJI, Button.ABILITY_1) if localPlayer.talent_ranks[Talent.SHADOWSTRIKE] > 0 and localPlayer.talent_trigger_times[Talent.SHADOWSTRIKE] +  talent_base_cooldowns[Talent.SHADOWSTRIKE] <= localPlayer.totalTimeElapsed else "",
                abilityIconString(Hero.BAPTISTE, Button.ABILITY_2) if localPlayer.talent_ranks[Talent.PURITY_FIELD] > 0 and localPlayer.talent_trigger_times[Talent.PURITY_FIELD] + talent_base_cooldowns[Talent.PURITY_FIELD] <= localPlayer.totalTimeElapsed else "",
                abilityIconString(Hero.PHARAH, Button.ABILITY_1) if localPlayer.talent_ranks[Talent.BLOODTHIRST] > 100 and localPlayer.browsing_shop == 100 else ""
            )
        ), updateEveryTick(localPlayer.getEyePosition() + (100 * (0.5 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0.05 - 0.25) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.NEVER
    )

    #Hearthstone
    createProgressBarInWorldText(localPlayer if localPlayer.is_using_hearthstone or localPlayer.is_using_skip_talent or localPlayer.using_one_of_the_hearthstones else null, localPlayer.using_hearthstone_timer / 2.75 * 100 if debugging == false else 0.5 * 100, "{0} Using Hearthstone".format(iconString(Icon.SPIRAL)) if localPlayer.browsing_shop == false else "{0} YES".format(iconString(Icon.CHECKMARK)) if localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true and localPlayer.replacing_talent_show_confirmation == true else "{0} NO".format(iconString(Icon.NO)) if localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true and localPlayer.replacing_talent_show_confirmation == true else "{0} Skipping Talents For XP Boost".format(iconString(Icon.TRASHCAN)) if localPlayer.browsing_shop == true and localPlayer.isHoldingButton(Button.RELOAD) == true else "", updateEveryTick(localPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0.75 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))) if localPlayer.browsing_shop == false else localPlayer.selected_talent_location + Vector.UP, 1, Clip.NONE, Color.WHITE, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.NEVER) 
    #What button to press in Stealth or Berserker
    createInWorldText(localPlayer if ((localPlayer.talent_ranks[Talent.STEALTH] > 0 or localPlayer.talent_ranks[Talent.BERSERKER] > 0) and localPlayer.browsing_shop == false) and localPlayer.is_using_ability[Talent.JUGGERNAUT] == false else null, "{0}".format("{0} {1} = Cancel".format(iconString(Icon.SKULL), buttonString(Button.ULTIMATE)) if localPlayer.is_using_ability[Talent.BERSERKER] == true else "{0} {1} = Damage & Stun".format(abilityIconString(Hero.SOMBRA, Button.ABILITY_1), buttonString(Button.MELEE)) if localPlayer.is_using_ability[Talent.STEALTH] == true else ""), updateEveryTick(localPlayer.getEyePosition() + (100 * (1.625 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0.05 - 0.25) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    #Railgun charge
    createInWorldText(localPlayer if localPlayer.talent_ranks[Talent.RAILGUN] > 0 and localPlayer.isCommunicatingEmote() == false and localPlayer.browsing_shop == false and localPlayer.is_using_ability[Talent.JUGGERNAUT] == false else null, "{0} {1}%".format(iconString(Icon.BOLT), localPlayer.railgun_charge if localPlayer.railgun_charge < 100 else 100), updateEveryTick(localPlayer.getEyePosition() + (100 * (1 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0 - 0.3) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE if localPlayer.railgun_charge < 100 else Color.SKY_BLUE, SpecVisibility.NEVER)
    #Engineer scrap
    createInWorldText(localPlayer if localPlayer.talent_ranks[Talent.ENGINEER] > 0 and localPlayer.isCommunicatingEmote() == false and localPlayer.browsing_shop == false and localPlayer.is_using_ability[Talent.JUGGERNAUT] == false else null, "{0} {1}%".format(abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE), localPlayer.engineer_scrap if localPlayer.engineer_scrap < 100 else 100), updateEveryTick(localPlayer.getEyePosition() + (100 * (1 * worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) + ((0 - 0.2) * (angleToDirection(horizontalAngleOfDirection(localPlayer.getFacingDirection()), verticalAngleOfDirection(localPlayer.getFacingDirection()) - 90))) + 3 * localPlayer.getFacingDirection()))), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE if localPlayer.engineer_scrap < 100 else Color.ORANGE, SpecVisibility.NEVER)
    #Cancel Juggernaut
    createInWorldText(localPlayer if localPlayer.is_using_ability[Talent.JUGGERNAUT] == true and localPlayer.has_hit_the_ground == true else null, "{0} {1} = Cancel".format(abilityIconString(Hero.REINHARDT, Button.ABILITY_1), buttonString(Button.INTERACT)), updateEveryTick(localPlayer.getEyePosition()), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.WHITE, SpecVisibility.NEVER)

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
    if eventPlayer.is_using_ability[Talent.STEALTH] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    if eventPlayer.stats[4] > 0:
        removeHealthPool(eventPlayer.health_pool_id_or_hot_id[7])
        eventPlayer.addHealthPool(Health.SHIELDS, eventPlayer.stats[4], true, true)
        eventPlayer.health_pool_id_or_hot_id[7] = getLastCreatedHealthPool()
    if eventPlayer.can_enter_shop == true and eventPlayer.amount_of_talents_purchased < 25:
        async(open_shop, AsyncBehavior.NOOP)
    else:
        wait(0.125)
        eventPlayer.stopCamera()
    if eventPlayer.getCurrentHero() == Hero.SOLDIER:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    eventPlayer.enableHeroHud()
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    if eventPlayer.talent_ranks[Talent.RAILGUN] == 0:
        eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
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
        if attacker.random_integer_between_0_to_5 <= 1 and attacker.reaper_hello_cooldown == 0:
            attacker.communicate(Comms.SORRY)
            attacker.reaper_hello_cooldown = 10
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
    if eventPlayer.is_using_ability[Talent.STEALTH] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    #Burning Soul
    if eventPlayer.talent_ranks[Talent.BURNING_SOUL] > 0:
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
    
    if eventPlayer.talent_ranks[Talent.BLOODTHIRST] > 0 and eventPlayer.is_using_ability[Talent.BERSERKER] == true:
        eventPlayer.bloodthirst_shield[0] += (eventDamage * (0.187 + eventPlayer.talent_ranks[Talent.BLOODTHIRST] * 0.063)) * (2.25 - eventPlayer.talent_ranks[Talent.BLOODTHIRST] * 0.25)
    attacker.using_hearthstone_timer = 0
    if attacker.is_using_ability[Talent.PURITY_FIELD] == false:
        attacker.in_combat = 3
    if eventPlayer.experience_current < eventPlayer.experience_max and attacker != victim:
        eventPlayer.experience_current += eventDamage / 5 * eventPlayer.stats[5]
    if attacker.talent_ranks[Talent.STEALTH] > 0 and attacker.is_using_ability[Talent.PURITY_FIELD] == false:
        attacker.entering_stealth = false
        stopChasingVariable(attacker.entering_stealth_timer)
        attacker.entering_stealth_timer = 0
    #MELEE
    if eventAbility == Button.MELEE:
        if eventPlayer.talent_ranks[Talent.STEALTH] > 0 and eventPlayer.is_using_ability[Talent.STEALTH] == true:
            async(break_stealth, AsyncBehavior.NOOP)
        #Dealt Stealth damage?
        if victim.is_using_ability[Talent.PURITY_FIELD] == false and eventPlayer.is_using_ability[Talent.STEALTH] == true and eventAbility != null:
            playEffect([player for player in getAllPlayers() if player != victim], DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION, Color.TEAM_1, victim, 1)
            playEffect([player for player in getAllPlayers() if player != victim], DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, Color.TEAM_1, victim, 100)
            victim.hit_by_talent[Talent.STEALTH] = attacker
            victim.setStatusEffect(attacker, Status.STUNNED, 0.5)
            #Wait so that Ignore Pain can trigger before damage
            wait()
            damage(victim, attacker, 50)
            playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT_SOUND, Color.WHITE, victim.getPosition(), 100)
            playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 100)
        #Dealt Predator damage?
        if eventPlayer.talent_ranks[Talent.PREDATOR] > 0 and eventPlayer.talent_trigger_times[Talent.PREDATOR] + talent_base_cooldowns[Talent.PREDATOR] - eventPlayer.talent_ranks[Talent.PREDATOR] * PREDATOR_COOLDOWN_REDUCTION_PER_RANK <= eventPlayer.totalTimeElapsed and victim.can_be_executed == true and victim.is_using_ability[Talent.PURITY_FIELD] == false and victim.getHealth() <= victim.getMaxHealth() * 0.25 == true and attacker.is_using_ability[Talent.PURITY_FIELD] == false:
            smallMessage(eventPlayer, "{0} Executed {1}!".format(abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), victim))
            if attacker.talent_ranks[Talent.SOUL_SIPHON] > 0:
                victim.hit_by_talent[Talent.SOUL_SIPHON] = attacker
            victim.hit_by_talent[Talent.PREDATOR] = attacker

            eventPlayer.talent_trigger_times[Talent.PREDATOR] = eventPlayer.totalTimeElapsed

            playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, Color.WHITE, victim.getPosition() + Vector.UP, 100)
            playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.WHITE, victim.getPosition() + Vector.UP, 1)
        #PRIMARY FIRE || ULTIMATE
    elif (eventAbility == Button.PRIMARY_FIRE or eventAbility == Button.ULTIMATE) == true:
        #Railgun?
        if attacker.talent_ranks[Talent.RAILGUN] > 0:
            eventPlayer.railgun_discharge = 6
            if attacker.railgun_charge < 100:
                attacker.railgun_charge += eventDamage * 0.375 + eventDamage * attacker.talent_ranks[Talent.OVERCLOCK] * 0.038
        #Engineer?
        if attacker.talent_ranks[Talent.ENGINEER] > 0:
            if attacker.engineer_scrap < 100:
                attacker.engineer_scrap += eventDamage * (0.037 + attacker.talent_ranks[Talent.ENGINEER] * 0.013)
        if attacker.talent_ranks[Talent.LIFESTEAL_AMMO] > 0 and attacker.getHealthOfType(Health.NORMAL) < attacker.getMaxHealthOfType(Health.NORMAL):
            heal(attacker, attacker, min(eventDamage * (0.112 + eventPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] * 0.038), eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)))
            eventPlayer.is_lifestealing = 1.5
            lifesteal_hps()
        #SECONDARY FIRE
    elif eventAbility == Button.SECONDARY_FIRE:
        if eventPlayer.talent_ranks[Talent.CRYOGENICS] > 0 and victim.is_using_ability[Talent.JUGGERNAUT] == false and victim.is_using_ability[Talent.PURITY_FIELD] == false and victim.is_using_ability[Talent.SHADOWSTEP] == false:
            victim.hit_by_talent[Talent.CRYOGENICS] = attacker
        if attacker.talent_ranks[Talent.IGNITE] > 0:
            if victim.is_using_ability[Talent.PURITY_FIELD] == false:
                victim.setStatusEffect(attacker, Status.BURNING, 3)
                victim.startDoT(attacker, 3, floor(attacker.talent_ranks[Talent.IGNITE] * 0.056 * eventDamage))
        if attacker.talent_ranks[Talent.LIFESTEAL_AMMO] > 0:
            heal(attacker, attacker, min(eventDamage * (0.112 + eventPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] * 0.038), eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)))
            eventPlayer.is_lifestealing = 1.5
            playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.TEAM_1, attacker.getPosition(), 100)
            lifesteal_hps()
        if attacker.talent_ranks[Talent.IGNITE] > 0 and attacker.is_using_ability[Talent.IGNITE] == true:
            attacker.is_using_ability[Talent.IGNITE] = false


rule "GENERAL - - - Player Took Damage":
    @Event playerTookDamage
    
    attacker.using_hearthstone_timer = 0
    if victim.is_using_ability[Talent.PURITY_FIELD] == false:
        victim.in_combat = 3
    if victim.talent_ranks[Talent.STEALTH] > 0 and victim.is_using_ability[Talent.PURITY_FIELD] == false:
        stopChasingVariable(victim.entering_stealth_timer)
        victim.entering_stealth_timer = 0
        if eventPlayer.is_using_ability[Talent.STEALTH] == true:
            async(break_stealth, AsyncBehavior.NOOP)
    if victim.is_using_ability[Talent.IGNORE_PAIN] == true and attacker.getCurrentHero() == Hero.SOLDIER and victim.is_using_ability[Talent.PURITY_FIELD] == false:
        eventPlayer.ignore_pain_damage_resisted[0] += eventDamage


rule "GENERAL - - - Player Slowed (Hit by Cryogenics Talent)":
    @Event eachPlayer
    @Condition eventPlayer.slow_amount < eventPlayer.stats[2]
    @Condition eventPlayer.refresh_slow == true
    
    stopChasingVariable(eventPlayer.slow_amount)
    eventPlayer.refresh_slow = false
    eventPlayer.setAbility1Enabled(false)
    chase(eventPlayer.slow_amount, eventPlayer.stats[2], duration=eventPlayer.slow_duration, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.isAlive() == true and eventPlayer.slow_amount != eventPlayer.stats[2] and eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false and eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false and eventPlayer.is_using_ability[Talent.SHADOWSTEP] == false:
        eventPlayer.setMoveSpeed(eventPlayer.slow_amount)
        wait(0.032, Wait.RESTART_WHEN_TRUE)
    stopChasingVariable(eventPlayer.slow_amount)
    eventPlayer.slow_amount = eventPlayer.stats[2]
    if eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true:
        eventPlayer.setMoveSpeed(25)
    elif eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true:
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
    if eventPlayer.hit_by_talent[33].talent_ranks[Talent.BURNING_SOUL] > 0 and eventPlayer.hit_by_talent[33].burning_soul_orb_timer > 0:
        eventPlayer.hit_by_talent[33].burning_soul_orb_timer = 0
    eventPlayer.hit_by_talent[33].dropped_xp_orb = false
    wait()
    eventPlayer.hit_by_talent[33] = null
    if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] > 0 and eventPlayer.amount_of_potions_or_vials < 3 and random.randint(0 + eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] * 13.2, 100) >= 66:
        if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0:
            eventPlayer.health_potion_cooldown_memory = eventPlayer.totalTimeElapsed - eventPlayer.talent_trigger_times[Talent.HEALTH_POTIONS]
            eventPlayer.talent_trigger_times[Talent.HEALTH_POTIONS] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.HEALTH_POTIONS] - eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST]
        elif eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0:
            eventPlayer.health_potion_cooldown_memory = eventPlayer.totalTimeElapsed - eventPlayer.talent_trigger_times[Talent.POISON_VIALS]
            eventPlayer.talent_trigger_times[Talent.POISON_VIALS] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.POISON_VIALS] - eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST]
        wait()
        /*
        if eventPlayer.amount_of_potions_or_vials < 3:
            if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0:
                eventPlayer.talent_trigger_times[Talent.HEALTH_POTIONS] = eventPlayer.totalTimeElapsed - eventPlayer.health_potion_cooldown_memory
            elif eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0:
                eventPlayer.talent_trigger_times[Talent.POISON_VIALS] = eventPlayer.totalTimeElapsed - eventPlayer.health_potion_cooldown_memory
        */
        /*if eventPlayer.amount_of_potions_or_vials < 3:
            eventPlayer.amount_of_potions_or_vials += 1*/
        smallMessage(eventPlayer, "{0} +1 {1}".format(iconString(Icon.RADIOACTIVE), "Health Potion!" if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 else "Poison Vial!"))
    #If there is a cooldown on Shadowstep
    if eventPlayer.talent_ranks[Talent.SHADOWSTEP] > 0 and eventPlayer.talent_trigger_times[Talent.SHADOWSTEP] + talent_base_cooldowns[Talent.SHADOWSTEP] - eventPlayer.talent_ranks[Talent.SHADOWSTEP] * SHADOWSTEP_COOLDOWN_REDUCTION_PER_RANK > eventPlayer.totalTimeElapsed:
        #Reset Shadowstep cooldown to 0
        eventPlayer.talent_trigger_times[Talent.SHADOWSTEP] = eventPlayer.totalTimeElapsed - (talent_base_cooldowns[Talent.SHADOWSTEP] + eventPlayer.talent_ranks[Talent.SHADOWSTEP] * SHADOWSTEP_COOLDOWN_REDUCTION_PER_RANK)  
    if eventPlayer.talent_ranks[Talent.ENGINEER] > 0 and eventPlayer.engineer_scrap < 100:
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