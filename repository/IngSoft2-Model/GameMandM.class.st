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
		'playersAbsolutePositions'
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
	^ laps.
]

{ #category : #accessing }
GameMandM >> board [
 ^board. 
]

{ #category : #initialization }
GameMandM >> intializePlayedOn: aBoard by: participants using: aDiceCup requiring: amountOfLaps [
	
	board := aBoard.
	players := participants.
	diceCup := aDiceCup.
	isFinished := false.
	turn := 1.
	laps := amountOfLaps.
	playersAbsolutePositions := OrderedCollection new.
	1 to: players size do: [ :position | playersAbsolutePositions add: 1 ].
	board setUpWith: players on: self.
]

{ #category : #'as yet unclassified' }
GameMandM >> isNotified: aPlayer movedTo: newPlayerPosition [
	
	| playerIndex |
	
	playerIndex := players indexOf: aPlayer.
	playersAbsolutePositions at: playerIndex put: newPlayerPosition.
	(playersAbsolutePositions at: playerIndex) > (board boardSquares * laps) ifTrue: [ isFinished := true ]
]

{ #category : #action }
GameMandM >> nextPlayerThrows [

	| resultOfThrow player playerIndex |
	
	self verifyItisFinished.
	player := players at: turn.
   playerIndex := players indexOf: player.
	resultOfThrow := player throwsWith: diceCup.
	board move: player by: resultOfThrow in: self with: playerIndex.
	self verifyNextPlayerNeedsToThrow.
	
]

{ #category : #'as yet unclassified' }
GameMandM >> playerAbsolutePositions [

	^ playersAbsolutePositions copy.
]

{ #category : #testing }
GameMandM >> playerLaps [
	| numberPositions playerPositions |
	 
	numberPositions := playersAbsolutePositions collect: [ :position | position // (board boardSquares) ].
	playerPositions := Dictionary new.
	1 to: numberPositions size do: [ :position | playerPositions at: ((players at: position) name) put: (numberPositions at: position) ].
	^playerPositions.
]

{ #category : #accesing }
GameMandM >> playerPositions [

	| numberPositions playerPositions |
	 
	numberPositions := playersAbsolutePositions collect: [ :position | (position rem: (board boardSquares)) = 0 ifTrue: [ position ] ifFalse: [ position rem: (board boardSquares) ] ].
	playerPositions := Dictionary new.
	1 to: numberPositions size do: [ :position | playerPositions at: ((players at: position) name) put: (numberPositions at: position) ].
	^playerPositions.
]

{ #category : #'as yet unclassified' }
GameMandM >> playerRanking [

	| placementCalculations playerRanking rankingNames |
	
	placementCalculations := Dictionary new.
	1 to: (players size) do: [ :index | placementCalculations at: ((players at:index) name) put:(playersAbsolutePositions at: index)].
	playerRanking := players sort: [ :playerOne :playerTwo | (placementCalculations at: playerOne name) > (placementCalculations at: playerTwo name) and: (playerOne name > playerTwo name)].
	rankingNames := playerRanking collect: [ :player | player name ].
	^rankingNames. 
]

{ #category : #accessing }
GameMandM >> players [
 ^players copy. 
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
	| winner winnerIndex |
	
	self verifyItIsInProgress.
	winnerIndex := playersAbsolutePositions detect: [ :position | position >= (((board boardSquares) * laps) + 1)].
	winnerIndex := playersAbsolutePositions indexOf: winnerIndex.
	winner := players at: winnerIndex.
	^ winner
]
