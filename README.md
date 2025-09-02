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
- **moves:** I updated move attributes and effects to their modern values.
- **battle mechanics:** things like trapping moves (Wrap etc), freeze, sleep, critical hits, pretty much all mechanics that changed since gen 1 were updated.
- **StatExp:** I replaced StatExp with EVs. They work exactly like in modern games.
- **sound engine:** I merged the 3 sound engines into 1, and adapted pokecrystal's way of reading sound data from any bank so that we're not limited by the size of a single bank for sound data. I also separated pokemon base cries from other SFX, they now have 2-bytes IDs, so that you can have as many as pokemon species.
- **bugfixes:** I tried to fix pretty much all the bugs that affect battles, plus a few others. The list is too long to put down here, but I think I got all known bugs and maybe some unknown bugs too.
- **trainer AI:** apart from fixing the numerous bugs, I improved it a bit for standard trainers, and I improved it a lot for Battle Facility trainers. The first AI routine, which initially just prevented trainers from using a non-volatile status move on a pokemon that already has one, now also prevent using any status move that would obviously fail, like CONFUSE RAY on an already confused target, LEECH SEED on a GRASS type, etc. The second AI routine, which initially just encouraged stat-modifying moves on the 2nd turn a pokemon is out, now handles all stats-related effects in a much more consistent way. The third AI routine, the infamous 'Good AI', now encourages double weakness more than single weakness, and conversely discourages double resisted moves more than single resisted ones, and discourages ineffective moves even more. I added several more routines, to handle various other aspects such as STAB, priority moves, finishing off low HP enemy, counter moves, suicide moves, 2-turn moves, healing moves.
- **in-game trades:** made it so that you can get the other version-exclusives from in-game trades.
- **naming screen:** more characters are now usable to name yourself, the rival, or your pokemon.

Here are the extra stuff I added in this template:
- **new move effects:** you can't add moves for which the move effect is not implemented, so I added lots of new move effects. Feel free to add your own if you don't find what you need.
- **new moves:** my goal was to give as many pokemon as possible the widest movepool possible, and to improve type representation dramatically.
- **"signature moves":** I did not make move IDs 2-bytes long (that would be even harder than species IDs, I suspect) but I was able to still go over 255 moves by using the last 2 move IDs as special values for "signature moves". That's how I call moves that depend on the species using them. For example, move ID SIGNATURE_MOVE_1 used by Blastoise will be Wave Crash, but when used by Venusaur it will be Vine Whip, and if move ID SIGNATURE_MOVE_2 is used by Blastoise, it will be Wave Crash too (not all pokemon have 2 different signature moves), but if it's used by Venusaur, it will be Petal Blizzard. This system allowed me to add lots more moves and in particular moves that not a lot of pokemon learn (hence their nickname of "signature moves") which otherwise would be a waste of a move ID. I debated using a 3rd move ID for this purpose, but I concluded that the benefits wouldn't outweigh the downsides, so I left it at 2.
- **new TMs:** still pursuing the goal of improving movepools, I added 45 more TMs.
- **new items:** new evolution items, EV-reducing berries, new fossils, new treasures (NUGGET-likes), and a few new key items.
- **item drops:** wild pokemon have a 20% chance to drop an item when defeated. The item type is only determined by the pokemon level, not the species. The goal of this was to have some infinite way to generate money before the E4, so the items are all things that you can just sell for money (like NUGGETs).
- **Move Tutor:** he's located on Route 23 and requires a TINY MUSHROOM to teach a move. I compiled a list of moves that have been available via various move tutors through the generations.
- **Hyper Training:** he's located on Route 23 too, requires pokemon to be at least level 50, and a BOTTLE CAP for 1 stat or a GOLDBOTTLECAP for all 6.
- **daycare moves:** since there is no breeding, this is a roundabout way to implement egg moves. Pokemon compatibilities are the same as in recent games. You have to place the move giver in the daycare, and then speak to the daycare manager and let the move receiver play with the pokemon in the daycare. If the pokemon are compatible and the giver has a move the receiver can learn this way, the move will be taught to the receiver.
- **new pokemon:** although the template does not alter wild pokemon, you can still get a few new pokemon through evolution (Crobat, Magnezone...) or Fossil resurrection (Tyrunt, Cranidos...). The rest is implemented, you can encounter them with AR codes and use them safely, but they are not available through normal gameplay.
- **secret passages:** they are ways to teleport from one spot to another by using DIG or an ESCAPE ROPE at specific coordinates in certain maps. I used it in the example ROM (see the IPS patch). There is a commented out example in this repo (see data/special_warps.asm and engine/items/items.asm).
- **alternate forms:** multiple species can share the same dex number, allowing for multiple forms. An example implementation of this is Giratina, or Arceus. Griseous Core and Origin Plate were added to change their forms.
- **alternate music for maps:** I added a way to have some maps use a different music if certain conditions are met.
- **alternate encounter table for dark maps:** I added a way to update the encounter table when FLASH is used in a dark map.
- **battle facility:** as a fun little post-game content, I decided to include a battle facility similar to what you find in recent games. You get a GOLDBOTTLECAP every 50 consecutive wins. Starting at battle 50, special opponents battle you every 10 battle.
- **souvenir shop:** in Pewter Museum, you can buy Fossils and a few other items, once you unlock them.
- **legendary pokemon respawning:** static legendaries now respawn after defeating the Champion if you fainted them or ran away from them.
- **new music:** I made a lower-pitched version of the wild encounter theme.
- **500 coins bulks:** you can now buy coins in bulks of 500 at the Game Corner.
- **visual stuff:** type and category symbols in various menus, trainer sprites individual palettes, move power and accuracy in 2nd status screen, 3rd status screen with DVs/EVs evaluation, dex registration screen upon evolution, trade, or receiving a gift mon.

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
