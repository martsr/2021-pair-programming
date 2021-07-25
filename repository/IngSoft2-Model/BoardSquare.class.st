Class {
	#name : #BoardSquare,
	#superclass : #Object,
	#instVars : [
		'effect',
		'applyEffect',
		'reversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardSquare class >> applying: anEffect [
	^self new initializeApplying: anEffect. 
]

{ #category : #action }
BoardSquare >> applyEffect [
	applyEffect := true
]

{ #category : #action }
BoardSquare >> doNotApplyEffect [
applyEffect := false
]

{ #category : #testing }
BoardSquare >> effect [
	^ effect
]

{ #category : #initialization }
BoardSquare >> initializeApplying: anEffect [
	effect := anEffect.
	reversed:= false. 
	applyEffect := true
]

{ #category : #action }
BoardSquare >> place: player on: aBoard [

	applyEffect ifTrue:[ 
		aBoard disableEffectsDuring: [ 
			effect applyOn: aBoard activatedBy: player withReversedMode: reversed. 
			aBoard updateLastApplied: effect ]. ]
]

{ #category : #'as yet unclassified' }
BoardSquare >> reverseEffect [
	reversed := reversed
		ifTrue: [ false ]
		ifFalse: [ true ]
]
