#!mainFile "soldier_x.opy"
#Global variables

globalvar shop_location
globalvar leave_shop_messages = ["Latest patch notes at: workshop.codes/ZEKK3", "Got any feedback? Join the Discord!", "Got an idea for a new talent? Join the Discord!", "Want to show your support? Click the {0} at: workshop.codes/ZEKK3".format(iconString(Icon.HEART)), "Found a bug? Join the Discord!", "Want to help the community grow? Join the Discord!"]
globalvar shop_talent_positions
globalvar max_experience_per_level = [250, 275, 303, 333, 366, 403, 443, 487, 536, 589, 648, 713, 785, 863, 949, 1044, 1149, 1264, 1390, 1529, 1682, 1850, 2035, 2239, 2462, 2709]

#Player variables

playervar bloodthirst_shield
playervar talent_trigger_times
playervar health_pool_id_or_hot_id
playervar engineer_scrap
playervar entering_stealth
playervar railgun_discharge
playervar railgun_charge
playervar railgun_projectile_start
playervar railgun_projectile_player_hit
playervar jetpack_fuel
playervar is_lifestealing
playervar ignite_position
playervar burning_soul_orb_timer
playervar fireball_position
playervar ignore_pain_damage_resisted
playervar ignore_pain_volume
playervar soul_siphon_duration
playervar pyromaniac_heal_duration
playervar current_talent_replace_or_buy
playervar hearthstone_effects_id
playervar is_respawning = false
playervar selected_talent_location = shop_talent_positions[1]
playervar selected_talent_will_replace
playervar using_hearthstone_timer = 0

#Subroutine names

