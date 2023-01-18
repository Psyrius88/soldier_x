rule "DEBUG - - - Hold Reload For XP [DEFAULT: OFF]":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer.can_enter_shop == false
    
    if eventPlayer.experience_current < eventPlayer.experience_max:
        eventPlayer.experience_current += 400
    if eventPlayer.isHoldingButton(Button.INTERACT):
        damage(eventPlayer, eventPlayer, 100)
    wait(0.125)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "DEBUG - - - Abilities [DEFAULT: OFF]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.hasSpawned() == true
    
    #Burning Soul (has no buy subroutine)
    #return
    #Purity Field
    #return
    #Engineer
    #return
    #Stealth
    #return
    #Cryogenics
    #return
    #Juggernaut
    #return
    #Railgun
    #return
    #Shadowstep
    #return
    #Dive Bomb
    #return
    #Jetpack
    #return
    #Predator
    eventPlayer.talent_ranks[10] = 1
    buy_predator()
    eventPlayer.talent_ranks[10] = 5
    #Health Potions
    #return
    #Poison Vials
    #return
    #Soul Siphon
    eventPlayer.talent_ranks[29] = 1
    buy_soul_siphon()
    eventPlayer.talent_ranks[29] = 5
    #Overclock
    #return
    #Ignore Pain
    #return
    #Lifesteal
    #return
    #Health Regen
    #return
    #Fireball
    #return
    #Berserker
    #return
    #Bloodthirst
    #return
    #Shadowstrike
    #return
    #Ignite
    #return
    #Pyromaniac
    #return
    #Cybernetics
    #return
*/

/*
rule "DEBUG - - - Host HUD Texts [DEFAULT: OFF]":
    hudText(hostPlayer, "Lifesteal Ammo:", "In Combat Avg: {0} {1}".format("[Rank 1: {0}] [Rank 2: {1}] [Rank 3: {2}]".format(lifesteal_total_healing[1] / lifesteal_time_in_combat[1], lifesteal_total_healing[2] / lifesteal_time_in_combat[2], lifesteal_total_healing[3] / lifesteal_time_in_combat[3]), "[Rank 4: {0}] [Rank 5: {1}]".format(lifesteal_total_healing[4] / lifesteal_time_in_combat[4], lifesteal_total_healing[5] / lifesteal_time_in_combat[5])), null, HudPosition.LEFT, 100, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(hostPlayer, "Health Regen:", "In Combat Avg: {0} {1}".format("[Rank 1: {0}] [Rank 2: {1}] [Rank 3: {2}]".format(health_regen_total_healing[1] / health_regen_time_in_combat[1], health_regen_total_healing[2] / health_regen_time_in_combat[2], health_regen_total_healing[3] / health_regen_time_in_combat[3]), "[Rank 4: {0}] [Rank 5: {1}]".format(health_regen_total_healing[4] / health_regen_time_in_combat[4], health_regen_total_healing[5] / health_regen_time_in_combat[5])), null, HudPosition.LEFT, 101, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(hostPlayer, "Health Potions:", "In Combat Avg: {0} {1}".format("[Rank 1: {0}] [Rank 2: {1}] [Rank 3: {2}]".format(health_potions_total_healing[1] / health_potions_time_in_combat[1], health_potions_total_healing[2] / health_potions_time_in_combat[2], health_potions_total_healing[3] / health_potions_time_in_combat[3]), "[Rank 4: {0}] [Rank 5: {1}]".format(health_potions_total_healing[4] / health_potions_time_in_combat[4], health_potions_total_healing[5] / health_potions_time_in_combat[5])), null, HudPosition.LEFT, 102, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudText(hostPlayer, "Ignore Pain:", "In Combat Avg: {0} {1}".format("[Rank 1: {0}] [Rank 2: {1}] [Rank 3: {2}]".format(ignore_pain_total_resisted[1] / ignore_pain_time_in_combat[1], ignore_pain_total_resisted[2] / ignore_pain_time_in_combat[2], ignore_pain_total_resisted[3] / ignore_pain_time_in_combat[3]), "[Rank 4: {0}] [Rank 5: {1}]".format(ignore_pain_total_resisted[4] / ignore_pain_time_in_combat[4], ignore_pain_total_resisted[5] / ignore_pain_time_in_combat[5])), null, HudPosition.LEFT, 103, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
*/

/*
def lifesteal_hps():
    @Name "DEBUG - - - [Talent: Lifesteal] Healing Done In Combat [DEFAULT: OFF]"
    
    eventPlayer.healing_done_in_combat[12] += eventDamage * (0.112 + eventPlayer.talent_ranks[12] * 0.038)
*/

