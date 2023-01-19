#Global variables

globalvar shop_location
globalvar leave_shop_messages = ["Latest patch notes at: workshop.codes/ZEKK3", "Got any feedback? Join the Discord!", "Got an idea for a new talent? Join the Discord!", "Want to show your support? Click the {0} at: workshop.codes/ZEKK3".format(iconString(Icon.HEART)), "Found a bug? Join the Discord!", "Want to help the community grow? Join the Discord!"]
globalvar shop_talent_left_location
globalvar shop_talent_middle_location
globalvar shop_talent_right_location
globalvar max_experience_per_level = [250, 275, 303, 333, 366, 403, 443, 487, 536, 589, 648, 713, 785, 863, 949, 1044, 1149, 1264, 1390, 1529, 1682, 1850, 2035, 2239, 2462, 2709]

#Player variables

playervar hearthstone_effects_id
playervar using_hearthstone_timer
playervar selected_talent_location
playervar is_respawning
playervar current_talent_replace_or_buy
playervar selected_talent_will_replace

#Subroutine names

subroutine open_shop
subroutine leave_shop_messages
subroutine buy_or_upgrade_talent
subroutine buy_bloodthirst
subroutine buy_purity_field
subroutine buy_cybernetics
subroutine buy_engineer
subroutine buy_shadowstrike
subroutine buy_stealth
subroutine buy_juggernaut
subroutine buy_dive_bomb
subroutine buy_cryogenics
subroutine buy_railgun
subroutine buy_predator
subroutine buy_jetpack
subroutine buy_lifesteal_ammo
subroutine buy_health_regen
subroutine buy_health_potions
subroutine buy_ignite
subroutine buy_overclock
subroutine buy_shadowstep
subroutine buy_fire_aura
subroutine buy_berserker
subroutine buy_fireball
subroutine buy_ignore_pain
subroutine buy_monkey_business
subroutine buy_gluttony
subroutine buy_weird_flex
subroutine buy_for_glory
subroutine buy_mace_to_the_face
subroutine buy_pinball
subroutine buy_soul_siphon
subroutine buy_pyromaniac
subroutine buy_poison_vials
subroutine buy_crazy_alchemist

#Activated extensions

#!extension buffAndDebuffSounds
#!extension energyExplosionEffects
#!extension explosionSounds