subroutine health_regen_heal_over_time
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
subroutine buy_burning_soul
subroutine buy_berserker
subroutine buy_fireball
subroutine buy_ignore_pain
subroutine buy_soul_siphon
subroutine buy_pyromaniac
subroutine buy_poison_vials
subroutine buy_crazy_alchemist
subroutine buy_bombardment
subroutine buy_gigachad
subroutine buy_gunslinger
subroutine buy_sprinter

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
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.in_combat == 0
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer.is_using_ability[Talent.JUGGERNAUT] == false
    @Condition eventPlayer.is_using_ability[Talent.DIVE_BOMB] == false
    @Condition eventPlayer.railgun_charge == 0

    
    wait(0.125, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_hearthstone = true
    using_one_of_the_hearthstones()


rule "SHOP - - - Canceled Hearthstone":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.is_using_hearthstone == true
    @Condition (eventPlayer.in_combat > 0 or eventPlayer.isHoldingButton(Button.RELOAD) == false or eventPlayer.isDead() == true) == true
    
    stopped_using_hearthstone()

rule "SHOP - - - Skip Talents & Exit Shop":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.replacing_talent_show_bought_talents == false
    @Condition eventPlayer.replacing_talent_show_confirmation == false
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition (eventPlayer.browsing_shop == true and eventPlayer.replacing_talent_show_bought_talents == false and eventPlayer.replacing_talent_show_confirmation == false) == true
    
    wait(0.75 if debugging == false else 0.425, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_skip_talent = true
    using_one_of_the_hearthstones()

rule "SHOP - - - Canceled Skip Talent & Exit Shop":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.is_using_skip_talent == true
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == false
    
    stopped_using_hearthstone()

rule "SHOP - - - Using Yes":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.replacing_talent_show_confirmation == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false

    wait(0.125, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_vote_yes = true
    using_one_of_the_hearthstones()

rule "SHOP - - - Using No":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.replacing_talent_show_confirmation == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true

    wait(0.125, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_vote_no = true
    using_one_of_the_hearthstones()

rule "SHOP - - - Canceled Using Yes / No":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition (eventPlayer.is_using_vote_yes or eventPlayer.is_using_vote_no)
    @Condition eventPlayer.replacing_talent_show_confirmation == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false

    stopped_using_hearthstone()

def using_one_of_the_hearthstones():
    @Name "SHOP - - - [SUBROUTINE] Using One of the Hearthstones"
    
    if eventPlayer.is_using_hearthstone == true:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2] * 0.25)
        createEffect(getAllPlayers(), Effect.GOOD_AURA_SOUND, Color.WHITE, updateEveryTick(eventPlayer.getPosition() + Vector.UP), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[0] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, Effect.GOOD_AURA, Color.GREEN, updateEveryTick(eventPlayer.getPosition() + Vector.UP), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[1] = getLastCreatedEntity()
    elif eventPlayer.is_using_skip_talent or eventPlayer.is_using_vote_yes or eventPlayer.is_using_vote_no:
        createEffect(eventPlayer, Effect.SOMBRA_HACKING_SOUND, Color.WHITE, shop_location if eventPlayer.browsing_shop == true else eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[0] = getLastCreatedEntity()
    chase(eventPlayer.using_hearthstone_timer, 2.75 if debugging == false else 0.5, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    if eventPlayer.is_using_vote_yes or eventPlayer.is_using_vote_no:
        goto lbl_0
    wait(2.75 if debugging == false else 0.5, Wait.ABORT_WHEN_FALSE)
    lbl_0:
    eventPlayer.using_one_of_the_hearthstones = true
    if eventPlayer.is_using_hearthstone == true:
        playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Color.TEAM_1, eventPlayer.getPosition() + Vector.UP, 1)
        playEffect(getAllPlayers(), DynamicEffect.TRACER_RECALL_DISAPPEAR_SOUND, Color.TEAM_2, eventPlayer.getPosition(), 100)
        if eventPlayer.is_using_ability[Talent.STEALTH] == true:
            break_stealth()
        eventPlayer.setInvisibility(Invis.ALL)
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
        eventPlayer.is_using_hearthstone = false
        async(open_shop, AsyncBehavior.NOOP)
        eventPlayer.browsing_shop = true
        async(stopped_using_hearthstone, AsyncBehavior.RESTART)
        return
    elif eventPlayer.is_using_skip_talent == true:
        eventPlayer.is_using_skip_talent = false
        goto lbl_1
    elif eventPlayer.is_using_vote_yes == true:
        waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 2.75 if debugging == false else 0.5)
        if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true:
            goto lbl_2
        if eventPlayer.replacing_talent_show_confirmation == true:
            eventPlayer.replacing_talent_show_bought_talents = true
            goto lbl_3
        smallMessage(eventPlayer, "{0} Voted Yes!".format(iconString(Icon.CHECKMARK)))
        /*eventPlayer.canVote_hasVoted_canStartVote[1] = true*/
        /*players_that_voted_yes = players_that_voted_yes.concat(eventPlayer)*/
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
        lbl_2:
        lbl_3:
        async(stopped_using_hearthstone, AsyncBehavior.RESTART)
        return
    elif eventPlayer.is_using_vote_no == true:
        waitUntil(eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true, 2.75 if debugging == false else 0.5)
        if eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true:
            goto lbl_4
        if eventPlayer.replacing_talent_show_confirmation == true:
            eventPlayer.replacing_talent_cancelled = true
            goto lbl_5
        smallMessage(eventPlayer, "{0} Voted No!".format(iconString(Icon.NO)))
        /*eventPlayer.canVote_hasVoted_canStartVote[1] = true*/
        /*players_that_voted_no = players_that_voted_no.concat(eventPlayer)*/
        playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, shop_location, 100)
        lbl_4:
        lbl_5:
        async(stopped_using_hearthstone, AsyncBehavior.RESTART)
        return
    lbl_1:
    async(stopped_using_hearthstone, AsyncBehavior.RESTART)
    eventPlayer.browsing_shop = false
    eventPlayer.selected_talent_location = shop_talent_positions[1]
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
    /*
    if random.randint(1, 100) <= 10 and eventPlayer.amount_of_talents_purchased > 4:
        async(leave_shop_messages, AsyncBehavior.NOOP)
    async(stopped_using_hearthstone, AsyncBehavior.RESTART)
    */
    /*
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
        */
        #Act as skipped a talent because the player didn't exit in time

def stopped_using_hearthstone():
    @Name "SHOP - - - [SUBROUTINE] Stopped Using Hearthstone"
    
    eventPlayer.using_one_of_the_hearthstones = false
    eventPlayer.is_using_hearthstone = false
    eventPlayer.is_using_skip_talent = false
    eventPlayer.is_using_vote_yes = false
    eventPlayer.is_using_vote_no = false
    stopChasingVariable(eventPlayer.using_hearthstone_timer)
    eventPlayer.using_hearthstone_timer = 0
    if eventPlayer.is_using_ability[Talent.CRYOGENICS] == false:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    destroyEffect(eventPlayer.hearthstone_effects_id[0])
    destroyEffect(eventPlayer.hearthstone_effects_id[1])

def open_shop():
    @Name "SHOP - - - [SUBROUTINE] Open Shop"

    eventPlayer.possible_talents = []

    if len(eventPlayer.bought_talents) == 5:
        eventPlayer.talent_counter_or_position_etc[15] = 4
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            if eventPlayer.talent_ranks[eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]] < 5:
                eventPlayer.possible_talents.append(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])
            eventPlayer.talent_counter_or_position_etc[15] -= 1
    else:
        eventPlayer.talent_counter_or_position_etc[15] = len(eventPlayer.bought_talents) - 1
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            if eventPlayer.talent_ranks[eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]] < 5:
                eventPlayer.possible_talents.append(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])
            eventPlayer.talent_counter_or_position_etc[15] -= 1
        eventPlayer.talent_counter_or_position_etc[15] = len(eventPlayer.talents_you_do_not_have)
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            if eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]] != null:
                eventPlayer.possible_talents.append(eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]])
            eventPlayer.talent_counter_or_position_etc[15] -= 1
    eventPlayer.is_using_hearthstone = false
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
    #Will the left talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5 and len([player for player in eventPlayer.possible_talents if player != null]) == 0:
        eventPlayer.selected_talent_will_replace[0] = true
    else:
        eventPlayer.selected_talent_will_replace[0] = false
    #Set left talent to a random choice in talents_you_do_not_have if selected_talent_will_replace = true, else random choice in possible_talents
    eventPlayer.talents_offered_in_shop[0] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null]) if eventPlayer.selected_talent_will_replace[0] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    #Remove the left talent
    if len([player for player in eventPlayer.possible_talents if player != null]) > 2:
        /*eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[0]] = null*/
        eventPlayer.possible_talents.remove(eventPlayer.talents_offered_in_shop[0])
    else:
        /*eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[0]] = null*/
        eventPlayer.possible_talents.remove(eventPlayer.talents_offered_in_shop[0])
    #Will the middle talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5:
        eventPlayer.selected_talent_will_replace[1] = true
    else:
        eventPlayer.selected_talent_will_replace[1] = false
    #Set middle talent to a random choice in talents_you_do_not_have if selected_talent_will_replace = true, else random choice in possible_talents
    eventPlayer.talents_offered_in_shop[1] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null and player!= eventPlayer.talents_offered_in_shop[0]]) if eventPlayer.selected_talent_will_replace[1] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    #Remove the middle talent
    if len([player for player in eventPlayer.possible_talents if player != null]) > 1:
        /*eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[1]] = null*/
        eventPlayer.possible_talents.remove(eventPlayer.talents_offered_in_shop[1])
    else:
        /*eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[1]] = null*/
        eventPlayer.possible_talents.remove(eventPlayer.talents_offered_in_shop[1])
    #Will the right talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5 and len([player for player in eventPlayer.possible_talents if player != null]) == 0:
        eventPlayer.selected_talent_will_replace[2] = true
    else:
        eventPlayer.selected_talent_will_replace[2] = false
    #Set right talent to a random choice in talents_you_do_not_have if selected_talent_will_replace = true, else random choice in possible_talents
    eventPlayer.talents_offered_in_shop[2] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null and player!= eventPlayer.talents_offered_in_shop[0] and player != eventPlayer.talents_offered_in_shop[1]]) if eventPlayer.selected_talent_will_replace[2]== true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    eventPlayer.startCamera(shop_location, shop_talent_positions[1], 0.5)
    playEffect(eventPlayer, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, Color.TEAM_1, shop_location.getPosition(), 100)

rule "SHOP - - - Shop Left":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == false
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.selected_talent[1] == 0:
            eventPlayer.selected_talent[1] = 4
            eventPlayer.startCamera(shop_location, shop_talent_positions[eventPlayer.selected_talent], 15)
        else:
            eventPlayer.selected_talent[1] -= 1
            eventPlayer.startCamera(shop_location, shop_talent_positions[eventPlayer.selected_talent], 15)
        return
    if eventPlayer.replacing_talent_show_confirmation == true:
        waitUntil(eventPlayer.replacing_talent_show_bought_talents == true or eventPlayer.replacing_talent_show_confirmation == false, 99999)
            wait(0.33)
            return
    if eventPlayer.selected_talent[0] >= 1:
        if eventPlayer.selected_talent[0] == 2:
            eventPlayer.selected_talent_location = shop_talent_positions[1]
            eventPlayer.selected_talent[0] = 1
            eventPlayer.startCamera(shop_location, shop_talent_positions[1], 15)
        elif eventPlayer.selected_talent[0] == 1:
            eventPlayer.selected_talent_location = shop_talent_positions[0]
            eventPlayer.selected_talent[0] = 0
            eventPlayer.startCamera(shop_location, shop_talent_positions[0], 15)


