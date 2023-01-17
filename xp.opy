rule "XP S﻿YSTEM - - - Level 0 or 25? Activate XP Boost":
    @Event eachPlayer
    @Hero soldier
    @Condition (eventPlayer.amount_of_talents_purchased == 0 or endless_mode == true and eventPlayer.amount_of_talents_purchased == 25) == true
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isAlive() == true
    
    eventPlayer.xp_boost_is_active = true


rule "XP S﻿YSTEM - - - Too Far Behind? Activate XP Boost":
    @Event eachPlayer
    @Hero soldier
    @Condition (endless_mode == false and eventPlayer.amount_of_talents_purchased <= sorted(getAllPlayers(), lambda player: player.getScore()).last().amount_of_talents_purchased - 5) == true
    @Condition eventPlayer.amount_of_talents_purchased > 0
    
    eventPlayer.xp_boost_is_active = true


rule "XP S﻿YSTEM - - - XP Boost Activated":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.xp_boost_is_active == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.can_enter_shop == false
    @Condition eventPlayer.experience_current < eventPlayer.experience_max
    
    chase(eventPlayer.experience_current, eventPlayer.experience_max, rate=eventPlayer.experience_max / 60, ChaseReeval.DESTINATION_AND_RATE)


rule "XP S﻿YSTEM - - - Deactivate XP Boost":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.amount_of_talents_purchased > 0
    @Condition eventPlayer.skipped_a_talent == false
    @Condition (endless_mode == true or endless_mode == false and eventPlayer.amount_of_talents_purchased > sorted(getAllPlayers(), lambda player: player.getScore()).last().amount_of_talents_purchased - 5) == true
    
    eventPlayer.xp_boost_is_active = false
    stopChasingVariable(eventPlayer.experience_current)


rule "XP S﻿YSTEM - - - Level Up":
    @Event eachPlayer
    @Hero soldier
    @Condition match_is_in_showdown == false
    @Condition eventPlayer.experience_current >= eventPlayer.experience_max
    
    eventPlayer.can_enter_shop = true
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    if eventPlayer.amount_of_talents_purchased < 25:
        smallMessage(eventPlayer, "{0} +1 Talent Point!".format(abilityIconString(Hero.GENJI, Button.JUMP)))


rule "XP S﻿YSTEM - - - Earned Elimination":
    @Event playerEarnedElimination
    @Hero soldier
    
    if eventPlayer.experience_current < eventPlayer.experience_max:
        eventPlayer.experience_current += victim.experience_max * 0.075 * eventPlayer.stats[5]
    if match_is_in_showdown == true:
        eventPlayer.addToScore(1)