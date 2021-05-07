Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
AtomicBombEffect >> applyOn: aGame activatedBy: aPlayer [
	| playerIndex amountOfSquaresToGoBack |
	aGame board setUpSquaresToNotApplyEffect.
	aGame players
		do: [ :player | 
			playerIndex := aGame players indexOf: player.
			amountOfSquaresToGoBack := (aGame board whereIsPlayer: player) = 1
			ifTrue: [ 0 ]
			ifFalse: [ (aGame board whereIsPlayer: player) * -1 + 1 ].
			aGame board move: player by: amountOfSquaresToGoBack in: aGame with: playerIndex ].
	aGame board setUpSquaresToApplyEffect
]