rule "SHOP - - - Shop Right":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == false
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.selected_talent[1] == 4:
            eventPlayer.selected_talent[1] = 0
            eventPlayer.startCamera(shop_location, shop_talent_positions[eventPlayer.selected_talent], 15)
        else:
            eventPlayer.selected_talent[1] += 1
            eventPlayer.startCamera(shop_location, shop_talent_positions[eventPlayer.selected_talent], 15)
        return
    if eventPlayer.replacing_talent_show_confirmation == true:
        waitUntil(eventPlayer.replacing_talent_show_bought_talents == true or eventPlayer.replacing_talent_show_confirmation == false, 99999)
            wait(0.33)
            return
    if eventPlayer.selected_talent[0] <= 1:
        if eventPlayer.selected_talent[0] == 1:
            eventPlayer.selected_talent_location = shop_talent_positions[2]
            eventPlayer.selected_talent[0] = 2
            eventPlayer.startCamera(shop_location, shop_talent_positions[2], 15)
        elif eventPlayer.selected_talent[0] == 0:
            eventPlayer.selected_talent_location = shop_talent_positions[1]
            eventPlayer.selected_talent[0] = 1
            eventPlayer.startCamera(shop_location, shop_talent_positions[1], 15)

rule "SHOP - - - Buy Talent":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.replacing_talent_show_confirmation == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    
    if eventPlayer.selected_talent[0] == 0:
        eventPlayer.startCamera(shop_talent_positions[0], shop_talent_positions[0], 4.125 if debugging == false else 8.250)
    elif eventPlayer.selected_talent[0] == 1:
        eventPlayer.startCamera(shop_talent_positions[1], shop_talent_positions[1], 4.125 if debugging == false else 8.250)
    elif eventPlayer.selected_talent[0] == 2:
        eventPlayer.startCamera(shop_talent_positions[2], shop_talent_positions[2], 4.125 if debugging == false else 8.250)
    waitUntil(eventPlayer.isHoldingButton(Button.INTERACT) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 0.85 if debugging == false else 0.425)
    if eventPlayer.isHoldingButton(Button.INTERACT) == false or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true:
        wait(0.25)
        return
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.current_talent_replace_or_buy = eventPlayer.bought_talents[eventPlayer.selected_talent[1]]
        buy_or_upgrade_talent()
        if eventPlayer.replacing_talent_cancelled == true:
            eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.TEAM_1, shop_location.getPosition(), 100)
            eventPlayer.replacing_talent_show_confirmation = false
            eventPlayer.replacing_talent_show_bought_talents = false
            eventPlayer.replacing_talent_cancelled = false
            return
        #Reduce the score by how many times the talent you removed was upgraded
        #return
        #Reduce the amount_of_talents_purchased by how many time the talent you removed was upgraded
        eventPlayer.amount_of_talents_purchased -= eventPlayer.talent_ranks[eventPlayer.current_talent_replace_or_buy]
        #Remove the talent from talent_ranks
        eventPlayer.talent_ranks[eventPlayer.current_talent_replace_or_buy] = 0
        #Remove the talent you removed from bought_talents
        eventPlayer.bought_talents = eventPlayer.bought_talents.exclude(eventPlayer.bought_talents[eventPlayer.selected_talent[1]])
        #Put the new talents in bought_talents
        eventPlayer.bought_talents.append(eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]])
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
            if eventPlayer.replacing_talent_cancelled == true:
                eventPlayer.replacing_talent_show_confirmation = false
                eventPlayer.replacing_talent_cancelled = false
                return
            if eventPlayer.replacing_talent_show_bought_talents == true:
                eventPlayer.replacing_talent_show_confirmation = false
                return
    #If the player do not have 5 talents yet and the talent is not bought yet, add it to bought_talents
    lbl_0:
    if len(eventPlayer.bought_talents) < 5 and eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] in eventPlayer.bought_talents == false:
        eventPlayer.bought_talents.append(eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]])
    eventPlayer.browsing_shop = false
    eventPlayer.selected_talent_location = shop_talent_positions[1]
    eventPlayer.amount_of_talents_purchased += 1
    #Add +1 to "talent_ranks" in the correct index
    eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] += 1
    #If the talent being purchased has reached 5...
    if eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] == 5:
        #...remove it from possible talents.
        eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] = null
    eventPlayer.replacing_talent_show_bought_talents = false
    eventPlayer.current_talent_replace_or_buy = eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]
    eventPlayer.possible_talents[eventPlayer.current_talent_replace_or_buy] = eventPlayer.current_talent_replace_or_buy
    buy_or_upgrade_talent()
    eventPlayer.can_enter_shop = false
    eventPlayer.experience_current = 0
    eventPlayer.experience_max = max_experience_per_level[eventPlayer.amount_of_talents_purchased]
    if eventPlayer.talent_ranks[Talent.FIREBALL] > 0 or eventPlayer.talent_ranks[Talent.JUGGERNAUT] > 0:
        async(spawned_with_fireball, AsyncBehavior.RESTART)
    eventPlayer.is_respawning = true
    eventPlayer.respawn()
    #Reset selection of a talent to the middle
    eventPlayer.selected_talent[0] = 1
    /*
    if random.randint(1, 100) <= 10 and eventPlayer.amount_of_talents_purchased > 4:
        async(leave_shop_messages, AsyncBehavior.NOOP)
    */

def replace_talent():
    @Name "SHOP - - - [SUBROUTINE] Replace Talent"
    
    eventPlayer.replacing_talent_show_confirmation = true
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
    waitUntil(eventPlayer.replacing_talent_show_bought_talents == true or eventPlayer.replacing_talent_cancelled == true, 99999)

rule "SHOP - - - Reset Shop Camera":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition (eventPlayer.is_using_skip_talent == true or eventPlayer.isHoldingButton(Button.INTERACT) == false) == true
    
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)


def cancel_shop_camera():
    @Name "SHOP - - - [SUBROUTINE] Cancel Shop Camera"
    
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)

