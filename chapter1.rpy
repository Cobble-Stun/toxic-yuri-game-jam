label tour:
    $ m = Character("???", color = "#000000")
    #Background
    scene bg forest3
    mc "Where are we going?"
    s "To introduce you to my friends."
    "Her friends? Great, more monsters."
    mc "Uh, what are they like?"
    s "Well, there is a giant animal, a plague doctor, a ghost, another one is a demon if memory serves me correct. But there are more."
    "I am going to die here aren't I?"
    s "Your face is grimacing, are you worried about something?"
    mc "..."
    s "Though they are eccentric, I believe they shouldn't do too much harm to you if you stay by my side."
    "I can't tell if her words put me at ease."
    "{b}In the distance, I see a blocky silhouette growing as we reer closer.{/b}"
    "It looks like a house."
    s "Yes. We had discovered it in the forest and the lights had always remained off. No one bothered to return."
    s "We assumed that the cabin was abandoned so we decided to make it our new home."
    "{b}As we approach, I notice the cabin is larger than I expected.{/b}"
    scene bg cabin
    show slenderman happy at center
    s "We have arrived."
    show slenderman happy at left
    mc "Woah."
    s "Not much of a sight to be awestruk over."
    stop music fadeout 2.0
    play sound flap
    mc "What is that sound?"
    "{b}I begin looking around, looking for the source of the flapping sound.{/b}"
    #scene cabin side
    show mothman flyhide at right with moveintop:
        yoffset 700
        zoom 0.8
    play music mothman
    "What the hell?"
    show mothman standhide at right:
        yoffset 0
        zoom 0.8
    m "Hey Slendy!"
    m "Hmm? Who's with you?"
    #show mothman smug (eyes are squinted)
    extend " He looks tasty~ haha."
    mc "!!!"
    s "Ah, his name is [mc]. I found him wandering the forest alone. I toyed around with him before he ran into my chest."
    show mothman wingcurledhide
    m "Aww, a little ankle biter ain't he?"
    "{b}She bends downward towards me .{/b}"
    "I am now surrounded by two giant monsters that tower over me compared to my androgenous height. I can't help but feel a bit insecure over this."
    s "As well as me, I believe your people recognize her too [mc]."
    mc "Oh are you... "
    extend "Moth Man?"
    "{b}She laughs awkwardly.{/b}"
    m "I guess you could call me that..."
    "I'm getting the feeling that she's a bit sad over being called Moth Man somehow."
    mc "Oh, would you like to be called soemthing else?"
    m "No no, that is me. But because most people call me \"Moth Man\", it feels weird."
    "{b}I gave her a slightly confused look.{/b}"
    show slenderman agitated
    s "The sightings of her at point pleasant, mawnan, and other places have caused humans to refer to her as \"Moth Man\" or \"Owl Man\"."
    s "They had misinterpreted her dark complection and wings to that of a giant moth or giant owl."
    show slenderman happy
    mc "Oh I see."
    m "There isn't a word or name really to call me by since I am a one-of-a-kind creature, so I guess either name is fine."
    m "What would you like to call me by?"

    label mothname:
        menu:
            "Moth Man": 
                $ m = Character("Moth Man", color="#c90000")
                m "Alright, sticking with your gut from before I see."

            "Owl Man":
                $ m = Character("Owl Man", color="#c90000")
                m "Hmm, I guess I do look a bit more birdlike. Seems more accurate."

            "Moth Woman":
                $ m = Character("Moth Woman", color="#c90000")
                m "Haha, very funny. I guess it makes sense considering my gender, but I let people call me by a name with male vocabulary to reduce confusion."
                m "But sticking with your gut with the \"Moth\" part I see."

            "Owl Woman":
                $ m = Character("Owl Woman", color="#c90000")
                m "Haha, very funny. I guess it makes sense considering my gender, but I let people call me by a name with male vocabulary to reduce confusion."
                m "I guess calling me by that would be more accurate since I have birdlike features."
                
    show mothman wingcurledshow
    m "Thanks for clearing up what I should be called. My friends usually call me whatever and switch it up sometimes, it gets pretty chaotic."
    m "If they can't stick with a name to call me they are kind of bad friends if you ask me."
    show slenderman agitated
    s "Ahem, let me introduce you to everyone else."
    hide mothman

