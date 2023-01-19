#Global variables

globalvar accurateTime

#Player variables

playervar bloodthirst_shield
playervar purity_field_cooldown
playervar has_hit_the_ground
playervar hit_by_talent
playervar health_pool_id_or_hot_id
playervar engineer_scrap
playervar shadowstep_cooldown
playervar shadowstrike_enemies_hit
playervar entering_stealth
playervar entering_stealth_timer
playervar health_regen_in_stealth_id
playervar time_since_freezing_rocket
playervar slow_duration
playervar slow_amount
playervar refresh_slow
playervar railgun_discharge
playervar railgun_charge
playervar railgun_projectile_start
playervar railgun_projectile_player_hit
playervar railgun_hit_someone
playervar railgun_raycasts_counter
playervar railgun_projectile_destination
playervar railgun_projectile_is_in_air
playervar is_lifestealing
playervar predator_cooldown
playervar predator_effect_position_1
playervar predator_effect_position_2
playervar predator_effects
playervar created_predator_effects_on_self
playervar in_execution_range_effects
playervar can_be_executed
playervar jetpack_fuel
playervar jetpack_will_have_a_delay
playervar health_potion_cooldown
playervar effectMemory
playervar exitSpeed
playervar gravity
playervar projData
playervar ignite_position
playervar burning_soul_orb_timer
playervar victims_in_fire_aura_radius
playervar fire_soul_loop
playervar xp_orb_location
playervar berserker_cooldown
playervar fireball_cooldown
playervar fireball_position
playervar fireball_in_air
playervar fireball_effects
playervar fireball_destination
playervar victims_in_fireball_radius
playervar fireball_loop
playervar ignore_pain_damage_resisted
playervar ignore_pain_volume
playervar ignore_pain_damage_resistance
playervar total_time_in_combat
playervar soul_siphon_duration
playervar used_soul_siphon_on
playervar pyromaniac_heal_duration
playervar talent_1_cooldown = 0
playervar talent_2_cooldown = 0
playervar talent_3_cooldown = 0
playervar talent_4_cooldown = 0
playervar talent_5_cooldown = 0

#Subroutine names

subroutine purity_field_impulse
subroutine stealth_camera
subroutine lifesteal_hps
subroutine railgun_projectile_is_in_air
subroutine health_regen_heal_over_time
subroutine already_at_full_health
subroutine health_potion_hps
subroutine health_potion_heal_over_time
subroutine fireball_casted
subroutine pyromaniac_heal_over_time
subroutine ignore_pain_volume
subroutine ignore_pain_hps

#!extension explosionSounds
#!extension buffStatusEffects
#!extension buffAndDebuffSounds
#!extension energyExplosionEffects
#!extension debuffStatusEffects
#!extension kineticExplosionEffects

def buy_bloodthirst():
    @Name "TALENT SYSTEM - - - [TALENT 0: BLOODTHIRST] [SUBROUTINE] Buy Bloodthirst"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.BLOODTHIRST] = talent_names[Talent.BLOODTHIRST]
        return
    if eventPlayer.talent_ranks[Talent.BLOODTHIRST] == 1:
        eventPlayer.bloodthirst_shield = 0
        eventPlayer.talents_you_do_not_have[Talent.BLOODTHIRST] = null


def bloodthirst_effects():
    @Name "TALENT SYSTEM - - - [TALENT 0: BLOODTHIRST] [SUBROUTINE] Bloodthirst Effects"
    
    playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
    createEffect(getAllPlayers(), Effect.HEAL_TARGET, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[45] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.HEAL_TARGET_ACTIVE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[46] = getLastCreatedEntity()
    wait(1.5)
    destroyEffect(eventPlayer.player_temp_effects[45])
    destroyEffect(eventPlayer.player_temp_effects[46])


def buy_purity_field():
    @Name "TALENT SYSTEM - - - [TALENT 1: PURITY FIELD] [SUBROUTINE] Buy Purity Field"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.PURITY_FIELD] = talent_names[Talent.PURITY_FIELD]
        eventPlayer.purity_field_cooldown = 0
        stopChasingVariable(eventPlayer.purity_field_cooldown)
        return
    if eventPlayer.talent_ranks[Talent.PURITY_FIELD] == 1:
        eventPlayer.purity_field_cooldown = 0
        chase(eventPlayer.purity_field_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.PURITY_FIELD] = null


rule "TALENT SYSTEM - - - [TALENT 1: PURITY FIELD] Use Purity Field":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.PURITY_FIELD] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.purity_field_cooldown == 0
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    
    eventPlayer.is_using_ability[Talent.PURITY_FIELD] = true
    #A wait for juggernaut (and maybe more abilities) to run their "end code" first before this triggers
    wait()
    async(purity_field_impulse, AsyncBehavior.NOOP)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.purity_field_cooldown = 45
    eventPlayer.setDamageReceived(0.001)
    eventPlayer.clearStatusEffect(Status.STUNNED)
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.FROZEN)
    eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
    createEffect(getAllPlayers() if eventPlayer.browsing_shop == false else null, Effect.ANA_BIOTIC_GRENADE_INCREASED_HEALING, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[53] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.browsing_shop == false else null, Effect.SPHERE, Color.WHITE, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.has_hit_the_ground == false else eventPlayer.talent_counter_or_position_etc[1], 2.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    eventPlayer.player_temp_effects[47] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.browsing_shop == false else null, Effect.SPHERE, Color.YELLOW, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.has_hit_the_ground == false else eventPlayer.talent_counter_or_position_etc[1], 2.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    eventPlayer.player_temp_effects[48] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.browsing_shop == false else null, Effect.GOOD_AURA, Color.WHITE, updateEveryTick(eventPlayer.getPosition()) if eventPlayer.has_hit_the_ground == false else eventPlayer.talent_counter_or_position_etc[1], 2.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    eventPlayer.player_temp_effects[49] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.browsing_shop == false else null, Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[50] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.browsing_shop == false else null, Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED_SOUND, Color.TEAM_1, eventPlayer.getPosition() if eventPlayer.has_hit_the_ground == false else eventPlayer.talent_counter_or_position_etc[1], 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[51] = getLastCreatedEntity()
    eventPlayer.setHealingReceived(125 + eventPlayer.talent_ranks[Talent.PURITY_FIELD] * 25)
    createInWorldText([player for player in getAllPlayers() if player != eventPlayer and isInLoS(eventPlayer.getEyePosition(), player.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) == true and eventPlayer.is_using_ability[Talent.STEALTH] == false], "{0}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_2)), updateEveryTick(eventPlayer.getPosition() + Vector.UP), 2.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    eventPlayer.player_temp_effects[52] = getLastCreatedText()
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0)
    eventPlayer.startForcingPosition(eventPlayer.getPosition(), true)
    wait()
    eventPlayer.stopForcingPosition()
    eventPlayer.in_combat = 0
    waitUntil(eventPlayer.isOnGround() == true or eventPlayer.isDead() == true or eventPlayer.browsing_shop == true, 15)
    eventPlayer.has_hit_the_ground = true
    eventPlayer.setMoveSpeed(25)
    eventPlayer.stopForcingThrottle()
    eventPlayer.talent_counter_or_position_etc[1] = eventPlayer.getPosition()
    waitUntil(distance(eventPlayer.getEyePosition(), eventPlayer.talent_counter_or_position_etc[1]) > 2.75 or eventPlayer.isDead() == true or eventPlayer.browsing_shop == true, 3.75 + eventPlayer.talent_ranks[Talent.PURITY_FIELD] * 1.25)
    eventPlayer.talent_counter_or_position_etc[1] = null
    destroyEffect(eventPlayer.player_temp_effects[47])
    destroyEffect(eventPlayer.player_temp_effects[48])
    destroyEffect(eventPlayer.player_temp_effects[49])
    destroyEffect(eventPlayer.player_temp_effects[50])
    destroyEffect(eventPlayer.player_temp_effects[51])
    eventPlayer.setDamageReceived(100)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    destroyInWorldText(eventPlayer.player_temp_effects[52])
    eventPlayer.setHealingReceived(100)
    destroyEffect(eventPlayer.player_temp_effects[53])
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.is_using_ability[Talent.PURITY_FIELD] = false
    waitUntil(eventPlayer.browsing_shop == false, 99999)
    eventPlayer.setPrimaryFireEnabled(true)
    if eventPlayer.talent_ranks[Talent.RAILGUN] == 0:
        eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setMeleeEnabled(true)


def purity_field_impulse():
    @Name "TALENT SYSTEM - - - [TALENT 1: PURITY FIELD] [SUBROUTINE] Purity Field Impulse"
    
    while eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true:
        #Impulse
        (([player for player in (getPlayersInRadius(eventPlayer.getPosition() if eventPlayer.has_hit_the_ground == false else eventPlayer.talent_counter_or_position_etc[1], 1 + 2.5, Team.ALL, LosCheck.OFF)) if player != eventPlayer and player.isAlive() == true and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false]).hit_by_talent)[1] = eventPlayer
        wait(0.125)


rule "TALENT SYSTEM - - - [TALENT 1: PURITY FIELD] Hit By Purity Field":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.PURITY_FIELD] != null
    
    eventPlayer.applyImpulse(angleToDirection(horizontalAngleOfDirection(directionTowards(eventPlayer.hit_by_talent[Talent.PURITY_FIELD].talent_counter_or_position_etc[1], eventPlayer.getPosition())), -1 * 1 * 1 * 30), 7.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    playEffect(getAllPlayers(), DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    eventPlayer.hit_by_talent[Talent.PURITY_FIELD] = null


def buy_cybernetics():
    @Name "TALENT SYSTEM - - - [TALENT 2: CYBERNETICS] [SUBROUTINE] Buy Cybernetics (hit_by_ability[2] is borrowed by talent: juggernaut)"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.CYBERNETICS] = talent_names[Talent.CYBERNETICS]
        #Shields
        eventPlayer.stats[4] = 0
        removeHealthPool(eventPlayer.health_pool_id_or_hot_id[7])
        return
    if eventPlayer.talent_ranks[Talent.CYBERNETICS] == 1:
        eventPlayer.talents_you_do_not_have[Talent.CYBERNETICS] = null
    #Shields
    eventPlayer.stats[4] = eventPlayer.stats[4] + 40


def buy_engineer():
    @Name "TALENT SYSTEM - - - [TALENT 3: ENGINEER] [SUBROUTINE] Buy Engineer"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.engineer_scrap = 0
        eventPlayer.talents_you_do_not_have[Talent.ENGINEER] = talent_names[Talent.ENGINEER]
        eventPlayer.talents_you_do_not_have[Talent.IGNORE_PAIN] = talent_names[Talent.IGNORE_PAIN]
        return
    if eventPlayer.talent_ranks[Talent.ENGINEER] == 1:
        #Lock talent Ignore Pain
        eventPlayer.possible_talents[Talent.IGNORE_PAIN] = null
        eventPlayer.talents_you_do_not_have[Talent.IGNORE_PAIN] = null
        eventPlayer.engineer_scrap = 0
        eventPlayer.talents_you_do_not_have[Talent.ENGINEER] = null


rule "TALENT SYSTEM - - - [TALENT 3: ENGINEER] Use Engineer":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.ENGINEER] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.engineer_scrap >= 100
    @Condition eventPlayer.isReloading() == true
    @Condition eventPlayer.getHealthOfType(Health.ARMOR) != 50 + eventPlayer.talent_ranks[Talent.ENGINEER] * 50
    
    waitUntil(eventPlayer.getAmmo(0) == eventPlayer.getMaxAmmo(0), 99999)
    eventPlayer.engineer_scrap = 0
    playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, Color.TEAM_1, eventPlayer, 100)
    playEffect(getAllPlayers().exclude(eventPlayer), DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, Color.TEAM_2, eventPlayer, 100)
    playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR, Color.TEAM_1, eventPlayer, 1)
    removeHealthPool(eventPlayer.health_pool_id_or_hot_id[0])
    eventPlayer.addHealthPool(Health.ARMOR, min(100, floor(100 - eventPlayer.getHealthOfType(Health.ARMOR))), false, true)
    eventPlayer.health_pool_id_or_hot_id[0] = getLastCreatedHealthPool()
    smallMessage(eventPlayer, "{0} Armor Repaired!".format(abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE)))


def buy_shadowstrike():
    @Name "TALENT SYSTEM - - - [TALENT 4: SHADOWSTRIKE] [SUBROUTINE] Buy Shadowstrike"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.shadowstep_cooldown)
        eventPlayer.shadowstep_cooldown = 0
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTRIKE] = talent_names[Talent.SHADOWSTRIKE]
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTEP] = talent_names[Talent.SHADOWSTEP]
        return
    if eventPlayer.talent_ranks[Talent.SHADOWSTRIKE] == 1:
        eventPlayer.shadowstep_cooldown = 0
        chase(eventPlayer.shadowstep_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTRIKE] = null
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTEP] = null


def shadowstrike():
    @Name "TALENT SYSTEM - - - [TALENT 4: SHADOWSTRIKE] [SUBROUTINE] Use Shadowstrike (triggers from talent 18: use shadowstep)"
    
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[4] = getLastCreatedEntity()
    eventPlayer.shadowstrike_enemies_hit = []
    while eventPlayer.is_using_ability[Talent.SHADOWSTEP] == true:
        if (len([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 2, Team.ALL, LosCheck.OFF) if player != eventPlayer and player.isAlive() == true and isInLoS(eventPlayer.getPosition() + Vector.UP, player.getPosition() + Vector.UP, BarrierLos.PASS_THROUGH_BARRIERS) == true and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false and player in eventPlayer.shadowstrike_enemies_hit == false])) > 0:
            playEffect(eventPlayer, DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition() + Vector.UP, 100)
            eventPlayer.shadowstrike_enemies_hit = eventPlayer.shadowstrike_enemies_hit.concat([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 2, Team.ALL, LosCheck.OFF) if player != eventPlayer and player.isAlive() == true and isInLoS(eventPlayer.getPosition() + Vector.UP, player.getPosition() + Vector.UP, BarrierLos.PASS_THROUGH_BARRIERS) == true and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false and player in eventPlayer.shadowstrike_enemies_hit == false])
        wait()
    destroyEffect(eventPlayer.player_temp_effects[4])
    wait(0.5)
    eventPlayer.talent_counter_or_position_etc[4] = len(eventPlayer.shadowstrike_enemies_hit)
    while eventPlayer.talent_counter_or_position_etc[4] > 0:
        eventPlayer.talent_counter_or_position_etc[4] -= 1
        playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, Color.TEAM_2, eventPlayer.shadowstrike_enemies_hit[eventPlayer.talent_counter_or_position_etc[4]].getPosition() + Vector.UP, 100)
        playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.TEAM_2, eventPlayer.shadowstrike_enemies_hit[eventPlayer.talent_counter_or_position_etc[4]] + Vector.UP, 100)
        damage(eventPlayer.shadowstrike_enemies_hit[eventPlayer.talent_counter_or_position_etc[4]], eventPlayer, 56.25 + eventPlayer.talent_ranks[Talent.SHADOWSTRIKE] * 18.75)
        wait(0.125)
    if len(eventPlayer.shadowstrike_enemies_hit) > 1:
        eventPlayer.shadowstep_cooldown = 1 - len(eventPlayer.shadowstrike_enemies_hit) * 0.125
        smallMessage(eventPlayer, "{0} Shadowstrike cooldown reset!".format(abilityIconString(Hero.GENJI, Button.ABILITY_1)))
        playEffect(eventPlayer, DynamicEffect.SOMBRA_TRANSLOCATING_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
        goto lbl_0
    if len(eventPlayer.shadowstrike_enemies_hit) > 0:
        eventPlayer.shadowstep_cooldown = eventPlayer.shadowstep_cooldown / 2
    lbl_0:
    eventPlayer.shadowstrike_enemies_hit = []


def buy_stealth():
    @Name "TALENT SYSTEM - - - [TALENT 5: STEALTH] [SUBROUTINE] Buy Stealth"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        break_stealth()
        stopChasingVariable(eventPlayer.stealth_cooldown)
        eventPlayer.stealth_cooldown = 0
        eventPlayer.entering_stealth = false
        destroyEffect(eventPlayer.player_temp_effects[57])
        destroyEffect(eventPlayer.player_temp_effects[58])
        eventPlayer.talents_you_do_not_have[Talent.STEALTH] = talent_names[Talent.STEALTH]
        return
    if eventPlayer.talent_ranks[Talent.STEALTH] == 1:
        eventPlayer.stealth_cooldown = 0
        chase(eventPlayer.stealth_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.entering_stealth = false
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.STEALTH] == true else null, Effect.REAPER_WRAITH_FORM, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[57] = getLastCreatedEntity()
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.STEALTH] == true else null, Effect.SIGMA_GRAVITIC_FLUX_TARGET_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[58] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have[Talent.STEALTH] = null


