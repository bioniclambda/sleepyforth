# sleepyforth
A sort of Forth written in Lua

First off, I know how probably sloppy and unoptimized this is. <br/>
I know I probably used a dumb way to do things. <br/>
I just want to get this working <br/>
(Still please contact me if you have a better method. If you have constructive criticism or tips or whatever, email me (or DM me on Discord).) <br/>

Note: While "keywords" technically can't be redefined since they aren't words, something being a word is check before the Forth checks that it's a keyword.
Which means that you can technically redefine keywords. <br/>
Ex: `: if 3 . ;`


Syntax example: <br/>

If: `1 if 3 2 + . end` <br/>
1 is true and 0 is false <br/>

Words: `: bob 3 2 + . ;` <br/>
You can call a word by typing it's name, no parthenses. <br/>
Yes you can redefine words. <br/>

Everything else is simple

(No emit yet because I'm lazy)

SleepyForth also has no strings or floating point numbers.
