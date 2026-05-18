label cabinoutside:
    show bg cabin
    window hide
    call screen cabin

screen cabin:
    imagebutton:
        auto "images/image_buttons/cabin_door_%s.png" xpos 1010 ypos 400
        action Jump("cabininterior")    
    imagebutton:
        auto "images/image_buttons/cabin_side_%s.png" xpos 1557
        action Jump("cabinside")
    imagebutton:
        auto "images/image_buttons/cabin_forest_%s.png" xpos 63 ypos 621
        action Jump("forest") 

label cabininterior:
    show bg cabininside

    call screen cabinslender

screen cabinslender:
    imagebutton:
        auto "images/image_buttons/cabin_inside_slender_%s.png" xpos 855 ypos 298
        action Jump("slender")
    imagebutton:
        auto "images/image_buttons/cabin_inside_%s.png" xpos 63 ypos 621
        action Jump("cabinoutside")

screen cabinsideaooni:
    imagebutton:
        auto "images/image_buttons/cabin_inside_slender_%s.png" xpos 855 ypos 298
        action Jump("slender")
    imagebutton:
        auto "images/image_buttons/cabin_inside_%s.png" xpos 63 ypos 621
        action Jump("cabinoutside")

label cabinside:
    show bg cabinside

label forest:
    show bg forest

label slender:
    show bg cabininside
    if slenderpoints == 0:
        show slenderman happy
        s "Oh? You have returned to me."
        s "Perhaps you had a change of heart about me? I noticed you had given a certain unsavory comment prior within the cabin."
        s "Have you come to issue an apology?"
        menu:
            "Yes":
                s "Thank goodness."
                s "Do not worry, I would've forgiven you whether you came or not"
            "No":
                show slenderman agitated
                s "You expect me to believe you came all the way here just so that you could tell me you don't owe an apology?"
        $ slenderpoints += 1
    elif slenderpoints == 1:
        show slenderman agitated
        s "We meet again."
        s "I do admit when I first found you, I had found you quite peculiar."
        s "What made you enter this forest?"
        menu:
            "Maybe I wanted to meet people like you?":
                s "Oh?"
                s "Why, thank you."
                s "I admit, I do not receive many compliments while within these woods. Moreso given my physical appearance."
                s "It... warms my heart."
            "I just got lost":
                show slenderman laughs
                "{b}She laughs slightly.{b}"
                s "I was not aware of you being a funny human."
                s "How foolish is it to simply lose yourself here."
                s "Do you not have technological devices to help you navigate? No maps either?"
            "I crashed my car in the woods was was looking for help":
                s "The nearest road from here is a straight line, how could you have possibly crashed?"
                s "Are you a drunk perhaps?"
                s "I wouldn't mind that. We could drink together."
                "How would she... nevermind"
        s "It was nice conversing with you but it seems that I will have to go again"
        s "See you soon."
        $ slenderpoints += 1
    elif slenderpoints == 2:
        show slenderman

        $ slenderpoints += 1
    elif slenderpoints == 3:
        show slenderman
        
        $ slenderpoints += 1

label mothman:
    if mothpoints == 0:

        $ mothpoints += 1
    elif mothpoints == 1:

        $ mothpoints += 1
    elif mothpoints == 2:

        $ mothpoints += 1
    elif mothpoints == 3:

        $ mothpoints += 1
        
label scp:
    if doctorpoints == 0:

        $ doctorpoints += 1
    elif doctorpoints == 1:

        $ doctorpoints += 1
    elif doctorpoints == 2:

        $ doctorpoints += 1
    elif doctorpoints == 3:

        $ doctorpoints += 1
        
label aooni:
    if demonpoints == 0:

        $ demonpoints += 1
    elif demonpoints == 1:

        $ demonpoints += 1
    elif demonpoints == 2:

        $ demonpoints += 1
    elif demonpoints == 3:

        $ demonpoints += 1
        

