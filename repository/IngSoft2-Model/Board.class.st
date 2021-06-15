Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'size',
		'players',
		'turn',
		'positionTracker',
		'laps',
		'lastAppliedEffect',
		'cardHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> having: squares requiring: aNumberOfLaps containing: aDeck usedBy: aGroupOfPlayers [
	self validateMoreThanEightSquares: squares.
	self validatesItDoesntHavePlayersWithSameName: aGroupOfPlayers.
	self validatesNamesMustHaveAtLeastOneLetter: aGroupOfPlayers.
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.  
	^self new initializeHaving: squares requiring: aNumberOfLaps containing: aDeck usedBy: aGroupOfPlayers  
]

{ #category : #validation }
Board class >> validateMoreThanEightSquares: squares [
	(squares size) < 8
		ifTrue: [ Error signal: 'A board must contain at least 8 square boards to satisfy the effects distribution.' ]
]

{ #category : #validation }
Board class >> validatesItDoesntHavePlayersWithSameName: players [

	| playerNames |
	
	playerNames := players asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A board cannot be created having players with repeated names.' ]
]

{ #category : #validation }
Board class >> validatesItMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A board must have at least 1 player in order to be created.' ]
]

{ #category : #'instance creation' }
Board class >> validatesItNeedsAtLeastOneLap: amountOfLaps [
	amountOfLaps < 1
		ifTrue: [ Error signal: 'A board requires at least one lap to be created.' ]
]

{ #category : #validation }
Board class >> validatesNamesMustHaveAtLeastOneLetter: players [ 

	players detect: [ :playerName | playerName size < 1] ifFound: [ Error signal: 'Player name must have at least one letter' ].
]

{ #category : #accessing }
Board >> absoluteSize [
	^ size * laps
]

{ #category : #accessing }
Board >> activeCards [
	^ cardHandler activeCards
]

{ #category : #accessing }
Board >> amountOfLaps [
	^ laps
]

{ #category : #accessing }
Board >> amountOfPlayers [
	^ players size
]

{ #category : #action }
Board >> applyActiveCards [

	| currentPlayer activePlays applicablePlays |
	
	activePlays := cardHandler activePlays.
	currentPlayer := self currentPlayerThrowing.
	applicablePlays := activePlays select: [ :play | (play target) includes: currentPlayer ].
	applicablePlays do: [ :play | self disableEffectsDuring: [ (play card) applyTo: self directedTo: currentPlayer ] ]
]

{ #category : #action }
Board >> applyCancellationCardTo: aPlay [ 
	cardHandler removeFromActivePlays: aPlay
]

{ #category : #action }
Board >> applyRedoCardTo: aTarget by: invokingPlayer [
	
	| reversedPlayHistory redoCard lastPlayApplied newPlay |
	
	reversedPlayHistory := cardHandler playHistory reverse.
	redoCard := reversedPlayHistory first card.
	lastPlayApplied := reversedPlayHistory detect: [ :play | play card ~= redoCard ] 
	ifNone: [Error signal: 'A Redo card can not be played if no previous cards were played'].
	newPlay := lastPlayApplied card asPlayAffecting: aTarget  by: invokingPlayer .  
	cardHandler deal: lastPlayApplied card to: invokingPlayer.
	self resolvePlayabilityOf: newPlay
	
]

{ #category : #action }
Board >> applyRepeatCardTo: aTarget [ 
	
	| targetedPlayer |
	
	targetedPlayer := aTarget first.
	self disableEffectsDuring: [ lastAppliedEffect applyOn: self activatedBy: targetedPlayer ]
]

{ #category : #accessing }
Board >> currentPlayerThrowing [
	^ players at: turn
]

{ #category : #action }
Board >> dealsCardTo: aPlayer [
	cardHandler dealsCardTo: aPlayer
]

{ #category : #action }
Board >> disableEffectsDuring: anAction [
	self notifySquaresToNotApplyEffect.
	anAction value.
	self notifySquaresToApplyEffect
]

{ #category : #accessing }
Board >> handOf: aPlayer [
	^ cardHandler handOf: aPlayer
]

{ #category : #action }
Board >> incrementTurn [
	turn := (turn rem: players size) + 1
]

{ #category : #initialization }
Board >> initializeHaving: boardSquares requiring: aNumberOfLaps containing: aDeck usedBy: aGroupOfPlayers [  
	
	players := aGroupOfPlayers.
	size := boardSquares size.
	turn := 1.
	squares := boardSquares.
	laps := aNumberOfLaps.
	positionTracker := PositionsTracker of: aGroupOfPlayers inBoardOf: size.
	cardHandler := CardHandler using: aDeck dealsTo: aGroupOfPlayers.
	lastAppliedEffect := NoEffect new
]

{ #category : #action }
Board >> makes: aPlay in: aGame [
	
	self resolvePlayabilityOf: aPlay.
	self verifyThereIsAWinner ifTrue: [ aGame isNotifiedItHasFinished ]
]

{ #category : #action }
Board >> move: player by: amountPlaces [

	| playerPosition calculatedPlayerPosition |
	
	playerPosition := positionTracker absolutePositionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	(squares at: (self positionOf: player)) place: player on: self 
	
]

{ #category : #action }
Board >> moveAllPlayersToFirstSquareOfTheirLap [

	| relativePositions relativePlayerPosition |
	
	relativePositions := positionTracker boardPositions.
	players do: [ :playerName |
		relativePlayerPosition := relativePositions at: playerName.
		self move: playerName by: ((relativePlayerPosition - 1) * (-1)). ]
]

{ #category : #action }
Board >> movePlayersBack: aNumberOfSpaces except: aPlayer [
	
	| affectedPlayers |
	
	affectedPlayers := players reject: [ :player | player = aPlayer ].
	affectedPlayers do: [ :player | self move: player by: (-1) * aNumberOfSpaces ]
]

{ #category : #action }
Board >> nextPlayerThrows: resultOfThrow in: aGame [ 
	
	| player |
	
	player := players at: turn.
	self move: player by: resultOfThrow.
	self applyActiveCards.
	self verifyThereIsAWinner ifTrue: [ aGame isNotifiedItHasFinished ] ifFalse: [ self incrementTurn ]
]

{ #category : #notification }
Board >> notifySquaresToApplyEffect [
	squares do: [ :square | square applyEffect ]
]

{ #category : #notification }
Board >> notifySquaresToNotApplyEffect [
	squares do: [ :square | square doNotApplyEffect ]
]

{ #category : #testing }
Board >> playerLaps [
	^ positionTracker playerLaps
]

{ #category : #accessing }
Board >> playerPositions [
	^ positionTracker boardPositions
]

{ #category : #testing }
Board >> playerRanking [
	^ positionTracker playerRanking
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
	^ positionTracker boardPositionOf: aPlayer
]

{ #category : #action }
Board >> resolvePlayabilityOf: newPlay [

	(newPlay card)isPermanent
		ifTrue: [ self currentPlayerThrowing ~= newPlay invokingPlayer
				ifTrue: [ Error signal: 'A permanent card can only played in the turn of the invoking player' ]
				ifFalse: [ cardHandler activate: newPlay ] ]
		ifFalse: [ cardHandler removeFromPlayerHandCardOf: newPlay.
					newPlay card applyTo: self directedTo: newPlay ]
]

{ #category : #accessing }
Board >> size [
	^ size
]

{ #category : #action }
Board >> updateLastApplied: effect [
	lastAppliedEffect := effect
]

{ #category : #verification }
Board >> verifyThereIsAWinner [
	^ players anySatisfy: [ :player | (positionTracker absolutePositionOf: player) > self absoluteSize ]
]
