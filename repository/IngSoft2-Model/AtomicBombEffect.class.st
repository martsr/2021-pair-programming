Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard setUpSquaresToNotApplyEffect.
	aBoard moveAllPlayersToFirstSquareOfTheirLap.
	aBoard setUpSquaresToApplyEffect
]