def buy_or_upgrade_talent():
    @Name "SHOP - - - [SUBROUTINE] Buy Or Upgrade Talent"
    
    if eventPlayer.current_talent_replace_or_buy == Talent.BLOODTHIRST:
        buy_bloodthirst()
    elif eventPlayer.current_talent_replace_or_buy == Talent.PURITY_FIELD:
        buy_purity_field()
    elif eventPlayer.current_talent_replace_or_buy == Talent.CYBERNETICS:
        buy_cybernetics()
    elif eventPlayer.current_talent_replace_or_buy == Talent.ENGINEER:
        buy_engineer()
    elif eventPlayer.current_talent_replace_or_buy == Talent.SHADOWSTRIKE:
        buy_shadowstrike()
    elif eventPlayer.current_talent_replace_or_buy == Talent.STEALTH:
        buy_stealth()
    elif eventPlayer.current_talent_replace_or_buy == Talent.JUGGERNAUT:
        buy_juggernaut()
    elif eventPlayer.current_talent_replace_or_buy == Talent.DIVE_BOMB:
        buy_dive_bomb()
    elif eventPlayer.current_talent_replace_or_buy == Talent.CRYOGENICS:
        buy_cryogenics()
    elif eventPlayer.current_talent_replace_or_buy == Talent.RAILGUN:
        buy_railgun()
    elif eventPlayer.current_talent_replace_or_buy == Talent.PREDATOR:
        buy_predator()
    elif eventPlayer.current_talent_replace_or_buy == Talent.JETPACK:
        buy_jetpack()
    elif eventPlayer.current_talent_replace_or_buy == Talent.LIFESTEAL_AMMO:
        buy_lifesteal_ammo()
    elif eventPlayer.current_talent_replace_or_buy == Talent.HEALTH_REGEN:
        buy_health_regen()
    elif eventPlayer.current_talent_replace_or_buy == Talent.HEALTH_POTIONS:
        if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] == 1:
            eventPlayer.amount_of_potions_or_vials = 3
        buy_health_potions()
    elif eventPlayer.current_talent_replace_or_buy == Talent.IGNITE:
        buy_ignite()
    elif eventPlayer.current_talent_replace_or_buy == Talent.OVERCLOCK:
        buy_overclock()
    elif eventPlayer.current_talent_replace_or_buy == Talent.SHADOWSTEP:
        buy_shadowstep()
    elif eventPlayer.current_talent_replace_or_buy == Talent.BURNING_SOUL:
        buy_burning_soul()
    elif eventPlayer.current_talent_replace_or_buy == Talent.BERSERKER:
        buy_berserker()
    elif eventPlayer.current_talent_replace_or_buy == Talent.FIREBALL:
        buy_fireball()
    elif eventPlayer.current_talent_replace_or_buy == Talent.IGNORE_PAIN:
        buy_ignore_pain()
    elif eventPlayer.current_talent_replace_or_buy == Talent.JAVELIN:
        return
    elif eventPlayer.current_talent_replace_or_buy == Talent.SOUL_SIPHON:
        buy_soul_siphon()
    elif eventPlayer.current_talent_replace_or_buy == Talent.PYROMANIAC:
        buy_pyromaniac()
    elif eventPlayer.current_talent_replace_or_buy == Talent.POISON_VIALS:
        if eventPlayer.talent_ranks[Talent.POISON_VIALS] == 1:
            eventPlayer.amount_of_potions_or_vials = 3
        buy_poison_vials()
    elif eventPlayer.current_talent_replace_or_buy == Talent.CRAZY_ALCHEMIST:
        buy_crazy_alchemist()
    elif eventPlayer.current_talent_replace_or_buy == Talent.BOMBARDMENT:
        buy_bombardment()
    elif eventPlayer.current_talent_replace_or_buy == Talent.GIGACHAD:
        buy_gigachad()
    elif eventPlayer.current_talent_replace_or_buy == Talent.GUNSLINGER:
        buy_gunslinger()
    elif eventPlayer.current_talent_replace_or_buy == Talent.SPRINTER:
        buy_sprinter()

/*
def leave_shop_messages():
    @Name "SHOP - - - [SUBROUTINE] Exit Shop Messages"
        
    eventPlayer.random_integer_between_0_to_5 = random.randint(0, 5)
    createInWorldText(eventPlayer, "{0}".format(leave_shop_messages[eventPlayer.random_integer_between_0_to_5]), updateEveryTick(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((0 - 1) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 *eventPlayer.getFacingDirection()))), 1.75, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.ORANGE, SpecVisibility.DEFAULT)
    eventPlayer.player_temp_effects[43] = getLastCreatedText()
    wait(5)
    destroyInWorldText(eventPlayer.player_temp_effects[43])
*/
def buy_bloodthirst():
    @Name "TALENT SYSTEM - - - [TALENT 0: BLOODTHIRST] [SUBROUTINE] Buy Bloodthirst"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.BLOODTHIRST)
        return
    if eventPlayer.talent_ranks[Talent.BLOODTHIRST] == 1:
        eventPlayer.bloodthirst_shield = 0
        eventPlayer.talents_you_do_not_have.remove(Talent.BLOODTHIRST)

def buy_purity_field():
    @Name "TALENT SYSTEM - - - [TALENT 1: PURITY FIELD] [SUBROUTINE] Buy Purity Field"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.PURITY_FIELD)
        return
    if eventPlayer.talent_ranks[Talent.PURITY_FIELD] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.PURITY_FIELD)
        eventPlayer.talent_trigger_times[Talent.PURITY_FIELD] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.PURITY_FIELD]

def buy_cybernetics():
    @Name "TALENT SYSTEM - - - [TALENT 2: CYBERNETICS] [SUBROUTINE] Buy Cybernetics (hit_by_ability[2] is borrowed by talent: juggernaut)"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.CYBERNETICS)
        #Shields
        eventPlayer.stats[4] = 0
        removeHealthPool(eventPlayer.health_pool_id_or_hot_id[7])
        return
    if eventPlayer.talent_ranks[Talent.CYBERNETICS] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.CYBERNETICS)
    #Shields
    eventPlayer.stats[4] = eventPlayer.stats[4] + 30

def buy_engineer():
    @Name "TALENT SYSTEM - - - [TALENT 3: ENGINEER] [SUBROUTINE] Buy Engineer"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.engineer_scrap = 0
        eventPlayer.talents_you_do_not_have.append(Talent.ENGINEER)
        eventPlayer.talents_you_do_not_have.append(Talent.IGNORE_PAIN)
        return
    if eventPlayer.talent_ranks[Talent.ENGINEER] == 1:
        #Lock talent Ignore Pain
        eventPlayer.possible_talents.remove(Talent.IGNORE_PAIN)
        eventPlayer.talents_you_do_not_have.remove(Talent.IGNORE_PAIN)
        eventPlayer.engineer_scrap = 0
        eventPlayer.talents_you_do_not_have.remove(Talent.ENGINEER)

def buy_shadowstrike():
    @Name "TALENT SYSTEM - - - [TALENT 4: SHADOWSTRIKE] [SUBROUTINE] Buy Shadowstrike"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.SHADOWSTRIKE)
        eventPlayer.talents_you_do_not_have.append(Talent.SHADOWSTEP)
        return
    if eventPlayer.talent_ranks[Talent.SHADOWSTRIKE] == 1:
        eventPlayer.talent_trigger_times[Talent.SHADOWSTRIKE] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.SHADOWSTRIKE]
        eventPlayer.talents_you_do_not_have.remove(Talent.SHADOWSTRIKE)
        eventPlayer.talents_you_do_not_have.remove(Talent.SHADOWSTEP)

