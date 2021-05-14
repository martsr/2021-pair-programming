Class {
	#name : #BoardSquare,
	#superclass : #Object,
	#instVars : [
		'effect',
		'applyEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardSquare class >> withEffect: anEffect [
	^self new initializeWithEffect: anEffect. 
]

{ #category : #'as yet unclassified' }
BoardSquare >> changeToApplyEffect [
	applyEffect := true
]

{ #category : #'as yet unclassified' }
BoardSquare >> changeToNotApplyEffect [
applyEffect := false
]

{ #category : #initialization }
BoardSquare >> initializeWithEffect: anEffect [ 
	effect := anEffect.
	applyEffect:= true.
]

{ #category : #'as yet unclassified' }
BoardSquare >> place: player on: aBoard [

	applyEffect ifTrue:[ effect applyOn: aBoard activatedBy: player ].
]

{ #category : #testing }
BoardSquare >> typeOfEffect [
	^ effect typeOfEffect.
]