rule "TALENT SYSTEM - - - [TALENT 5: STEALTH] Use Stealth":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.STEALTH] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.is_using_ability[Talent.STEALTH] == false
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.stealth_cooldown == 0
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.in_combat == 0
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    
    eventPlayer.entering_stealth = true
    async(stealth_camera, AsyncBehavior.RESTART)
    chase(eventPlayer.entering_stealth_timer, 0 if eventPlayer.is_using_ability[Talent.STEALTH] == true else 1, rate=0.113 - eventPlayer.talent_ranks[Talent.STEALTH] * 0.013 if eventPlayer.is_using_ability[Talent.STEALTH] == true else 1, ChaseReeval.DESTINATION_AND_RATE)
    wait(1, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR, Color.TEAM_1, eventPlayer.getPosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
    eventPlayer.entering_stealth = false
    eventPlayer.is_using_ability[Talent.STEALTH] = true
    eventPlayer.setInvisibility(Invis.ALL)
    if eventPlayer.talent_ranks[Talent.HEALTH_REGEN] > 0:
        eventPlayer.startHoT(null, 9999, 9 + eventPlayer.talent_ranks[Talent.HEALTH_REGEN] * 1.8)
        eventPlayer.health_regen_in_stealth_id = getLastHoT()
    waitUntil(eventPlayer.entering_stealth_timer == 0, 99999)
    break_stealth()


rule "TALENT SYSTEM - - - [TALENT 5: STEALTH] Canceled Entering Stealth":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.STEALTH] > 0
    @Condition eventPlayer.entering_stealth == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == false
    
    eventPlayer.entering_stealth = false
    stopChasingVariable(eventPlayer.entering_stealth_timer)
    eventPlayer.entering_stealth_timer = 0


rule "TALENT SYSTEM - - - [TALENT 5: STEALTH] Hit By Stealth Melee":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.STEALTH] != null
    
    playEffect(eventPlayer, DynamicEffect.ANA_BIOTIC_GRENAGE_NO_HEALING_SOUND, Color.WHITE, eventPlayer, 80)
    createEffect(getAllPlayers(), Effect.ANA_BIOTIC_GRENADE_NO_HEALING, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[5] = getLastCreatedEntity()
    eventPlayer.setHealingReceived(0)
    waitUntil(eventPlayer.isDead() == true or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true, 4)
    if eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true:
        goto lbl_0
    eventPlayer.setHealingReceived(100)
    lbl_0:
    eventPlayer.hit_by_talent[Talent.STEALTH] = null
    destroyEffect(eventPlayer.player_temp_effects[5])


rule "TALENT SYSTEM - - - [TALENT 5: STEALTH] Break Stealth If Being Loud":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.STEALTH] > 0
    @Condition eventPlayer.is_using_ability[Talent.STEALTH] == true
    @Condition (eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)) == true
    
    async(break_stealth, AsyncBehavior.NOOP)


def break_stealth():
    @Name "TALENT SYSTEM - - - [TALENT 5: STEALTH] [SUBROUTINE] Break Stealth"
    
    eventPlayer.is_using_ability[Talent.STEALTH] = false
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.stealth_cooldown = 20 - eventPlayer.talent_ranks[Talent.STEALTH] * 4
    stopChasingVariable(eventPlayer.entering_stealth_timer)
    eventPlayer.entering_stealth_timer = 0
    if eventPlayer.talent_ranks[Talent.HEALTH_REGEN] > 0:
        stopHoT(eventPlayer.health_regen_in_stealth_id)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR, Color.TEAM_2, eventPlayer.getPosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)


/*
def buy_juggernaut():
    @Name "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] [SUBROUTINE] Buy Juggernaut [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.juggernaut_cooldown)
        stopChasingVariable(eventPlayer.juggernaut_charge)
        eventPlayer.juggernaut_cooldown = 0
        destroyEffect(eventPlayer.player_temp_effects[59])
        eventPlayer.talents_you_do_not_have[Talent.JUGGERNAUT] = talent_names[Talent.JUGGERNAUT]
        eventPlayer.talents_you_do_not_have[Talent.FIREBALL] = talent_names[Talent.FIREBALL]
        return
    if eventPlayer.talent_ranks[Talent.JUGGERNAUT] == 1:
        eventPlayer.juggernaut_cooldown = 0
        chase(eventPlayer.juggernaut_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        chase(eventPlayer.juggernaut_charge, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true else null, Effect.SOLDIER_SPRINTING, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[59] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have[Talent.JUGGERNAUT] = null
        eventPlayer.talents_you_do_not_have[Talent.FIREBALL] = null
*/

/*
rule "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] Use Juggernaut [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.JUGGERNAUT] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.juggernaut_cooldown == 0
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.isCommunicatingEmote() == false
    @Condition (eventPlayer.hasStatusEffect(Status.PHASED_OUT) == false if eventPlayer.is_using_ability[Talent.SHADOWSTEP] == false else eventPlayer.isAlive()) == true
    @Condition eventPlayer.is_using_hearthstone[0] == false
    @Condition eventPlayer.is_using_ability[Talent.JETPACK] == false
    
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.has_hit_the_ground = false
    eventPlayer.is_using_ability[Talent.JUGGERNAUT] = true
    async(juggernaut_knockback, AsyncBehavior.NOOP)
    eventPlayer.setJumpEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.juggernaut_cooldown = 60
    eventPlayer.clearStatusEffect(Status.FROZEN)
    if eventPlayer.is_using_ability[Talent.STEALTH] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    eventPlayer.setMoveSpeed(0)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_LEAP, Color.TEAM_1, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_LEAP_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0)
    eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition(), eventPlayer.getPosition() + worldVector(vect(0, 1, 0), eventPlayer, Transform.ROTATION)), 5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0.067)
    waitUntil(eventPlayer.isDead() == true or eventPlayer.isOnGround() == true or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true, 99999)
    eventPlayer.has_hit_the_ground = true
    eventPlayer.startCamera(eventPlayer.getEyePosition() + worldVector(vect(0, 0, 0.333), eventPlayer, Transform.ROTATION) if eventPlayer.getSpeed() <= 14 else eventPlayer.getEyePosition() + (worldVector(vect(0.5 if ((eventPlayer.getSpeedInDirection(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(-1 * 1 * 1 * 1, 0, 0), eventPlayer, Transform.ROTATION)))) / 4) * 0.5 > 0.5 else (-1 * 1 * 1 * 0.5 if ((eventPlayer.getSpeedInDirection(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(-1 * 1 * 1 * 1, 0, 0), eventPlayer, Transform.ROTATION)))) / 4) * 0.5 < -1 * 1 * 1 * 0.5 else eventPlayer.getSpeedInDirection(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(-1 * 1 * 1 * 1, 0, 0), eventPlayer, Transform.ROTATION)))) / 4, 0.333, 0), eventPlayer, Transform.ROTATION)), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1, getAllPlayers(), eventPlayer, true).getHitPosition() if eventPlayer.getSpeed() <= 14 else eventPlayer.getEyePosition() + worldVector(vect(0, 0.25, 3), eventPlayer, Transform.ROTATION), 30 if eventPlayer.getSpeed() <= 14 else 12)
    eventPlayer.startFacing(angleToDirection(eventPlayer.getHorizontalFacingAngle() + 0.4 if eventPlayer.getSpeedInDirection(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(1, 0, 0), eventPlayer, Transform.ROTATION))) > 3.9 else eventPlayer.getHorizontalFacingAngle() - 0.4 if eventPlayer.getSpeedInDirection(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(1, 0, 0), eventPlayer, Transform.ROTATION))) < -1 * 1 * 1 * 3.9 else eventPlayer.getHorizontalFacingAngle(), 0), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    #If the player lands on the ground too quick
    waitUntil(eventPlayer.juggernaut_cooldown <= 59.4, 59.4)
    eventPlayer.juggernaut_cooldown = 20
    eventPlayer.has_hit_the_ground = true
    if eventPlayer.isDead() == true or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true:
        goto lbl_0
    async(cancel_juggernaut, AsyncBehavior.NOOP)
    async(juggernaut_effects, AsyncBehavior.NOOP)
    eventPlayer.stopForcingThrottle()
    eventPlayer.setMoveSpeed(eventPlayer.stats[2] * 3)
    eventPlayer.startForcingThrottle(1, 1, 0, 0, 0, 0.25)
    eventPlayer.juggernaut_charge = 10
    waitUntil(eventPlayer.getSpeed() > 14, 1)
    while eventPlayer.isAlive() == true and eventPlayer.juggernaut_charge > 0 and eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false and eventPlayer.talent_counter_or_position_etc[6] == null and ((eventPlayer.juggernaut_cooldown < 19.75 and eventPlayer.getSpeed() > 14 or eventPlayer.juggernaut_cooldown >= 19.75) == true):
        #Pick up target
        (((sorted([player for player in getPlayersInRadius(eventPlayer.getPosition() + worldVector(vect(0, 1, 2.5), eventPlayer, Transform.ROTATION), 5, Team.ALL, LosCheck.OFF) if eventPlayer.isInViewAngle(player, 45) and isInLoS(eventPlayer.getEyePosition() + Vector.DOWN, player.getEyePosition() + Vector.DOWN, BarrierLos.PASS_THROUGH_BARRIERS) and player.getPosition().y < (eventPlayer.getEyePosition() + Vector.UP).y and player.getEyePosition().y > eventPlayer.getPosition().y and distance(eventPlayer.getPosition() + Vector.UP, player.getPosition() + Vector.UP) < 3 and player != eventPlayer and player.isAlive() == true and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.is_using_ability[Talent.DIVE_BOMB] == false], lambda i: distance(eventPlayer.getPosition() + Vector.UP, i.getPosition() + Vector.UP)))[0]).hit_by_talent)[6] = eventPlayer
        wait()
        #If the player got a target
        if eventPlayer.talent_counter_or_position_etc[6] != null:
            while eventPlayer.talent_counter_or_position_etc[6] != null and eventPlayer.talent_counter_or_position_etc[6] != eventPlayer and eventPlayer.isAlive() == true and eventPlayer.juggernaut_charge > 0 and eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false and ((eventPlayer.juggernaut_cooldown < 19.75 and eventPlayer.getSpeed() > 14 or eventPlayer.juggernaut_cooldown >= 19.75) == true):
                (([player for player in getPlayersInRadius(eventPlayer.getPosition() + worldVector(vect(0, 1, 2.5), eventPlayer, Transform.ROTATION), 5, Team.ALL, LosCheck.OFF) if eventPlayer.isInViewAngle(player, 45) and isInLoS(eventPlayer.talent_counter_or_position_etc[6].getEyePosition() + Vector.DOWN, player.getEyePosition() + Vector.DOWN, BarrierLos.PASS_THROUGH_BARRIERS) and player.getPosition().y < (eventPlayer.getEyePosition() + Vector.UP).y and player.getEyePosition().y > eventPlayer.getPosition().y and distance(eventPlayer.getPosition() + Vector.UP, player.getPosition() + Vector.UP) < 4 and player != eventPlayer and player.isAlive() == true and player != eventPlayer.talent_counter_or_position_etc[6] and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.is_using_ability[Talent.DIVE_BOMB] == false and player.hit_by_talent[Talent.CYBERNETICS] == null]).hit_by_talent)[2] = eventPlayer
                wait()
                waitUntil(eventPlayer.talent_counter_or_position_etc[6] == null or eventPlayer.talent_counter_or_position_etc[6] == eventPlayer or eventPlayer.isDead() == true or eventPlayer.juggernaut_charge <= 0 or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true or eventPlayer.juggernaut_cooldown < 19.75 and eventPlayer.getSpeed() <= 14, 0.048)
                if eventPlayer.talent_counter_or_position_etc[6] == null or eventPlayer.talent_counter_or_position_etc[6] == eventPlayer or eventPlayer.isDead() == true or eventPlayer.juggernaut_charge <= 0 or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true or eventPlayer.juggernaut_cooldown < 19.75 and eventPlayer.getSpeed() <= 14:
                    break
        if eventPlayer.talent_counter_or_position_etc[6] == eventPlayer or eventPlayer.isDead() == true or eventPlayer.juggernaut_charge <= 0 or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true or eventPlayer.juggernaut_cooldown < 19.75 and eventPlayer.getSpeed() <= 14:
            break
    if eventPlayer.getSpeed() <= 14 and eventPlayer.isAlive() == true and eventPlayer.juggernaut_charge > 0 and eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false:
        (([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 4, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer and player.isAlive() == true and player != eventPlayer.talent_counter_or_position_etc[6] and player.hit_by_talent[Talent.JUGGERNAUT] != eventPlayer and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.is_using_ability[Talent.DIVE_BOMB] == false and player.hit_by_talent[Talent.CYBERNETICS] == null]).hit_by_talent)[2] = eventPlayer
        damage([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 4, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer and player.hit_by_talent[Talent.JUGGERNAUT] != eventPlayer and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false], eventPlayer, 125 + eventPlayer.talent_ranks[Talent.JUGGERNAUT] * 25)
        playEffect(getAllPlayers(), DynamicEffect.SIGMA_ACCRETION_IMPACT, Color.TEAM_1, eventPlayer.getPosition() + Vector.UP, 1)
        playEffect(getAllPlayers(), DynamicEffect.SIGMA_ACCRETION_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition() + Vector.UP, 100)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT, Color.TEAM_1, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION, Color.TEAM_2, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
    eventPlayer.setMoveSpeed(0)
    wait(0.125)
    eventPlayer.setJumpEnabled(true)
    eventPlayer.setMeleeEnabled(true)
    lbl_0:
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.stopCamera()
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.stopFacing()
    stopChasingVariable(eventPlayer.juggernaut_charge)
    eventPlayer.juggernaut_charge = 0
    eventPlayer.is_using_ability[Talent.JUGGERNAUT] = false
    eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    eventPlayer.stopForcingThrottle()
    eventPlayer.setPrimaryFireEnabled(true)
    if eventPlayer.talent_ranks[Talent.RAILGUN] == 0:
        eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.talent_counter_or_position_etc[6] = null
    eventPlayer.setKnockbackReceived(100)
*/

