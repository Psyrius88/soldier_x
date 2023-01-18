#Global variables

globalvar map_is_changing = false
globalvar vote_to_change_map_duration
globalvar showdown_duration

#Player variables

playervar color_chaser

rule "ENDLESS MODE - - - Player Left The Match":
    @Event playerLeft
    @Condition endless_mode == true
    
    if someone_is_voting_to_change_map == true:
        players_that_voted_yes = [player for player in players_that_voted_yes if player.getCurrentHero() == Hero.SOLDIER]
        players_that_voted_no = [player for player in players_that_voted_no if player.getCurrentHero() == Hero.SOLDIER]
        if player_who_started_vote.getCurrentHero() != Hero.SOLDIER:
            player_who_started_vote = null
        wait()


rule "ENDLESS MODE - - - Can Vote & Can Start Vote":
    @Event eachPlayer
    @Hero soldier
    @Condition endless_mode == true
    @Condition eventPlayer.amount_of_talents_purchased >= 5
    
    #Can vote
    eventPlayer.canVote_hasVoted_canStartVote[0] = true
    wait(5)
    smallMessage(eventPlayer, "{0} You now got the right to vote!".format(iconString(Icon.STOP)))
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    waitUntil(eventPlayer.time_since_joined_match >= 900, 99999)
    smallMessage(eventPlayer, "{0} You can now call for a vote!".format(iconString(Icon.STOP)))
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    eventPlayer.canVote_hasVoted_canStartVote[2] = true
    hudSubheader(eventPlayer if endless_mode == true and eventPlayer.browsing_shop == true and eventPlayer.canVote_hasVoted_canStartVote[2] == true and match_is_in_showdown == false and someone_is_voting_to_change_map == false else null, "[Start a showdown & change map? Hold {0}]".format(buttonString(Button.JUMP)), HudPosition.TOP, 3, rgba(255, eventPlayer.color_chaser, 0, 127.5 + eventPlayer.color_chaser), HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.player_temp_effects[3] = getLastCreatedText()


rule "ENDLESS MODE - - - [GLOBAL] Someone Is Voting To Change Map":
    @Condition endless_mode == true
    @Condition someone_is_voting_to_change_map == true
    @Condition map_is_changing == false
    @Condition (player_who_started_vote.getCurrentHero() == Hero.SOLDIER and player_who_started_vote.browsing_shop == false) == true
    @Condition vote_to_change_map_duration == null
    
    vote_to_change_map_duration = 180
    bigMessage(getAllPlayers(), "{0} wants to start a showdown & change map!".format(player_who_started_vote))
    waitUntil(len(players_that_voted_yes) > ((len([player for player in getAllPlayers() if player.getCurrentHero() == Hero.SOLDIER and player.canVote_hasVoted_canStartVote[0] == true])) * 0.5) or len(players_that_voted_no) >= ((len([player for player in getAllPlayers() if player.getCurrentHero() == Hero.SOLDIER and player.canVote_hasVoted_canStartVote[0] == true])) * 0.5) or len(players_that_voted_yes) + len(players_that_voted_no) - (len([player for player in getAllPlayers() if player.canVote_hasVoted_canStartVote[0] == true])) == 0 or players_that_voted_yes == [], 180)
    if players_that_voted_yes == [] or len(players_that_voted_yes) + len(players_that_voted_no) - (len([player for player in getAllPlayers() if player.canVote_hasVoted_canStartVote[0] == true])) == 0 == true or len(players_that_voted_no) >= ((len([player for player in getAllPlayers() if player.getCurrentHero() == Hero.SOLDIER and player.canVote_hasVoted_canStartVote[0] == true])) * 0.5):
        someone_is_voting_to_change_map = false
        bigMessage(getAllPlayers(), "Vote Failed!")
        players_that_voted_yes = []
        players_that_voted_no = []
        vote_to_change_map_duration = null
        player_who_started_vote = null
        return
    if len(players_that_voted_yes) > ((len([player for player in getAllPlayers() if player.getCurrentHero() == Hero.SOLDIER and player.canVote_hasVoted_canStartVote[0] == true])) * 0.5):
        vote_to_change_map_duration = null
        map_is_changing = true
        bigMessage(getAllPlayers(), "Vote Passed!")
        wait(5)
        bigMessage(getAllPlayers(), "Everyone's score will be reset!")
        wait(5)
        bigMessage(getAllPlayers(), "The player with the most score after 3 minutes wins!")
        match_is_in_showdown = true
        wait(0.25)
        setSlowMotion(10)
        someone_is_voting_to_change_map = false
        wait(0.75)
        players_that_voted_yes = []
        players_that_voted_no = []
        setSlowMotion(100)
        bigMessage(getAllPlayers(), "Fight!")
        showdown_duration = 180
        chase(showdown_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        setMatchTime(180)
        #Cancel Showdown?
        waitUntil(len(players_that_voted_yes) > ((len([player for player in getAllPlayers() if player.getCurrentHero() == Hero.SOLDIER])) * 0.5) or showdown_duration == 0, 180)
        if getMatchTime() < 3:
            return
        if len(players_that_voted_yes) > ((len([player for player in getAllPlayers() if player.getCurrentHero() == Hero.SOLDIER])) * 0.5):
            bigMessage(getAllPlayers(), "Showdown Skipped! Changing map...")
            wait(0.5)
            setSlowMotion(10)
            wait(0.5)
            map_is_changing = true
            restartMatch()


rule "ENDLESS MODE - - - [EACH PLAYER] Someone Is Voting To Change Map":
    @Event eachPlayer
    @Hero soldier
    @Condition endless_mode == true
    @Condition someone_is_voting_to_change_map == true
    @Condition map_is_changing == false
    @Condition (player_who_started_vote.getCurrentHero() == Hero.SOLDIER and player_who_started_vote.browsing_shop == false) == true
    
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    eventPlayer.can_enter_shop = true
    waitUntil(someone_is_voting_to_change_map == false or map_is_changing == true, 99999)
    if eventPlayer.experience_current < eventPlayer.experience_max:
        eventPlayer.can_enter_shop = false
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
    if map_is_changing == true:
        waitUntil(match_is_in_showdown == true, 99999)
        wait(0.25)
        if eventPlayer.browsing_shop == false:
            eventPlayer.respawn()
        wait(2)
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)
        waitUntil(eventPlayer.browsing_shop == false, 99999)
        if match_is_in_showdown == true:
            eventPlayer.setScore(0)


rule "ENDLESS MODE - - - Waiting For Players To Vote":
    @Event eachPlayer
    @Hero soldier
    @Condition endless_mode == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.canVote_hasVoted_canStartVote[0] == true
    @Condition (someone_is_voting_to_change_map == true or match_is_in_showdown == true) == true
    @Condition (someone_is_voting_to_change_map == true and player_who_started_vote.getCurrentHero() == Hero.SOLDIER and player_who_started_vote.browsing_shop == false and player_who_started_vote != eventPlayer or match_is_in_showdown == true) == true
    
    eventPlayer.canVote_hasVoted_canStartVote[1] = false
    waitUntil((someone_is_voting_to_change_map == false or map_is_changing == true) == true, 99999)
    if someone_is_voting_to_change_map == false:
        eventPlayer.canVote_hasVoted_canStartVote[1] = true
        return
    if map_is_changing == true:
        eventPlayer.canVote_hasVoted_canStartVote[1] = false


rule "ENDLESS MODE - - - Start Showdown?":
    @Event eachPlayer
    @Hero soldier
    @Condition endless_mode == true
    @Condition eventPlayer.canVote_hasVoted_canStartVote[2] == true
    @Condition eventPlayer.canVote_hasVoted_canStartVote[1] == false
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.replace_replacing_or_cancelled[0] == false
    @Condition eventPlayer.replace_replacing_or_cancelled[1] == false
    @Condition map_is_changing == false
    @Condition someone_is_voting_to_change_map == false
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition match_is_in_showdown == false
    
    wait(0.75, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_hearthstone[1] = true
    using_one_of_the_hearthstones()


rule "ENDLESS MODE - - - Player Dealt Final Bl0w":
    @Event playerDealtFinalBlow
    @Condition endless_mode == true
    
    eventPlayer.addToScore(-1 * 1 * 1 * 1)


rule "ENDLESS MODE - - - Canceled Start Showdown & Change Map":
    @Event eachPlayer
    @Hero soldier
    @Condition endless_mode == true
    @Condition eventPlayer.is_using_hearthstone[1] == true
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == false
    
    stopped_using_hearthstone()


rule "ENDLESS MODE - - - End Showdown & Change Map":
    @Event eachPlayer
    @Hero soldier
    @Condition match_is_in_showdown == true
    @Condition eventPlayer.browsing_shop == false
    @Condition eventPlayer.canVote_hasVoted_canStartVote[1] == false
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    
    wait(0.75, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_using_hearthstone[2] = true
    using_one_of_the_hearthstones()


rule "ENDLESS MODE - - - Vote Yes":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    if endless_mode == true and map_is_changing == false and someone_is_voting_to_change_map == true and eventPlayer.canVote_hasVoted_canStartVote[1] == false and eventPlayer.canVote_hasVoted_canStartVote[0] == true or eventPlayer.replace_replacing_or_cancelled[0] == true == true:
        wait(0.125, Wait.ABORT_WHEN_FALSE)
        eventPlayer.is_using_hearthstone[3] = true
        using_one_of_the_hearthstones()


rule "ENDLESS MODE - - - Vote No":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition eventPlayer.using_one_of_the_hearthstones == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    
    if endless_mode == true and map_is_changing == false and someone_is_voting_to_change_map == true and eventPlayer.canVote_hasVoted_canStartVote[1] == false and eventPlayer.canVote_hasVoted_canStartVote[0] == true or eventPlayer.replace_replacing_or_cancelled[0] == true == true:
        wait(0.125, Wait.ABORT_WHEN_FALSE)
        eventPlayer.is_using_hearthstone[4] = true
        using_one_of_the_hearthstones()


rule "ENDLESS MODE - - - Canceled Yes / No":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.browsing_shop == true
    @Condition (eventPlayer.is_using_hearthstone[3] == true or eventPlayer.is_using_hearthstone[4] == true) == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    stopped_using_hearthstone()