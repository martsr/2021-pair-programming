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
GameMandM class >> playedOn: aBoard [ 
	^self new initializePlayedOn: aBoard.
]

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

{ #category : #initialization }
GameMandM >> initializePlayedOn: aBoard [
 	board:= aBoard. 
	isFinished := false.
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
GameMandM >> isNotifiedItHasFinished [
	isFinished := true .
]

{ #category : #'as yet unclassified' }
GameMandM >> nextTurn [
	
	self verifyItisFinished.
	board nextPlayerThrowsIn: self.

	
]

{ #category : #'as yet unclassified' }
GameMandM >> playerAbsolutePositions [

	^ playersAbsolutePositions copy.
]

{ #category : #testing }
GameMandM >> playerLaps [
	| playerLaps |
	playerLaps := board playerLaps.
	^ playerLaps.
]

{ #category : #accesing }
GameMandM >> playerPositions [
	 
	| playerPositions |
	playerPositions := board playerPositions .
	^playerPositions.
]

{ #category : #testing }
GameMandM >> playerRanking [

	| playerRanking |
	playerRanking := board playerRanking.
	^ playerRanking.
]

{ #category : #private }
GameMandM >> verifyItIsInProgress [
	isFinished ifFalse: [ Error signal: 'A winner cannot be determined, the game is still in progress' ]
]

{ #category : #private }
GameMandM >> verifyItisFinished [
	isFinished ifTrue: [ Error signal: 'The game has finished, dice cannot be rolled anymore' ]
]

{ #category : #accesing }
GameMandM >> winner [
	| winner playerRanking |
	
	self verifyItIsInProgress.
	playerRanking := board playerRanking. 
	winner:= playerRanking at: 1.
	^ winner
]
