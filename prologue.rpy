label prologue_main:

    $ s = Character("???", color = "#000000")
    $ slenderpoints = 0
    $ mothpoints = 0
    $ doctorpoints = 0
    $ demonpoints = 0

    scene bg car:
    show carrighthand
    show carlefthand

    play music car

    "{b}I flutter my eyelids open as I tilt my head up to look at the road.{/b}"
    "I started falling asleep over the wheel again."
    "It's getting so late, and I need to get home."
    "Hmm? A message from mom?"

    hide carrighthand
    show phone
    window hide
    pause
    window show

    "\"Where are you? Come home as soon as possible. It's getting dark.\""

    hide phone
    show carrighthand

    "Crap. I need to hurry."
    "I can't even think straight. Where am I even going?"
    "Did I forget where to go? What else did I forget?"

    $ mcname = renpy.input("My name is... ", "Simon", exclude='{0123456789+=,.?!<>}', length=15)
    $ mc = Character(mcname.strip(), color = "#2f3be2ff")

    "My name is [mc], and I'm... 22 years old, 5'7\"."
    "Ok, this is stupid. I don't have dementia. I'm just tired."
    "So much for hanging out with friends, I'm in the middle of nowhere now."
    "Why did they have to live so far away?"
    "{b}Sigh{/b}"
    "Fuck, my eyes are getting heavy."
    "{b}I feel my hands weaken and lose their grip on the steering wheel.{/b}"
    "Stay awake. Stay awake... Stay-"

    stop music
    play sound carcrash
    scene black

    window hide
    pause
    window show
    
    mc "Ugh."

    "{b}I open the door as I exit my crashed car.{/b}"

    play music crickets
    play sound cardoorslam 
    scene bg crash:

    mc "Fuck, fuck, FUCK."

    show phone
    window hide
    pause
    window show
    hide phone
    play sound phoneringing

    "Mom, please, pick up, please. Pick up."
    "Of course, there's no fucking signal. What do I do now?"
    "Stupid, stupid, stupid. All I had to do was to just keep my eyes open."
    "{b}In my frustration I would pace back and forth.{/b}"
    "What do I do now?"
    "{b}As I turn I notice in the corner of my eye something out of the ordinary between the trunks of a few trees.{/b}"
    "Hmm? What's this?"

    scene bg forest:
        ypos 0

    "There's a path? Maybe someone lives here."

    "{b}I begin to walk down the path, occasionally stumbling over some rocks.{/b}" 
    "Nobody's been on this path in a long time..." 
    "I guess I was wrong. Nobody lives here." 
    "This path starts winding to a close... But it looks like there's something on the tree over there." 
    "A page?" 

    scene bg tree

    window hide
    pause
    window show

    "\"Ignorance is bliss, don't look at the trees.\""
    "What's wrong with the trees for someone to write this?"
    "This can only be some sick joke. I see no other reason why someone would put this here."    
    "I should get going..."

    scene bg forestslender:
        truecenter zoom 0.8
        ypos 350

    "{b}I began walking again and felt uneasy from reading that loose notebook page.{/b}"
    "{b}I tried not to look but thought I heard rustling.{/b}"
    "{b}I didn't know if I had imagined it.{/b}"
    "No, there is nothing there. There can't be. Why am I following the orders of some random poster and looking down?"
    "{b}I finally decided to look up from the floor and look around to relieve my paranoia.{/b}"

    play music forest
    scene bg forestslender:
        truecenter zoom 0.75
        ypos 500

    "{b}For a moment, I thought I had lost my mind. I could see something in the distance.{/b}"
    "{b}Some humanoid shape was seen hiding behind the trees.{/b}"
    "{b}I stop walking and blink a few times. My breath is now audible.{/b}"

    scene bg forestslender:
        truecenter zoom 0.8
        ypos 350
    "{b}I looked to the floor as I felt lightheaded from dread, holding my head.{/b}"
    "What's happening to me?"
    "{b}My footsteps slow as I can still see something in my peripheral vision.{/b}"
    "{b}In my mind I kept trying to convince myself that there wasn't anything there.{/b}"
    "{b}It was to no avail.{/b}"
    "{b}I turned around, feeling this overwhelming urge to bolt out as soon as possible.{/b}"
    scene bg path
    "I feel like a child, scared of the dark. I feel so pathetic."
    "{b}Something appears in and out of the corner of my eye.{/b}"
    "{b}Despite common sense, I am absolutely sure something is there.{/b}"
    "{b}The feeling of dread and doom worsens.{/b}"
    play sound running
    scene bg path with vpunch:
        truecenter zoom 1.2
    "{b}I start running.{/b}"
    "{b}But it didn't matter how fast I ran, the feeling of eyes placed on me didn't go away.{/b}"
    "{b}No other thought is in my mind other than to get the fuck out of this forest.{/b}"
    "{b}I checked my back, still running forward.{/b}"
    scene bg forest:
        ypos 0
    "{b}There's nothing there.{/b}"
    "No, It can't be."
    "I can swear I can hear something."
    scene bg path:
        truecenter zoom 1.2
    "I am not crazy." 
    scene bg path:
        truecenter zoom 1.5
    "I. Am. Not. Crazy."

    scene black
    play sound bodyimpact
    stop music

    "{b}I get knocked backward, blinking a little from the impact before looking back up.{/b}"
    "{b}I could've sworn nothing was in front of me before.{/b}"
    "{b}It was like a tree had spontaneously appeared to block my path.{/b}"

    scene bg path
    play sound impact
    show slenderman stand t at center
    window hide
    pause
    window show

    mc "AH!"
    "{b}I stand back a bit in shock, like a deer in headlights. I couldn't believe what I saw before me.{/b}"

    show slenderman laugh t

    s "Ha! If only you beheld your face! A very frightened expression."
    "..."
    show slenderman happy
    s "Apologies. I jest with you."
    "What is happening right now?"

    "{b}A large, pale, faceless creature towered over me.{/b}"
    "{b}It's wearing a suit and tie and speaking way too formally like it's trying to blend in with humanity.{/b}"

    play music quietmountain

    s "I would have killed you but now observing you closely you look quite lovely, so I have refrained from killing you."
    "What?!?"
    s "Oh, I almost forgot to introduce myself."
    s "I have been referred to by many names by your people. \"Der Großmann\", \"The Operator\", or most well known..."
    show slenderman stand
    s "\"The Slender Man\""
    s "Although I must admit it is quite humorous for you humans to be mistaking for a man, so I must ask."
    s "What name would you like to refer to me by?"

    label slendername:
        menu:
            "Slender Man": 
                $ s = Character("Slender Man", color="#00000080")
                s "I suppose that name should reduce confusion considering other humans call me that too."

            "Slender Woman":
                $ s = Character("Slender Woman", color="#00000080")
                s "If you insist, that is now my name."

    mc "Nice to meet you..."
    show slenderman happy
    s "Your name?"
    mc "[mc]."

    show slenderman stand
    s "Hello [mc], welcome to my forest."
    s "Would you like a tour?"

    label choicetour:
        menu:
            "Alright...?":
                s "Excellent, come with me."
                s "I expected you to put up more resistance."
                mc "I don't really have a choice."
                s "Oh you dislike me so soon?"
                mc "I didn't mean it like that."
            "I need to get going":
                show slenderman agitated
                s "No, that simply will not do, you will come with me."
                mc "But-"
                hide slenderman
                "{b}Before I can finish my sentence she keeps walks ahead, leaving me in the dust.{/b}"
                "{b}I had to run to catch up to her due to her long spindely legs. I was following reluctantly.{/b}"
                s "Follow. {b}Giggle{/b}"
                "That sounded strangely like a child's. It was contrary to her sultry voice before and sounded like a different person."
    $ persistent.notscary = True
    $ renpy.persistent.save()
    return