/*
def juggernaut_knockback():
    @Name "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] [SUBROUTINE] Juggernaut Knockback Start [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    #When doing the juggernaut start jump
    while eventPlayer.isAlive() == true and eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true and eventPlayer.talent_counter_or_position_etc[6] == null and eventPlayer.has_hit_the_ground == false:
        (([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 5, Team.ALL, LosCheck.OFF) if eventPlayer.isInViewAngle(player, 45) and isInLoS(eventPlayer.talent_counter_or_position_etc[6].getEyePosition() + Vector.DOWN, player.getEyePosition() + Vector.DOWN, BarrierLos.PASS_THROUGH_BARRIERS) and player.getPosition().y < (eventPlayer.getEyePosition() + Vector.UP).y and player.getEyePosition().y > eventPlayer.getPosition().y and distance(eventPlayer.getPosition() + Vector.UP, player.getPosition() + Vector.UP) < 4 and player != eventPlayer and player.isAlive() == true and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.is_using_ability[Talent.DIVE_BOMB] == false and player.hit_by_talent[Talent.CYBERNETICS] == null]).hit_by_talent)[2] = eventPlayer
        wait()
        waitUntil(eventPlayer.isAlive() == false or eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false or eventPlayer.talent_counter_or_position_etc[6] != null or eventPlayer.has_hit_the_ground == true, 0.048)
*/

/*
def juggernaut_effects():
    @Name "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] Juggernaut Effects [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    wait(0.25)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    while eventPlayer.isAlive() == true and eventPlayer.juggernaut_charge > 0:
        playEffect(getAllPlayers() if (eventPlayer.isOnGround() == true and eventPlayer.getSpeedInDirection(worldVector(Vector.FORWARD, eventPlayer, Transform.ROTATION)) > 5) == true else null, DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers() if (eventPlayer.isOnGround() == true and eventPlayer.getSpeedInDirection(worldVector(Vector.FORWARD, eventPlayer, Transform.ROTATION)) > 5) == true else null, DynamicEffect.REINHARDT_FIRE_STRIKE_TARGET_IMPACT, Color.TEAM_2, eventPlayer.getPosition() + worldVector(vect(0, 0, 0.25), eventPlayer, Transform.ROTATION), 1)
        wait(1 / 7.752)
        wait(1 / 7.753)
*/

/*
rule "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] Hit By Juggernaut [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.JUGGERNAUT] != null
    
    if eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true and eventPlayer.has_hit_the_ground == true:
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT].talent_counter_or_position_etc[6] = null
        eventPlayer.talent_counter_or_position_etc[6] = null
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT].juggernaut_charge = 0
        eventPlayer.juggernaut_charge = 0
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT].setKnockbackReceived(100)
        eventPlayer.setKnockbackReceived(100)
        eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT].setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
        return
    eventPlayer.hit_by_talent[Talent.JUGGERNAUT].talent_counter_or_position_etc[6] = eventPlayer
    eventPlayer.attachTo(eventPlayer.hit_by_talent[Talent.JUGGERNAUT], vect(0, 0, 1))
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.hit_by_talent[Talent.JUGGERNAUT].getEyePosition()), 1500, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 10)
    waitUntil(eventPlayer.isDead() == true or eventPlayer.hit_by_talent[Talent.JUGGERNAUT].isDead() == true or eventPlayer.hit_by_talent[Talent.JUGGERNAUT].juggernaut_charge == 0 or eventPlayer.hit_by_talent[Talent.JUGGERNAUT].is_using_ability[Talent.PURITY_FIELD] == true or eventPlayer.hit_by_talent[Talent.JUGGERNAUT].getSpeed() <= 14, 10)
    eventPlayer.stopFacing()
    eventPlayer.teleport(eventPlayer.hit_by_talent[Talent.JUGGERNAUT])
    eventPlayer.clearStatusEffect(Status.STUNNED)
    wait()
    if eventPlayer.isDead() == true:
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT].talent_counter_or_position_etc[6] = null
        wait(0.032)
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT] = null
        return
    if eventPlayer.hit_by_talent[Talent.JUGGERNAUT].isAlive() == true:
        eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
        damage(eventPlayer, eventPlayer.hit_by_talent[Talent.JUGGERNAUT], 125 + eventPlayer.hit_by_talent[Talent.JUGGERNAUT].talent_ranks[Talent.JUGGERNAUT] * 25)
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT].talent_counter_or_position_etc[6] = eventPlayer.hit_by_talent[Talent.JUGGERNAUT]
        wait(0.032)
        eventPlayer.hit_by_talent[Talent.JUGGERNAUT] = null
*/

/*
rule "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] Juggernaut Hit By Impulse [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.CYBERNETICS] != null
    
    eventPlayer.applyImpulse(angleToDirection(horizontalAngleOfDirection(directionTowards(eventPlayer.hit_by_talent[Talent.CYBERNETICS].getPosition() + worldVector(vect(0, 0, 0.75), eventPlayer.hit_by_talent[Talent.CYBERNETICS], Transform.ROTATION), eventPlayer.getPosition())), -1 * 1 * 1 * 15), 20 if eventPlayer.hit_by_talent[Talent.CYBERNETICS].talent_counter_or_position_etc[6] != null else 20 if eventPlayer.hit_by_talent[Talent.CYBERNETICS].talent_counter_or_position_etc[6] == eventPlayer.hit_by_talent[Talent.CYBERNETICS] else 7.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    async(juggernaut_impulse_sound_cd, AsyncBehavior.NOOP)
    wait()
    eventPlayer.hit_by_talent[Talent.CYBERNETICS] = null
*/

/*
def juggernaut_impulse_sound_cd():
    @Name "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] [SUBROUTINE] Juggernaut Impulse Sound Cooldo﻿wn [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    playEffect(getAllPlayers(), DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    wait(0.333)
*/

/*
def cancel_juggernaut():
    @Name "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] Cancel Juggernaut [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    wait(0.5)
    if eventPlayer.isDead() == true:
        return
    if eventPlayer.isHoldingButton(Button.INTERACT) == true:
        waitUntil(eventPlayer.isHoldingButton(Button.INTERACT) == false or eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false, 10)
    if eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false:
        return
    if eventPlayer.isHoldingButton(Button.INTERACT) == false:
        waitUntil(eventPlayer.isHoldingButton(Button.INTERACT) == true or eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false, 10)
    if eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false:
        return
    if eventPlayer.isAlive() == true and eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true:
        eventPlayer.juggernaut_charge = 0
*/

/*
def buy_dive_bomb():
    @Name "TALENT SYSTEM - - - [TALENT 7: DIVE BOMB] [SUBROUTINE] Buy Dive Bomb [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.dive_bomb_cooldown)
        eventPlayer.dive_bomb_cooldown = 0
        eventPlayer.talents_you_do_not_have[Talent.DIVE_BOMB] = talent_names[Talent.DIVE_BOMB]
        return
    if eventPlayer.talent_ranks[Talent.DIVE_BOMB] == 1:
        eventPlayer.dive_bomb_cooldown = 0
        chase(eventPlayer.dive_bomb_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.DIVE_BOMB] = null
*/

/*
rule "TALENT SYSTEM - - - [TALENT 7: DIVE BOMB] Use Dive Bomb [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.DIVE_BOMB] > 0
    @Condition eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false
    @Condition eventPlayer.is_using_ability[Talent.SHADOWSTEP] == false
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.is_using_ability[Talent.JETPACK] == false
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.dive_bomb_cooldown == 0
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.getAltitude() > 3
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.isCommunicatingEmote() == false
    
    eventPlayer.is_using_ability[Talent.DIVE_BOMB] = true
    eventPlayer.setPrimaryFireEnabled(false)
    if eventPlayer.is_using_ability[Talent.STEALTH] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    eventPlayer.dive_bomb_cooldown = 20
    playEffect(getAllPlayers(), DynamicEffect.SOLDIER_SPRINT_START_SOUND, Color.TEAM_1, eventPlayer, 100)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_LEAP, Color.TEAM_2, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.TEAM_2, eventPlayer.getPosition() + Vector.UP, 100)
    eventPlayer.startForcingPosition(eventPlayer.getPosition(), true)
    wait()
    eventPlayer.stopForcingPosition()
    eventPlayer.applyImpulse(Vector.UP, 7.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.35)
    createEffect(getAllPlayers(), Effect.ASHE_DYNAMITE_BURNING_PARTICLE, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.TORBJORN_OVERLOADING, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[1] = getLastCreatedEntity()
    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION, Color.TEAM_2, eventPlayer, 100)
    wait(0.35)
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection() if eventPlayer.getVerticalFacingAngle() > 0 else worldVector(vect(0, 0, 1), eventPlayer, Transform.ROTATION), 25, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, true)
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[2] = getLastCreatedEntity()
    while eventPlayer.isAlive() == true and eventPlayer.isInAir() == true:
        playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT, Color.TEAM_2, eventPlayer, 1)
        wait(0.25)
    destroyEffect(eventPlayer.player_temp_effects[0])
    destroyEffect(eventPlayer.player_temp_effects[1])
    destroyEffect(eventPlayer.player_temp_effects[2])
    if eventPlayer.isAlive() == true:
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT, Color.TEAM_2, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
        #Impulse
        (([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 5, Team.ALL, LosCheck.SURFACES) if player.is_using_ability[15] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player != eventPlayer and player.browsing_shop == false and player.isAlive() == true]).hit_by_talent)[7] = eventPlayer
        wait(0.125)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION, Color.TEAM_2, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
    eventPlayer.is_using_ability[Talent.DIVE_BOMB] = false
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, false)
    eventPlayer.setPrimaryFireEnabled(true)
*/

/*
rule "TALENT SYSTEM - - - [TALENT 7: DIVE BOMB] Hit By Dive Bomb [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.DIVE_BOMB] != null
    
    if eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true:
        eventPlayer.hit_by_talent[Talent.DIVE_BOMB] = null
        return
    eventPlayer.applyImpulse(angleToDirection(horizontalAngleOfDirection(directionTowards(eventPlayer.hit_by_talent[Talent.DIVE_BOMB].getPosition(), eventPlayer.getPosition())), -1 * 1 * 1 * 45), 15, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    wait()
    damage(eventPlayer, eventPlayer.hit_by_talent[Talent.DIVE_BOMB], 125 + eventPlayer.hit_by_talent[Talent.DIVE_BOMB].talent_ranks[Talent.DIVE_BOMB] * 25)
    eventPlayer.hit_by_talent[Talent.DIVE_BOMB] = null
    eventPlayer.talent_counter_or_position_etc[7] = 3
    while eventPlayer.talent_counter_or_position_etc[7] > 0 and eventPlayer.hit_by_talent[Talent.DIVE_BOMB] == null and eventPlayer.isAlive() == true:
        playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT, Color.TEAM_2, eventPlayer, 1)
        eventPlayer.talent_counter_or_position_etc[7] -= 1
        wait(0.5, Wait.RESTART_WHEN_TRUE)
*/

def buy_cryogenics():
    @Name "TALENT SYSTEM - - - [TALENT 8: CRYOGENICS] [SUBROUTINE] Buy Cryogenics"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.CRYOGENICS] = talent_names[Talent.CRYOGENICS]
        return
    if eventPlayer.talent_ranks[Talent.CRYOGENICS] == 1:
        eventPlayer.talents_you_do_not_have[Talent.CRYOGENICS] = null


rule "TALENT SYSTEM - - - [TALENT 8: CRYOGENICS] Hit By Cryogenics":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.CRYOGENICS] != null
    
    if eventPlayer.is_using_ability[Talent.SHADOWSTEP] == true:
        eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
        return
    if eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true:
        eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
        return
    if eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true:
        eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
        return
    #Is affected by ability
    eventPlayer.is_using_ability[Talent.CRYOGENICS] = false
    if eventPlayer.hit_by_talent[Talent.CRYOGENICS] == eventPlayer:
        eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
        return
    if eventPlayer.getCurrentHero() != Hero.SOLDIER and eventPlayer.getCurrentHero() != Hero.REAPER:
        eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
        return
    #Is affected by ability
    eventPlayer.is_using_ability[Talent.CRYOGENICS] = true
    stopChasingVariable(eventPlayer.time_since_freezing_rocket)
    eventPlayer.time_since_freezing_rocket = 0
    chase(eventPlayer.time_since_freezing_rocket, 3, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    #If the incoming freezing rocket has a higher duration
    if 2 + eventPlayer.hit_by_talent[Talent.CRYOGENICS].talent_ranks[Talent.CRYOGENICS] * 0.2 > eventPlayer.slow_duration - eventPlayer.time_since_freezing_rocket:
        eventPlayer.slow_duration = 2 + eventPlayer.hit_by_talent[Talent.CRYOGENICS].talent_ranks[Talent.CRYOGENICS] * 0.2
    #If the incoming freezing rocket has a higher slow amount
    if eventPlayer.stats[2] * 0.5 - eventPlayer.hit_by_talent[Talent.CRYOGENICS].talent_ranks[Talent.CRYOGENICS] * 10 < eventPlayer.slow_amount:
        eventPlayer.slow_amount = eventPlayer.stats[2] * 0.5 - eventPlayer.hit_by_talent[Talent.CRYOGENICS].talent_ranks[Talent.CRYOGENICS] * 10
    eventPlayer.refresh_slow = true
    eventPlayer.hit_by_talent[Talent.CRYOGENICS] = null
    wait(eventPlayer.slow_duration, Wait.RESTART_WHEN_TRUE)
    #Is affected by ability
    eventPlayer.is_using_ability[Talent.CRYOGENICS] = false
    stopChasingVariable(eventPlayer.time_since_freezing_rocket)
    eventPlayer.time_since_freezing_rocket = 0


def buy_railgun():
    @Name "TALENT SYSTEM - - - [TALENT 9: RAILGUN] [SUBROUTINE] Buy Railgun"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]] == talent_names[Talent.OVERCLOCK]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.RAILGUN], talent_names[Talent.OVERCLOCK]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.OVERCLOCK] > 0:
            smallMessage(eventPlayer, "Need to remove {0} first!".format(talent_names[Talent.OVERCLOCK]))
            lbl_0:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            return
        stopChasingVariable(eventPlayer.railgun_discharge)
        destroyEffect(eventPlayer.player_temp_effects[59])
        eventPlayer.railgun_discharge = 0
        eventPlayer.railgun_charge = 0
        eventPlayer.setSecondaryFireEnabled(true)
        eventPlayer.railgun_projectile_start = []
        eventPlayer.railgun_projectile_player_hit = []
        eventPlayer.talents_you_do_not_have[Talent.RAILGUN] = talent_names[Talent.RAILGUN]
        eventPlayer.talents_you_do_not_have[Talent.OVERCLOCK] = null
        return
    if eventPlayer.talent_ranks[Talent.RAILGUN] == 1:
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents[Talent.OVERCLOCK] = "{0}".format(talent_names[Talent.OVERCLOCK])
        eventPlayer.railgun_projectile_start = []
        eventPlayer.railgun_projectile_player_hit = []
        chase(eventPlayer.railgun_discharge, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.railgun_charge = 0
        eventPlayer.setSecondaryFireEnabled(false)
        createEffect(getAllPlayers() if eventPlayer.railgun_charge >= 100 else null, Effect.ANA_NANO_BOOSTED, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[59] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have[Talent.RAILGUN] = null
        eventPlayer.talents_you_do_not_have[Talent.OVERCLOCK] = talent_names[Talent.OVERCLOCK]


rule "TALENT SYSTEM - - - [TALENT 9: RAILGUN] Use Railgun":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.RAILGUN] > 0
    @Condition eventPlayer.is_using_hearthstone[0] == false
    @Condition eventPlayer.railgun_charge >= 100
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isCommunicatingEmote() == false
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false
    @Condition eventPlayer.isCommunicatingEmote() == false
    
    eventPlayer.is_using_ability[Talent.RAILGUN] = true
    if eventPlayer.is_using_ability[Talent.STEALTH] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    eventPlayer.railgun_hit_someone = false
    eventPlayer.railgun_charge = 0
    eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition(), eventPlayer.getPosition() + worldVector(vect(0, 2, -1 * 1 * 1 * 2), eventPlayer, Transform.ROTATION)), 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    #Create All Start Positions
    eventPlayer.railgun_projectile_start[0] = eventPlayer.getEyePosition()
    for eventPlayer.railgun_raycasts_counter in range(0, 360, 360 / 7):
        eventPlayer.railgun_projectile_start.append(eventPlayer.getEyePosition() + (0.25 * (evalOnce(cosDeg(eventPlayer.railgun_raycasts_counter)) * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (evalOnce(sinDeg(eventPlayer.railgun_raycasts_counter)) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))))) + eventPlayer.getFacingDirection())
    #Create All End Positions
    eventPlayer.railgun_projectile_player_hit[0] = raycast(eventPlayer.railgun_projectile_start[0], eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, true).getPlayerHit()
    eventPlayer.railgun_projectile_destination = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, true).getHitPosition()
    for eventPlayer.railgun_raycasts_counter in range(0, 360, 360 / 7):
        eventPlayer.railgun_projectile_player_hit.append(raycast(eventPlayer.getEyePosition() + (0.5 * (cosDeg(eventPlayer.railgun_raycasts_counter) * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (sinDeg(eventPlayer.railgun_raycasts_counter) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))))), eventPlayer.getEyePosition() + (0.5 * (cosDeg(eventPlayer.railgun_raycasts_counter) * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (sinDeg(eventPlayer.railgun_raycasts_counter) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))))) + 100 * eventPlayer.getFacingDirection(), getAllPlayers(), eventPlayer, true).getPlayerHit())
    #If a player is hit
    if any([player != null for player in eventPlayer.railgun_projectile_player_hit]):
        ((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null and (player.getCurrentHero() == Hero.SOLDIER or player.getCurrentHero() == Hero.REAPER)], lambda i: distance(eventPlayer.getPosition(), i)))[0]).setStatusEffect(null, Status.STUNNED, 0.5)
        #Wait so that Ignore Pain can trigger before Damage
        wait()
        damage((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null], lambda i: distance(eventPlayer.getPosition(), i)))[0], eventPlayer, 81.25 + eventPlayer.talent_ranks[Talent.RAILGUN] * 18.75)
        if eventPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] > 0:
            heal(eventPlayer, eventPlayer, min((120 + eventPlayer.talent_ranks[Talent.RAILGUN] * 20) * (0.112 + eventPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] * 0.038), eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)))
            eventPlayer.is_lifestealing = 1.5
            playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
            lifesteal_hps()
        if eventPlayer.talent_ranks[Talent.IGNITE] > 0:
            if (((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null], lambda i: distance(eventPlayer.getPosition(), i)))[0]).is_using_ability)[1] == false:
                ((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null], lambda i: distance(eventPlayer.getPosition(), i)))[0]).setStatusEffect(eventPlayer, Status.BURNING, 3)
                ((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null], lambda i: distance(eventPlayer.getPosition(), i)))[0]).startDoT(eventPlayer, 3, floor(eventPlayer.talent_ranks[Talent.IGNITE] * 0.056 * 120))
        playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT, Color.TEAM_1, eventPlayer.getPlayerClosestToReticle(Team.ALL).getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.TEAM_2, eventPlayer.getPlayerClosestToReticle(Team.ALL).getPosition(), 100)
        playEffect(getAllPlayers(), DynamicEffect.PHARAH_CONCUSSIVE_BLAST, Color.TEAM_1, eventPlayer.getPlayerClosestToReticle(Team.ALL).getPosition(), 1)
        if eventPlayer.talent_ranks[Talent.CRYOGENICS] > 0 and eventPlayer.getPlayerClosestToReticle(Team.ALL).is_using_ability[Talent.JUGGERNAUT] == false:
            eventPlayer.getPlayerClosestToReticle(Team.ALL).hit_by_talent[Talent.CRYOGENICS] = eventPlayer
    async(railgun_projectile_is_in_air, AsyncBehavior.NOOP)
    eventPlayer.is_using_ability[Talent.RAILGUN] = false
    eventPlayer.railgun_projectile_start = []
    if eventPlayer.getCurrentHero() != Hero.SOLDIER and eventPlayer.getCurrentHero() != Hero.REAPER:


rule "TALENT SYSTEM - - - [TALENT 9: RAILGUN] Railgun Discharge":
    @Event eachPlayer
    @Condition eventPlayer.talent_ranks[Talent.RAILGUN] > 0
    @Condition eventPlayer.railgun_discharge == 0
    
    chase(eventPlayer.railgun_charge, 0, rate=10, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(eventPlayer.railgun_charge == 0 or eventPlayer.railgun_discharge == 6, 99999)
    stopChasingVariable(eventPlayer.railgun_charge)


def railgun_projectile_is_in_air():
    @Name "TALENT SYSTEM - - - [TALENT 9: RAILGUN] [SUBROUTINE] Railgun Projectile Is In Air"
    
    createBeam(getAllPlayers() if eventPlayer.railgun_projectile_is_in_air == true else null, Beam.BAD, evalOnce(eventPlayer.getPosition() + worldVector(vect(-1 * 1 * 1 * 0.25, 1.375, 0), eventPlayer, Transform.ROTATION) if eventPlayer.isCrouching() == false else eventPlayer.getPosition() + worldVector(vect(-1 * 1 * 1 * 0.25, 0.875, 0), eventPlayer, Transform.ROTATION)), (((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null and (player.getCurrentHero() == Hero.SOLDIER or player.getCurrentHero() == Hero.REAPER)], lambda i: distance(eventPlayer.getPosition(), i)))[0]).getPosition()) + Vector.UP if any([player != null for player in eventPlayer.railgun_projectile_player_hit]) else eventPlayer.railgun_projectile_destination, Color.SKY_BLUE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.TEAM_2, ((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null and (player.getCurrentHero() == Hero.SOLDIER or player.getCurrentHero() == Hero.REAPER)], lambda i: distance(eventPlayer.getPosition(), i.getPosition() + Vector.UP)))[0]).getPosition() if any([player != null for player in eventPlayer.railgun_projectile_player_hit]) else eventPlayer.railgun_projectile_destination, 100)
    playEffect(getAllPlayers(), DynamicEffect.PHARAH_CONCUSSIVE_BLAST, Color.TEAM_1, ((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null and (player.getCurrentHero() == Hero.SOLDIER or player.getCurrentHero() == Hero.REAPER)], lambda i: distance(eventPlayer.getPosition(), i.getPosition() + Vector.UP)))[0]).getPosition() if any([player != null for player in eventPlayer.railgun_projectile_player_hit]) else eventPlayer.railgun_projectile_destination, 1)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT, Color.TEAM_1, ((sorted([player for player in eventPlayer.railgun_projectile_player_hit if player != null and (player.getCurrentHero() == Hero.SOLDIER or player.getCurrentHero() == Hero.REAPER)], lambda i: distance(eventPlayer.getPosition(), i.getPosition() + Vector.UP)))[0]).getPosition() if any([player != null for player in eventPlayer.railgun_projectile_player_hit]) else eventPlayer.railgun_projectile_destination, 1)
    eventPlayer.player_temp_effects[30] = getLastCreatedEntity()
    eventPlayer.railgun_projectile_is_in_air = true
    wait(0.375)
    destroyEffect(eventPlayer.player_temp_effects[30])
    eventPlayer.railgun_projectile_is_in_air = false
    eventPlayer.railgun_projectile_start = []
    eventPlayer.railgun_projectile_player_hit = []


def buy_predator():
    @Name "TALENT SYSTEM - - - [TALENT 10: PREDATOR] [SUBROUTINE] Buy Predator"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        #If you are trying to replace predator with soul siphon
        if eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]] == talent_names[Talent.SOUL_SIPHON]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.PREDATOR], talent_names[Talent.SOUL_SIPHON]))
            goto lbl_0
        #If you are trying to remove predator when you have soul siphon
        if eventPlayer.talent_ranks[Talent.SOUL_SIPHON] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Soul Siphon first!".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)))
            lbl_0:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            return
        stopChasingVariable(eventPlayer.predator_cooldown)
        eventPlayer.predator_cooldown = 0
        eventPlayer.talents_you_do_not_have[Talent.PREDATOR] = talent_names[Talent.PREDATOR]
        eventPlayer.talents_you_do_not_have[Talent.SOUL_SIPHON] = null
        return
    if eventPlayer.talent_ranks[Talent.PREDATOR] == 1:
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents[29] = "{0} [Soul Siphon]".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE))
        eventPlayer.predator_cooldown = 0
        chase(eventPlayer.predator_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.PREDATOR] = null
        eventPlayer.talents_you_do_not_have[Talent.SOUL_SIPHON] = talent_names[Talent.SOUL_SIPHON]


rule "TALENT SYSTEM - - - [TALENT 10: PREDATOR] Predator":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.PREDATOR] != null
    
    eventPlayer.setStatusEffect(null, Status.STUNNED, 1)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1)
    eventPlayer.predator_effect_position_1 = worldVector(vect(1, 2, 0), eventPlayer.hit_by_talent[Talent.PREDATOR], Transform.ROTATION) + eventPlayer.getPosition()
    eventPlayer.predator_effect_position_2 = worldVector(vect(-1 * 1 * 1 * 1, 2, 0), eventPlayer.hit_by_talent[Talent.PREDATOR], Transform.ROTATION) + eventPlayer.getPosition()
    createBeam(getAllPlayers(), Beam.BAD, worldVector(vect(1, 2, 0), eventPlayer.hit_by_talent[Talent.PREDATOR], Transform.ROTATION) + eventPlayer.getPosition(), eventPlayer.predator_effect_position_1, Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.predator_effects.append(getLastCreatedEntity())
    createBeam(getAllPlayers(), Beam.BAD, worldVector(vect(-1 * 1 * 1 * 1, 2, 0), eventPlayer.hit_by_talent[Talent.PREDATOR], Transform.ROTATION) + eventPlayer.getPosition(), eventPlayer.predator_effect_position_2, Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.predator_effects.append(getLastCreatedEntity())
    chase(eventPlayer.predator_effect_position_1, worldVector(vect(-1 * 1 * 1 * 1, 0, 0), eventPlayer.hit_by_talent[Talent.PREDATOR], Transform.ROTATION) + eventPlayer.getPosition(), duration=0.25, ChaseReeval.DESTINATION_AND_DURATION)
    chase(eventPlayer.predator_effect_position_2, worldVector(vect(1, 0, 0), eventPlayer.hit_by_talent[Talent.PREDATOR], Transform.ROTATION) + eventPlayer.getPosition(), duration=0.25, ChaseReeval.DESTINATION_AND_DURATION)
    wait(0.25)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer, 3)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.SKY_BLUE, eventPlayer, 50)
    kill(eventPlayer, eventPlayer.hit_by_talent[Talent.PREDATOR])
    destroyEffect(eventPlayer.predator_effects[1])
    destroyEffect(eventPlayer.predator_effects[2])
    eventPlayer.hit_by_talent[Talent.PREDATOR] = null
    eventPlayer.predator_effects = null
    wait(0.05)
    stopChasingVariable(eventPlayer.predator_effect_position_1)
    stopChasingVariable(eventPlayer.predator_effect_position_2)
    eventPlayer.predator_effect_position_1 = null
    eventPlayer.predator_effect_position_2 = null
    wait(3)


rule "TALENT SYSTEM - - - [TALENT 10: PREDATOR] Create Predator Effect On Myself":
    @Event eachPlayer
    @Condition any([player.talent_ranks[Talent.PREDATOR] > 0 for player in getAllPlayers()]) == true
    #when my health is <25%
    @Condition eventPlayer.getHealth() < eventPlayer.getMaxHealth() * 0.25
    @Condition eventPlayer.created_predator_effects_on_self == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.browsing_shop == false
    
    eventPlayer.created_predator_effects_on_self = true
    createEffect([player for player in getAllPlayers() if player.talent_ranks[Talent.PREDATOR] > 0 and eventPlayer.getHealth() < eventPlayer.getMaxHealth() * 0.25 and eventPlayer.isAlive() == true and player != eventPlayer and player.predator_cooldown == 0], Effect.ECHO_CLONING, Color.TEAM_2, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.in_execution_range_effects = getLastCreatedEntity()
    eventPlayer.startForcingOutlineFor([player for player in getAllPlayers() if player.talent_ranks[Talent.PREDATOR] > 0 and player.predator_cooldown == 0], true, Color.RED, OutlineVisibility.ALWAYS)
    eventPlayer.can_be_executed = true


rule "TALENT SYSTEM - - - [TALENT 10: PREDATOR] Remove Predator Effect On Myself":
    @Event eachPlayer
    #when my health is >=25%
    @Condition eventPlayer.getHealth() >= eventPlayer.getMaxHealth() * 0.25
    @Condition eventPlayer.created_predator_effects_on_self == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    
    eventPlayer.created_predator_effects_on_self = false
    eventPlayer.can_be_executed = false
    destroyEffect(eventPlayer.in_execution_range_effects)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())


def buy_jetpack():
    @Name "TALENT SYSTEM - - - [TALENT 11: JETPACK] [SUBROUTINE] Buy Jetpack"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.stopAcceleration()
        stopChasingVariable(eventPlayer.jetpack_fuel)
        eventPlayer.jetpack_fuel = 100
        destroyEffect(eventPlayer.player_temp_effects[14])
        eventPlayer.talents_you_do_not_have[Talent.JETPACK] = talent_names[Talent.JETPACK]
        return
    if eventPlayer.talent_ranks[Talent.JETPACK] == 1:
        eventPlayer.startAcceleration(Vector.UP, 10 + 0.275 * eventPlayer.jetpack_fuel if eventPlayer.is_using_ability[Talent.JETPACK] == true else 0, 3, Relativity.TO_PLAYER, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)
        eventPlayer.jetpack_fuel = 100
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.JETPACK] == true and eventPlayer.is_using_ability[Talent.STEALTH] == false else null, Effect.WRECKING_BALL_PILEDRIVER_FIRE_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[14] = getLastCreatedEntity()
        chase(eventPlayer.jetpack_fuel, 0 if eventPlayer.is_using_ability[Talent.JETPACK] == true else 100, rate=25 - eventPlayer.talent_ranks[Talent.JETPACK] * 3 if eventPlayer.is_using_ability[Talent.JETPACK] == true else 10, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.JETPACK] = null


rule "TALENT SYSTEM - - - [TALENT 11: JETPACK] Use Jetpack":
    @Event eachPlayer
    @Condition eventPlayer.talent_ranks[Talent.JETPACK] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isCommunicatingEmote() == false
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    @Condition eventPlayer.is_using_ability[Talent.SHADOWSTEP] == false
    @Condition eventPlayer.has_hit_the_ground == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition (eventPlayer.getCurrentHero() == Hero.SOLDIER or eventPlayer.getCurrentHero() == Hero.BRIGITTE) == true
    
    if eventPlayer.jetpack_will_have_a_delay == true:
        wait(0.25, Wait.ABORT_WHEN_FALSE)
        eventPlayer.jetpack_will_have_a_delay = false
    if eventPlayer.getCurrentHero() == Hero.SOLDIER:
        eventPlayer.stopForcingButton(Button.ABILITY_1)
        eventPlayer.setAbility1Enabled(false)
    eventPlayer.is_using_ability[Talent.JETPACK] = true
    waitUntil(eventPlayer.isHoldingButton(Button.JUMP) == false or eventPlayer.isAlive() == false or eventPlayer.hasStatusEffect(Status.FROZEN) == true or eventPlayer.hasStatusEffect(Status.STUNNED) == true or eventPlayer.jetpack_fuel == 0, 9999)
    eventPlayer.is_using_ability[Talent.JETPACK] = false
    if eventPlayer.getCurrentHero() == Hero.SOLDIER:
        if eventPlayer.is_using_ability[Talent.CRYOGENICS] == false:
            eventPlayer.setAbility1Enabled(true)


