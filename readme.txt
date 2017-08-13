FF4 Yaith Mode
==============

About
-----
Yaith Mode is a randomizer of sorts for FF2US version 1.1 that makes the game
into an open world where you can do the events in any order. Doing the game's
events in a strange order can have side effects to your party composition,
inventory, etc. It also randomizes the contents of chests, as well as what
events give you what plot items. For example, the King of Baron might give you
the SandRuby or Luca Key or Adamant or any number of other plot items rather
than the Package.

You start the game with the Enterprise parked outside Baron with the hook
enabled. The Serpent Road in Baron has been modified to take you to the final
battle with Zeromus; this way you can skip straight to the final battle
whenever you feel you're prepared enough to take it on, much like Chrono
Trigger's "Lavos Bucket".


Usage
-----
You can double click "yaith.exe" from Windows, or you can type "yaith" on the
command line to run the program. It will ask you for a filename:

  Enter ROM file name: _
  
From here, type the filename, including extension (".smc" for example) of the
ROM you wish to randomize. If it is not in the same folder as yaith.exe,
include the path. Hit enter when you're done.

Next, it will ask you if you wish to enter a seed value:

  Enter seed (leave blank for random seed): _

The purpose of this is so that the same randomization can be duplicated
multiple times or be shared with multiple people if desired. If you don't care
and just want it to be completely random, simply hit enter at this prompt;
otherwise, you can type the seed number and hit enter.

If you get any other messages, then something went wrong. Otherwise, the
program will simply terminate and you will find a new file in the same folder
as the original file whose name is the same as the original ROM file except it
has a number in brackets after it. This number is the seed value for
duplicating that ROM. The output ROM is the randomized version which you can
now enjoy.


WTF Does "Yaith" Mean?
----------------------
Back in the olden days before ROM hacking was a thing in the way it is now, we
used to use Game Genie codes to mess with our SNES games. We used BBSes and the
new-fangled "internet" to share interesting codes to try.

I was going through one such list and found a code that was simply labelled
"Yaith Code", and when I tried it out, I found that when I loaded my save file,
it had reset all the plot flags. I still had my airships though, so the end
result was essentially a somewhat buggy open world where I could, say, dismiss
Kain by doing the Mist events, dismiss Rosa by going to Fabul, pick up the
twins by going to Mysidia, then taking them to the moon with the Lunar Whale.
It was very exciting for the time.

Fast-forward to today when the idea for this randomizer was being pitched, I
was strongly reminded of the effect of this "Yaith Code", so I named it after
that. I have no idea if Yaith is a word in some language or if it is a
reference to someone's name or username or what; its only meaning I know of is
in relation to this open-world-no-flags-set Game Genie code.


Acknowledgements
----------------
Pinkpuff: Programming, readme
RiversMcCown: Original concept, beta testing
Myself086: ASM patching
