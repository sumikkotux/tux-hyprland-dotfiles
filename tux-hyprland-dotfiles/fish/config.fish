if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt
    # 第一層：時間、用戶、主機，同 Hyprland emoji
    set_color brpurple
    echo -n "󰈸 "(date "+%H:%M")" "
    set_color magenta
    echo -n " "(whoami)"@"(hostname)
    if ping -c 1 google.com > /dev/null
        set net "📶 Online"
    else
        set net "❌ Offline"
    end

    echo -n "$net"
    echo ""

    # 第二層：目前路徑，加箭咀提示
    set moods "😎" "🤓" "😴" "🤖" "🧠" "💜" "🌌" "🔥"
    set mood (random choice $moods)

    echo -n "$mood Mood of the Day"
    set_color purple
    echo -n "󰍛 "(prompt_pwd)
    set_color brpurple
    echo -n " ➤ "
end

fastfetch
