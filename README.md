#  Summoner Tasks

(Eventually) A utility for Summoners War

I'm working on this for two reasons:

1. I find I understand things better if I understand the data model;
2. I find keeping track of longer tasks in SW to be extremely difficult because of how the UI is organized.

Some of those longer tasks include things like:

* Getting ready each month for Free Rune Removal Day.
* Keeping track of progress in building rift raid teams, e.g., [Baleygr-Janssen R5](https://www.reddit.com/r/summonerswar/comments/dgyqsp/bj5_balegyr_janssen_r5_guide/), especially when you add additional placements.
* Keeping track of what teams you *do* have, because between the 230 floors of Tower of Ascension (okay, 30 of them are 10 floors at 3 difficulty levels), over a dozen regular Caiross levels, the various Dimension Hole levels and builds, Guild Wars, Arena, Guild Siege…it's a lot of teams. (Yes, [swarfarm](https://swarfarm.com) helps keeps track of teams, and it's wonderful.)

## Where We Are

0. I decided to refactor. It's better, but it's not done, and there are still 8 compile errors as I write this. I hadn't made everything conform to protocols, and…then I changed the protocol midstream. So, down from 88 errors to 8, but I need sleep.

1. Welp, importing the bestiary data, aka the half-million (!) line JSON file that describes the world. It's not done, but the most-important-to-me parts are, at least for now.

2. Currently working on: importing the player data file, which are the instances of the things described in the bestiary file, which is only ~190k lines.