def buy_stealth():
    @Name "TALENT SYSTEM - - - [TALENT 5: STEALTH] [SUBROUTINE] Buy Stealth"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        break_stealth()
        eventPlayer.entering_stealth = false
        destroyEffect(eventPlayer.player_temp_effects[57])
        destroyEffect(eventPlayer.player_temp_effects[58])
        eventPlayer.talents_you_do_not_have.append(Talent.STEALTH)
        return
    if eventPlayer.talent_ranks[Talent.STEALTH] == 1:
        eventPlayer.talent_trigger_times[Talent.STEALTH] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.STEALTH]
        eventPlayer.entering_stealth = false
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.STEALTH] == true else null, Effect.REAPER_WRAITH_FORM, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[57] = getLastCreatedEntity()
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.STEALTH] == true else null, Effect.SIGMA_GRAVITIC_FLUX_TARGET_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[58] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have.remove(Talent.STEALTH)

def buy_juggernaut():
    @Name "TALENT SYSTEM - - - [TALENT 6: JUGGERNAUT] [SUBROUTINE] Buy Juggernaut [DISABLED: JUGGERNAUT NOT WORKING AS INTENDED]"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        stopChasingVariable(eventPlayer.juggernaut_charge)
        destroyEffect(eventPlayer.player_temp_effects[59])
        eventPlayer.talents_you_do_not_have.append(Talent.JUGGERNAUT)
        eventPlayer.talents_you_do_not_have.append(Talent.FIREBALL)
        return
    if eventPlayer.talent_ranks[Talent.JUGGERNAUT] == 1:
        chase(eventPlayer.juggernaut_charge, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.JUGGERNAUT] == true else null, Effect.SOLDIER_SPRINTING, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[59] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have.remove(Talent.JUGGERNAUT)
        eventPlayer.talents_you_do_not_have.remove(Talent.FIREBALL)
        eventPlayer.talent_trigger_times[Talent.JUGGERNAUT] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.JUGGERNAUT]

def buy_dive_bomb():
    @Name "TALENT SYSTEM - - - [TALENT 7: DIVE BOMB] [SUBROUTINE] Buy Dive Bomb [DISABLED: DIVE BOMB NOT WORKING AS INTENDED]"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.DIVE_BOMB)
        return
    if eventPlayer.talent_ranks[Talent.DIVE_BOMB] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.DIVE_BOMB)
        eventPlayer.talent_trigger_times[Talent.DIVE_BOMB] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.DIVE_BOMB]

def buy_cryogenics():
    @Name "TALENT SYSTEM - - - [TALENT 8: CRYOGENICS] [SUBROUTINE] Buy Cryogenics"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.CRYOGENICS)
        return
    if eventPlayer.talent_ranks[Talent.CRYOGENICS] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.CRYOGENICS)

def buy_railgun():
    @Name "TALENT SYSTEM - - - [TALENT 9: RAILGUN] [SUBROUTINE] Buy Railgun"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] == [Talent.OVERCLOCK]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.RAILGUN], talent_names[Talent.OVERCLOCK]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.OVERCLOCK] > 0:
            smallMessage(eventPlayer, "Need to remove {0} first!".format(talent_names[Talent.OVERCLOCK]))
            lbl_0:
            eventPlayer.replacing_talent_cancelled = true
            return
        stopChasingVariable(eventPlayer.railgun_discharge)
        destroyEffect(eventPlayer.player_temp_effects[59])
        destroyEffect(eventPlayer.player_temp_effects[76])
        eventPlayer.railgun_discharge = 0
        eventPlayer.railgun_charge = 0
        eventPlayer.setSecondaryFireEnabled(true)
        eventPlayer.railgun_projectile_start = []
        eventPlayer.railgun_projectile_player_hit = []
        eventPlayer.talents_you_do_not_have.append(Talent.RAILGUN)
        eventPlayer.talents_you_do_not_have.append(Talent.BOMBARDMENT)
        eventPlayer.talents_you_do_not_have.remove(Talent.OVERCLOCK)
        return
    if eventPlayer.talent_ranks[Talent.RAILGUN] == 1:
        eventPlayer.talent_trigger_times[Talent.RAILGUN] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.RAILGUN]
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents.append(Talent.OVERCLOCK)
        eventPlayer.railgun_projectile_start = []
        eventPlayer.railgun_projectile_player_hit = []
        chase(eventPlayer.railgun_discharge, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.railgun_charge = 0
        eventPlayer.setSecondaryFireEnabled(false)
        createEffect(getAllPlayers() if eventPlayer.railgun_charge == 100 else null, Effect.ANA_NANO_BOOSTED, Color.TEAM_1, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[59] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.railgun_charge == 100 else null, Effect.WINSTON_TESLA_CANNON_TARGET_SOUND, Color.TEAM_1, eventPlayer, 75, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[76] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have.remove(Talent.RAILGUN)
        eventPlayer.talents_you_do_not_have.remove(Talent.BOMBARDMENT)
        eventPlayer.talents_you_do_not_have.append(Talent.OVERCLOCK)

def buy_predator():
    @Name "TALENT SYSTEM - - - [TALENT 10: PREDATOR] [SUBROUTINE] Buy Predator"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        #If you are trying to replace predator with soul siphon
        if eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] == [Talent.SOUL_SIPHON]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.PREDATOR], talent_names[Talent.SOUL_SIPHON]))
            goto lbl_0
        #If you are trying to remove predator when you have soul siphon
        if eventPlayer.talent_ranks[Talent.SOUL_SIPHON] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Soul Siphon first!".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE)))
            lbl_0:
            eventPlayer.replacing_talent_cancelled = true
            return
        eventPlayer.talents_you_do_not_have.append(Talent.PREDATOR)
        eventPlayer.talents_you_do_not_have.remove(Talent.SOUL_SIPHON)
        return
    if eventPlayer.talent_ranks[Talent.PREDATOR] == 1:
        eventPlayer.talent_trigger_times[Talent.PREDATOR] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.PREDATOR]
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents.append(Talent.SOUL_SIPHON)
        eventPlayer.talents_you_do_not_have.remove(Talent.PREDATOR)
        eventPlayer.talents_you_do_not_have.append(Talent.SOUL_SIPHON)

