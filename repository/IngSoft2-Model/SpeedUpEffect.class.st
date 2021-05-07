Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUpEffect >> applyOn: aGame activatedBy: aPlayer [

	| playerIndex |
	
	(aGame board) setUpSquaresToNotApplyEffect.
	playerIndex := aGame players indexOf: aPlayer.
	(aGame board) move: aPlayer by: 4 in: aGame with: playerIndex.
	(aGame board) setUpSquaresToApplyEffect
]