rule "SHOP - - - Using Hearthstone":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.can_enter_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition match_is_in_showdown == false
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.in_combat == 0
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    
    wait(0.125, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_hearthstone[0] = true
    using_one_of_the_hearthstones()


rule "SHOP - - - Canceled Hearthstone":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.is_using_hearthstone[0] == true
    @Condition (eventPlayer.in_combat > 0 or eventPlayer.isHoldingButton(Button.RELOAD) == false or eventPlayer.isDead() == true) == true
    
    stopped_using_hearthstone()


rule "SHOP - - - Skip Talents & Exit Shop":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.replace_replacing_or_cancelled[1] == false
    @Condition eventPlayer.replace_replacing_or_cancelled[0] == false
    @Condition eventPlayer.canVote_hasVoted_canStartVote[1] == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition (eventPlayer.browsing_shop == true and eventPlayer.replace_replacing_or_cancelled[1] == false and eventPlayer.replace_replacing_or_cancelled[0] == false and eventPlayer.canVote_hasVoted_canStartVote[1] == true or eventPlayer.browsing_shop == false and eventPlayer.canVote_hasVoted_canStartVote[1] == false and match_is_in_showdown == true) == true
    
    wait(0.75, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_hearthstone[2] = true
    using_one_of_the_hearthstones()


rule "SHOP - - - Canceled Skip Talent & Exit Shop or Skip Showdown":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.is_using_hearthstone[2] == true
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == false
    
    stopped_using_hearthstone()


def using_one_of_the_hearthstones():
    @Name "SHOP - - - [SUBROUTINE] Using One of the Hearthstones"
    
    if eventPlayer.is_using_hearthstone[0] == true:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2] * 0.25)
        createEffect(getAllPlayers(), Effect.GOOD_AURA_SOUND, Color.WHITE, eventPlayer.getPosition() + Vector.UP, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[0] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, Effect.GOOD_AURA, Color.GREEN, updateEveryTick(eventPlayer.getPosition() + Vector.UP), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[1] = getLastCreatedEntity()
    elif eventPlayer.is_using_hearthstone[1] == true:
        if eventPlayer.time_since_joined_match < 900:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} You can not start a vote yet! You can do it in {1} second(s).".format(iconString(Icon.STOP), ceil(900 - eventPlayer.time_since_joined_match)))
            async(stopped_using_hearthstone, AsyncBehavior.RESTART)
            wait(5)
            return
    elif eventPlayer.is_using_hearthstone[2] == true:
        if match_is_in_showdown == true and eventPlayer.canVote_hasVoted_canStartVote[1] == true:
            smallMessage(eventPlayer, "{0} You have already voted yes to skip the Showdown!".format(iconString(Icon.CHECKMARK)))
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            async(stopped_using_hearthstone, AsyncBehavior.RESTART)
            wait(5)
            return
    if eventPlayer.is_using_hearthstone[1] == true or eventPlayer.is_using_hearthstone[2] == true or eventPlayer.is_using_hearthstone[3] == true or eventPlayer.is_using_hearthstone[4] == true:
        createEffect(eventPlayer, Effect.SOMBRA_HACKING_SOUND, Color.WHITE, shop_location if eventPlayer.browsing_shop == true else eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[0] = getLastCreatedEntity()
    chase(eventPlayer.using_hearthstone_timer, 2.75, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    if eventPlayer.is_using_hearthstone[3] == true or eventPlayer.is_using_hearthstone[4] == true:
        goto lbl_0
    wait(2.75, Wait.ABORT_WHEN_FALSE)
    lbl_0:
    eventPlayer.using_one_of_the_hearthstones = true
    if eventPlayer.is_using_hearthstone[0] == true:
        playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_1, eventPlayer.getPosition() + Vector.UP, 1)
        playEffect(getAllPlayers(), DynamicEffect.TRACER_RECALL_DISAPPEAR_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
        if eventPlayer.is_using_ability[Talent.STEALTH] == true:
            break_stealth()
        eventPlayer.setInvisibility(Invis.ALL)
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
        eventPlayer.is_using_hearthstone[0] = false
        async(open_shop, AsyncBehavior.NOOP)
        eventPlayer.browsing_shop = true
    elif eventPlayer.is_using_hearthstone[1] == true:
        player_who_started_vote = eventPlayer
        wait()
        eventPlayer.time_since_joined_match = 720
        eventPlayer.canVote_hasVoted_canStartVote[2] = false
        eventPlayer.canVote_hasVoted_canStartVote[1] = true
        players_that_voted_yes = players_that_voted_yes.concat(eventPlayer)
        someone_is_voting_to_change_map = true
        smallMessage(eventPlayer, "{0} The vote will start when you exit the shop!".format(iconString(Icon.CHECKMARK)))
        eventPlayer.is_using_hearthstone[1] = false
    elif eventPlayer.is_using_hearthstone[2] == true:
        eventPlayer.is_using_hearthstone[2] = false
        if match_is_in_showdown == true:
            smallMessage(eventPlayer, "{0} You voted yes to skip the Showdown!".format(iconString(Icon.CHECKMARK)))
            playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
            eventPlayer.canVote_hasVoted_canStartVote[1] = true
            players_that_voted_yes = players_that_voted_yes.concat(eventPlayer)
            async(stopped_using_hearthstone, AsyncBehavior.RESTART)
            return
        goto lbl_1
    elif eventPlayer.is_using_hearthstone[3] == true:
        waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 2.75)
        if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true:
            goto lbl_2
        if eventPlayer.replace_replacing_or_cancelled[0] == true:
            eventPlayer.replace_replacing_or_cancelled[1] = true
            goto lbl_3
        smallMessage(eventPlayer, "{0} Voted Yes!".format(iconString(Icon.CHECKMARK)))
        eventPlayer.canVote_hasVoted_canStartVote[1] = true
        players_that_voted_yes = players_that_voted_yes.concat(eventPlayer)
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
        lbl_2:
        lbl_3:
        async(stopped_using_hearthstone, AsyncBehavior.RESTART)
        return
    elif eventPlayer.is_using_hearthstone[4] == true:
        waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true, 2.75)
        if eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true:
            goto lbl_4
        if eventPlayer.replace_replacing_or_cancelled[0] == true:
            eventPlayer.replace_replacing_or_cancelled[2] = true
            goto lbl_5
        smallMessage(eventPlayer, "{0} Voted No!".format(iconString(Icon.NO)))
        eventPlayer.canVote_hasVoted_canStartVote[1] = true
        players_that_voted_no = players_that_voted_no.concat(eventPlayer)
        playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, shop_location, 100)
        lbl_4:
        lbl_5:
        async(stopped_using_hearthstone, AsyncBehavior.RESTART)
        return
    async(stopped_using_hearthstone, AsyncBehavior.RESTART)
    if player_who_started_vote == eventPlayer and eventPlayer.time_since_joined_match < 725:
        waitUntil(eventPlayer.browsing_shop == false, 30)
        if eventPlayer.browsing_shop == false:
            return
        if eventPlayer.browsing_shop == true:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} You have 30 seconds to leave the shop, or you will respawn automatically!".format(iconString(Icon.WARNING)))
        waitUntil(eventPlayer.browsing_shop == false, 10)
        if eventPlayer.browsing_shop == false:
            return
        if eventPlayer.browsing_shop == true:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} You have 20 seconds to leave the shop, or you will respawn automatically!".format(iconString(Icon.WARNING)))
        waitUntil(eventPlayer.browsing_shop == false, 10)
        if eventPlayer.browsing_shop == false:
            return
        if eventPlayer.browsing_shop == true:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} You have 10 seconds to leave the shop, or you will respawn automatically!".format(iconString(Icon.WARNING)))
        waitUntil(eventPlayer.browsing_shop == false, 7)
        if eventPlayer.browsing_shop == false:
            return
        if eventPlayer.browsing_shop == true:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} 3".format(iconString(Icon.WARNING)))
        waitUntil(eventPlayer.browsing_shop == false, 1)
        if eventPlayer.browsing_shop == false:
            return
        if eventPlayer.browsing_shop == true:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} 2".format(iconString(Icon.WARNING)))
        waitUntil(eventPlayer.browsing_shop == false, 1)
        if eventPlayer.browsing_shop == false:
            return
        if eventPlayer.browsing_shop == true:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
            smallMessage(eventPlayer, "{0} 1".format(iconString(Icon.WARNING)))
        waitUntil(eventPlayer.browsing_shop == false, 1)
        if eventPlayer.browsing_shop == false:
            return
        #Act as skipped a talent because the player didn't exit in time
        lbl_1:
        eventPlayer.browsing_shop = false
        eventPlayer.selected_talent_location = shop_talent_middle_location
        eventPlayer.can_enter_shop = false
        eventPlayer.experience_current = 0
        if eventPlayer.talent_ranks[Talent.FIREBALL] > 0 or eventPlayer.talent_ranks[Talent.JUGGERNAUT] > 0:
            async(spawned_with_fireball, AsyncBehavior.RESTART)
        eventPlayer.is_respawning = true
        eventPlayer.respawn()
        #Reset selection of a talent to the middle
        eventPlayer.selected_talent[0] = 1
        eventPlayer.skipped_a_talent = true
        eventPlayer.xp_boost_is_active = true
        if random.randint(1, 100) <= 10 and eventPlayer.amount_of_talents_purchased > 4:
            async(leave_shop_messages, AsyncBehavior.NOOP)
        async(stopped_using_hearthstone, AsyncBehavior.RESTART)


