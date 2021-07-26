Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
	aBoard moveAllPlayersToFirstSquareOfTheirLap
]
