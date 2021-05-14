Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard setUpSquaresToNotApplyEffect.
	aBoard move: aPlayer by: 4.
	aBoard setUpSquaresToApplyEffect
]

{ #category : #testing }
SpeedUpEffect >> typeOfEffect [
	^ 'Speed Up'.
]