def stopped_using_hearthstone():
    @Name "SHOP - - - [SUBROUTINE] Stopped Using Hearthstone"
    
    eventPlayer.using_one_of_the_hearthstones = false
    eventPlayer.is_using_hearthstone[0] = false
    eventPlayer.is_using_hearthstone[1] = false
    eventPlayer.is_using_hearthstone[2] = false
    eventPlayer.is_using_hearthstone[3] = false
    eventPlayer.is_using_hearthstone[4] = false
    stopChasingVariable(eventPlayer.using_hearthstone_timer)
    eventPlayer.using_hearthstone_timer = 0
    if eventPlayer.is_using_ability[Talent.CRYOGENICS] == false:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    destroyEffect(eventPlayer.hearthstone_effects_id[0])
    destroyEffect(eventPlayer.hearthstone_effects_id[1])


def replace_talent():
    @Name "SHOP - - - [SUBROUTINE] Replace Talent"
    
    eventPlayer.replace_replacing_or_cancelled[0] = true
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
    waitUntil(eventPlayer.replace_replacing_or_cancelled[1] == true or eventPlayer.replace_replacing_or_cancelled[2] == true, 99999)


def leave_shop_messages():
    @Name "SHOP - - - [SUBROUTINE] Exit Shop Messages"
    
    eventPlayer.random_integer_between_0_to_5 = random.randint(0, 5)
    createInWorldText(eventPlayer, "{0}".format(leave_shop_messages[eventPlayer.random_integer_between_0_to_5]), updateEveryTick(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((0 - 1) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.75, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.ORANGE, SpecVisibility.DEFAULT)
    eventPlayer.player_temp_effects[43] = getLastCreatedText()
    wait(5)
    destroyInWorldText(eventPlayer.player_temp_effects[43])


rule "SHOP - - - Shop Left":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.replace_replacing_or_cancelled[0] == false
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == false
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.selected_talent[1] == 0:
            eventPlayer.selected_talent[1] = 4
        else:
            eventPlayer.selected_talent[1] -= 1
        return
    if eventPlayer.selected_talent[0] >= 1:
        if eventPlayer.selected_talent[0] == 2:
            eventPlayer.selected_talent_location = shop_talent_middle_location
            eventPlayer.selected_talent[0] = 1
            eventPlayer.startCamera(shop_location, shop_talent_middle_location, 15)
        elif eventPlayer.selected_talent[0] == 1:
            eventPlayer.selected_talent_location = shop_talent_left_location
            eventPlayer.selected_talent[0] = 0
            eventPlayer.startCamera(shop_location, shop_talent_left_location, 15)


rule "SHOP - - - Shop Right":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.replace_replacing_or_cancelled[0] == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == false
    
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        if eventPlayer.selected_talent[1] == 4:
            eventPlayer.selected_talent[1] = 0
        else:
            eventPlayer.selected_talent[1] += 1
        return
    if eventPlayer.selected_talent[0] <= 1:
        if eventPlayer.selected_talent[0] == 1:
            eventPlayer.selected_talent_location = shop_talent_right_location
            eventPlayer.selected_talent[0] = 2
            eventPlayer.startCamera(shop_location, shop_talent_right_location, 15)
        elif eventPlayer.selected_talent[0] == 0:
            eventPlayer.selected_talent_location = shop_talent_middle_location
            eventPlayer.selected_talent[0] = 1
            eventPlayer.startCamera(shop_location, shop_talent_middle_location, 15)


rule "SHOP - - - Buy Talent":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.canVote_hasVoted_canStartVote[1] == true
    @Condition eventPlayer.replace_replacing_or_cancelled[0] == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    
    if eventPlayer.selected_talent[0] == 0:
        eventPlayer.startCamera(shop_talent_left_location, shop_talent_left_location, 4.125)
    elif eventPlayer.selected_talent[0] == 1:
        eventPlayer.startCamera(shop_talent_middle_location, shop_talent_middle_location, 4.125)
    elif eventPlayer.selected_talent[0] == 2:
        eventPlayer.startCamera(shop_talent_right_location, shop_talent_right_location, 4.125)
    wait(0.85, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.replace_replacing_or_cancelled[1] == true:
        eventPlayer.current_talent_replace_or_buy = eventPlayer.bought_talents[eventPlayer.selected_talent[1]]
        buy_or_upgrade_talent()
        if eventPlayer.replace_replacing_or_cancelled[2] == true:
            eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.TEAM_1, shop_location.getPosition(), 100)
            eventPlayer.replace_replacing_or_cancelled[0] = false
            eventPlayer.replace_replacing_or_cancelled[1] = false
            eventPlayer.replace_replacing_or_cancelled[2] = false
            return
        #Reduce the score by how many times the talent you removed was upgraded
        #return
        #Reduce the amount_of_talents_purchased by how many time the talent you removed was upgraded
        eventPlayer.amount_of_talents_purchased -= eventPlayer.talent_ranks[talent_names.index(eventPlayer.current_talent_replace_or_buy)]
        #Remove the talent from talent_ranks
        eventPlayer.talent_ranks[talent_names.index(eventPlayer.current_talent_replace_or_buy)] = 0
        #Remove the talent you removed from bought_talents
        eventPlayer.bought_talents = eventPlayer.bought_talents.exclude(eventPlayer.bought_talents[eventPlayer.selected_talent[1]])
        #Put the new talents in bought_talents
        eventPlayer.bought_talents.append(talent_names[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])])
        goto lbl_0
    if eventPlayer.selected_talent[0] == 0:
        if eventPlayer.selected_talent_will_replace[0] == true:
            goto lbl_1
    elif eventPlayer.selected_talent[0] == 1:
        if eventPlayer.selected_talent_will_replace[1] == true:
            goto lbl_2
    elif eventPlayer.selected_talent[0] == 2:
        if eventPlayer.selected_talent_will_replace[2] == true:
            lbl_1:
            lbl_2:
            replace_talent()
            if eventPlayer.replace_replacing_or_cancelled[2] == true:
                eventPlayer.replace_replacing_or_cancelled[0] = false
                eventPlayer.replace_replacing_or_cancelled[2] = false
                return
            if eventPlayer.replace_replacing_or_cancelled[1] == true:
                eventPlayer.replace_replacing_or_cancelled[0] = false
                return
    #If the player do not have 5 talents yet and the talent is not bought yet, add it to bought_talents
    lbl_0:
    if len(eventPlayer.bought_talents) < 5 and talent_names[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])] in eventPlayer.bought_talents == false:
        eventPlayer.bought_talents.append(talent_names[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])])
    eventPlayer.browsing_shop = false
    eventPlayer.selected_talent_location = shop_talent_middle_location
    eventPlayer.amount_of_talents_purchased += 1
    #Add +1 to "talent_ranks" in the correct index
    eventPlayer.talent_ranks[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])] += 1
    #If the talent being purchased has reached 5...
    if eventPlayer.talent_ranks[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])] == 5:
        #...remove it from possible talents.
        eventPlayer.possible_talents[talent_names.index(eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]])] = null
    eventPlayer.replace_replacing_or_cancelled[1] = false
    eventPlayer.current_talent_replace_or_buy = eventPlayer.offered_talents_in_shop[eventPlayer.selected_talent[0]]
    eventPlayer.possible_talents[talent_names.index(eventPlayer.current_talent_replace_or_buy)] = talent_names[talent_names.index(eventPlayer.current_talent_replace_or_buy)]
    buy_or_upgrade_talent()
    if endless_mode == true and match_is_in_showdown == false:
        eventPlayer.setScore(eventPlayer.amount_of_talents_purchased)
    eventPlayer.can_enter_shop = false
    eventPlayer.experience_current = 0
    eventPlayer.experience_max = max_experience_per_level[eventPlayer.amount_of_talents_purchased]
    if eventPlayer.talent_ranks[Talent.FIREBALL] > 0 or eventPlayer.talent_ranks[Talent.JUGGERNAUT] > 0:
        async(spawned_with_fireball, AsyncBehavior.RESTART)
    eventPlayer.is_respawning = true
    eventPlayer.respawn()
    #Reset selection of a talent to the middle
    eventPlayer.selected_talent[0] = 1
    if random.randint(1, 100) <= 10 and eventPlayer.amount_of_talents_purchased > 4:
        async(leave_shop_messages, AsyncBehavior.NOOP)


