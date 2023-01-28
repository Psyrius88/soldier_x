#!mainFile "soldier_x.opy"
#Global variables

globalvar shop_location
globalvar leave_shop_messages = ["Latest patch notes at: workshop.codes/ZEKK3", "Got any feedback? Join the Discord!", "Got an idea for a new talent? Join the Discord!", "Want to show your support? Click the {0} at: workshop.codes/ZEKK3".format(iconString(Icon.HEART)), "Found a bug? Join the Discord!", "Want to help the community grow? Join the Discord!"]
globalvar shop_talent_left_location
globalvar shop_talent_middle_location
globalvar shop_talent_right_location
globalvar max_experience_per_level = [250, 275, 303, 333, 366, 403, 443, 487, 536, 589, 648, 713, 785, 863, 949, 1044, 1149, 1264, 1390, 1529, 1682, 1850, 2035, 2239, 2462, 2709]

#Player variables

playervar current_talent_replace_or_buy
playervar hearthstone_effects_id
playervar is_respawning = false
playervar selected_talent_location = shop_talent_middle_location
playervar selected_talent_will_replace
playervar using_hearthstone_timer = 0

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

def using_one_of_the_hearthstones():
    @Name "SHOP - - - [SUBROUTINE] Using One of the Hearthstones"
    
    if eventPlayer.is_using_hearthstone[0] == true:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2] * 0.25)
        createEffect(getAllPlayers(), Effect.GOOD_AURA_SOUND, Color.WHITE, eventPlayer.getPosition() + Vector.UP, 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[0] = getLastCreatedEntity()
        createEffect(getAllPlayers() if eventPlayer.is_using_ability[Talent.STEALTH] == false else null, Effect.GOOD_AURA, Color.GREEN, updateEveryTick(eventPlayer.getPosition() + Vector.UP), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[1] = getLastCreatedEntity()
    if eventPlayer.is_using_hearthstone[1] == true:
        createEffect(eventPlayer, Effect.SOMBRA_HACKING_SOUND, Color.WHITE, shop_location if eventPlayer.browsing_shop == true else eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.hearthstone_effects_id[0] = getLastCreatedEntity()
    chase(eventPlayer.using_hearthstone_timer, 2.75, rate=1, ChaseReeval.DESTINATION_AND_RATE)
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
    async(stopped_using_hearthstone, AsyncBehavior.RESTART)


def stopped_using_hearthstone():
    @Name "SHOP - - - [SUBROUTINE] Stopped Using Hearthstone"
    
    eventPlayer.using_one_of_the_hearthstones = false
    eventPlayer.is_using_hearthstone[0] = false
    eventPlayer.is_using_hearthstone[1] = false
    stopChasingVariable(eventPlayer.using_hearthstone_timer)
    eventPlayer.using_hearthstone_timer = 0
    if eventPlayer.is_using_ability[Talent.CRYOGENICS] == false:
        eventPlayer.setMoveSpeed(eventPlayer.stats[2])
    destroyEffect(eventPlayer.hearthstone_effects_id[0])
    destroyEffect(eventPlayer.hearthstone_effects_id[1])

def open_shop():
    @Name "SHOP - - - [SUBROUTINE] Open Shop"
    #EMPTY POSSIBLE_TALENTS
    eventPlayer.possible_talents = []
    #THIS FILLS POSSIBLE_TALENTS WITH ONLY TALENTS THAT ARE NOT RANK 5 YET.
    if len(eventPlayer.bought_talents) == 5:
        #Set while counter variable to 4
        eventPlayer.talent_counter_or_position_etc[15] = 4
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            #If the current talent considered by the counter variable have not reached maximum rank yet
            if eventPlayer.talent_ranks[eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]] < 5:
                #FILL POSSIBLE_TALENTS with the current talent considered by the counter variable
                eventPlayer.possible_talents[eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]] = eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]
            eventPlayer.talent_counter_or_position_etc[15] -= 1
    else:
        #Set while counter variable to the length of bought_talents (-1 because array starts at 0)
        eventPlayer.talent_counter_or_position_etc[15] = len(eventPlayer.bought_talents) - 1
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            #If the current talent considered in bought_talents by the counter variable has something in it
            if eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]] != null:
                #FILL POSSIBLE_TALENTS with the current talent considered by the counter variable
                eventPlayer.possible_talents.append(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])

                /*eventPlayer.possible_talents[talent_names.index(eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]])] = eventPlayer.bought_talents[eventPlayer.talent_counter_or_position_etc[15]]*/

            eventPlayer.talent_counter_or_position_etc[15] -= 1
        #Set while counter variable to the length of talents_you_do_not_have
        eventPlayer.talent_counter_or_position_etc[15] = len(eventPlayer.talents_you_do_not_have)
        while eventPlayer.talent_counter_or_position_etc[15] >= 0:
            #If the current talent considered in talents_you_do_not_have by the counter variable has something in it
            if eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]] != null:
                #FILL POSSIBLE_TALENTS with the current talent considered by the counter variable
                eventPlayer.possible_talents.append(eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]])

                /*eventPlayer.possible_talents[talent_names.index(eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]])] = eventPlayer.talents_you_do_not_have[eventPlayer.talent_counter_or_position_etc[15]]*/

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
    #Will the left talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5 and len([player for player in eventPlayer.possible_talents if player != null]) == 0:
        eventPlayer.selected_talent_will_replace[0] = true
    else:
        eventPlayer.selected_talent_will_replace[0] = false
    #Set the left talent
    #return
    eventPlayer.talents_offered_in_shop[0] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null]) if eventPlayer.selected_talent_will_replace[0] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    #Remove the left talent
    if len([player for player in eventPlayer.possible_talents if player != null]) > 2:
        eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[0]] = null
    else:
        eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[0]] = null
    #Will the middle talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5:
        eventPlayer.selected_talent_will_replace[1] = true
    else:
        eventPlayer.selected_talent_will_replace[1] = false
    #Set the middle talent
    #return
    eventPlayer.talents_offered_in_shop[1] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null and player!= eventPlayer.talents_offered_in_shop[0]]) if eventPlayer.selected_talent_will_replace[1] == true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    #Remove the middle talent
    if len([player for player in eventPlayer.possible_talents if player != null]) > 1:
        eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[1]] = null
    else:
        eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[1]] = null
    #Will the right talent replace a talent if taken?
    #return
    if len(eventPlayer.bought_talents) == 5 and len([player for player in eventPlayer.possible_talents if player != null]) == 0:
        eventPlayer.selected_talent_will_replace[2] = true
    else:
        eventPlayer.selected_talent_will_replace[2] = false
    #Set the right talent
    #return
    eventPlayer.talents_offered_in_shop[2] = random.choice([player for player in eventPlayer.talents_you_do_not_have if player != null and player!= eventPlayer.talents_offered_in_shop[0] and player != eventPlayer.talents_offered_in_shop[1]]) if eventPlayer.selected_talent_will_replace[2]== true else random.choice([player for player in eventPlayer.possible_talents if player != null])
    eventPlayer.startCamera(shop_location, shop_talent_middle_location, 0.5)
    playEffect(eventPlayer, DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, Color.TEAM_1, shop_location.getPosition(), 100)

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
            if eventPlayer.replace_replacing_or_cancelled[2] == true:
                eventPlayer.replace_replacing_or_cancelled[0] = false
                eventPlayer.replace_replacing_or_cancelled[2] = false
                return
            if eventPlayer.replace_replacing_or_cancelled[1] == true:
                eventPlayer.replace_replacing_or_cancelled[0] = false
                return
    #If the player do not have 5 talents yet and the talent is not bought yet, add it to bought_talents
    lbl_0:
    if len(eventPlayer.bought_talents) < 5 and eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]] in eventPlayer.bought_talents == false:
        eventPlayer.bought_talents.append(eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]])
    eventPlayer.browsing_shop = false
    eventPlayer.selected_talent_location = shop_talent_middle_location
    eventPlayer.amount_of_talents_purchased += 1
    #Add +1 to "talent_ranks" in the correct index
    eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] += 1
    #If the talent being purchased has reached 5...
    if eventPlayer.talent_ranks[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] == 5:
        #...remove it from possible talents.
        eventPlayer.possible_talents[eventPlayer.talents_offered_in_shop[eventPlayer.selected_talent[0]]] = null
    eventPlayer.replace_replacing_or_cancelled[1] = false
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
    if random.randint(1, 100) <= 10 and eventPlayer.amount_of_talents_purchased > 4:
        async(leave_shop_messages, AsyncBehavior.NOOP)

