# tremolator

`tremolator` is a patch to tremolo tool from [craigsapp/humlib](https://github.com/craigsapp/humlib), that adds `*tremolo`/`*Xtremolo` interpretations to each tremolo note encoded with `@n@` markers.

`humlib` tools are not required to use `tremolator`, since `tremolo` and `tabber` from `humlib` are also implemented as filters in [**Verovio Humdrum Viewer**](http://verovio.humdrum.org).

## usage

`tremolator [file].krn`

in combination with `humlib` tools:

`tremolator [file].krn | tremolo`

or (for more complicated files with spine splits and merges):

`tabber [file].krn | tremolator | tremolo | tabber -r`

## examples

### the most simple one:

input (`test1.krn`):

```
**kern
1c@8@
=
8cL
8c
8c
8cJ
8cL
8c
8c
8cJ
=
1c@8@
==
*-
```

command:

```
tremolator test1.krn | tremolo
```

output:

```
**kern
*tremolo
8cL
8c
8c
8c
8c
8c
8c
8cJ
*Xtremolo
=
8cL
8c
8c
8cJ
8cL
8c
8c
8cJ
=
*tremolo
8cL
8c
8c
8c
8c
8c
8c
8cJ
*Xtremolo
==
*-

```

### more complex example:

input (`test2.krn`):

```
**kern	**kern	**kern	**kern	**kern	**kern
1c@8@	1c	1c@8@	1c	1c	1c
=	=	=	=	=	=
2c	2c	8cL	2c	2c	2c
.	.	8c	.	.	.
.	.	8c	.	.	.
.	.	8cJ	.	.	.
2c	2c	8cL	2c	2c@8@	2c
.	.	8c	.	.	.
.	.	8c	.	.	.
.	.	8cJ	.	.	.
=	=	=	=	=	=
1c	1c	1c@16@	1c	1c@8@	1c
=	=	=	=	=	=
4c	4c	4c	4c	4c	4c
4c	4c	4c	4c	4c	4c
2c@16@	2c	2c	2c	2c	2c
=	=	=	=	=	=
*-	*-	*-	*-	*-	*-
```

command:

```
tremolator test2.krn | tremolo
```

output:

```
**kern	**kern	**kern	**kern	**kern	**kern
*tremolo	*	*	*	*	*
*	*	*tremolo	*	*	*
8cL	1c	8cL	1c	1c	1c
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8cJ	.	8cJ	.	.	.
*Xtremolo	*	*Xtremolo	*	*	*
=	=	=	=	=	=
2c	2c	8cL	2c	2c	2c
.	.	8c	.	.	.
.	.	8c	.	.	.
.	.	8cJ	.	.	.
*	*	*	*	*tremolo	*
2c	2c	8cL	2c	8cL	2c
.	.	8c	.	8c	.
.	.	8c	.	8c	.
.	.	8cJ	.	8cJ	.
*	*	*	*	*Xtremolo	*
=	=	=	=	=	=
*	*	*tremolo	*	*tremolo	*
1c	1c	16cLL	1c	8cL	1c
.	.	16c	.	.	.
.	.	16c	.	8c	.
.	.	16c	.	.	.
.	.	16c	.	8c	.
.	.	16c	.	.	.
.	.	16c	.	8c	.
.	.	16c	.	.	.
.	.	16c	.	8c	.
.	.	16c	.	.	.
.	.	16c	.	8c	.
.	.	16c	.	.	.
.	.	16c	.	8c	.
.	.	16c	.	.	.
.	.	16c	.	8cJ	.
.	.	16cJJ	.	.	.
*	*	*	*	*Xtremolo	*
*	*	*Xtremolo	*	*	*
=	=	=	=	=	=
4c	4c	4c	4c	4c	4c
4c	4c	4c	4c	4c	4c
*tremolo	*	*	*	*	*
16cLL	2c	2c	2c	2c	2c
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16cJJ	.	.	.	.	.
*Xtremolo	*	*	*	*	*
=	=	=	=	=	=
*-	*-	*-	*-	*-	*-
```

### example with spine splits and merges:

input (`test3.krn`):

```
**kern	**kern	**kern	**kern	**kern	**kern
1c@8@	1c	1c@8@	1c	1c	1c
=	=	=	=	=	=
2c	2c	8cL	2c	2c	2c
.	.	8c	.	.	.
.	.	8c	.	.	.
.	.	8cJ	.	.	.
2c	2c	8cL	2c	2c@8@	2c
.	.	8c	.	.	.
.	.	8c	.	.	.
.	.	8cJ	.	.	.
=	=	=	=	=	=
*^	*	*	*	*	*
1cc	1c	1c	1c@16@	1c	1c@8@	1c
*v	*v	*	*	*	*	*
=	=	=	=	=	=
4c	4c	4c	4c	4c	4c
4c	4c	4c	4c	4c	4c
2c@16@	2c	2c	2c	2c	2c
=	=	=	=	=	=
*-	*-	*-	*-	*-	*-
```

command:

```
tabber test3.krn | tremolator | tremolo | tabber -r
```

output:

```
**kern	**kern	**kern	**kern	**kern	**kern
*tremolo	*	*	*	*	*
*	*	*tremolo	*	*	*
8cL	1c	8cL	1c	1c	1c
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8c	.	8c	.	.	.
8cJ	.	8cJ	.	.	.
*Xtremolo	*	*Xtremolo	*	*	*
=	=	=	=	=	=
2c	2c	8cL	2c	2c	2c
.	.	8c	.	.	.
.	.	8c	.	.	.
.	.	8cJ	.	.	.
*	*	*	*	*tremolo	*
2c	2c	8cL	2c	8cL	2c
.	.	8c	.	8c	.
.	.	8c	.	8c	.
.	.	8cJ	.	8cJ	.
*	*	*	*	*Xtremolo	*
=	=	=	=	=	=
*^	*	*	*	*	*
*	*	*	*tremolo	*	*tremolo	*
1cc	1c	1c	16cLL	1c	8cL	1c
.	.	.	16c	.	.	.
.	.	.	16c	.	8c	.
.	.	.	16c	.	.	.
.	.	.	16c	.	8c	.
.	.	.	16c	.	.	.
.	.	.	16c	.	8c	.
.	.	.	16c	.	.	.
.	.	.	16c	.	8c	.
.	.	.	16c	.	.	.
.	.	.	16c	.	8c	.
.	.	.	16c	.	.	.
.	.	.	16c	.	8c	.
.	.	.	16c	.	.	.
.	.	.	16c	.	8cJ	.
.	.	.	16cJJ	.	.	.
*	*	*	*	*	*Xtremolo	*
*	*	*	*Xtremolo	*	*	*
*v	*v	*	*	*	*	*
=	=	=	=	=	=
4c	4c	4c	4c	4c	4c
4c	4c	4c	4c	4c	4c
*tremolo	*	*	*	*	*
16cLL	2c	2c	2c	2c	2c
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16c	.	.	.	.	.
16cJJ	.	.	.	.	.
*Xtremolo	*	*	*	*	*
=	=	=	=	=	=
*-	*-	*-	*-	*-	*-
```

## instalation

```
git clone https://github.com/jacekiwaszko1/humdrum-scripts.git
cd humdrum-scripts
make install
```
