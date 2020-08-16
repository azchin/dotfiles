#!/bin/sh
echo -n "\033[1;36m"
cat << "EOF"
               .,-:;//;:=,
           . :H@@@MM@M#H/.,+%;,
        ,/X+ +M@@M@MM%=,-%HMMM@X/,
      -+@MM; $M@@MH+-,;XMMMM@MMMM@+-
     ;@M@@M- XM@X;. -+XXXXXHHH@M@M#@/.
   ,%MM@@MH ,@%=             .---=-=:=,.
   =@#@@@MX.,                -%HX$$%%%:;
  =-./@M@M$                   .;@MMMM@MM:
  X@/ -$MM/                    . +MM@@@M$
 ,@M@H: :@:                    . =X#@@@@-
 ,@@@MMX, .                    /H- ;@M@M=
 .H@@@@M@+,                    %MM+..%#$.
  /MMMM@MMH/.                  XM@MH; =;
   /%+%$XHH@$=              , .H@@@@MX,
    .=--------.           -%H.,@@@@@MX,
    .%MM@@@HHHXX$$$%+- .:$MMX =M@@MM%.
      =XMMM@MM@MM#H;,-+HMM@M+ /MMMX=
        =%@M@M#@$-.=$@MM@@@M; %M%=
          ,:+$+-,/H#MMMMMMM@= =,
                =++%%%%+/:-.
EOF
user=$(echo "$USER" | sed -E "s/.*/\l\0/;s/\b./\u\0/g")
echo "\033[1;33m\n Welcome, ${user}. Shall we resume the testing?\n"
echo -n "\033[0m"
