
	.SEGMENT "0"


	.FUNCT	PICK-ONE,TBL,LENGTH,CNT,RND,MSG,RFROB
	GET	TBL,0 >LENGTH
	GET	TBL,1 >CNT
	DEC	'LENGTH
	ADD	TBL,2 >TBL
	MUL	CNT,2
	ADD	TBL,STACK >RFROB
	SUB	LENGTH,CNT
	RANDOM	STACK >RND
	GET	RFROB,RND >MSG
	GET	RFROB,1
	PUT	RFROB,RND,STACK
	PUT	RFROB,1,MSG
	INC	'CNT
	EQUAL?	CNT,LENGTH \?CND1
	SET	'CNT,0
?CND1:	PUT	TBL,0,CNT
	RETURN	MSG


	.FUNCT	DPRINT,OBJ
	GETP	OBJ,P?INANIMATE-DESC
	ZERO?	STACK /?CCL3
	FSET?	OBJ,ANIMATEDBIT /?CCL3
	GETP	OBJ,P?INANIMATE-DESC
	PRINT	STACK
	RTRUE	
?CCL3:	GETP	OBJ,P?SDESC
	ZERO?	STACK /?CCL7
	GETP	OBJ,P?SDESC
	PRINT	STACK
	RTRUE	
?CCL7:	PRINTD	OBJ
	RTRUE	


	.FUNCT	APRINT,OBJ,NOSP,LEN
	ZERO?	NOSP \?CND1
	PRINTC	32
?CND1:	CALL2	GET-OWNER,OBJ >LEN
	ZERO?	LEN /?CCL5
	GETP	OBJ,P?OWNER
	EQUAL?	LEN,STACK /?CCL5
	EQUAL?	LEN,PROTAGONIST \?CCL10
	PRINTI	"your "
	JUMP	?CND3
?CCL10:	EQUAL?	LEN,OBJ /?CND3
	ICALL	APRINT,LEN,TRUE-VALUE
	PRINTI	"'s "
	JUMP	?CND3
?CCL5:	FSET?	OBJ,NARTICLEBIT /?CND3
	FSET?	OBJ,VOWELBIT \?CCL15
	PRINTI	"an "
	JUMP	?CND3
?CCL15:	PRINTI	"a "
?CND3:	CALL2	DPRINT,OBJ
	RSTACK	


	.FUNCT	TPRINT,OBJ,NOSP,LEN
	ZERO?	NOSP \?CND1
	PRINTC	32
?CND1:	CALL2	GET-OWNER,OBJ >LEN
	ZERO?	LEN /?CCL5
	GETP	OBJ,P?OWNER
	EQUAL?	LEN,STACK /?CCL5
	EQUAL?	LEN,PROTAGONIST \?CCL10
	PRINTI	"your "
	JUMP	?CND3
?CCL10:	EQUAL?	LEN,OBJ /?CND3
	ICALL	TPRINT,LEN,TRUE-VALUE
	PRINTI	"'s "
	JUMP	?CND3
?CCL5:	FSET?	OBJ,NARTICLEBIT /?CND3
	PRINTI	"the "
?CND3:	CALL2	DPRINT,OBJ
	RSTACK	


	.FUNCT	TPRINT-PRSO
	CALL2	TPRINT,PRSO
	RSTACK	


	.FUNCT	TPRINT-PRSI
	CALL2	TPRINT,PRSI
	RSTACK	


	.FUNCT	ARPRINT,OBJ
	ICALL2	APRINT,OBJ
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	TRPRINT,OBJ
	ICALL2	TPRINT,OBJ
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	IS-ARE-PRINT,OBJ
	FSET?	OBJ,NARTICLEBIT \?CCL3
	PRINTC	32
	JUMP	?CND1
?CCL3:	PRINTI	" the "
?CND1:	ICALL2	DPRINT,OBJ
	FSET?	OBJ,PLURALBIT \?CCL6
	PRINTI	" are "
	RTRUE	
?CCL6:	PRINTI	" is "
	RTRUE	


	.FUNCT	VERB-ALL-TEST,OO,II,L
	LOC	OO >L
	EQUAL?	OO,ROOMS \?CCL3
	INC	'P-NOT-HERE
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL5
	ZERO?	II /?CCL5
	IN?	OO,II \FALSE
?CCL5:	ZERO?	II /?CCL11
	EQUAL?	PRSO,II /FALSE
?CCL11:	EQUAL?	PRSA,V?TAKE \?CCL15
	FSET?	OO,TAKEBIT /?CCL18
	FSET?	OO,TRYTAKEBIT \FALSE
