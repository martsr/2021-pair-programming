Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard notifySquaresToNotApplyEffect.
	aBoard moveAllPlayersToFirstSquareOfTheirLap.
	aBoard notifySquaresToApplyEffect
]

{ #category : #testing }
AtomicBombEffect >> typeOfEffect [
	^ 'Atomic Bomb'.
]
