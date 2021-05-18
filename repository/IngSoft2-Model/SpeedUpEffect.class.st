Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard move: aPlayer by: 4.
]

{ #category : #testing }
SpeedUpEffect >> typeOfEffect [
	^ 'Speed Up'.
]