def buy_jetpack():
    @Name "TALENT SYSTEM - - - [TALENT 11: JETPACK] [SUBROUTINE] Buy Jetpack"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.stopAcceleration()
        stopChasingVariable(eventPlayer.jetpack_fuel)
        eventPlayer.jetpack_fuel = 100
        destroyEffect(eventPlayer.player_temp_effects[14])
        eventPlayer.talents_you_do_not_have.append(Talent.JETPACK)
        return
    if eventPlayer.talent_ranks[Talent.JETPACK] == 1:
        eventPlayer.startAcceleration(Vector.UP, 10 + 0.275 * eventPlayer.jetpack_fuel if eventPlayer.is_using_ability[Talent.JETPACK] == true else 0, 3, Relativity.TO_PLAYER, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)
        eventPlayer.jetpack_fuel = 100
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.JETPACK] == true and eventPlayer.is_using_ability[Talent.STEALTH] == false else null, Effect.WRECKING_BALL_PILEDRIVER_FIRE_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[14] = getLastCreatedEntity()
        chase(eventPlayer.jetpack_fuel, 0 if eventPlayer.is_using_ability[Talent.JETPACK] == true else 100, rate=25 - eventPlayer.talent_ranks[Talent.JETPACK] * 3 if eventPlayer.is_using_ability[Talent.JETPACK] == true else 10, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have.remove(Talent.JETPACK)

def buy_lifesteal_ammo():
    @Name "TALENT SYSTEM - - - [TALENT 12: LIFESTEAL AMMO] [SUBROUTINE] Buy Lifesteal Ammo"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        stopChasingVariable(eventPlayer.is_lifestealing)
        eventPlayer.is_lifestealing = 0
        destroyEffect(eventPlayer.player_temp_effects[60])
        destroyEffect(eventPlayer.player_temp_effects[61])
        destroyEffect(eventPlayer.player_temp_effects[62])
        eventPlayer.talents_you_do_not_have.append(Talent.LIFESTEAL_AMMO)
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
        eventPlayer.talents_you_do_not_have.remove(Talent.LIFESTEAL_AMMO)

def buy_health_regen():
    @Name "TALENT SYSTEM - - - [TALENT 13: HEALTH REGEN] [SUBROUTINE] Buy Health Regen"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.HEALTH_REGEN)
        destroyEffect(eventPlayer.player_temp_effects[63])
        destroyEffect(eventPlayer.player_temp_effects[64])
        stopHoT(eventPlayer.health_pool_id_or_hot_id[2])
        return
    if eventPlayer.talent_ranks[Talent.HEALTH_REGEN] == 1:
        createEffect(eventPlayer if eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL) and eventPlayer.isAlive() == true else null, Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.player_temp_effects[63] = getLastCreatedEntity()
        createEffect(eventPlayer if eventPlayer.getHealthOfType(Health.NORMAL) < eventPlayer.getMaxHealthOfType(Health.NORMAL) and eventPlayer.isAlive() == true else null, Effect.SPARKLES, Color.PURPLE if eventPlayer.is_using_ability[Talent.STEALTH] == true else Color.ORANGE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.player_temp_effects[64] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have.remove(Talent.HEALTH_REGEN)
        async(health_regen_heal_over_time, AsyncBehavior.RESTART)

def buy_health_potions():
    @Name "TALENT SYSTEM - - - [TALENT 14: HEALTH POTIONS] [SUBROUTINE] Buy Health Potions"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] == [Talent.CRAZY_ALCHEMIST]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.HEALTH_POTIONS], talent_names[Talent.CRAZY_ALCHEMIST]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Crazy Alchemist first!".format(iconString(Icon.RADIOACTIVE)))
            lbl_0:
            eventPlayer.replacing_talent_cancelled = true
            return
        eventPlayer.amount_of_potions_or_vials = 0
        eventPlayer.talents_you_do_not_have.append(Talent.HEALTH_POTIONS)
        eventPlayer.talents_you_do_not_have.append(Talent.POISON_VIALS)
        eventPlayer.talents_you_do_not_have.remove(Talent.CRAZY_ALCHEMIST)
        return
    if eventPlayer.talent_ranks[Talent.HEALTH_POTIONS] == 1:
        eventPlayer.talent_trigger_times[Talent.HEALTH_POTIONS] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.HEALTH_POTIONS]
        eventPlayer.amount_of_potions_or_vials = 3
        #Lock talent Poison Vials
        eventPlayer.possible_talents.remove(Talent.POISON_VIALS)
        eventPlayer.talents_you_do_not_have.remove(Talent.POISON_VIALS)
        eventPlayer.talents_you_do_not_have.remove(Talent.HEALTH_POTIONS)
        eventPlayer.talents_you_do_not_have.append(Talent.CRAZY_ALCHEMIST)
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents.append(Talent.CRAZY_ALCHEMIST)

def buy_ignite():
    @Name "TALENT SYSTEM - - - [TALENT 16: IGNITE] [SUBROUTINE] Buy Ignite"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.ignite_position = eventPlayer.getEyePosition()
        eventPlayer.talents_you_do_not_have.append(Talent.IGNITE)
        return
    if eventPlayer.talent_ranks[Talent.IGNITE] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.IGNITE)

def buy_overclock():
    @Name "TALENT SYSTEM - - - [TALENT 17: OVERCLOCK] [SUBROUTINE] Buy Overclock"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.OVERCLOCK)
        return
    if eventPlayer.talent_ranks[Talent.OVERCLOCK] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.OVERCLOCK)

def buy_shadowstep():
    @Name "TALENT SYSTEM - - - [TALENT 18: SHADOWSTEP] [SUBROUTINE] Buy Shadowstep"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.SHADOWSTEP)
        eventPlayer.talents_you_do_not_have.append(Talent.SHADOWSTRIKE)
        return
    if eventPlayer.talent_ranks[Talent.SHADOWSTEP] == 1:
        eventPlayer.talent_trigger_times[Talent.SHADOWSTEP] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.SHADOWSTEP]
        eventPlayer.talents_you_do_not_have.remove(Talent.SHADOWSTEP)
        eventPlayer.talents_you_do_not_have.remove(Talent.SHADOWSTRIKE)

