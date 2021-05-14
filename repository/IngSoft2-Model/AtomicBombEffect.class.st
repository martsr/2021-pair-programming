Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard setUpSquaresToNotApplyEffect.
	aBoard moveAllPlayersToFirstSquareOfTheirLap.
	aBoard setUpSquaresToApplyEffect
]

{ #category : #testing }
AtomicBombEffect >> typeOfEffect [
	^ 'Atomic Bomb'.
]
