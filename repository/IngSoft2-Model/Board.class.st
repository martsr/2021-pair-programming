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
		'deck',
		'cardManager',
		'lastAppliedEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> having: squares requiring: aNumberOfLaps containing: aDeck usedBy: aGroupOfPlayers [
	self validateMoreThanFiveSquares: squares.
	self validatesItDoesntHavePlayersWithSameName: aGroupOfPlayers.
	self validatesNamesMustHaveAtLeastOneLetter: aGroupOfPlayers.
	self validatesItMustHaveAtLeastOnePlayer: aGroupOfPlayers.
	self validatesItNeedsAtLeastOneLap: aNumberOfLaps.  
	^self new initializeHaving: squares requiring: aNumberOfLaps containing: aDeck usedBy: aGroupOfPlayers  
]

{ #category : #validation }
Board class >> validateMoreThanFiveSquares: squares [
	(squares size) < 5
		ifTrue: [ Error signal: 'A board must contain at least 5 square boards to satisfy the effects distribution.' ]
]

{ #category : #validation }
Board class >> validatesItDoesntHavePlayersWithSameName: players [

	| playerNames |
	
	playerNames := players asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A board cannot be generated having players with repeated names.' ]
]

{ #category : #validation }
Board class >> validatesItMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A board  must have at least 1 player in order to be generated.' ]
]

{ #category : #'instance creation' }
Board class >> validatesItNeedsAtLeastOneLap: amountOfLaps [
	amountOfLaps < 1
		ifTrue: [ Error signal: 'A board requires at least one lap to be generated.' ]
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
	^ cardManager activeCards.
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

	| currentPlayer activePlays applicableCards applicablePlays |
	activePlays := cardManager activePlays.
	currentPlayer := self currentPlayerThrowing.
	applicablePlays := activePlays select: [ :play | (play target) includes: currentPlayer ].
	applicableCards := applicablePlays collect: [ :play | play card ].
	applicableCards do: [ :card | self disableEffectsDuring: [ card applyTo: self directedTo: currentPlayer ] ].
]

{ #category : #action }
Board >> applyCancellationCardTo: aPlay [ 
	cardManager removeFromActivePlays: aPlay.
]

{ #category : #action }
Board >> applyCancellationCardTo: aPermanentCard affecting: aPlayer [
	cardManager remove: aPermanentCard affecting: aPlayer.
]

{ #category : #action }
Board >> applyRedoCardTo: aTarget [

	
]

{ #category : #action }
Board >> applyRepeatCardTo: aTarget [ 
	
	| targetedPlayer |
	
	targetedPlayer := aTarget first.
	self disableEffectsDuring: [ lastAppliedEffect applyOn: self activatedBy: targetedPlayer ]. 
]

{ #category : #action }
Board >> applyRepeatCardTo: aPermanentCard affecting: aPlayer [
	self disableEffectsDuring: [ lastAppliedEffect applyOn: self activatedBy: aPlayer ]. 
]

{ #category : #accessing }
Board >> currentPlayerThrowing [
	^ players at: turn.
]

{ #category : #action }
Board >> dealsCardTo: aPlayer [
	cardManager dealsCardTo: aPlayer.
]

{ #category : #action }
Board >> disableEffectsDuring: anAction [
	self notifySquaresToNotApplyEffect.
	anAction value.
	self notifySquaresToApplyEffect.
]

{ #category : #accessing }
Board >> handOf: aPlayer [
	^ cardManager handOf: aPlayer.
]

{ #category : #action }
Board >> incrementTurn [
	turn := (turn rem: players size) + 1
]

{ #category : #initialization }
Board >> initializeHaving: boardSquares requiring: aNumberOfLaps containing: aDeck usedBy: aGroupOfPlayers [  
	
	deck := aDeck.
	players := aGroupOfPlayers.
	size := boardSquares size.
	turn := 1.
	squares := boardSquares.
	laps := aNumberOfLaps.
	positionTracker := PositionsTracker of: aGroupOfPlayers inBoardOf: size.
	cardManager := CardManager using: aDeck dealsTo: aGroupOfPlayers.
	lastAppliedEffect := NoEffect new.
]

{ #category : #action }
Board >> make: aPlay by: invokingPlayer [
	
	(aPlay card) isPermanent
		ifTrue: [ self currentPlayerThrowing ~= invokingPlayer
				ifTrue: [ Error signal: 'A permanent card can only played in the turn of the invoking player' ]
				ifFalse: [ cardManager activate: aPlay card by: invokingPlayer directedTo: aPlay target ] ]
		ifFalse: [ cardManager remove: (aPlay card) fromHandOf: invokingPlayer.
			(aPlay card) applyTo: self directedTo: (aPlay target) ]
]

{ #category : #action }
Board >> make: aPlay by: invokingPlayer in: aGame [
	
	(aPlay card) isPermanent
		ifTrue: [ self currentPlayerThrowing ~= invokingPlayer
				ifTrue: [ Error signal: 'A permanent card can only played in the turn of the invoking player' ]
				ifFalse: [ cardManager activate: aPlay card by: invokingPlayer directedTo: aPlay target ] ]
		ifFalse: [ cardManager remove: (aPlay card) fromHandOf: invokingPlayer.
			(aPlay card) applyTo: self directedTo: (aPlay target) ].
		
	self verifyThereIsAWinner ifTrue: [ aGame isNotifiedItHasFinished ].
]

{ #category : #action }
Board >> move: player by: amountPlaces [

	| playerPosition calculatedPlayerPosition |
	
	playerPosition := positionTracker absolutePositionOf: player.
	calculatedPlayerPosition := playerPosition + amountPlaces.
	calculatedPlayerPosition <= 0	ifTrue: [ calculatedPlayerPosition := 1 ].
	positionTracker update: player withNew: calculatedPlayerPosition.
	"(calculatedPlayerPosition > (self absoluteSize )) ifFalse: ["(squares at: (self positionOf: player)) place: player on: self "]."
	
]

{ #category : #action }
Board >> moveAllPlayersToFirstSquareOfTheirLap [

	| relativePositions relativePlayerPosition |
	relativePositions := positionTracker boardPositions.
	players do: [ :playerName |
		relativePlayerPosition := relativePositions at: playerName.
		self move: playerName by: ((relativePlayerPosition - 1) * (-1)).
		 ].
]

{ #category : #action }
Board >> movePlayersBack: aNumberOfSpaces except: aPlayer [
	
	| affectedPlayers |
	
	affectedPlayers := players reject: [ :player | player = aPlayer ].
	affectedPlayers
		do: [ :player | self move: player by: (-1) * aNumberOfSpaces ]
]

{ #category : #action }
Board >> nextPlayerThrows: resultOfThrow in: aGame [ 
	
	| player |
	
	player := players at: turn.
	self move: player by: resultOfThrow.
	self applyActiveCards.
	"(positionTracker absolutePositionOf: player) > self absoluteSize" self verifyThereIsAWinner ifTrue: [ aGame isNotifiedItHasFinished ] ifFalse: [ self incrementTurn ]
]

{ #category : #notification }
Board >> notifySquaresToApplyEffect [
	squares do: [ :square | square applyEffect ]
]

{ #category : #notification }
Board >> notifySquaresToNotApplyEffect [
	squares do: [ :square | square doNotApplyEffect ]
]

{ #category : #action }
Board >> play: aCard by: invokingPlayer affecting: targetedPlayer [  
	cardManager remove: aCard fromHandOf: invokingPlayer.
	aCard applyTo: self directedTo: lastAppliedEffect affecting: targetedPlayer.
]

{ #category : #action }
Board >> play: aCard by: invokingPlayer directedTo: aTarget [
	(self currentPlayerThrowing ~= invokingPlayer)
				ifTrue: [ Error signal: 'A permanent card can only played in the turn of the invoking player' ]
				ifFalse: [ cardManager activate: aCard by: invokingPlayer directedTo: aTarget ].
]

{ #category : #action }
Board >> play: aCard by: invokingPlayer directedTo: aTarget affecting: aPlayer [
	cardManager remove: aCard fromHandOf: invokingPlayer.
	aCard applyTo: self directedTo: aTarget affecting: aPlayer.
]

{ #category : #action }
Board >> play: aCard directedToAllBy: invokingPlayer [
	self play: aCard by: invokingPlayer directedTo: players. 
	
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

{ #category : #accessing }
Board >> size [
	^size
]

{ #category : #action }
Board >> updateLastApplied: effect [
	lastAppliedEffect := effect.
]

{ #category : #'as yet unclassified' }
Board >> verifyThereIsAWinner [
	^ players anySatisfy: [ :player | (positionTracker absolutePositionOf: player) > self absoluteSize ].
]