rule "TALENT SYSTEM - - - [TALENT 11: JETPACK] Jetpack Effects":
    @Event eachPlayer
    @Condition eventPlayer.is_using_ability[Talent.JETPACK] == true
    @Condition (eventPlayer.getCurrentHero() == Hero.SOLDIER or eventPlayer.getCurrentHero() == Hero.BRIGITTE) == true
    
    playEffect(null if eventPlayer.is_using_ability[Talent.STEALTH] == true else getAllPlayers().exclude(eventPlayer), DynamicEffect.PHARAH_BARRAGE_EXPLOSION, Color.TEAM_2, eventPlayer.getPosition() + worldVector(vect(0, 1.5, -1 * 1 * 1 * 0.5), eventPlayer, Transform.ROTATION), 1)
    wait(0.125)
    if RULE_CONDITION:
        goto RULE_START


rule "TALENT SYSTEM - - - [TALENT 11: JETPACK] Jetpack Will Have a Delay":
    @Event eachPlayer
    @Condition eventPlayer.talent_ranks[Talent.JETPACK] > 0
    @Condition eventPlayer.isOnGround() == true
    @Condition (eventPlayer.getCurrentHero() == Hero.SOLDIER or eventPlayer.getCurrentHero() == Hero.BRIGITTE) == true
    
    eventPlayer.jetpack_will_have_a_delay = true


def buy_lifesteal_ammo():
    @Name "TALENT SYSTEM - - - [TALENT 12: LIFESTEAL AMMO] [SUBROUTINE] Buy Lifesteal Ammo"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.is_lifestealing)
        eventPlayer.is_lifestealing = 0
        destroyEffect(eventPlayer.player_temp_effects[60])
        destroyEffect(eventPlayer.player_temp_effects[61])
        destroyEffect(eventPlayer.player_temp_effects[62])
        eventPlayer.talents_you_do_not_have[Talent.LIFESTEAL_AMMO] = talent_names[Talent.LIFESTEAL_AMMO]
        return
    if eventPlayer.talent_ranks[Talent.LIFESTEAL_AMMO] == 1:
        eventPlayer.is_lifestealing = 0
        chase(eventPlayer.is_lifestealing, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        createEffect(eventPlayer if eventPlayer.is_lifestealing > 0 else null, Effect.BAD_AURA_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[60] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_lifestealing > 0 else null, Effect.HEAL_TARGET, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[61] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_lifestealing > 0 else null, Effect.HEAL_TARGET_ACTIVE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[62] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have[Talent.LIFESTEAL_AMMO] = null


def buy_health_regen():
    @Name "TALENT SYSTEM - - - [TALENT 13: HEALTH REGEN] [SUBROUTINE] Buy Health Regen"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.HEALTH_REGEN] = talent_names[Talent.HEALTH_REGEN]
        destroyEffect(eventPlayer.player_temp_effects[63])
        destroyEffect(eventPlayer.player_temp_effects[64])
        stopHoT(eventPlayer.health_pool_id_or_hot_id[2])
        return
    if eventPlayer.talent_ranks[Talent.HEALTH_REGEN] == 1:
        createEffect(eventPlayer if eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL) and eventPlayer.isAlive() == true else null, Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.player_temp_effects[63] = getLastCreatedEntity()
        createEffect(eventPlayer if eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL) and eventPlayer.isAlive() == true else null, Effect.SPARKLES, Color.PURPLE if eventPlayer.is_using_ability[Talent.STEALTH] == true else Color.ORANGE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.player_temp_effects[64] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have[Talent.HEALTH_REGEN] = null
        async(health_regen_heal_over_time, AsyncBehavior.RESTART)


def health_regen_heal_over_time():
    @Name "TALENT SYSTEM - - - [TALENT 13: HEALTH REGEN] [SUBROUTINE] Health Regen Heal Over Time"
    
    while eventPlayer.talent_ranks[Talent.HEALTH_REGEN] > 0:
        waitUntil(eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL) and eventPlayer.is_using_ability[Talent.POISON_VIALS] == false or eventPlayer.talent_ranks[Talent.HEALTH_REGEN] == 0 == true, 99999)
        eventPlayer.startHoT(null, 9999, 4.5 + eventPlayer.talent_ranks[Talent.HEALTH_REGEN] * 0.9)
        eventPlayer.health_pool_id_or_hot_id[2] = getLastHoT()
        waitUntil(eventPlayer.getHealthOfType(Health.NORMAL) >= eventPlayer.getMaxHealthOfType(Health.NORMAL) or eventPlayer.is_using_ability[Talent.POISON_VIALS] == true or eventPlayer.talent_ranks[Talent.HEALTH_REGEN] == 0 == true, 99999)
        stopHoT(eventPlayer.health_pool_id_or_hot_id[2])


def buy_health_potions():
    @Name "TALENT SYSTEM - - - [TALENT 14: HEALTH POTIONS] [SUBROUTINE] Buy Health Potions"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]] == talent_names[Talent.CRAZY_ALCHEMIST]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.HEALTH_POTIONS], talent_names[Talent.CRAZY_ALCHEMIST]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Crazy Alchemist first!".format(iconString(Icon.RADIOACTIVE)))
            lbl_0:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            return
        stopChasingVariable(eventPlayer.health_potion_cooldown)
        eventPlayer.amount_of_potions_or_vials = 0
        eventPlayer.talents_you_do_not_have[Talent.HEALTH_POTIONS] = talent_names[Talent.HEALTH_POTIONS]
        eventPlayer.talents_you_do_not_have[Talent.POISON_VIALS] = talent_names[Talent.POISON_VIALS]
        eventPlayer.talents_you_do_not_have[Talent.CRAZY_ALCHEMIST] = null
        return
    if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] == 1:
        eventPlayer.amount_of_potions_or_vials = 3
        #Lock talent Poison Vials
        eventPlayer.possible_talents[Talent.POISON_VIALS] = null
        eventPlayer.talents_you_do_not_have[Talent.POISON_VIALS] = null
        eventPlayer.talents_you_do_not_have[Talent.HEALTH_POTIONS] = null
        eventPlayer.talents_you_do_not_have[Talent.CRAZY_ALCHEMIST] = talent_names[Talent.CRAZY_ALCHEMIST]
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents[Talent.CRAZY_ALCHEMIST] = "{0} [Crazy Alchemist]".format(iconString(Icon.RADIOACTIVE))
        chase(eventPlayer.health_potion_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)


rule "TALENT SYSTEM - - - [TALENT 14/31: HEALTH POTIONS/POISON VIAL] Use Health Potion or Poison Vial":
    @Event eachPlayer
    @Hero soldier
    @Condition (eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 or eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0) == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.is_using_ability[Talent.HEALTH_POTIONS] == false
    @Condition eventPlayer.amount_of_potions_or_vials > 0
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    #Juggernaut
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    #Dive Bomb
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    
    #So the code can detect if the player is casting purity field at the same time
    wait()
    if eventPlayer.getHealthOfType(Health.NORMAL) == eventPlayer.getMaxHealthOfType(Health.NORMAL) and eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0:
        async(already_at_full_health, AsyncBehavior.NOOP)
        return
    if (eventPlayer.isUsingAbility1() == true or eventPlayer.is_using_ability[Talent.PURITY_FIELD] == true) and eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0:
        return
    eventPlayer.is_using_ability[Talent.HEALTH_POTIONS] = true
    if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0:
        health_potion_hps()
        playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT, Color.TEAM_1, eventPlayer, 100)
        eventPlayer.startHoT(eventPlayer, 2, 21.875 + eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] * 8.75)
        #health_pool_id[4] & health_pool_id[5] & health_pool_id[6] &
        eventPlayer.health_pool_id_or_hot_id[7 - eventPlayer.amount_of_potions_or_vials] = getLastHoT()
        eventPlayer.amount_of_potions_or_vials -= 1
        async(health_potion_heal_over_time, AsyncBehavior.NOOP)
    if eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0:
        eventPlayer.amount_of_potions_or_vials -= 1
        if eventPlayer.is_using_ability[Talent.STEALTH] == true:
            async(break_stealth, AsyncBehavior.NOOP)
        eventPlayer.effectMemory = []
        #Customizable except Position:
        createEffect(getAllPlayers(), Effect.ORB, Color.LIME_GREEN, updateEveryTick(evalOnce(eventPlayer.getEyePosition()) + (evalOnce(eventPlayer.exitSpeed * eventPlayer.getFacingDirection()) * (accurateTime - evalOnce(accurateTime))) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime - evalOnce(accurateTime)) ** 2))), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        #////////////////////////////////
        eventPlayer.effectMemory.append(getLastCreatedEntity())
        #Customizable except Position:
        createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.LIME_GREEN, updateEveryTick(evalOnce(eventPlayer.getEyePosition()) + (evalOnce(eventPlayer.exitSpeed * eventPlayer.getFacingDirection()) * (accurateTime - evalOnce(accurateTime))) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime - evalOnce(accurateTime)) ** 2))), 0.6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        #////////////////////////////////
        eventPlayer.effectMemory.append(getLastCreatedEntity())
        eventPlayer.projData.append([[accurateTime, eventPlayer.getEyePosition(), eventPlayer.getFacingDirection(), eventPlayer.effectMemory]])
    wait(0.5)
    eventPlayer.is_using_ability[Talent.HEALTH_POTIONS] = false


rule "TALENT SYSTEM - - - [TALENT 14/31: HEALTH POTIONS/POISON VIAL] Health Potion or Poison Vial Recharge":
    @Event eachPlayer
    @Hero soldier
    @Condition (eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] > 0 or eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0) == true
    @Condition eventPlayer.amount_of_potions_or_vials < 3
    
    eventPlayer.health_potion_cooldown = 15 - eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST]
    waitUntil(eventPlayer.health_potion_cooldown == 0, 99999)
    eventPlayer.amount_of_potions_or_vials += 1
    playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, Color.WHITE, eventPlayer, 100)
    if RULE_CONDITION:
        goto RULE_START


def health_potion_heal_over_time():
    @Name "TALENT SYSTEM - - - [TALENT 14: HEALTH POTIONS] [SUBROUTINE] Health Potions Stop Heal Over Time"
    
    waitUntil(eventPlayer.isDead() == true or eventPlayer.getMaxHealthOfType(Health.NORMAL) == eventPlayer.getHealthOfType(Health.NORMAL), 2)
    removeHealthPool(eventPlayer.health_pool_id_or_hot_id[4])
    removeHealthPool(eventPlayer.health_pool_id_or_hot_id[5])
    removeHealthPool(eventPlayer.health_pool_id_or_hot_id[6])


def already_at_full_health():
    @Name "TALENT SYSTEM - - - [TALENT 14: HEALTH POTIONS] [SUBROUTINE] Health Potion Already At Full Health!"
    
    smallMessage(eventPlayer, "Already at full health!")
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 75)
    wait(3)


def buy_ignite():
    @Name "TALENT SYSTEM - - - [TALENT 16: IGNITE] [SUBROUTINE] Buy Ignite"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.ignite_position = eventPlayer.getEyePosition()
        eventPlayer.talents_you_do_not_have[Talent.IGNITE] = talent_names[Talent.IGNITE]
        return
    if eventPlayer.talent_ranks[Talent.IGNITE] == 1:
        eventPlayer.talents_you_do_not_have[Talent.IGNITE] = null


rule "TALENT SYSTEM - - - [TALENT 16: IGNITE] Ignite Effects":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.talent_ranks[Talent.IGNITE] > 0
    
    eventPlayer.is_using_ability[Talent.IGNITE] = true
    eventPlayer.ignite_position = eventPlayer.getEyePosition()
    eventPlayer.talent_counter_or_position_etc[16] = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, null, getAllPlayers(), true).getHitPosition()
    createEffect(getAllPlayers(), Effect.TORBJORN_OVERLOADING, Color.TEAM_1, eventPlayer.ignite_position, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[70] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.TORBJORN_OVERLOADING_SOUND, Color.TEAM_1, eventPlayer.ignite_position, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[72] = getLastCreatedEntity()
    chase(eventPlayer.ignite_position, eventPlayer.talent_counter_or_position_etc[16], rate=50, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(eventPlayer.is_using_ability[Talent.IGNITE] == false or eventPlayer.ignite_position == eventPlayer.talent_counter_or_position_etc[16], 5.984)
    stopChasingVariable(eventPlayer.ignite_position)
    playEffect(getAllPlayers(), DynamicEffect.JUNKRAT_CONCUSSION_MINE_EXPLOSION, Color.TEAM_1, eventPlayer.ignite_position, 1)
    playEffect(getAllPlayers(), DynamicEffect.PHARAH_ROCKET_LAUNCHER_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.ignite_position, 100)
    destroyEffect(eventPlayer.player_temp_effects[70])
    destroyEffect(eventPlayer.player_temp_effects[72])
    eventPlayer.is_using_ability[Talent.IGNITE] = false


def buy_overclock():
    @Name "TALENT SYSTEM - - - [TALENT 17: OVERCLOCK] [SUBROUTINE] Buy Overclock"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.OVERCLOCK] = talent_names[Talent.OVERCLOCK]
        return
    if eventPlayer.talent_ranks[Talent.OVERCLOCK] == 1:
        eventPlayer.talents_you_do_not_have[Talent.OVERCLOCK] = null


def buy_shadowstep():
    @Name "TALENT SYSTEM - - - [TALENT 18: SHADOWSTEP] [SUBROUTINE] Buy Shadowstep"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.shadowstep_cooldown)
        eventPlayer.shadowstep_cooldown = 0
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTRIKE] = talent_names[Talent.SHADOWSTRIKE]
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTEP] = talent_names[Talent.SHADOWSTEP]
        return
    if eventPlayer.talent_ranks[Talent.SHADOWSTEP] == 1:
        eventPlayer.shadowstep_cooldown = 0
        chase(eventPlayer.shadowstep_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTEP] = null
        eventPlayer.talents_you_do_not_have[Talent.SHADOWSTRIKE] = null


