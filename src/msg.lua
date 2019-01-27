M = {
    silence = "[Awkward silence]",

    -- Speaking with Dana
    not_really = "Not really",
    i_dont_think_so = 'I don\'t think so',
    i_dont_know_anyone = 'I don\'t know anyone',
    i_want_to_stay = 'I want to just stay here',
    maybe_youll_make_a_friend = 'Maybe you\'ll make a friend..',
    q_it_might_be_fun = 'Are you sure? It could be fun!',
    q_looking_forward_to_party = 'Looking forward to the party?',
    groan = '[Groan]',
    fine = 'Fine',
    your_right = 'You\'re right',

    -- Possible knowledge
    hi_finally_meet_you = "Hi, so nice to finally meet you.",
    nice_to_meet_you_too = "Nice to meet you too!",
    erm_hello_do_you_speak = "Erm, hello? Do you speak?",
    fine_suit_yourself = "Fine, suit yourself",
    oh_so_you_do_speak = "Oh, so you do speak!",
    for_goodness_sake = "For goodness sake, you're infuriating",
    yes_surprised = "Why yes! Are you surprised?",
    good_day = "Good day",
}

local msg = {}

local conversation_killers = {
    [M.groan] = true,
    [M.fine] = true,
    [M.your_right] = true,
    [M.fine_suit_yourself] = true,
    [M.for_goodness_sake] = true,
}

msg.ends_conversation = function(m)
    return conversation_killers[m] ~= nil
end

return msg