/*
def health_potion_hps():
    @Name "DEBUG - - - [Talent: Health Potions] Healing Done In Combat [DEFAULT: OFF]"
    
    eventPlayer.healing_done_in_combat[14] += 43.75 + eventPlayer.talent_ranks[14] * 17.5
*/

/*
def ignore_pain_hps():
    @Name "DEBUG - - - [Talent: Ignore Pain] Healing Done In Combat [DEFAULT: OFF]"
    
    eventPlayer.healing_done_in_combat[22] += eventPlayer.ignore_pain_damage_resisted[1]
*/

/*
rule "DEBUG - - - Activate Slow Motion With Melee & Cancel Slow Motion With Interact [DEFAULT: OFF]":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    
    setSlowMotion(15)
    waitUntil(eventPlayer.isHoldingButton(Button.INTERACT) == false and eventPlayer.isHoldingButton(Button.MELEE) == false, 99999)
    waitUntil(eventPlayer.isHoldingButton(Button.INTERACT) == true and eventPlayer.isHoldingButton(Button.MELEE) == true, 99999)
    setSlowMotion(100)
*/

/*
rule "DEBUG - - - Create Dummy Bot With Crouch + Primary Fire [DEFAULT: OFF]":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    
    createDummy(Hero.REAPER, Team.ALL, -1 * 1 * 1 * 1, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, true).getHitPosition(), vect(0, 0, 0))
*/

/*
rule "DEBUG - - - Restart Match With Primary Fire + Secondary Fire + Jump + Crouch [DEFAULT: OFF]":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    
    restartMatch()
*/

/*
rule "DEBUG - - - [Talent: Juggernaut] Debug [DEFAULT: OFF]":
    @Event eachPlayer
    @Hero soldier
    
    createEffect(eventPlayer, Effect.SPHERE, Color.GRAY, eventPlayer.getPosition() + worldVector(vect(0, 1, 3), eventPlayer, Transform.ROTATION), 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer, Effect.SPHERE, Color.GRAY, eventPlayer.getPosition() + worldVector(vect(0, 1, 1), eventPlayer, Transform.ROTATION), 2.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer, Effect.SPHERE, Color.RED, eventPlayer.getPosition() + worldVector(vect(0, 1, 1), eventPlayer, Transform.ROTATION), 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

/*
rule "DEBUG - - - Activate Third Person Camera With Secondary Fire [DEFAULT: OFF]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.startCamera(eventPlayer.getEyePosition() + worldVector(vect(0, 1, 4), eventPlayer, Transform.ROTATION), eventPlayer.getEyePosition(), 12)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false, 99999)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 99999)
    eventPlayer.startCamera(eventPlayer.getEyePosition() + worldVector(vect(4, 2, -1 * 1 * 1 * 3), eventPlayer, Transform.ROTATION), eventPlayer.getEyePosition(), 12)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false, 99999)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 99999)
    eventPlayer.startCamera(eventPlayer.getEyePosition() + worldVector(vect(0, 1, -1 * 1 * 1 * 4), eventPlayer, Transform.ROTATION), eventPlayer.getEyePosition(), 12)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false, 99999)
    waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 99999)
    eventPlayer.stopCamera()
*/

/*
def new_reaper_pathfinding():
    @Name "DEBUG - - - [SUBROUTINE] Bot Pathfinding Test [DEFAULT: OFF]"
    
    while eventPlayer.reaper_aggro_list == []:
        eventPlayer.stopFacing()
        eventPlayer.startFacing(angleToDirection(random.randint(-1 * 1 * 1 * 180, 180), random.randint(-1 * 1 * 1 * 45, 45)), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        wait(3)
        if nearestWalkablePosition(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 25, null, getAllPlayers(), true).getHitPosition()) == raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 25, null, getAllPlayers(), true).getHitPosition():
            eventPlayer.reaper_brain_information[5] = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 25, null, getAllPlayers(), true).getHitPosition()
            eventPlayer.startThrottleInDirection(eventPlayer.reaper_brain_information[5], 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
            waitUntil(distance(eventPlayer.getPosition(), eventPlayer.reaper_brain_information[5]) < 2 or eventPlayer.reaper_aggro_list != [] or eventPlayer.isDead() == true, 99999)
            if eventPlayer.reaper_aggro_list != [] or eventPlayer.isDead() == true:
                return
*/

/*
rule "DEBUG - - - Activate Inspector Recording When Server Load Average Is Above 110 [DEFAULT: OFF]":
    @Condition getAverageServerLoad() > 110
    
    enableInspector()
    waitUntil(getAverageServerLoad() < 110, 99999)
    disableInspector()
*/

/*
rule "DEBUG - - - Reset [Talent: Juggernaut] Cooldown With Reload [DEFAULT: OFF]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    eventPlayer.juggernaut_cooldown = 0
*/

