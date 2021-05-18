Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard moveAllPlayersToFirstSquareOfTheirLap.

]

{ #category : #testing }
AtomicBombEffect >> typeOfEffect [
	^ 'Atomic Bomb'.
]