?CCL18:	FSET?	OO,NALLBIT /FALSE
	ZERO?	II \TRUE
	CALL2	ULTIMATELY-IN?,OO
	ZERO?	STACK /TRUE
	RFALSE	
?CCL15:	EQUAL?	PRSA,V?PUT-ON,V?PUT,V?DROP /?PRD30
	EQUAL?	PRSA,V?SGIVE,V?GIVE \?CCL28
?PRD30:	IN?	OO,WINNER \FALSE
?CCL28:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?CCL34
	IN?	OO,WINNER /?CCL34
	CALL	ULTIMATELY-IN?,OO,II
	ZERO?	STACK \FALSE
?CCL34:	EQUAL?	PRSA,V?WEAR \?CCL39
	FSET?	OO,WORNBIT /FALSE
	FSET?	OO,WEARBIT \FALSE
?CCL39:	EQUAL?	OO,II /FALSE
	RTRUE	


	.FUNCT	GAME-VERB?
	EQUAL?	PRSA,V?$COMMAND,V?$UNRECORD,V?$RECORD /TRUE
	EQUAL?	PRSA,V?$REFRESH,V?$VERIFY,V?$RANDOM /TRUE
	EQUAL?	PRSA,V?RESTART,V?RESTORE,V?SAVE /TRUE
	EQUAL?	PRSA,V?UNSCRIPT,V?SCRIPT,V?QUIT /TRUE
	EQUAL?	PRSA,V?VERBOSE,V?SUPERBRIEF,V?BRIEF /TRUE
	EQUAL?	PRSA,V?NOTIFY,V?CREDITS,V?VERSION /TRUE
	EQUAL?	PRSA,V?SCORE,V?COLOR,V?HINT /TRUE
	EQUAL?	PRSA,V?DEFINE,V?MAP,V?TIME /TRUE
	EQUAL?	PRSA,V?MODE /TRUE
	RFALSE	


	.FUNCT	THIS-IS-IT,OBJ
	EQUAL?	PRSA,V?WALK \?PRD5
	EQUAL?	PRSO,OBJ /TRUE
?PRD5:	EQUAL?	OBJ,FALSE-VALUE,ROOMS,ME /TRUE
	EQUAL?	OBJ,PROTAGONIST /TRUE
	CALL	DONT-IT,OBJ,LOBSTER,W?NUTCRACKER
	ZERO?	STACK \TRUE
	CALL	DONT-IT,OBJ,SNAKE,W?ROPE
	ZERO?	STACK \TRUE
	FSET?	OBJ,FEMALEBIT \?CCL14
	EQUAL?	P-HER-OBJECT,OBJ /?CND15
	FCLEAR	HER,TOUCHBIT
?CND15:	SET	'P-HER-OBJECT,OBJ
	RETURN	P-HER-OBJECT
?CCL14:	FSET?	OBJ,ACTORBIT /?CTR17
	EQUAL?	OBJ,LITTLE-FUNGUS \?CCL18
?CTR17:	EQUAL?	P-HIM-OBJECT,OBJ /?CND21
	FCLEAR	HIM,TOUCHBIT
?CND21:	SET	'P-HIM-OBJECT,OBJ
	EQUAL?	OBJ,JESTER,EXECUTIONER /FALSE
	EQUAL?	P-IT-OBJECT,OBJ /?CND26
	FCLEAR	IT,TOUCHBIT
?CND26:	SET	'P-IT-OBJECT,OBJ
	RETURN	P-IT-OBJECT
?CCL18:	EQUAL?	P-IT-OBJECT,OBJ /?CND28
	FCLEAR	IT,TOUCHBIT
