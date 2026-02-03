local emoticons_M = {}

emoticons_M.emoticons = {
    "⸜(｡˃ᵕ˂)⸝♡",
    "⸜(｡˃ᵕ˂)⸝💕",
    "(˶ᵔ ᵕ ᵔ˶)",
    "!(•̀ᴗ•́)و ̑̑",
    "SENPAI!!!(#ﾟДﾟ)っ‥･･━━━◆~☆))`ωﾟ)･;’.",
    "(๑>◡ <๑)",
    "(˶˃ ᵕ ˂˶) .ᐟ.ᐟ",
    "(ˊ•͈ ◡ •͈ˋ)",
    "(^▽^)👍",
    "ε(´｡•᎑•`)っ 💕",
    "⚞🎀・◦・⚟"
}

function emoticons_M. get_random_emoticon()
    local emoticon_list = emoticons_M.emoticons
    if #emoticon_list == 0 then
        return nil
    end
    return emoticon_list[math.random(1, #emoticon_list)]
end

return emoticons_M

