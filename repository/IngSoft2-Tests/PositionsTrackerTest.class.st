Class {
	#name : #PositionsTrackerTest,
	#superclass : #TestCase,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #generators }
PositionsTrackerTest >> generatePlayerCollectionWith: playerNames [

	players := OrderedCollection new.
	players := playerNames collect: [ :name | Player named: name ].
]

{ #category : #running }
PositionsTrackerTest >> setUp [

	super setUp. 
	players := OrderedCollection new.
]

{ #category : #tests }
PositionsTrackerTest >> test01PositionTrackerIsCreatedFromAGroupOfPlayersandTheirInitalPositionsAreBeingDisplayed [

| positionTracker playersPositions |

	self generatePlayerCollectionWith: #('Fran' 'Martu' 'Vader').
	positionTracker := PositionsTracker of: players inBoardSize: 20 requiring: 2.
	playersPositions:= Dictionary newFrom: {'Fran' ->1 . 'Martu'-> 1 .'Vader' ->1 }.
	self assert: (positionTracker actualPositions) equals: playersPositions.
]