?CND28:	SET	'P-IT-OBJECT,OBJ
	RETURN	P-IT-OBJECT


	.FUNCT	DONT-IT,OBJ1,OBJ2,WRD
	EQUAL?	OBJ1,OBJ2 \FALSE
	CALL	NOUN-USED?,OBJ2,WRD
	ZERO?	STACK /FALSE
	FSET?	OBJ2,ANIMATEDBIT \FALSE
	CALL2	VISIBLE?,OBJ2
	ZERO?	STACK \FALSE
	RTRUE	


	.FUNCT	PERFORM-PRSA,O,I
	ICALL	PERFORM,PRSA,O,I
	RTRUE	


	.FUNCT	CAPITAL-NOUN?,WRD,TBL
	EQUAL?	WRD,W?FLATHEAD,W?DIMWIT,W?URSULA /TRUE
	EQUAL?	WRD,W?MEGABOZ,W?JOHN,W?PIERPONT /TRUE
	EQUAL?	WRD,W?STONEWALL,W?LUCREZIA,W?SEBASTIAN /TRUE
	EQUAL?	WRD,W?DAVISON,W?THOMAS,W?ALVA /TRUE
	EQUAL?	WRD,W?LEONARDO,W?JOHANN,W?RALPH /TRUE
	EQUAL?	WRD,W?PAUL,W?FRANK,W?LLOYD /TRUE
	EQUAL?	WRD,W?BABE,W?ZILBO,W?MERETZKY /TRUE
	EQUAL?	WRD,W?FOOBUS,W?BARBAZZO,W?FERNAP /TRUE
	EQUAL?	WRD,W?MUMBERTHRAX,W?BOZBO,W?MUMBO /TRUE
	EQUAL?	WRD,W?PHLOID,W?BELWIT /TRUE
	GETPT	SAINTS,P?SYNONYM >TBL
	ZERO?	TBL /?CCL15
	PTSIZE	TBL
	DIV	STACK,2
	INTBL?	WRD,TBL,STACK /TRUE
?CCL15:	INTBL?	WRD,FUNGUS-WORDS,12 /TRUE
	INTBL?	WRD,MID-NAME-WORDS,12 /TRUE
	RFALSE	


	.FUNCT	LIT?,RM,RMBIT,OHERE,LIT,RES,OLD-OBJECT
	ASSIGNED?	'RMBIT /?CND1
	SET	'RMBIT,TRUE-VALUE
?CND1:	SET	'RES,SEARCH-RES
	EQUAL?	HERE,UNDERWATER,LAKE-BOTTOM \?CND3
	FSET?	EXTERIOR-LIGHT,ONBIT \FALSE
?CND3:	ZERO?	RM \?CND7
	SET	'RM,HERE
?CND7:	SET	'OHERE,HERE
	SET	'HERE,RM
	ZERO?	RMBIT /?CCL11
	FSET?	RM,ONBIT \?CCL11
	SET	'LIT,HERE
	JUMP	?CND9
?CCL11:	FSET?	WINNER,ONBIT \?CCL15
	CALL	ULTIMATELY-IN?,WINNER,RM
	ZERO?	STACK /?CCL15
	SET	'LIT,WINNER
	JUMP	?CND9
?CCL15:	SET	'OLD-OBJECT,RES
	PUT	OLD-OBJECT,1,0
	PUT	OLD-OBJECT,2,FALSE-VALUE
	PUT	OLD-OBJECT,3,FALSE-VALUE
	PUT	OLD-OBJECT,4,FALSE-VALUE
	SET	'OLD-OBJECT,FINDER
	PUT	OLD-OBJECT,0,ONBIT
	PUT	OLD-OBJECT,1,FIND-FLAGS-GWIM
	PUT	OLD-OBJECT,2,FALSE-VALUE
	PUT	OLD-OBJECT,3,FALSE-VALUE
	PUT	OLD-OBJECT,4,0
	PUT	OLD-OBJECT,5,FALSE-VALUE
	PUT	OLD-OBJECT,6,FALSE-VALUE
	PUT	OLD-OBJECT,7,FALSE-VALUE
	PUT	OLD-OBJECT,8,FALSE-VALUE
	PUT	OLD-OBJECT,9,RES
	PUT	OLD-OBJECT,10,0
	EQUAL?	OHERE,RM \?CND18
	ICALL	FIND-DESCENDANTS,WINNER,7
	EQUAL?	WINNER,PROTAGONIST /?CND18
	IN?	PROTAGONIST,RM \?CND18
	ICALL	FIND-DESCENDANTS,PROTAGONIST,7
?CND18:	GET	RES,1
	ZERO?	STACK \?CND24
	LOC	WINNER
	FSET?	STACK,VEHBIT \?CND26
	LOC	WINNER
	FSET?	STACK,OPENBIT /?CND26
	LOC	WINNER
	ICALL	FIND-DESCENDANTS,STACK,7
?CND26:	ICALL	FIND-DESCENDANTS,RM,7
?CND24:	GET	RES,1
	GRTR?	STACK,0 \?CND9
	GET	RES,4 >LIT
