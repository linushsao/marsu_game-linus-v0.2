--The actual rules.
interact.rules = [[
Rules:

1. Don't steal or grief stuff, owned by other peoples!
2. Don't spam the world with random or ugly Blocks or one-node pillars!
3. Don't break someone's buildings, build 100 blocks away from other peoples, 
as long they don't allow u to build more near! That rule is especcially for Spawn!
4. No killing (it will most times result in a BAN!)
5. No Dating!
6. Ask for help, not for items!
7. Don't mine everywhere, build your mine under your home, or in an canyon, to not make 
the landscape ugly. 
HINT: you can mine also in the Public Mine!

For the first building it is recommended to build at the Building area, u can go there
by pushing the Build-button at spawn.
"
]]

--The questions on the rules, if the quiz is used.
--The checkboxes for the first 4 questions are in config.lua
interact.s4_question1 = "Is PVP is allowed?"
interact.s4_question2 = "Is it allowed to grief or steal or kill?"
interact.s4_question3 = "Do you can build 110 blocks away from other people's areas?"
interact.s4_question4 = "Should you ask peoples for items?"
interact.s4_question5 = "Is it allowed to date?"
interact.s4_multi_question = "Where should u build your mine?"

--The answers to the multiple choice questions. Only one of these should be true.
interact.s4_multi1 = "Near spawn, under 100 blocks away from it."
interact.s4_multi2 = "Under your home/base"
interact.s4_multi3 = "In the desert 100 blocks away from other's areas"


--Which answer is needed for the quiz questions. interact.quiz1-4 takes true or false.
--True is left, false is right.
--Please, please spell true and false right!!! If you spell it wrong it won't work!
--interact.quiz can be 1, 2 or 3.
--1 is the top one by the question, 2 is the bottom left one, 3 is the bottom right one.
--Make sure these agree with your answers!
interact.quiz1 = false
interact.quiz2 = false
interact.quiz3 = true
interact.quiz4 = false
interact.quiz5 = false
interact.quiz_multi = 2
