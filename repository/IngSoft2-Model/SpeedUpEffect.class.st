Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> applyOn: aBoard activatedBy: aPlayer withReversedMode: reversed [
	reversed ifTrue: [ aBoard move: aPlayer by: -4 ]
	ifFalse: [ aBoard move: aPlayer by: 4 ]
]