def buy_burning_soul():
    @Name "TALENT SYSTEM - - - [TALENT 19: BURNING SOUL] [SUBROUTINE] Buy Burning Soul"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        stopChasingVariable(eventPlayer.burning_soul_orb_timer)
        eventPlayer.talents_you_do_not_have.append(Talent.BURNING_SOUL)
        destroyEffect(eventPlayer.player_temp_effects[65])
        destroyEffect(eventPlayer.player_temp_effects[66])
        return
    if eventPlayer.talent_ranks[Talent.BURNING_SOUL] == 1:
        createEffect(getAllPlayers() if "{0}".format(eventPlayer.isCommunicatingEmote()) == "false" else [player for player in getAllPlayers() if player != eventPlayer] if eventPlayer.isUsingAbility1() == false else null, Effect.ASHE_DYNAMITE_BURNING_PARTICLE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[65] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.isUsingAbility1() == false else null, Effect.ASHE_DYNAMITE_BURNING_MATERIAL, Color.TEAM_2, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[66] = getLastCreatedEntity()
        chase(eventPlayer.burning_soul_orb_timer, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have.remove(Talent.BURNING_SOUL)

def buy_berserker():
    @Name "TALENT SYSTEM - - - [TALENT 20: BERSERKER] [SUBROUTINE] Buy Berserker"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] == [Talent.BLOODTHIRST]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.BERSERKER], talent_names[Talent.BLOODTHIRST]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.BLOODTHIRST] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Bloodthirst first!".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1)))
            lbl_0:
            eventPlayer.replacing_talent_cancelled = true
            return
        eventPlayer.talents_you_do_not_have.append(Talent.BERSERKER)
        eventPlayer.talents_you_do_not_have.remove(Talent.BLOODTHIRST)
        destroyEffect(eventPlayer.player_temp_effects[67])
        destroyEffect(eventPlayer.player_temp_effects[68])
        destroyEffect(eventPlayer.player_temp_effects[69])
        return
    if eventPlayer.talent_ranks[Talent.BERSERKER] == 1:
        eventPlayer.talent_trigger_times[Talent.BERSERKER] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.BERSERKER]
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents.append(Talent.BLOODTHIRST)
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.BERSERKER] == true else null, Effect.WINSTON_PRIMAL_RAGE, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[67] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.BERSERKER] == true else null, Effect.WINSTON_PRIMAL_RAGE, Color.TEAM_2, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[68] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.BERSERKER] == true else null, Effect.WINSTON_PRIMAL_RAGE_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[69] = getLastCreatedEntity()
        eventPlayer.talents_you_do_not_have.remove(Talent.BERSERKER)
        eventPlayer.talents_you_do_not_have.append(Talent.BLOODTHIRST)

def buy_fireball():
    @Name "TALENT SYSTEM - - - [TALENT 21: FIREBALL] [SUBROUTINE] Buy Fireball"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] == [Talent.PYROMANIAC]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.FIREBALL], talent_names[Talent.PYROMANIAC]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.PYROMANIAC] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Pyromaniac first!".format(abilityIconString(Hero.REAPER, Button.ULTIMATE)))
            lbl_0:
            eventPlayer.replacing_talent_cancelled = true
            return
        eventPlayer.fireball_position = vect(0, 0, 0)
        eventPlayer.talents_you_do_not_have.append(Talent.JUGGERNAUT)
        eventPlayer.talents_you_do_not_have.append(Talent.FIREBALL)
        eventPlayer.talents_you_do_not_have.remove(Talent.PYROMANIAC)
        return
    if eventPlayer.talent_ranks[Talent.FIREBALL] == 1:
        eventPlayer.talent_trigger_times[Talent.FIREBALL] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.FIREBALL]
        eventPlayer.fireball_position = vect(0, 0, 0)
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents.append(Talent.PYROMANIAC)
        eventPlayer.talents_you_do_not_have.remove(Talent.JUGGERNAUT)
        eventPlayer.talents_you_do_not_have.remove(Talent.FIREBALL)
        eventPlayer.talents_you_do_not_have.append(Talent.PYROMANIAC)

def buy_ignore_pain():
    @Name "TALENT SYSTEM - - - [TALENT 22: IGNORE PAIN] [SUBROUTINE] Buy Ignore Pain"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.ignore_pain_damage_resisted = 0
        eventPlayer.talents_you_do_not_have.append(Talent.ENGINEER)
        eventPlayer.talents_you_do_not_have.append(Talent.IGNORE_PAIN)
        destroyEffect(eventPlayer.player_temp_effects[55])
        destroyEffect(eventPlayer.player_temp_effects[56])
        return
    if eventPlayer.talent_ranks[Talent.IGNORE_PAIN] == 1:
        #Lock talent Engineer
        eventPlayer.possible_talents.remove(Talent.IGNORE_PAIN)
        eventPlayer.talents_you_do_not_have.remove(Talent.ENGINEER)
        eventPlayer.talents_you_do_not_have.remove(Talent.IGNORE_PAIN)
        eventPlayer.ignore_pain_damage_resisted = 0
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.IGNORE_PAIN] == true else null, Effect.WRECKING_BALL_ADAPTIVE_SHIELD_TARGET, Color.TEAM_1, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[55] = getLastCreatedEntity()
        createEffect(eventPlayer if eventPlayer.is_using_ability[Talent.IGNORE_PAIN] == true else null, Effect.WRECKING_BALL_ADAPTIVE_SHIELD_TARGET_SOUND, Color.TEAM_1, eventPlayer.getPosition(), eventPlayer.ignore_pain_volume, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.player_temp_effects[56] = getLastCreatedEntity()

def buy_soul_siphon():
    @Name "TALENT SYSTEM - - - [TALENT 29: SOUL SIPHON] [SUBROUTINE] Buy Soul Siphon"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        stopChasingVariable(eventPlayer.soul_siphon_duration)
        eventPlayer.soul_siphon_duration = 0
        eventPlayer.talents_you_do_not_have.append(Talent.SOUL_SIPHON)
        return
    if eventPlayer.talent_ranks[Talent.SOUL_SIPHON] == 1:
        eventPlayer.soul_siphon_duration = 0
        chase(eventPlayer.soul_siphon_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have.remove(Talent.SOUL_SIPHON)

def buy_pyromaniac():
    @Name "TALENT SYSTEM - - - [TALENT 30: PYROMANIAC] [SUBROUTINE] Buy Pyromaniac"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        stopChasingVariable(eventPlayer.pyromaniac_heal_duration)
        eventPlayer.pyromaniac_heal_duration = 0
        eventPlayer.talents_you_do_not_have.append(Talent.PYROMANIAC)
        return
    if eventPlayer.talent_ranks[Talent.PYROMANIAC] == 1:
        eventPlayer.pyromaniac_heal_duration = 0
        chase(eventPlayer.pyromaniac_heal_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.talents_you_do_not_have.remove(Talent.PYROMANIAC)

def buy_poison_vials():
    @Name "TALENT SYSTEM - - - [TALENT 31: POISON VIALS] [SUBROUTINE] Buy Poison Vials [DISABLED: POISON VIALS NOT WORKING AS INTENDED]"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        if eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] == talent_names[Talent.CRAZY_ALCHEMIST]:
            smallMessage(eventPlayer, "You need {0} for {1}!".format(talent_names[Talent.POISON_VIALS], talent_names[Talent.CRAZY_ALCHEMIST]))
            goto lbl_0
        if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] > 0:
            smallMessage(eventPlayer, "Need to remove {0} Crazy Alchemist first!".format(iconString(Icon.RADIOACTIVE)))
            lbl_0:
            eventPlayer.replacing_talent_cancelled = true
            return
        stopChasingVariable(eventPlayer.time_since_poison_vial_exploded)
        eventPlayer.poison_vial_effects = []
        eventPlayer.poison_vial_clouds_spawned = 0
        eventPlayer.time_since_poison_vial_exploded = 0
        eventPlayer.amount_of_potions_or_vials = 0
        eventPlayer.talents_you_do_not_have.append(Talent.HEALTH_POTIONS)
        eventPlayer.talents_you_do_not_have.append(Talent.POISON_VIALS)
        eventPlayer.talents_you_do_not_have.remove(Talent.CRAZY_ALCHEMIST)
        return
    if eventPlayer.talent_ranks[Talent.POISON_VIALS] == 1:
        eventPlayer.talent_trigger_times[Talent.POISON_VIALS] = eventPlayer.totalTimeElapsed - talent_base_cooldowns[Talent.POISON_VIALS]
        eventPlayer.talents_you_do_not_have.remove(Talent.HEALTH_POTIONS)
        eventPlayer.talents_you_do_not_have.remove(Talent.POISON_VIALS)
        eventPlayer.talents_you_do_not_have.append(Talent.CRAZY_ALCHEMIST)
        eventPlayer.amount_of_potions_or_vials = 3
        #Lock talent Health Potions
        eventPlayer.possible_talents.remove(Talent.HEALTH_POTIONS)
        if len(eventPlayer.bought_talents) < 5:
            #Unlock follow-up talent
            eventPlayer.possible_talents.append(Talent.CRAZY_ALCHEMIST)
        eventPlayer.poison_vial_effects = []
        eventPlayer.poison_vial_clouds_spawned = 0
        chase(eventPlayer.time_since_poison_vial_exploded, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)

def buy_crazy_alchemist():
    @Name "TALENT SYSTEM - - - [TALENT 32: CRAZY ALCHEMIST] [SUBROUTINE] Buy Crazy Alchemist"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.CRAZY_ALCHEMIST)
        return
    if eventPlayer.talent_ranks[Talent.CRAZY_ALCHEMIST] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.CRAZY_ALCHEMIST)

