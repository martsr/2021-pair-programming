Class {
	#name : #GameMandM,
	#superclass : #Object,
	#instVars : [
		'board',
		'isFinished',
		'diceCup'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameMandM class >> playedOn: aBoard using: aDiceCup [
	^self new initializePlayedOn: aBoard using: aDiceCup.
]

{ #category : #accessing }
GameMandM >> activeCards [
	^ board activeCards.
]

{ #category : #accessing }
GameMandM >> handOf: aPlayer [
	^ board handOf: aPlayer.
]

{ #category : #initialization }
GameMandM >> initializePlayedOn: aBoard using: aDiceCup [
	
	diceCup := aDiceCup.
	board := aBoard.
	isFinished := false

]

{ #category : #notification }
GameMandM >> isNotifiedItHasFinished [
	isFinished := true
]

{ #category : #action }
GameMandM >> make: aPlay [
	self verifyItisFinished.
	board make: aPlay in: self.
]

{ #category : #action }
GameMandM >> nextTurn [
	| resultOfThrow |
	
	self verifyItisFinished.
	resultOfThrow := diceCup throw.
	board nextPlayerThrows: resultOfThrow in: self.
]

{ #category : #testing }
GameMandM >> playerLaps [
	| playerLaps |
	playerLaps := board playerLaps.
	^ playerLaps
]

{ #category : #accesing }
GameMandM >> playerPositions [
	| playerPositions |
	playerPositions := board playerPositions.
	^ playerPositions
]

{ #category : #testing }
GameMandM >> playerRanking [
	| playerRanking |
	playerRanking := board playerRanking.
	^ playerRanking
]

{ #category : #private }
GameMandM >> verifyItIsInProgress [
	isFinished ifFalse: [ Error signal: 'A winner cannot be determined, the game is still in progress' ]
]

{ #category : #private }
GameMandM >> verifyItisFinished [
	isFinished ifTrue: [ Error signal: 'The game has finished, dice cannot be rolled anymore nor cards can be played' ]
]

{ #category : #accesing }
GameMandM >> winner [
	| winner playerRanking |
	self verifyItIsInProgress.
	playerRanking := board playerRanking.
	winner := playerRanking at: 1.
	^ winner
]