rule "SHOP - - - Reset Shop Camera":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition (eventPlayer.is_using_hearthstone[2] == true or eventPlayer.isHoldingButton(Button.INTERACT) == false) == true
    
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)


def cancel_shop_camera():
    @Name "SHOP - - - [SUBROUTINE] Cancel Shop Camera"
    
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)


def open_shop():
    @Name "SHOP - - - [SUBROUTINE] Open Shop"
    
    eventPlayer.possible_talents = []
    if len(eventPlayer.bought_talents) == 5:
        eventPlayer.talent_counter_or_position_etc[15] = 4
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            if eventPlayer.talent_ranks[talent_names.index(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])] < 5:
                eventPlayer.possible_talents[talent_names.index(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])] = eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]
            eventPlayer.talent_counter_or_position_etc[15] -= 1
    else:
        eventPlayer.talent_counter_or_position_etc[15] = len(eventPlayer.bought_talents) - 1
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            if eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]] != null:
                eventPlayer.possible_talents[talent_names.index(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])] = eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]
            eventPlayer.talent_counter_or_position_etc[15] -= 1
        eventPlayer.talent_counter_or_position_etc[15] = len(eventPlayer.talents_you_do_not_have)
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            if eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]] != null:
                eventPlayer.possible_talents[talent_names.index(eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]])] = eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]]
            eventPlayer.talent_counter_or_position_etc[15] -= 1
    eventPlayer.is_using_hearthstone[0] = false
    eventPlayer.skipped_a_talent = false
    eventPlayer.disableHeroHUD()
    eventPlayer.setMoveSpeed(0)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 99999)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.browsing_shop = true
    #Someone has started a vote and you have not voted yet
    if endless_mode == true and someone_is_voting_to_change_map == true and eventPlayer.canVote_hasVoted_canStartVote[0] == true and eventPlayer.canVote_hasVoted_canStartVote[1] == false:
        playEffect(eventPlayer, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, Color.TEAM_1, shop_location.getPosition(), 100)
        eventPlayer.offered_talents_in_shop[1] = talent_names[15]
        waitUntil(eventPlayer.canVote_hasVoted_canStartVote[1] == true, 99999)
    if eventPlayer.experience_current < eventPlayer.experience_max:
        eventPlayer.browsing_shop = false
        eventPlayer.selected_talent_location = shop_talent_middle_location
        eventPlayer.can_enter_shop = false
        if eventPlayer.talent_ranks[Talent.FIREBALL] > 0 or eventPlayer.talent_ranks[Talent.JUGGERNAUT] > 0:
            async(spawned_with_fireball, AsyncBehavior.RESTART)
        eventPlayer.is_respawning = true
        eventPlayer.respawn()
        #Reset selection of a talent to the middle
        eventPlayer.selected_talent[0] = 1
        if random.randint(1, 100) <= 10 and eventPlayer.amount_of_talents_purchased > 4:
            async(leave_shop_messages, AsyncBehavior.NOOP)
        return
    #Will the left talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5 and len([player for player in eventPlayer.possible_talents if player != null]) == 0:
        eventPlayer.selected_talent_will_replace[0] = true
    else:
        eventPlayer.selected_talent_will_replace[0] = false
    #Set the left talent
    #return
    eventPlayer.offered_talents_in_shop[0] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null]) if eventPlayer.selected_talent_will_replace[0] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    #Remove the left talent
    if endless_mode == false and len([player for player in eventPlayer.possible_talents if player != null]) > 2:
        eventPlayer.possible_talents[talent_names.index(eventPlayer.offered_talents_in_shop[0])] = null
    else:
        eventPlayer.possible_talents[talent_names.index(eventPlayer.offered_talents_in_shop[0])] = null
    #Will the middle talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5:
        eventPlayer.selected_talent_will_replace[1] = true
    else:
        eventPlayer.selected_talent_will_replace[1] = false
    #Set the middle talent
    #return
    eventPlayer.offered_talents_in_shop[1] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null and player != eventPlayer.offered_talents_in_shop[0]]) if eventPlayer.selected_talent_will_replace[1] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    #Remove the middle talent
    if endless_mode == false and len([player for player in eventPlayer.possible_talents if player != null]) > 1:
        eventPlayer.possible_talents[talent_names.index(eventPlayer.offered_talents_in_shop[1])] = null
    else:
        eventPlayer.possible_talents[talent_names.index(eventPlayer.offered_talents_in_shop[1])] = null
    #Will the right talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5 and len([player for player in eventPlayer.possible_talents if player != null]) == 0:
        eventPlayer.selected_talent_will_replace[2] = true
    else:
        eventPlayer.selected_talent_will_replace[2] = false
    #Set the right talent
    #return
    eventPlayer.offered_talents_in_shop[2] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null and player != eventPlayer.offered_talents_in_shop[0] and player != eventPlayer.offered_talents_in_shop[1]]) if eventPlayer.selected_talent_will_replace[2] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    eventPlayer.startCamera(shop_location, shop_talent_middle_location, 0.5)
    playEffect(eventPlayer, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, Color.TEAM_1, shop_location.getPosition(), 100)