def buy_bombardment():
    @Name "TALENT SYSTEM - - - [BOMBARDMENT] [SUBROUTINE] Buy Bombardment"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.BOMBARDMENT)
        eventPlayer.talents_you_do_not_have.append(Talent.GUNSLINGER)
        eventPlayer.talents_you_do_not_have.append(Talent.RAILGUN)
        eventPlayer.setMaxAmmo(0, 30)
        eventPlayer.setProjectileSpeed(100)
        return
    if eventPlayer.talent_ranks[Talent.BOMBARDMENT] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.BOMBARDMENT)
        eventPlayer.talents_you_do_not_have.remove(Talent.GUNSLINGER)
        eventPlayer.talents_you_do_not_have.remove(Talent.RAILGUN)
        eventPlayer.possible_talents.remove(Talent.BOMBARDMENT)
        eventPlayer.setMaxAmmo(0, 0)
        eventPlayer.setProjectileSpeed(70)

def buy_gigachad():
    @Name "TALENT SYSTEM - - - [GIGACHAD] [SUBROUTINE] Buy GIGACHAD"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.GIGACHAD)
        eventPlayer.talents_you_do_not_have.append(Talent.SPRINTER)
        #Health
        eventPlayer.stats[1] = 250
        #Speed
        eventPlayer.stats[2] = 100
        #Size
        eventPlayer.stats[8] = 1
        eventPlayer.startScalingSize(eventPlayer.stats[8], false)
        #Voice
        eventPlayer.stats[6] = 1
        eventPlayer.startModifyingVoicelinePitch(eventPlayer.stats[6], false)
        return
    if eventPlayer.talent_ranks[Talent.GIGACHAD] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.GIGACHAD)
        eventPlayer.talents_you_do_not_have.remove(Talent.SPRINTER)
    #Health
    eventPlayer.stats[1] += 50
    #Speed
    eventPlayer.stats[2] -= 5
    #Size
    eventPlayer.stats[8] += 0.07
    eventPlayer.startScalingSize(eventPlayer.stats[8], false)
    #Voice
    eventPlayer.stats[6] -= 0.05
    eventPlayer.startModifyingVoicelinePitch(eventPlayer.stats[6], false)

def buy_gunslinger():
    @Name "TALENT SYSTEM - - - [GUNSLINGER] [SUBROUTINE] Buy GUNSLINGER"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.allowButton(Button.PRIMARY_FIRE)
        eventPlayer.talents_you_do_not_have.append(Talent.GUNSLINGER)
        eventPlayer.talents_you_do_not_have.append(Talent.BOMBARDMENT)
        eventPlayer.setMaxAmmo(0, 30)
        return
    if eventPlayer.talent_ranks[Talent.GUNSLINGER] == 1:
        eventPlayer.disallowButton(Button.PRIMARY_FIRE)
        eventPlayer.talents_you_do_not_have.remove(Talent.GUNSLINGER)
        eventPlayer.talents_you_do_not_have.remove(Talent.BOMBARDMENT)
        eventPlayer.possible_talents.remove(Talent.BOMBARDMENT)
        eventPlayer.setMaxAmmo(0, 6)
        eventPlayer.setAmmo(0, 6)

def buy_sprinter():
    @Name "TALENT SYSTEM - - - [SPRINTER] [SUBROUTINE] Buy SPRINTER"
    
    if eventPlayer.replacing_talent_show_bought_talents == true:
        eventPlayer.talents_you_do_not_have.append(Talent.SPRINTER)
        eventPlayer.talents_you_do_not_have.append(Talent.GIGACHAD)
        #Size
        eventPlayer.stats[8] = 1
        eventPlayer.startScalingSize(eventPlayer.stats[8], false)
        #Voice
        eventPlayer.stats[6] = 1
        eventPlayer.startModifyingVoicelinePitch(eventPlayer.stats[6], false)
        return
    if eventPlayer.talent_ranks[Talent.SPRINTER] == 1:
        eventPlayer.talents_you_do_not_have.remove(Talent.SPRINTER)
        eventPlayer.talents_you_do_not_have.remove(Talent.GIGACHAD)
    #Size
    eventPlayer.stats[8] -= 0.035
    eventPlayer.startScalingSize(eventPlayer.stats[8], false)
    #Voice
    eventPlayer.stats[6] += 0.075
    eventPlayer.startModifyingVoicelinePitch(eventPlayer.stats[6], false)