label cabinintroductions:
    $ o = Character("???", color = "#000000")
    $ a = Character("???", color = "#000000")
    show bg cabininside
    "{b}The interior of the cabin enveloped me in warmth and light. There seems to be a fireplace close to the door.{/b}"
    "{b}I notice two others within my view. They both seem taller than me... not again...{/b}"
    play music scp049
    show scp idle at right
    show slenderman happy at left
    o "Greetings."
    "Is that the plague doctor she was talking about?"
    o "Oh dear, it seems I sense the disease in you."
    mc "Uhh, what?."
    show scp glove
    o "Do not worry, I am the cure."
    show slenderman afraid
    s "!!!"
    "{b}As the plague doctor reaches towards me, [s] pulls me and tucks me under one of her tentacles.{/b}"
    show slenderman agitated t
    s "Now now, I do not believe we have been properly introduced. This is [mc]. I discovered him wandering the woods and had a little jest with them."
    s "[mc], this is SCP-049... a plague doctor."
    "{b}I turn towards [s].{/b}"
    mc "What disease does she mean?"
    "{b}She looks down at me. Despite the fact she does not have a face, I can tell she's making an expression that is telling me \"don't\".{/b}"
    label choiceinquiry:
        menu:
            "Seriously, what disease?":
                show scp idle
                "{b}You feel [s] glare at you worriedly.{/b}"
                o "The great pestillence, the plague, the great death?"
                o "Is that name unfamilar upon your ears?"
                o "It matters not, I can cure you neverthelater."

            "(Stay silent)":
                show scp idle
                s "..."
                o "I sense a great illness that has befallen you."
                o "Fret not, for I am the cure."
    s "Excuse us for one moment."
    hide scp
    show slenderman stand at center
    "{b}[s] pulls me to the side to a nearby room.{/b}"
    #Cabin room background
    "{b}She places an arm on my shoulder and inhales despite not having a mouth.{/b}"
    s "That was SCP-049, she has a tendency to believe humans have some sort of disease."
    $ o = Character("SCP-049", color = "#694545")
    s "Don't let that fool you however, by \"curing\" she means operating on you and turning you into a mindless husk of your former self. A Zombie."
    s "It seems the only way she wil not try to cure you is if she believes you are a physician."
    mc "I see."
    s "I shall tell her you are a doctor as a lie. I hope you understand."
    s "So be wary of her, and don't let her touch you, she can kill on contact if she wills it."
    label choicedoubt:
        menu:
            "I thought you said I was safe?":
                $ config.rollback_enabled = False
                $ renpy.block_rollback()
                $ config.rollback_enabled = True
                s "You are. They are my friends and I shall speak with her to not harm you."

            "Thanks for the information.":
                $ config.rollback_enabled = False
                $ slenderpoints += 1
                $ renpy.block_rollback()
                $ config.rollback_enabled = True
                s "My pleasure. I'll inform her not to harm you. "

            "You have some strange friends.":
                $ config.rollback_enabled = False
                $ renpy.block_rollback()
                $ config.rollback_enabled = True
                s "I suppose you are correct...  but I shall speak with her to not harm you."

    s "Let us return to her now."
    #background back to living room.
    show slenderman happy at left
    show scp idle at right
    "{b}We emerge back to the room with the plague doctor.{/b}"
    show scp explain
    o "What happened?"
    show scp idle
    s "Apologies, I was only... checking on him."
    o "Ah, I see."
    s "It seems that you won't be as lonely now. This fellow I have found in the woods so happens to be a doctor."
    "{b}The plague doctor tilts her head to the side as if she's slightly suspicious.{/b}"
    o "Hmm."
    extend " I did want company in all this time."
    hide scp
    "{b}She walks off into another room.{/b}"
    "{b}I don't know if she was convinced of our explanation.{/b}"
    s "... Apologies."
    "{b}I notice the other large figure walk over to us as SCP-049 leaves the living room.{/b}"
    play music aooni
    show aooni stand at right
    a "Hey."
    "Purple..."
    extend " And tall too..."
    "She's even taller than [s] somehow."
    s "Salutations, this is [mc]."
    s "[mc], I believe you humans have chosen to call her \"Ao Oni\"."
    "Isn't that japanese?"
    $ a = Character("Ao Oni", color = "#862aff")
    show slenderman agitated
    s "She's an oni that had lived in a mansion."
    "That doesn't explain why she's purple though..."
    mc "Wow, you must be rich to live in that kind of building."
    show aooni angle
    a "Not particularly."
    "Very surprising."
    "{b}She eyes up and down in a critical kind of way.{b}"
    "Why is she looking at me like that? Am I dirty?"
    "{b}I check my body to see what she could've possibly been looking at.{b}"
    a "I'd think you'd look better a lot taller."
    "{b}My head jolts back up to look at her.{b}"
    "Oh this bi-"
    a "As in, the same height as me. And purple too."
    "Huh?"
    "{b}[s] tilts her head sideways.{b}"
    "Judging by her response to SCP-049 before, I can probably guess why she's fidgety with this one too."
    s "You should get those urges under control."
    a "Ah. Sorry."
    a "It keeps acting up."
    s "Do you mind if I tell him?"
    a "You can tell him"
    s "Well then. there was a sort of incident in the mansion she now resides within."
    s "She had once been human dared along with a few other friends to explore said mansion."
    s "She had been killed by a creature that shared the same appearnce as her now, though bald."
    s "The creature had transformed her appearance post mortem. She grew in height, and her skin changed in color."
    s "I assume it carried on certain urges to do the same to other humans."
    "{b}With everything within context, it makes me nervous.{b}"
    a "I'll be seeing you"
    hide aooni
    "{b}She smirks a little before exiting.{b}"
    "..."
    $ persistent.notscary = True
    s "It seems you have now been acquainted with every one here"
    s "I extend my humblest hospitality to you, you can stay here."
    s "If you wish to sleep, there is a room waiting for you. (Not added yet)"
    s "Now I must go, have proxies to attend to."
    mc "Proxies?"
    hide slenderman
    "{b}She leaves before I can respond.{b}"
    "Well, I am tired. I should sleep and decide on what to do tomorrow."
    stop music fadeout 1.0
    show bg cabininside
    with Fade(0.5, 1.0, 0.5)
    "That was a good nap."
    "{b}I step towards the door to leave the cabin.{b}"
    return