def buy_or_upgrade_talent():
    @Name "SHOP - - - [SUBROUTINE] Buy Or Upgrade Talent"
    
    if eventPlayer.current_talent_replace_or_buy == talent_names[Talent.BLOODTHIRST]:
        buy_bloodthirst()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.PURITY_FIELD]:
        buy_purity_field()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.CYBERNETICS]:
        buy_cybernetics()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.ENGINEER]:
        buy_engineer()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.SHADOWSTRIKE]:
        buy_shadowstrike()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.STEALTH]:
        buy_stealth()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.JUGGERNAUT]:
        buy_juggernaut()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.DIVE_BOMB]:
        buy_dive_bomb()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.CRYOGENICS]:
        buy_cryogenics()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.RAILGUN]:
        buy_railgun()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.PREDATOR]:
        buy_predator()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.JETPACK]:
        buy_jetpack()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.LIFESTEAL_AMMO]:
        buy_lifesteal_ammo()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.HEALTH_REGEN]:
        buy_health_regen()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.HEALTH_POTIONS]:
        if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] == 1:
            eventPlayer.amount_of_potions_or_vials = 3
        buy_health_potions()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.IGNITE]:
        buy_ignite()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.OVERCLOCK]:
        buy_overclock()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.SHADOWSTEP]:
        buy_shadowstep()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.BURNING_SOUL]:
        buy_fire_aura()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.BERSERKER]:
        buy_berserker()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.FIREBALL]:
        buy_fireball()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.IGNORE_PAIN]:
        buy_ignore_pain()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.JAVELIN]:
        buy_monkey_business()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[24]:
        buy_gluttony()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[25]:
        buy_weird_flex()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[26]:
        buy_for_glory()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[27]:
        buy_mace_to_the_face()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[28]:
        buy_pinball()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.SOUL_SIPHON]:
        buy_soul_siphon()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.PYROMANIAC]:
        buy_pyromaniac()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.POISON_VIALS]:
        if eventPlayer.talent_ranks[Talent.POISON_VIALS] == 1:
            eventPlayer.amount_of_potions_or_vials = 3
        buy_poison_vials()
    elif eventPlayer.current_talent_replace_or_buy == talent_names[Talent.CRAZY_ALCHEMIST]:
        buy_crazy_alchemist()


