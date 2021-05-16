Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> applyOn: aBoard activatedBy: aPlayer [

	aBoard notifySquaresToNotApplyEffect.
	aBoard move: aPlayer by: 4.
	aBoard notifySquaresToApplyEffect
]

{ #category : #testing }
SpeedUpEffect >> typeOfEffect [
	^ 'Speed Up'.
]
