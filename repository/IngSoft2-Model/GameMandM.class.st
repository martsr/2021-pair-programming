Class {
	#name : #GameMandM,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'isFinished',
		'turn',
		'players',
		'laps',
		'playerLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameMandM class >> playedOn: aBoard by: players using: aDiceCup requiring: amountOfLaps [
	self validatesItMustHaveAtLeastOnePlayer: players.
	self validatesItDoesntHavePlayersWithSameName: players.
	self validatesItNeedsAtLeastOneLap: amountOfLaps.
	^ self new intializePlayedOn: aBoard by: players using: aDiceCup requiring: amountOfLaps
]

{ #category : #validation }
GameMandM class >> validatesItDoesntHavePlayersWithSameName: players [

	| playerNames |
	
	playerNames := players collect: [ :player | player name ].
	playerNames := playerNames asSet.
	(players size) > (playerNames size) ifTrue: [ Error signal: 'A game cannot be created with any players having repeated names' ]
]

{ #category : #validation }
GameMandM class >> validatesItMustHaveAtLeastOnePlayer: aPlayer [
	aPlayer size < 1
		ifTrue: [ Error signal: 'A game must have at least 1 player' ]
]

{ #category : #'instance creation' }
GameMandM class >> validatesItNeedsAtLeastOneLap: amountOfLaps [
	amountOfLaps < 1
		ifTrue: [ Error signal: 'A game requires at least one lap to be playable.' ]
]

{ #category : #'as yet unclassified' }
GameMandM >> amountOfLaps [
	^laps.
]

{ #category : #initialization }
GameMandM >> intializePlayedOn: aBoard by: participants using: aDiceCup requiring: amountOfLaps [

	board := aBoard.
	players := participants.
	diceCup := aDiceCup.
	isFinished := false.
	turn := 1.
	laps:= amountOfLaps. 
	playerLaps := Dictionary new.
	1 to: (players size) do: [ :position | playerLaps at: ((players at: position) name) put: 0 ].
	board setUpWith: players
]

{ #category : #'as yet unclassified' }
GameMandM >> isNotified: aPlayer made: amountOfLaps [
	| playerName lapsDone |
	playerName := aPlayer name.
	lapsDone := playerLaps at: playerName.
	playerLaps at: playerName put:amountOfLaps.
	(playerLaps at: playerName) >= laps
		ifTrue: [ self placeWinnerInFirstSquare: aPlayer  ].
]

{ #category : #action }
GameMandM >> nextPlayerThrows [

	| resultOfThrow player |
	
	self verifyItisFinished.
	player := players at: turn.
	resultOfThrow := player throwsWith: diceCup.
	board move: player by: resultOfThrow in: self onCurrent: (playerLaps at: (player name)).
	self verifyNextPlayerNeedsToThrow.
	
]

{ #category : #'as yet unclassified' }
GameMandM >> placeWinnerInFirstSquare: aPlayer [
	playerLaps at: aPlayer name put:laps.
	board places: aPlayer at: 1.
	isFinished := true
]

{ #category : #accesing }
GameMandM >> playerPositions [

	| numberPositions playerPositions |
	
	numberPositions := board finalPositionsOf: players.
	playerPositions := Dictionary new.
	1 to: numberPositions size do: [ :position | playerPositions at: ((players at: position) name) put: (numberPositions at: position) ].
	^playerPositions.
]

{ #category : #'as yet unclassified' }
GameMandM >> playerRanking [

	| placementCalculations playerRanking rankingNames |
	
	placementCalculations := playerLaps copy.
	placementCalculations keysDo: [ :playerName | placementCalculations at: playerName put:((playerLaps at: playerName) * (board boardSquares) + (self playerPositions at: playerName))].
	playerRanking := players sort: [ :playerOne :playerTwo | (placementCalculations at: playerOne name) > (placementCalculations at: playerTwo name)].
	rankingNames := playerRanking collect: [ :player | player name ].
	^rankingNames. 
]

{ #category : #private }
GameMandM >> verifyItIsInProgress [
	isFinished ifFalse: [ Error signal: 'A winner cannot be determined, the game is still in progress' ]
]

{ #category : #private }
GameMandM >> verifyItisFinished [
	isFinished ifTrue: [ Error signal: 'The game has finished, dice cannot be rolled anymore' ]
]

{ #category : #private }
GameMandM >> verifyNextPlayerNeedsToThrow [
	isFinished ifFalse: [ turn := (turn rem: (players size )) + 1 ]
]

{ #category : #accesing }
GameMandM >> winner [
	| winnerName winner |
	self verifyItIsInProgress.
	winnerName := playerLaps keyAtValue: laps.
	winner := players detect: [ :player | player name = winnerName ].
	^ winner
]