/*
rule "SHOP - - - XP Code [DISABLED: NOT HAPPY WITH CURRENT IMPLEMENTATION]":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.typing_in_xp_code[0] == false
    @Condition eventPlayer.stats[5] == 0.65
    @Condition eventPlayer.code_cooldown == 0
    
    eventPlayer.typing_in_xp_code[0] = true
    waitUntil(eventPlayer.isHoldingButton(Button.CROUCH) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true or eventPlayer.isHoldingButton(Button.JUMP) == true or eventPlayer.browsing_shop == false, 99999)
    if eventPlayer.browsing_shop == false or eventPlayer.isHoldingButton(Button.CROUCH) == false:
        eventPlayer.typing_in_xp_code = [false]
        eventPlayer.typing_in_xp_code[0] = false
        return
    if eventPlayer.isHoldingButton(Button.CROUCH) == true and eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true:
        eventPlayer.typing_in_xp_code = eventPlayer.typing_in_xp_code.concat(iconString(Icon.ARROW_LEFT))
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
        waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false or eventPlayer.isHoldingButton(Button.CROUCH) == false, 99999)
    elif eventPlayer.isHoldingButton(Button.CROUCH) == true and eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true:
        eventPlayer.typing_in_xp_code = eventPlayer.typing_in_xp_code.concat(iconString(Icon.ARROW_RIGHT))
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
        waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false or eventPlayer.isHoldingButton(Button.CROUCH) == false, 99999)
    elif eventPlayer.isHoldingButton(Button.CROUCH) == true and eventPlayer.isHoldingButton(Button.JUMP) == true:
        eventPlayer.typing_in_xp_code = eventPlayer.typing_in_xp_code.concat(iconString(Icon.CIRCLE))
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
        waitUntil(eventPlayer.isHoldingButton(Button.JUMP) == false or eventPlayer.isHoldingButton(Button.CROUCH) == false, 99999)
    if eventPlayer.isHoldingButton(Button.CROUCH) == false:
        eventPlayer.typing_in_xp_code = [false, null, null, null, null, null, null, null, null]
        eventPlayer.typing_in_xp_code[0] = false
        return
    if len(eventPlayer.typing_in_xp_code) == 5:
        if eventPlayer.typing_in_xp_code == xp_code:
            eventPlayer.stats[5] = 0.715
            bigMessage(getAllPlayers(), "{0} Unlocked 110% XP".format(eventPlayer))
            playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
            return
        else:
            eventPlayer.typing_in_xp_code = [false]
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, shop_location, 100)
            eventPlayer.code_cooldown = 60
            chase(eventPlayer.code_cooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.typing_in_xp_code[0] = false
*/