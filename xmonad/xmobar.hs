-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- Modified by Ben Thompson
-- http://github.com/vicfryzel/xmonad-config
Config { font = "xft:Source Code Pro Semibold:size=9:antialias=true"
       , bgColor = "black"
       , fgColor = "grey"
       , position = TopW L 90
       , lowerOnStart =     False    -- send to bottom of window stack on start
       , hideOnStart =      False    -- start with window unmapped (hidden)
       , allDesktops =      True     -- show on all desktops
       , overrideRedirect = False    -- set the Override Redirect flag (Xlib)
       , pickBroadest =     False    -- choose widest display (multi-monitor)
       , persistent =       True     -- enable/disable hiding (True = disabled)
       , commands = [ Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 50
                    , Run Memory ["-t","Mem: <usedratio>%"] 50
                    , Run Swap [] 50
                    , Run Date "%a %b %_d %l:%M" "date" 50
                    , Run StdinReader
                    -- battery monitor
                    , Run Battery        [ "--template" , "Batt: <acstatus>"
                                         , "--Low"      , "10"        -- units: %
                                         , "--High"     , "80"        -- units: %
                                         , "--low"      , "darkred"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkgreen"

                                         , "--" -- battery specific options
                                                   -- discharging status
                                                   , "-o"	, "<left>% (<timeleft>)"
                                                   -- AC "on" status
                                                   , "-O"	, "<fc=#dAA520>Charging</fc>"
                                                   -- charged status
                                                   , "-i"	, "<fc=#006000>Charged</fc>"
                                         ] 50
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %battery% | %cpu% | %memory% * %swap%    <fc=#ee9a00>%date%</fc> |"
       }