rule "TALENT SYSTEM - - - [TALENT 18/4: SHADOWSTEP/SHADOWSTRIKE] Use Shadowstep or Shadowstrike":
    @Event eachPlayer
    @Hero soldier
    @Condition (eventPlayer.talent_ranks[Talent.SHADOWSTEP] > 0 or eventPlayer.talent_ranks[Talent.SHADOWSTRIKE] > 0) == true
    @Condition eventPlayer.shadowstep_cooldown == 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition eventPlayer.is_using_hearthstone[0] == false
    #Juggernaut
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    #Dive Bomb
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.isCommunicatingEmote() == false
    
    waitUntil(eventPlayer.isHoldingButton(Button.JUMP) == false, 0.25)
    if eventPlayer.isHoldingButton(Button.JUMP) == true:
        return
    waitUntil(eventPlayer.isHoldingButton(Button.JUMP) == true, 0.25)
    if eventPlayer.isHoldingButton(Button.JUMP) == false:
        return
    eventPlayer.is_using_ability[Talent.SHADOWSTEP] = true
    #If using Shadowstrike
    if eventPlayer.talent_ranks[Talent.SHADOWSTRIKE] > 0:
        async(shadowstrike, AsyncBehavior.RESTART)
        eventPlayer.shadowstep_cooldown = 20
        playEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, DynamicEffect.MOIRA_FADE_DISAPPEAR, Color.TEAM_2, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
    #If using Shadowstep
    if eventPlayer.talent_ranks[Talent.SHADOWSTEP] > 0:
        createEffect(eventPlayer, Effect.SOMBRA_HACKING_SOUND, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[6] = getLastCreatedEntity()
        eventPlayer.shadowstep_cooldown = 22.5 - eventPlayer.talent_ranks[Talent.SHADOWSTEP] * 2.5
        playEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, DynamicEffect.SOMBRA_TRANSLOCATOR_DISAPPEAR, Color.TEAM_1, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_DISAPPEAR_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 0.5)
    eventPlayer.setGravity(0)
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 41.421 if eventPlayer.getVerticalFacingAngle() > 0 else (7.5 + ((178 + eventPlayer.getVerticalFacingAngle()) * 0.113)) * 1.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    if eventPlayer.is_using_ability[Talent.STEALTH] == false:
        eventPlayer.setInvisibility(Invis.ALL)
    createEffect(eventPlayer, Effect.REAPER_WRAITH_FORM, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[7] = getLastCreatedEntity()
    wait(0.5)
    eventPlayer.setGravity(100)
    #If using Shadowstrike
    if eventPlayer.talent_ranks[Talent.SHADOWSTRIKE] > 0:
        playEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, DynamicEffect.MOIRA_FADE_REAPPEAR, Color.TEAM_2, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
    #If using Shadowstep
    if eventPlayer.talent_ranks[Talent.SHADOWSTEP] > 0:
        playEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR, Color.TEAM_2, eventPlayer.getPosition(), 1)
        playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    if eventPlayer.is_using_ability[Talent.STEALTH] == false:
        eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.is_using_ability[Talent.SHADOWSTEP] = false
    destroyEffect(eventPlayer.player_temp_effects[6])
    destroyEffect(eventPlayer.player_temp_effects[7])


def buy_fire_aura():
    @Name "TALENT SYSTEM - - - [TALENT 19: BURNING SOUL] [SUBROUTINE] Buy Burning Soul"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.burning_soul_orb_timer)
        eventPlayer.talents_you_do_not_have[Talent.BURNING_SOUL] = talent_names[Talent.BURNING_SOUL]
        destroyEffect(eventPlayer.player_temp_effects[65])
        destroyEffect(eventPlayer.player_temp_effects[66])
        return
    if eventPlayer.talent_ranks[Talent.BURNING_SOUL] == 1:
        createEffect(getAllPlayers() if eventPlayer.isCommunicatingEmote() == true else [player for player in getAllPlayers() if player != eventPlayer], Effect.ASHE_DYNAMITE_BURNING_PARTICLE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[65] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ASHE_DYNAMITE_BURNING_MATERIAL, Color.TEAM_2, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[66] = getLastCreatedEntity()
        chase(eventPlayer.burning_soul_orb_timer, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.BURNING_SOUL] = null


rule "TALENT SYSTEM - - - [TALENT 19: BURNING SOUL] Burning Soul":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.BURNING_SOUL] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition (eventPlayer.is_using_ability[Talent.IGNORE_PAIN] > 0 and eventPlayer.isUsingAbility1() == true) == false
    @Condition (len([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 6, Team.ALL, LosCheck.SURFACES) if player != eventPlayer and player.is_using_ability[Talent.SHADOWSTEP] == false and eventPlayer.is_using_ability[Talent.STEALTH] == false and player.browsing_shop == false and player.is_using_ability[Talent.STEALTH] == false])) > 0
    
    ([player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 6, Team.ALL, LosCheck.SURFACES) if player != eventPlayer and player.is_using_ability[Talent.SHADOWSTEP] == false and player.is_using_ability[Talent.PURITY_FIELD] == false and player.browsing_shop == false and player.isAlive() == true]).setStatusEffect(eventPlayer, Status.BURNING, 1)
    eventPlayer.victims_in_fire_aura_radius = [player for player in getPlayersInRadius(eventPlayer.getPosition() + Vector.UP, 6, Team.ALL, LosCheck.SURFACES) if player != eventPlayer and player.is_using_ability[Talent.SHADOWSTEP] == false and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.STEALTH] == false and player.browsing_shop == false]
    for eventPlayer.fire_soul_loop in range(len(eventPlayer.victims_in_fire_aura_radius)):
        damage(eventPlayer.victims_in_fire_aura_radius[eventPlayer.fire_soul_loop], eventPlayer, 3 + eventPlayer.talent_ranks[Talent.BURNING_SOUL] * 0.6)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "TALENT SYSTEM - - - [TALENT 19: BURNING SOUL] Hit By Burning Soul Orb Explosion":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.BURNING_SOUL] != null
    
    eventPlayer.applyImpulse(directionTowards(eventPlayer.hit_by_talent[Talent.BURNING_SOUL].getPosition() if eventPlayer.hit_by_talent[Talent.BURNING_SOUL].is_using_ability[33] == true else eventPlayer.hit_by_talent[Talent.BURNING_SOUL].xp_orb_location, eventPlayer.getEyePosition()), 12.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    damage(eventPlayer, eventPlayer.hit_by_talent[Talent.BURNING_SOUL], 75 + eventPlayer.hit_by_talent[Talent.BURNING_SOUL].talent_ranks[Talent.BURNING_SOUL] * 25)
    wait()
    eventPlayer.hit_by_talent[Talent.BURNING_SOUL] = null


def dropped_burning_soul_orb():
    @Name "TALENT SYSTEM - - - [TALENT 19: BURNING SOUL] Dropped Burning Soul Orb"
    
    waitUntil(eventPlayer.burning_soul_orb_timer == 0, 4)
    (([player for player in (getPlayersInRadius(eventPlayer.getPosition() + Vector.UP * 0.25 if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location + Vector.UP * 0.25, 3, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS)) if player != eventPlayer]).hit_by_talent)[19] = eventPlayer
    playEffect(getAllPlayers(), DynamicEffect.JUNKRAT_FRAG_LAUNCHER_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, 100)
    playEffect(getAllPlayers(), DynamicEffect.JUNKRAT_FRAG_LAUNCHER_EXPLOSION, Color.TEAM_2, eventPlayer.getPosition() if eventPlayer.is_using_ability[33] == true else eventPlayer.xp_orb_location, 1)
    destroyEffect(eventPlayer.player_temp_effects[54])


def buy_berserker():
    @Name "TALENT SYSTEM - - - [TALENT 20: BERSERKER] [SUBROUTINE] Buy Berserker"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]] == talent_names[Talent.BLOODTHIRST]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.BERSERKER], talent_names[Talent.BLOODTHIRST]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.BLOODTHIRST] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Bloodthirst first!".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1)))
            lbl_0:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            return
        stopChasingVariable(eventPlayer.berserker_cooldown)
        eventPlayer.berserker_cooldown = 0
        eventPlayer.talents_you_do_not_have[Talent.BERSERKER] = talent_names[Talent.BERSERKER]
        eventPlayer.talents_you_do_not_have[Talent.BLOODTHIRST] = null
        destroyEffect(eventPlayer.player_temp_effects[67])
        destroyEffect(eventPlayer.player_temp_effects[68])
        destroyEffect(eventPlayer.player_temp_effects[69])
        return
    if eventPlayer.talent_ranks[Talent.BERSERKER] == 1:
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents[Talent.BLOODTHIRST] = "{0} [Bloodthirst]".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1))
        eventPlayer.talents_you_do_not_have[Talent.BLOODTHIRST] = talent_names[Talent.BLOODTHIRST]
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.BERSERKER] == true else null, Effect.WINSTON_PRIMAL_RAGE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[67] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.BERSERKER] == true else null, Effect.WINSTON_PRIMAL_RAGE, Color.TEAM_2, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[68] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.BERSERKER] == true else null, Effect.WINSTON_PRIMAL_RAGE_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[69] = getLastCreatedEntity()
        eventPlayer.berserker_cooldown = 0
        chase(eventPlayer.berserker_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.BERSERKER] = null


rule "TALENT SYSTEM - - - [TALENT 20: BERSERKER] Use Berserker":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.BERSERKER] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.berserker_cooldown == 0
    #Berserker
    @Condition eventPlayer.is_using_ability[Talent.BERSERKER] == false
    #Immunity
    @Condition eventPlayer.is_using_ability[15] == false
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    #Juggernaut
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    #Dive Bomb
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false
    @Condition eventPlayer.isCommunicatingEmote() == false
    
    eventPlayer.is_using_ability[Talent.BERSERKER] = true
    eventPlayer.berserker_cooldown = 45
    eventPlayer.setDamageDealt(eventPlayer.stats[0] * 1.25)
    eventPlayer.setDamageReceived(110)
    wait(0.5)
    waitUntil(eventPlayer.isDead() == true or eventPlayer.isHoldingButton(Button.ULTIMATE) == true, 3.75 + eventPlayer.talent_ranks[Talent.BERSERKER] * 1.25 - 0.5)
    eventPlayer.setDamageDealt(eventPlayer.stats[0])
    eventPlayer.setDamageReceived(100)
    eventPlayer.is_using_ability[Talent.BERSERKER] = false
    if eventPlayer.isAlive() == true and eventPlayer.talent_ranks[Talent.BLOODTHIRST] > 0 and eventPlayer.bloodthirst_shield[0] >= 1:
        async(bloodthirst_effects, AsyncBehavior.RESTART)
        eventPlayer.bloodthirst_shield[3] = eventPlayer.bloodthirst_shield[0]
        wait()
        smallMessage(eventPlayer, "{0} Bloodthirst Healing: {1}!".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1), round(eventPlayer.bloodthirst_shield[3])))
        eventPlayer.bloodthirst_shield[2] = eventPlayer.bloodthirst_shield[0]
        eventPlayer.bloodthirst_shield[0] -= eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)
        heal(eventPlayer, eventPlayer, min(eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL), eventPlayer.bloodthirst_shield[2]))
        eventPlayer.bloodthirst_shield[1] = eventPlayer.bloodthirst_shield[0] / (45 - (3.75 + eventPlayer.talent_ranks[Talent.BERSERKER] * 1.25))
        eventPlayer.is_using_ability[Talent.BLOODTHIRST] = true
        eventPlayer.addHealthPool(Health.NORMAL, eventPlayer.bloodthirst_shield[0], false, true)
        eventPlayer.health_pool_id_or_hot_id[1] = getLastCreatedHealthPool()
        while eventPlayer.getHealthOfType(Health.NORMAL) > eventPlayer.stats[1] * 2 and eventPlayer.isAlive() == true and eventPlayer.bloodthirst_shield[0] >= 1:
            removeHealthPool(eventPlayer.health_pool_id_or_hot_id[1])
            eventPlayer.bloodthirst_shield[0] -= eventPlayer.bloodthirst_shield[1]
            eventPlayer.addHealthPool(Health.NORMAL, eventPlayer.bloodthirst_shield[0], false, true)
            eventPlayer.health_pool_id_or_hot_id[1] = getLastCreatedHealthPool()
            wait(1)
        removeHealthPool(eventPlayer.health_pool_id_or_hot_id[1])
        eventPlayer.is_using_ability[Talent.BLOODTHIRST] = false
        wait()
    eventPlayer.bloodthirst_shield = 0


def buy_fireball():
    @Name "TALENT SYSTEM - - - [TALENT 21: FIREBALL] [SUBROUTINE] Buy Fireball"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.offered_talents_in_shop[1] == talent_names[Talent.PYROMANIAC]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.FIREBALL], talent_names[Talent.PYROMANIAC]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.PYROMANIAC] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Pyromaniac first!".format(abilityIconString(Hero.REAPER, Button.ULTIMATE)))
            lbl_0:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            return
        stopChasingVariable(eventPlayer.fireball_cooldown)
        eventPlayer.fireball_cooldown = 0
        eventPlayer.fireball_position = vect(0, 0, 0)
        eventPlayer.talents_you_do_not_have[Talent.JUGGERNAUT] = talent_names[Talent.JUGGERNAUT]
        eventPlayer.talents_you_do_not_have[Talent.FIREBALL] = talent_names[Talent.FIREBALL]
        eventPlayer.talents_you_do_not_have[Talent.PYROMANIAC] = null
        return
    if eventPlayer.talent_ranks[Talent.FIREBALL] == 1:
        eventPlayer.fireball_position = vect(0, 0, 0)
        chase(eventPlayer.fireball_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents[Talent.PYROMANIAC] = "{0} [Pyromaniac]".format(abilityIconString(Hero.REAPER, Button.ULTIMATE))
        eventPlayer.talents_you_do_not_have[Talent.FIREBALL] = null
        eventPlayer.talents_you_do_not_have[Talent.JUGGERNAUT] = null
        eventPlayer.talents_you_do_not_have[Talent.PYROMANIAC] = talent_names[Talent.PYROMANIAC]


def spawned_with_fireball():
    @Name "TALENT SYSTEM - - - [TALENT 21: FIREBALL] [SUBROUTINE] Spawned With Fireball"
    
    eventPlayer.disallowButton(Button.INTERACT)
    wait(2)
    eventPlayer.allowButton(Button.INTERACT)


rule "TALENT SYSTEM - - - [TALENT 21: FIREBALL] Use Fireball":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.FIREBALL] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.fireball_cooldown == 0
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.STUNNED) == false
    @Condition eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false
    @Condition (eventPlayer.hasStatusEffect(Status.PHASED_OUT) == false if eventPlayer.is_using_ability[Talent.SHADOWSTEP] == false else eventPlayer.isAlive()) == true
    @Condition eventPlayer.isUsingAbility1() == false
    @Condition eventPlayer.fireball_in_air == false
    @Condition eventPlayer.is_using_ability[15] == false
    @Condition eventPlayer.is_using_hearthstone[0] == false
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    @Condition eventPlayer.fireball_position == vect(0, 0, 0)
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false
    @Condition eventPlayer.isCommunicatingEmote() == false
    
    if eventPlayer.is_using_ability[Talent.STEALTH] == true:
        async(break_stealth, AsyncBehavior.NOOP)
    eventPlayer.fireball_cooldown = 12
    async(fireball_casted, AsyncBehavior.NOOP)


def fireball_casted():
    @Name "TALENT SYSTEM - - - [TALENT 21: FIREBALL] [SUBROUTINE] Fireball Casted"
    
    eventPlayer.fireball_in_air = true
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_RISING_UPPERCUT_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
    createEffect(getAllPlayers(), Effect.ORB, Color.ORANGE, eventPlayer.fireball_position, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.fireball_effects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.RED, eventPlayer.fireball_position, 0.45, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.fireball_effects[1] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.BAD_AURA, Color.RED, eventPlayer.fireball_position, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.fireball_effects[2] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.TORBJORN_OVERLOADING_SOUND, Color.ORANGE, eventPlayer.fireball_position, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.fireball_effects[3] = getLastCreatedEntity()
    eventPlayer.fireball_destination = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000, getAllPlayers(), eventPlayer, true).getHitPosition()
    eventPlayer.fireball_position = eventPlayer.getEyePosition()
    chase(eventPlayer.fireball_position, eventPlayer.fireball_destination, rate=15, ChaseReeval.DESTINATION_AND_RATE)
    while eventPlayer.fireball_in_air == true:
        playEffect(getAllPlayers(), DynamicEffect.PHARAH_BARRAGE_EXPLOSION, Color.ORANGE, eventPlayer.fireball_position, 0.75)
        playEffect(getAllPlayers(), DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION, Color.TEAM_2, eventPlayer.fireball_position, 0.75)
        wait(0.05)
    stopChasingVariable(eventPlayer.fireball_position)
    destroyEffect(eventPlayer.fireball_effects[0])
    destroyEffect(eventPlayer.fireball_effects[1])
    destroyEffect(eventPlayer.fireball_effects[2])
    destroyEffect(eventPlayer.fireball_effects[3])
    eventPlayer.fireball_position = vect(0, 0, 0)
    destroyEffect(eventPlayer.player_temp_effects[29])