def replace_talent():
    @Name "SHOP - - - [SUBROUTINE] Replace Talent"
    
    eventPlayer.replace_replacing_or_cancelled[0] = true
    eventPlayer.startCamera(shop_location, eventPlayer.selected_talent_location, 12)
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, shop_location, 100)
    waitUntil(eventPlayer.replace_replacing_or_cancelled[1] == true or eventPlayer.replace_replacing_or_cancelled[2] == true, 99999)

rule "SHOP - - - Reset Shop Camera":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition (eventPlayer.is_using_hearthstone[1] == true or eventPlayer.isHoldingButton(Button.INTERACT) == false) == true
    
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
        buy_fire_aura()
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

rule "SHOP - - - Skip Talents & Exit Shop":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.replace_replacing_or_cancelled[1] == false
    @Condition eventPlayer.replace_replacing_or_cancelled[0] == false
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition (eventPlayer.browsing_shop == true and eventPlayer.replace_replacing_or_cancelled[1] == false and eventPlayer.replace_replacing_or_cancelled[0] == false) == true
    
    wait(0.75, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_hearthstone[1] = true
    using_one_of_the_hearthstones()


rule "SHOP - - - Canceled Skip Talent & Exit Shop or Skip Showdown":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.is_using_hearthstone[1] == true
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == false
    
    stopped_using_hearthstone()
def leave_shop_messages():
    @Name "SHOP - - - [SUBROUTINE] Exit Shop Messages"
        
    eventPlayer.random_integer_between_0_to_5 = random.randint(0, 5)
    createInWorldText(eventPlayer, "{0}".format(leave_shop_messages[eventPlayer.random_integer_between_0_to_5]), updateEveryTick(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((0 - 1) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 *eventPlayer.getFacingDirection()))), 1.75, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.ORANGE, SpecVisibility.DEFAULT)
    eventPlayer.player_temp_effects[43] = getLastCreatedText()
    wait(5)
    destroyInWorldText(eventPlayer.player_temp_effects[43])