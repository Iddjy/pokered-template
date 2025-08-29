; this function temporarily makes the starters (and Ivysaur) seen
; so that the full Pokedex information gets displayed in Oak's lab
StarterDex:
	callab AddToPokedexOwned		; to allow any pokemon to be used as starter
	predef ShowPokedexData
	jpab RemoveFromPokedexOwned		; to allow any pokemon to be used as starter
