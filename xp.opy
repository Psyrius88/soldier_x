#!mainFile "soldier_x.opy"
rule "XP SYSTEM - - - Level 0 or 25? Activate XP Boost":
    @Event eachPlayer
    @Hero soldier
    @Condition (eventPlayer.amount_of_talents_purchased == 0 or eventPlayer.amount_of_talents_purchased == 25) == true
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isAlive() == true
    
    eventPlayer.xp_boost_is_active = true
    if eventPlayer.amount_of_talents_purchased == 0:
        if eventPlayer.spawning_for_the_first_time == true:
            if debugging == true:
                buy_debug_talents()
            eventPlayer.totalTimeElapsed = 0
            chase(eventPlayer.totalTimeElapsed, 99999, rate=1, ChaseReeval.DESTINATION_AND_RATE)
            #if eventPlayer.amount_of_talents_purchased < leading_player_talents_purchased and eventPlayer.amount_of_talents_purchased < 5:
            #eventPlayer.xp_boost_is_active = false
            #eventPlayer.amount_of_bonus_talents = leading_player_talents_purchased if leading_player_talents_purchased <= 5 else 5
            #async(late_to_the_party, AsyncBehavior.NOOP)
            #return
            #__end__()
        if eventPlayer.spawning_for_the_first_time == true:
            eventPlayer.spawning_for_the_first_time = false
        return
    waitUntil(eventPlayer.amount_of_talents_purchased < 25, 99999)
    eventPlayer.xp_boost_is_active = false

rule "XP SYSTEM - - - Too Far Behind? Activate XP Boost":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.amount_of_talents_purchased <= sorted(getAllPlayers(), lambda player: player.getScore()).last().amount_of_talents_purchased - 5
    @Condition eventPlayer.amount_of_talents_purchased > 0
    
    eventPlayer.xp_boost_is_active = true


rule "XP SYSTEM - - - XP Boost Activated":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.xp_boost_is_active == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.can_enter_shop == false
    @Condition eventPlayer.experience_current < eventPlayer.experience_max
    
    chase(eventPlayer.experience_current, eventPlayer.experience_max, rate=eventPlayer.experience_max / 60, ChaseReeval.DESTINATION_AND_RATE)


rule "XP SYSTEM - - - Deactivate XP Boost":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.amount_of_talents_purchased > 0
    @Condition eventPlayer.skipped_a_talent == false
    @Condition eventPlayer.amount_of_talents_purchased > sorted(getAllPlayers(), lambda player: player.getScore()).last().amount_of_talents_purchased - 5
    
    eventPlayer.xp_boost_is_active = false
    stopChasingVariable(eventPlayer.experience_current)


rule "XP SYSTEM - - - Level Up":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.experience_current >= eventPlayer.experience_max
    
    eventPlayer.can_enter_shop = true
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    if eventPlayer.amount_of_talents_purchased < 25:
        bigMessage(eventPlayer, "{0} Level Up!".format(abilityIconString(Hero.GENJI, Button.JUMP)))


rule "XP SYSTEM - - - Earned Elimination":
    @Event playerEarnedElimination
    @Hero soldier
    
    if eventPlayer.experience_current < eventPlayer.experience_max:
        eventPlayer.experience_current += victim.experience_max * 0.075 * eventPlayer.stats[5]