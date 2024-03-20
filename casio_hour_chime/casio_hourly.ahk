#Persistent
sound = %A_WorkingDir%\casio_hour_chime.mp3
Play:
SoundPlay, % now ? sound : ""
now := 2020010100 SubStr(A_Now, 11), sec := 2020010101
sec -= now, S
SetTimer, Play, % -1000 * sec
Return