rule "TALENT SYSTEM - - - [TALENT 21: FIREBALL] Fireball Hit Something":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.FIREBALL] > 0
    @Condition eventPlayer.fireball_in_air == true
    @Condition (eventPlayer.fireball_position == eventPlayer.fireball_destination or eventPlayer.fireball_cooldown == 0 or (any([player != eventPlayer and player.is_using_ability[Talent.SHADOWSTEP] == false and eventPlayer.fireball_position != vect(0, 0, 0) and player.isAlive() and player.browsing_shop == false for player in getPlayersInRadius(eventPlayer.fireball_position.getPosition(), 1.75, Team.ALL, LosCheck.SURFACES)])) == true) == true
    
    #Impulse
    (([player for player in getPlayersInRadius(eventPlayer.fireball_position, 4, Team.ALL, LosCheck.SURFACES) if player.isAlive() == true and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false]).hit_by_talent)[21] = eventPlayer
    #Set Status Burning
    ([player for player in getPlayersInRadius(eventPlayer.fireball_position, 4, Team.ALL, LosCheck.SURFACES) if player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.isAlive() == true]).setStatusEffect(eventPlayer, Status.BURNING, 5)
    #Who should recieve full damage?
    eventPlayer.victims_in_fireball_radius = [player for player in getPlayersInRadius(eventPlayer.fireball_position, 4, Team.ALL, LosCheck.SURFACES) if player.browsing_shop == false and player.isAlive() == true and player != eventPlayer and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false]
    for eventPlayer.fireball_loop in range(len(eventPlayer.victims_in_fireball_radius)):
        damage(eventPlayer.victims_in_fireball_radius[eventPlayer.fireball_loop], eventPlayer, 37.5 + eventPlayer.talent_ranks[Talent.FIREBALL] * 12.5)
        eventPlayer.victims_in_fireball_radius[eventPlayer.fireball_loop].startDoT(eventPlayer, 5, 7.5 + eventPlayer.talent_ranks[Talent.FIREBALL] * 2.5)
    #If the caster is within radius
    if ([player for player in getPlayersInRadius(eventPlayer.fireball_position, 4, Team.ALL, LosCheck.OFF) if player == eventPlayer and player.isAlive() == true]) == true:
        #deal friendly fire (33,333%)
        if eventPlayer.talent_ranks[Talent.PYROMANIAC] == 0 and eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false:
            damage(eventPlayer, eventPlayer, 12.5 + eventPlayer.talent_ranks[Talent.FIREBALL] * 4.166)
            eventPlayer.startDoT(eventPlayer, 5, 2.5 + eventPlayer.talent_ranks[Talent.FIREBALL] * 0.833)
            #Heal the caster if it has [30] Pyromaniac talent
        else:
            async(pyromaniac_heal_over_time, AsyncBehavior.NOOP)
            playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA, Color.TEAM_1, eventPlayer.getPosition(), 1)
            playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_WHIP_SHOT_HEAL_AREA_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
            playEffect(getAllPlayers(), DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
            createEffect(eventPlayer, Effect.HEAL_TARGET_ACTIVE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
            eventPlayer.player_temp_effects[29] = getLastCreatedEntity()
    playEffect(getAllPlayers(), DynamicEffect.ASHE_DYNAMITE_EXPLOSION, Color.TEAM_2, eventPlayer.fireball_position, 2)
    playEffect(getAllPlayers(), DynamicEffect.ASHE_DYNAMITE_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.fireball_position, 100)
    destroyEffect(eventPlayer.fireball_effects[0])
    destroyEffect(eventPlayer.fireball_effects[1])
    destroyEffect(eventPlayer.fireball_effects[2])
    destroyEffect(eventPlayer.fireball_effects[3])
    eventPlayer.fireball_in_air = false


rule "TALENT SYSTEM - - - [TALENT 21: FIREBALL] Hit By Fireball":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.FIREBALL] != null
    
    eventPlayer.applyImpulse(directionTowards(eventPlayer.hit_by_talent[Talent.FIREBALL].fireball_position, eventPlayer.getEyePosition()), 15, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.hit_by_talent[Talent.FIREBALL] = null


def buy_ignore_pain():
    @Name "TALENT SYSTEM - - - [TALENT 22: IGNORE PAIN] [SUBROUTINE] Buy Ignore Pain"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.ignore_pain_damage_resisted = 0
        eventPlayer.talents_you_do_not_have[Talent.ENGINEER] = talent_names[Talent.ENGINEER]
        eventPlayer.talents_you_do_not_have[Talent.IGNORE_PAIN] = talent_names[Talent.IGNORE_PAIN]
        destroyEffect(eventPlayer.player_temp_effects[55])
        destroyEffect(eventPlayer.player_temp_effects[56])
        return
    if eventPlayer.talent_ranks[Talent.IGNORE_PAIN] == 1:
        #Lock talent Engineer
        eventPlayer.possible_talents[Talent.ENGINEER] = null
        eventPlayer.talents_you_do_not_have[Talent.ENGINEER] = null
        eventPlayer.talents_you_do_not_have[Talent.IGNORE_PAIN] = null
        eventPlayer.ignore_pain_damage_resisted = 0
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.IGNORE_PAIN] == true else null, Effect.WRECKING_BALL_ADAPTIVE_SHIELD_TARGET, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[55] = getLastCreatedEntity()
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.IGNORE_PAIN] == true else null, Effect.WRECKING_BALL_ADAPTIVE_SHIELD_TARGET_SOUND, Color.TEAM_1, eventPlayer.getPosition(), eventPlayer.ignore_pain_volume, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[56] = getLastCreatedEntity()


rule "TALENT SYSTEM - - - [TALENT 22: IGNORE PAIN] Ignore Pain Activated":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.IGNORE_PAIN] > 0
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false
    @Condition (eventPlayer.hasStatusEffect(Status.STUNNED) == true or eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true or eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == true or eventPlayer.isReloading() == true or eventPlayer.isUsingAbility1() == true) == true
    
    eventPlayer.is_using_ability[Talent.IGNORE_PAIN] = true
    async(ignore_pain_volume, AsyncBehavior.RESTART)
    eventPlayer.ignore_pain_damage_resistance = eventPlayer.talent_ranks[Talent.IGNORE_PAIN] * 6.666 + 33.333
    eventPlayer.setDamageReceived(66.666 - eventPlayer.talent_ranks[Talent.IGNORE_PAIN] * 6.666)
    waitUntil(eventPlayer.hasStatusEffect(Status.STUNNED) == false and eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false and eventPlayer.isReloading() == false and eventPlayer.isUsingAbility1() == false and eventPlayer.is_using_ability[Talent.PURITY_FIELD] == false and eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false or eventPlayer.isDead() == true, 99999)
    eventPlayer.ignore_pain_volume = 25
    eventPlayer.setDamageReceived(100)
    eventPlayer.is_using_ability[Talent.IGNORE_PAIN] = false


rule "TALENT SYSTEM - - - [TALENT 22: IGNORE PAIN] Start Timer When Entering Combat":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.IGNORE_PAIN] > 0
    @Condition eventPlayer.in_combat > 0
    
    chase(eventPlayer.total_time_in_combat, 9999, rate=1, ChaseReeval.DESTINATION_AND_RATE)


rule "TALENT SYSTEM - - - [TALENT 22: IGNORE PAIN] How Much Damage Was Resisted Inside Combat?":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.IGNORE_PAIN] > 0
    @Condition eventPlayer.in_combat == 0
    
    stopChasingVariable(eventPlayer.total_time_in_combat)
    if eventPlayer.ignore_pain_damage_resisted[0] > 0:
        eventPlayer.ignore_pain_damage_resisted[1] = eventPlayer.ignore_pain_damage_resisted[0] * (0.333 + eventPlayer.talent_ranks[Talent.IGNORE_PAIN] * 0.333)
        ignore_pain_hps()
        smallMessage(eventPlayer, "{0} Total Damage Resisted: {1}".format(abilityIconString(Hero.ZARYA, Button.ABILITY_1), round(eventPlayer.ignore_pain_damage_resisted[1])))
        eventPlayer.ignore_pain_damage_resisted[0] = 0
    #Got Lifesteal?
    #return
    #Add healing done by Lifesteal to the index number that matches the rank of Lifesteal
    #return
    #Add time in combat to the index number that matches the rank of Lifesteal
    #return
    #Got Health Regen?
    #return
    #Add healing done by Health Regen to the index number that matches the rank of Health Regen
    #return
    #Add time in combat to the index number that matches the rank of Health Regen
    #return
    #Got Health Potions?
    #return
    #Add healing done by Health Potions to the index number that matches the rank of Health Potions
    #return
    #Add time in combat to the index number that matches the rank of Health Potions
    #return
    #Got Ignore Pain?
    #return
    #Add total damage resisted by Ignore Pain to the index number that matches the rank of Ignore Pain
    #return
    #Add time in combat to the index number that matches the rank of Ignore Pain
    #return
    eventPlayer.total_time_in_combat = 0


def ignore_pain_volume():
    @Name "TALENT SYSTEM - - - [TALENT 22: IGNORE PAIN] [SUBROUTINE] Ignore Pain Volume"
    
    eventPlayer.ignore_pain_volume = 0
    wait(0.064, Wait.RESTART_WHEN_TRUE)
    eventPlayer.ignore_pain_volume = 75


/*
rule "TALENT SYSTEM - - - [TALENT 23: JAVELIN] Use Javelin [DISABLED: WORK IN PROGRESS]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition eventPlayer.is_using_ability[Talent.JAVELIN] == false
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    waitUntil(eventPlayer.isHoldingButton(Button.MELEE) == false, 99999)
    eventPlayer.is_using_ability[Talent.JAVELIN] = true
    eventPlayer.javelin_middle_position = eventPlayer.getEyePosition() + worldVector(vect(-1 * 1 * 1 * 0.25, 0, 0), eventPlayer, Transform.ROTATION)
    eventPlayer.talent_counter_or_position_etc[23] = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, null, getAllPlayers(), true).getHitPosition()
    createBeam(getAllPlayers(), Beam.GRAPPLE, eventPlayer.javelin_middle_position - evalOnce(directionTowards(eventPlayer.javelin_middle_position, eventPlayer.talent_counter_or_position_etc[23]) * 1), eventPlayer.javelin_middle_position + evalOnce(directionTowards(eventPlayer.javelin_middle_position, eventPlayer.talent_counter_or_position_etc[23]) * 1), Color.YELLOW, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[73] = getLastCreatedEntity()
    createBeam(getAllPlayers(), Beam.BAD, eventPlayer.javelin_middle_position - evalOnce(directionTowards(eventPlayer.javelin_middle_position, eventPlayer.talent_counter_or_position_etc[23]) * 1), eventPlayer.javelin_middle_position + evalOnce(directionTowards(eventPlayer.javelin_middle_position, eventPlayer.talent_counter_or_position_etc[23]) * 1), Color.YELLOW, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[74] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer.javelin_middle_position, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[75] = getLastCreatedEntity()
    chase(eventPlayer.javelin_middle_position, eventPlayer.talent_counter_or_position_etc[23], rate=50, ChaseReeval.DESTINATION_AND_RATE)
    while eventPlayer.javelin_middle_position != eventPlayer.talent_counter_or_position_etc[23] and eventPlayer.is_using_ability[Talent.JAVELIN].hit_by_talent[Talent.JAVELIN] != eventPlayer:
        (((sorted([player for player in getPlayersInRadius(eventPlayer.javelin_middle_position, 3, Team.ALL, LosCheck.OFF) if distance(player.getPosition() + worldVector(vect(0, 1, 0), player, Transform.ROTATION), eventPlayer.javelin_middle_position) < 1 and player != eventPlayer and player.isAlive() == true and player.is_using_ability[Talent.PURITY_FIELD] == false and player.is_using_ability[Talent.SHADOWSTEP] == false and player.browsing_shop == false and player.is_using_ability[Talent.DIVE_BOMB] == false], lambda i: distance(eventPlayer.javelin_middle_position, i.getPosition() + worldVector(vect(0, 1, 0), i, Transform.ROTATION))))[0]).hit_by_talent)[23] = eventPlayer
        wait()
    if eventPlayer.is_using_ability[Talent.JAVELIN].hit_by_talent[Talent.JAVELIN] == eventPlayer:
        return
    else:
        waitUntil(eventPlayer.javelin_middle_position == eventPlayer.talent_counter_or_position_etc[23], 99999)
        eventPlayer.talent_counter_or_position_etc[23] = null
        eventPlayer.is_using_ability[Talent.JAVELIN] = false
*/

/*
rule "TALENT SYSTEM - - - [TALENT 23: JAVELIN] Hit By Javelin [DISABLED: WORK IN PROGRESS]":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.JAVELIN] != null
    
    eventPlayer.hit_by_talent[Talent.JAVELIN].is_using_ability[Talent.JAVELIN] = eventPlayer
    eventPlayer.startFacing(directionTowards(eventPlayer.hit_by_talent[Talent.JAVELIN].talent_counter_or_position_etc[23], eventPlayer.hit_by_talent[Talent.JAVELIN].talent_counter_or_position_etc[23] + directionTowards(eventPlayer.hit_by_talent[Talent.JAVELIN].talent_counter_or_position_etc[23], eventPlayer.hit_by_talent[Talent.JAVELIN].javelin_middle_position) * 200), 1000, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 0.5)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.5)
    eventPlayer.startForcingPosition(eventPlayer.hit_by_talent[Talent.JAVELIN].javelin_middle_position + worldVector(vect(0, -1 * 1 * 1 * 1, 0), eventPlayer, Transform.ROTATION), true)
    if eventPlayer.getAltitude() == 100:
        eventPlayer.teleport(nearestWalkablePosition(eventPlayer.hit_by_talent[Talent.JAVELIN].javelin_middle_position))
        eventPlayer.javelin_middle_position = eventPlayer.getPosition() + worldVector(vect(0, 1, 0), eventPlayer, Transform.ROTATION)
    while eventPlayer.hasStatusEffect(Status.PHASED_OUT) == true:
        if distance(eventPlayer.getPosition() + worldVector(vect(0, 1, 0), eventPlayer, Transform.ROTATION), eventPlayer.hit_by_talent[Talent.JAVELIN].talent_counter_or_position_etc[23]) < 2:
            eventPlayer.stopForcingPosition()
            eventPlayer.clearStatusEffect(Status.PHASED_OUT)
            eventPlayer.stopFacing()
            if eventPlayer.isOnGround() == true:
                eventPlayer.clearStatusEffect(Status.STUNNED)
                wait()
                eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 1.5)
                wait(1.5)
            else:
                eventPlayer.startForcingPosition(eventPlayer.getPosition(), true)
                eventPlayer.clearStatusEffect(Status.STUNNED)
                wait()
                eventPlayer.setStatusEffect(null, Status.STUNNED, 1.5)
                wait(1.5)
                eventPlayer.stopForcingPosition()
        wait()
    eventPlayer.stopForcingPosition()
    eventPlayer.stopFacing()
    eventPlayer.hit_by_talent[Talent.JAVELIN].is_using_ability[Talent.JAVELIN] = false
    eventPlayer.hit_by_talent[Talent.JAVELIN].talent_counter_or_position_etc[23] = null
    eventPlayer.hit_by_talent[Talent.JAVELIN] = null
*/

/*
rule "TALENT SYSTEM - - - [TALENT 23: JAVELIN] Stop Using Javelin [DISABLED: WORK IN PROGRESS]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.is_using_ability[Talent.JAVELIN] == false
    
    stopChasingVariable(eventPlayer.javelin_middle_position)
    destroyEffect(eventPlayer.player_temp_effects[73])
    destroyEffect(eventPlayer.player_temp_effects[74])
    destroyEffect(eventPlayer.player_temp_effects[75])
*/

