# Pokémon Red and Blue template

This is a fork of [pret/pokered][pokered].

This repo builds a ROM with an expanded Pokedex and updated game mechanics, but without altering the structure of the game story-wise and without changing enemy trainers or wild pokemon.
It can be used as a template to start from when creating a ROM hack, so that all the work to expand the dex and update the game mechanics is already done.

I pre-included an expanded roster of 402 pokemon which I selected in order to have better type representation and also based on personal preference.
If you wish to alter this roster, you can pretty much do a drop-in replacement of a pokemon by another, the only extra things you'll need are the pokemon's sprites (front and back) and the pokemon's cry.
Sprites can be found on various sites, or you can draw them yourself, but for cries there aren't many resources out there. I had to create them myself for my roster (see Cries).

Here are the main changes I included in this template:
- **expanded pokedex:** pokemon species IDs are now stored over 2 bytes, allowing up to 65534 different species. Of course, the ROM can't contain that many species. The limit you'll hit will be the space taken by the pokemon sprites. With 402 species, and all the modifications I made, there is still quite a bit of room left in the ROM, but I think something like 500 might start to be a bit too much. Of course it all depends on the rest of the content of the ROM (eg if you reduce the number and/or size of maps, that leaves more room for sprites).
- **special split:** the special stat is now split into special attack and special defense. I think this is necessary to implement pokemon from gen 2 onwards, because arbitrarily choosing their special stat feels wrong to me. Plus it is a pretty welcome balancing improvement.
- **move categories:** they are no longer tied to the move type. You can have physical fire moves, special fighting moves etc. I think this is also essential to help replayability of any hack, because it makes so many more pokemon viable and interesting.
- **learnsets:** I updated the learnsets according to modern versions, but they don't match any version in particular. I gave moves to pokemon if they could learn them in any version, the goal being to have the widest learnsets possible.
- **trainer parties data structure:** each trainer's team is now specified down to each pokemon's moveset and level.
- **TMs:** they are now infinite use. I changed some of them so that they teach better moves, with more type diversity. I also changed the TMs given by Gym Leaders because the old ones contained moves that became widely available via level up, so it wouldn't make sense. Gym Leader TMs have always been exclusive moves upon their introduction.
- **item management:** the bag now has 3 'pockets': items, TMs/HMs, and keys. Since TMs are not consumed upon use now, they would utterly clog the bag, so I gave them their own 'pocket'. Same thing for key items. The standard items pocket still has a capacity of 20 items, but it's much more easily manageable now. I reduced the capacity of the player's PC to 20 since it's sufficient now.
- **moves:** I updated move attributes and effects to their modern values
- **battle mechanics:** things like trapping moves (Wrap etc), freeze, sleep, pretty much all mechanics that changed since gen 1 were updated.
- **sound engine:** I merged the 3 sound engines into 1, and adapted pokecrystal's way of reading sound data from any bank so that we're not limited by the size of a single bank for sound data.
- **bugfixes:** I tried to fix pretty much all the bugs that affect battles, plus a few others. The list is too long to put down here, but I think I got all known bugs and maybe some unknown bugs too.

Here are the extra stuff I added in this template:
- **new move effects:** you can't add moves for which the move effect is not implemented, so I added lots of new move effects. Feel free to add your own if you don't find what you need.
- **new moves:** my goal was to give as many pokemon as possible the widest movepool possible, and to improve type representation dramatically
- **"signature moves":** I did not make move IDs 2-bytes long (that would be even harder than species IDs, I suspect) but I was able to still go over 255 moves by using the last 2 move IDs as special values for "signature moves". That's how I call moves that depend on the species using them. For example, move ID SIGNATURE_MOVE_1 used by Blastoise will be Wave Crash, but when used by Venusaur it will be Vine Whip, and if move ID SIGNATURE_MOVE_2 is used by Blastoise, it will be Wave Crash too (not all pokemon have 2 different signature moves), but if it's used by Venusaur, it will be Petal Blizzard. This system allowed me to add lots more moves and in particular moves that not a lot of pokemon learn (hence their nickname of "signature moves") which otherwise would be a waste of a move ID. I debated using a 3rd move ID for this purpose, but I concluded that the benefits wouldn't outweigh the downsides, so I left it at 2.
- **new TMs:** still pursuing the goal of improving movepools, I added 45 more TMs.
- **new pokemon:** although the template does not alter wild pokemon, you can still get a few new pokemon through evolution (Crobat, Magnezone...) or Fossil resurrection (Tyrunt, Cranidos...). The rest is implemented, you can encounter them with AR codes and use them safely, but they are not available through normal gameplay.
- **alternate forms:** multiple species can share the same dex number, allowing for multiple forms. An example implementation of this is Giratina, or Arceus. Griseous Core and Origin Plate were added to change their forms.
- **battle facility:** as a fun little post-game content, I decided to include a battle facility similar to what you find in recent games.
- **souvenir shop:** in Pewter Museum, you can buy Fossils and a few other items, once you unlock them.
- **visual stuff:** type and category symbols in various menus, trainer sprites individual palettes.

Here are the things I did **not** implement:
- **breeding:** I don't think breeding is the kind of activity you play ROM hacks for. The effort didn't seem worth it to me.
- **genders:** apart from restricting certain evolutions and for a few battle mechanics, it's mostly important for breeding, which I did not include, so I decided to not even include genders. So of course Attract is not implemented, and any Salandit can evolve.
- **abilities:** implementing them all would be a huge effort, it would probably require a complete rewriting of the whole battle core because there wouldn't be enough room in bank F (which is already full as it is). And I don't see how I could implement just a subset of them without throwing balance out the window.
- **held items:** implementing them all would be as huge as abilities, plus there is not enough item IDs available to add all modern items, you would have to make item IDs 2-bytes long, and that would be pretty massive in itself. Implementing just a subset would be doable, but if it's just to have only Leftovers and a few berries, I prefer not to.
- **weather:** without abilities or held items to combo with, weather moves are not super useful, but they would require a big effort to implement, so I decided against it.
- **running shoes:** I find it weird when I see it in pokemon red hacks. I never missed it when playing.

I did alter some maps slightly, mostly to include new TMs.

As an example of what can be done with it, I included an IPS patch of a ROM hack I made based on it.
To be clear, the patch does **not** correspond to the ROM this repo builds (what would be the point?), it's for a ROM hack whose source code is not public but is based on this repo.
It's still the same game structure (still Kanto), but with more variety in wild pokemon and trainer pokemon, as well as a bit of post-game content and additional areas.


To set up the repository, see [**INSTALL.md**](INSTALL.md).

[pokered]: https://github.com/pret/pokered
