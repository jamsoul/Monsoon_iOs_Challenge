Monsoon_iOs_Challenge
=====================

iOs Challenge

TO-DO:

* Create global defines for constants.
* Add data structure to hold other properties within the Round segments. (id, strings, etc.) or Add DataDelegate if necessary.
* Layout Constraints to main view. Adapt for iPad.
* Remove magic numbers from code.
* Run a memory leak test.
* Add animations for segments changing current selection.
* Add VC Animations.
* Fix round buttons gesture area.

General Thoughts and comments:

* UI Implemented programatically: Most of the large projects I've been involved with, decided to use this approach. Personally I've found that multiple users updating xib files is a little problematic, and screen ownership got stucked. If the project needs a different approach I can cope with it, but less efficiently in terms of time at least until I get the thing during the first two weeks working with my mates.
* I know there are a lot of changes still to be made to the code, but I'd rather submit it to review with  visible results as soon as possible. In my experience I've found that even being difficult to grasp the exact point between functionallity and quality, I focus on getting things done trusting in general design principles and do small refactors as required by the reviewer or p.owner. Again, I find this method of working to be the most accurate for agile development. Since we didn't have the chance of having a first technical meeting to approach the solution, I decided to go with the most comfortable way to me, but I consider that some meetings before starting new features is mandatory. 
* ARC: I have a C++ background, and since I trust these new compiler features, it's more comfortable to me to manually track memory allocation. Simple principles, I use to think in a 'Stack-fashion' (yeah, I made up this word) way, open/close, owner creates/owner destroy, new/delete, etc.
* Most of the remaining work to-do fits in a couple of hours, maybe 8. I think just being concious about it is enough to the purpose of this test.
* All of the work here was made in <10 raw hours.