?CND9:	SET	'HERE,OHERE
	RETURN	LIT


	.FUNCT	DEQUEUE,RTN
	CALL2	QUEUED?,RTN >RTN
	ZERO?	RTN /FALSE
	PUT	RTN,C-RTN,0
	RTRUE	


	.FUNCT	QUEUED?,RTN,C,E
	SET	'E,C-TABLE+60
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E /FALSE
	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	GET	C,C-TICK
	ZERO?	STACK /FALSE
	RETURN	C
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	RUNNING?,RTN,C,E
	SET	'E,C-TABLE+60
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E /FALSE
	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	GET	C,C-TICK
	ZERO?	STACK /FALSE
	GET	C,C-TICK
	GRTR?	STACK,1 /FALSE
	RTRUE	
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	QUEUE,RTN,TICK,C,E,INT
	SET	'E,C-TABLE+60
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E \?CCL5
	ZERO?	INT /?CCL8
	SET	'C,INT
	JUMP	?CND6
?CCL8:	LESS?	C-INTS,C-INTLEN \?CND9
	PRINTI	"**Too many ints!**"
	CRLF	
?CND9:	SUB	C-INTS,C-INTLEN >C-INTS
	LESS?	C-INTS,C-MAXINTS \?CND11
	SET	'C-MAXINTS,C-INTS
?CND11:	ADD	C-TABLE,C-INTS >INT
?CND6:	PUT	INT,C-RTN,RTN
	JUMP	?REP2
?CCL5:	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CCL14
	SET	'INT,C
?REP2:	ZERO?	CLOCK-HAND /?CND16
	GRTR?	INT,CLOCK-HAND \?CND16
	ADD	TICK,3
	SUB	0,STACK >TICK
?CND16:	PUT	INT,C-TICK,TICK
	RETURN	INT
?CCL14:	GET	C,C-RTN
	ZERO?	STACK \?CND3
	SET	'INT,C
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	CLOCKER,E,TICK,RTN,FLG,Q?,OWINNER
	ZERO?	CLOCK-WAIT /?CCL3
	SET	'CLOCK-WAIT,FALSE-VALUE
	RFALSE	
?CCL3:	ZERO?	TIME-STOPPED /?CND1
	INC	'MOVES
	RFALSE	
?CND1:	ADD	C-TABLE,C-INTS >CLOCK-HAND
	SET	'E,C-TABLE+60
	SET	'OWINNER,WINNER
	SET	'WINNER,PROTAGONIST
?PRG5:	EQUAL?	CLOCK-HAND,E \?CCL9
	SET	'CLOCK-HAND,E
	INC	'MOVES
	SET	'WINNER,OWINNER
	RETURN	FLG
?CCL9:	GET	CLOCK-HAND,C-RTN
	ZERO?	STACK /?CND7
	GET	CLOCK-HAND,C-TICK >TICK
	LESS?	TICK,-1 \?CCL13
	SUB	0,TICK
	SUB	STACK,3
	PUT	CLOCK-HAND,C-TICK,STACK
	SET	'Q?,CLOCK-HAND
	JUMP	?CND7
?CCL13:	ZERO?	TICK /?CND7
	GRTR?	TICK,0 \?CND15
	DEC	'TICK
	PUT	CLOCK-HAND,C-TICK,TICK
?CND15:	ZERO?	TICK /?CND17
	SET	'Q?,CLOCK-HAND
?CND17:	GRTR?	TICK,0 /?CND7
	GET	CLOCK-HAND,C-RTN >RTN
	ZERO?	TICK \?CND21
	PUT	CLOCK-HAND,C-RTN,0
?CND21:	CALL	RTN
	ZERO?	STACK /?CND23
	SET	'FLG,TRUE-VALUE
?CND23:	ZERO?	Q? \?CND7
	GET	CLOCK-HAND,C-RTN
	ZERO?	STACK /?CND7
	SET	'Q?,TRUE-VALUE
?CND7:	ADD	CLOCK-HAND,C-INTLEN >CLOCK-HAND
	ZERO?	Q? \?PRG5
	ADD	C-INTS,C-INTLEN >C-INTS
	JUMP	?PRG5


	.FUNCT	C-PIXELS,X
	SUB	X,1
	MUL	STACK,FONT-X
	ADD	STACK,1
	RSTACK	


	.FUNCT	L-PIXELS,Y
	SUB	Y,1
	MUL	STACK,FONT-Y
	ADD	STACK,1
	RSTACK	


	.FUNCT	CCURSET,Y,X,?TMP1
	CALL2	L-PIXELS,Y >?TMP1
	CALL2	C-PIXELS,X
	CURSET	?TMP1,STACK
	RTRUE	

	.ENDSEG

	.ENDI