def buy_soul_siphon():
    @Name "TALENT SYSTEM - - - [TALENT 29: SOUL SIPHON] [SUBROUTINE] Buy Soul Siphon"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.soul_siphon_duration)
        eventPlayer.soul_siphon_duration = 0
        eventPlayer.talents_you_do_not_have[Talent.SOUL_SIPHON] = talent_names[Talent.SOUL_SIPHON]
        return
    if eventPlayer.talent_ranks[Talent.SOUL_SIPHON] == 1:
        eventPlayer.soul_siphon_duration = 0
        chase(eventPlayer.soul_siphon_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.SOUL_SIPHON] = null


rule "TALENT SYSTEM - - - [TALENT 29: SOUL SIPHON] Hit By Soul Siphon":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.SOUL_SIPHON] != null
    
    eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].used_soul_siphon_on = eventPlayer
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], Effect.CLOUD, Color.PURPLE, eventPlayer.getPosition() + vect(0, -1 * 1 * 1 * 0.125, 0), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[20] = getLastCreatedEntity()
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], Effect.CLOUD, Color.VIOLET, eventPlayer.getPosition() + vect(0, -1 * 1 * 1 * 0.125, 0), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[25] = getLastCreatedEntity()
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], Effect.RING, Color.PURPLE, eventPlayer.getPosition() + Vector.DOWN, 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[24] = getLastCreatedEntity()
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], Effect.BAD_AURA, Color.VIOLET, eventPlayer.getPosition() + vect(0, 0.25, 0), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[26] = getLastCreatedEntity()
    createBeam(getAllPlayers() if distance(eventPlayer.getPosition(), eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].getPosition()) <= 2 else null, Beam.BAD, eventPlayer.getPosition() + vect(0, 0.25, 0), eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], Color.PURPLE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[21] = getLastCreatedEntity()
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON] if distance(eventPlayer.getPosition(), eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].getPosition()) <= 2 else null, Effect.ENERGY_SOUND, Color.TEAM_1, eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[22] = getLastCreatedEntity()
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON] if distance(eventPlayer.getPosition(), eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].getPosition()) <= 2 else null, Effect.HEAL_TARGET_ACTIVE, Color.TEAM_1, eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[27] = getLastCreatedEntity()
    createEffect(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON] if distance(eventPlayer.getPosition(), eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].getPosition()) <= 2 else null, Effect.HEAL_TARGET, Color.TEAM_1, eventPlayer.hit_by_talent[Talent.SOUL_SIPHON], 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[28] = getLastCreatedEntity()
    waitUntil(eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].isDead() == true, 5)
    eventPlayer.hit_by_talent[Talent.SOUL_SIPHON].used_soul_siphon_on = null
    eventPlayer.hit_by_talent[Talent.SOUL_SIPHON] = null
    destroyEffect(eventPlayer.player_temp_effects[20])
    destroyEffect(eventPlayer.player_temp_effects[21])
    destroyEffect(eventPlayer.player_temp_effects[22])
    destroyEffect(eventPlayer.player_temp_effects[24])
    destroyEffect(eventPlayer.player_temp_effects[25])
    destroyEffect(eventPlayer.player_temp_effects[26])
    destroyEffect(eventPlayer.player_temp_effects[27])
    destroyEffect(eventPlayer.player_temp_effects[28])


rule "TALENT SYSTEM - - - [TALENT 29: SOUL SIPHON] Used Soul Siphon":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.used_soul_siphon_on != null
    @Condition distance(eventPlayer.getPosition(), eventPlayer.used_soul_siphon_on.getPosition()) <= 2
    @Condition eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL)
    
    eventPlayer.soul_siphon_duration = 5
    eventPlayer.startHoT(eventPlayer, 5, 30 + eventPlayer.talent_ranks[Talent.SOUL_SIPHON] * 10)
    eventPlayer.player_temp_effects[23] = getLastHoT()
    waitUntil(distance(eventPlayer.getPosition(), eventPlayer.used_soul_siphon_on.getPosition()) > 2 or eventPlayer.used_soul_siphon_on == null or eventPlayer.getHealthOfType(Health.NORMAL) >= eventPlayer.getMaxHealthOfType(Health.NORMAL) or eventPlayer.isDead() == true or eventPlayer.soul_siphon_duration == 0, 5)
    stopHoT(eventPlayer.player_temp_effects[23])
    wait()
    if RULE_CONDITION:
        goto RULE_START


def buy_pyromaniac():
    @Name "TALENT SYSTEM - - - [TALENT 30: PYROMANIAC] [SUBROUTINE] Buy Pyromaniac"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        stopChasingVariable(eventPlayer.pyromaniac_heal_duration)
        eventPlayer.pyromaniac_heal_duration = 0
        eventPlayer.talents_you_do_not_have[Talent.PYROMANIAC] = talent_names[Talent.PYROMANIAC]
        return
    if eventPlayer.talent_ranks[Talent.PYROMANIAC] == 1:
        eventPlayer.pyromaniac_heal_duration = 0
        chase(eventPlayer.pyromaniac_heal_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have[Talent.PYROMANIAC] = null


def pyromaniac_heal_over_time():
    @Name "TALENT SYSTEM - - - [TALENT 30: PYROMANIAC] [SUBROUTINE] Pyromaniac Stop Healing Over Time"
    
    eventPlayer.pyromaniac_heal_duration = 5
    heal(eventPlayer, eventPlayer, min(37.5 + eventPlayer.talent_ranks[Talent.PYROMANIAC] * 12.5, eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.getHealthOfType(Health.NORMAL)))
    while eventPlayer.isAlive() == true and eventPlayer.pyromaniac_heal_duration > 0:
        eventPlayer.talent_counter_or_position_etc[30] = eventPlayer.pyromaniac_heal_duration
        eventPlayer.startHoT(eventPlayer, eventPlayer.talent_counter_or_position_etc[30], 7.5 + eventPlayer.talent_ranks[Talent.PYROMANIAC] * 2.5)
        eventPlayer.health_pool_id_or_hot_id[3] = getLastHoT()
        waitUntil(eventPlayer.isDead() == true or eventPlayer.getMaxHealthOfType(Health.NORMAL) == eventPlayer.getHealthOfType(Health.NORMAL), eventPlayer.talent_counter_or_position_etc[30])
        stopHoT(eventPlayer.health_pool_id_or_hot_id[3])
        if eventPlayer.pyromaniac_heal_duration == 0 or eventPlayer.isDead() == true:
            return
        eventPlayer.talent_counter_or_position_etc[30] = eventPlayer.pyromaniac_heal_duration
        waitUntil(eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL), eventPlayer.talent_counter_or_position_etc[30])


/*
def buy_poison_vials():
    @Name "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] [SUBROUTINE] Buy Poison Vials [DISABLED: POISON VIALS NOT WORKING AS INTENDED]"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]] == talent_names[Talent.CRAZY_ALCHEMIST]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.POISON_VIALS], talent_names[Talent.CRAZY_ALCHEMIST]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Crazy Alchemist first!".format(iconString(Icon.RADIOACTIVE)))
            lbl_0:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            return
        stopChasingVariable(eventPlayer.time_since_poison_vial_exploded)
        stopChasingVariable(eventPlayer.health_potion_cooldown)
        eventPlayer.poison_vial_effects = []
        eventPlayer.poison_vial_clouds_spawned = 0
        eventPlayer.time_since_poison_vial_exploded = 0
        eventPlayer.health_potion_cooldown = 0
        eventPlayer.amount_of_potions_or_vials = 0
        eventPlayer.talents_you_do_not_have[Talent.HEALTH_POTIONS] = talent_names[Talent.HEALTH_POTIONS]
        eventPlayer.talents_you_do_not_have[Talent.POISON_VIALS] = talent_names[Talent.POISON_VIALS]
        eventPlayer.talents_you_do_not_have[Talent.CRAZY_ALCHEMIST] = null
        return
    if eventPlayer.talent_ranks[Talent.POISON_VIALS] == 1:
        eventPlayer.talents_you_do_not_have[Talent.HEALTH_POTIONS] = null
        eventPlayer.talents_you_do_not_have[Talent.POISON_VIALS] = null
        eventPlayer.talents_you_do_not_have[Talent.CRAZY_ALCHEMIST] = talent_names[Talent.CRAZY_ALCHEMIST]
        eventPlayer.amount_of_potions_or_vials = 3
        #Lock talent Health Potions
        eventPlayer.possible_talents[Talent.HEALTH_POTIONS] = null
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents[Talent.CRAZY_ALCHEMIST] = "{0} [Crazy Alchemist]".format(iconString(Icon.RADIOACTIVE))
        eventPlayer.poison_vial_effects = []
        eventPlayer.poison_vial_clouds_spawned = 0
        chase(eventPlayer.time_since_poison_vial_exploded, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        chase(eventPlayer.health_potion_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
*/

/*
rule "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] accurateTime [DISABLED: POISON VIALS NOT WORKING AS INTENDED]":
    chase(accurateTime, accurateTime + true, rate=true, ChaseReeval.DESTINATION_AND_RATE)
*/

/*
rule "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] Setup [DISABLED: POISON VIALS NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Hero soldier
    
    #Customizable:
    eventPlayer.exitSpeed = 25
    eventPlayer.gravity = 9.8
    #Customizable (old setup):
    #return
    #////////////////////////////////
    eventPlayer.projData = []
    eventPlayer.cloudData = []
    while true:
        #Customizable (who should be affected? updates when players join):
        eventPlayer.interactablePlayers = getAllPlayers().exclude(eventPlayer)
        #///////////////////////////////
        waitUntil(getAllPlayers() != evalOnce(getAllPlayers()), 99999)
*/

/*
rule "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] projCollision [DISABLED: POISON VIALS NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0
    @Condition any([player[true] + (eventPlayer.exitSpeed * player[2] * (accurateTime + 0.032 - player[0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime + 0.032 - player[0]) ** 2)) != raycast(player[true] + (eventPlayer.exitSpeed * player[2] * (accurateTime - player[0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime - player[0]) ** 2)), player[true] + (eventPlayer.exitSpeed * player[2] * (accurateTime + 0.032 - player[0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime + 0.032 - player[0]) ** 2)), eventPlayer.interactablePlayers, [], true).getHitPosition() for player in eventPlayer.projData]) == true
    
    eventPlayer.indexMemory = ((([i for i in [[player, i + true] for player, i in eventPlayer.projData] if i[0][true] + (eventPlayer.exitSpeed * i[0][2] * (accurateTime + 0.032 - i[0][0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime + 0.032 - i[0][0]) ** 2)) != raycast(i[0][true] + (eventPlayer.exitSpeed * i[0][2] * (accurateTime - i[0][0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime - i[0][0]) ** 2)), i[0][true] + (eventPlayer.exitSpeed * i[0][2] * (accurateTime + 0.032 - i[0][0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime + 0.032 - i[0][0]) ** 2)), eventPlayer.interactablePlayers, [], true).getHitPosition()])[0]).last()) - true
    eventPlayer.projPos = eventPlayer.projData[eventPlayer.indexMemory][true] + (eventPlayer.exitSpeed * eventPlayer.projData[eventPlayer.indexMemory][2] * (accurateTime - eventPlayer.projData[eventPlayer.indexMemory][0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime - eventPlayer.projData[eventPlayer.indexMemory][0]) ** 2))
    eventPlayer.projPosIn0032 = eventPlayer.projData[eventPlayer.indexMemory][true] + (eventPlayer.exitSpeed * eventPlayer.projData[eventPlayer.indexMemory][2] * (accurateTime + 0.032 - eventPlayer.projData[eventPlayer.indexMemory][0])) + (eventPlayer.gravity / 2 * Vector.DOWN * ((accurateTime + 0.032 - eventPlayer.projData[eventPlayer.indexMemory][0]) ** 2))
    #Customizable:
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.LIME_GREEN, eventPlayer.projPos, 3)
    playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION, Color.TEAM_2, eventPlayer.projPos, 1)
    playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION, Color.TEAM_1, eventPlayer.projPos, 1)
    playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.projPos, 100)
    playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Color.TEAM_2, eventPlayer.projPos, 100)
    playEffect(getAllPlayers(), DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION, Color.TEAM_1, eventPlayer.projPos, 1)
    playEffect(getAllPlayers(), DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.projPos, 100)
    damage([player for player in getPlayersInRadius(eventPlayer.projPos, 3, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer and player == eventPlayer.isAlive() and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false], eventPlayer, 28.125 + eventPlayer.talent_ranks[Talent.POISON_VIALS] * 9.375)
    ([player for player in getPlayersInRadius(eventPlayer.projPos, 3, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer and player == eventPlayer.isAlive() and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false]).startDoT(eventPlayer, 5, floor(5.6 + eventPlayer.talent_ranks[Talent.POISON_VIALS] * 1.9))
    (([player for player in getPlayersInRadius(eventPlayer.projPos, 3, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer and player == eventPlayer.isAlive() and player.browsing_shop == false and player.is_using_ability[Talent.PURITY_FIELD] == false]).hit_by_talent)[31] = eventPlayer
    eventPlayer.effectMemory = []
    #////////////////////////////////
    destroyEffect(eventPlayer.projData[eventPlayer.indexMemory].last())
    del eventPlayer.projData[eventPlayer.indexMemory]
    wait()
    if RULE_CONDITION:
        goto RULE_START
*/

/*
rule "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] projTimeout [DISABLED: POISON VIALS NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.talent_ranks[Talent.POISON_VIALS] > 0
    @Condition any([accurateTime - player[0] > 9 for player in eventPlayer.projData]) == true
    
    eventPlayer.indexMemory = ((([i for i in [[player, i + true] for player, i in eventPlayer.projData] if accurateTime - i[0][0] > 9])[0]).last()) - true
    destroyEffect(eventPlayer.projData[eventPlayer.indexMemory].last())
    del eventPlayer.projData[eventPlayer.indexMemory]
    wait()
    if RULE_CONDITION:
        goto RULE_START
*/

/*
rule "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] Hit By Poison Vials [DISABLED: POISON VIALS NOT WORKING AS INTENDED]":
    @Event eachPlayer
    @Condition eventPlayer.hit_by_talent[Talent.POISON_VIALS] != null
    
    eventPlayer.hit_by_talent[Talent.POISON_VIALS] = null
    destroyEffect(eventPlayer.player_temp_effects[40])
    #Is affected by ability
    eventPlayer.is_using_ability[Talent.POISON_VIALS] = true
    createEffect(getAllPlayers(), Effect.WIDOWMAKER_VENOM_MINE_TARGET, Color.WHITE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.player_temp_effects[40] = getLastCreatedEntity()
    playEffect(getAllPlayers(), DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION, Color.TEAM_1, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.WIDOWMAKER_VENOM_MINE_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer, 100)
    wait(5, Wait.RESTART_WHEN_TRUE)
    #Is affected by ability
    eventPlayer.is_using_ability[Talent.POISON_VIALS] = false
    destroyEffect(eventPlayer.player_temp_effects[40])
*/

def buy_crazy_alchemist():
    @Name "TALENT SYSTEM - - - [TALENT 32: CRAZY ALCHEMIST] [SUBROUTINE] Buy Crazy Alchemist"
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.talents_you_do_not_have[Talent.CRAZY_ALCHEMIST] = talent_names[Talent.CRAZY_ALCHEMIST]
        return
    if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] == 1:
        eventPlayer.talents_you_do_not_have[Talent.CRAZY_ALCHEMIST] = null