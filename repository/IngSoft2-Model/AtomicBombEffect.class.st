Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyOn: aBoard activatedBy: aPlayer [
	| playerIndex amountOfSquaresToGoBack aGame |
	aBoard setUpSquaresToNotApplyEffect.
	aGame players
		do: [ :player | 
			playerIndex := aGame players indexOf: player.
			amountOfSquaresToGoBack := (aGame board whereIsPlayer: player) = 1
			ifTrue: [ 0 ]
			ifFalse: [ (aGame board whereIsPlayer: player) * -1 + 1 ].
			aGame board move: player by: amountOfSquaresToGoBack in: aGame with: playerIndex ].
	aGame board setUpSquaresToApplyEffect
]
