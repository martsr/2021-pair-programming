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
	^ effect.
]

{ #category : #initialization }
BoardSquare >> initializeApplying: anEffect [
	effect := anEffect.
	applyEffect := true
]

{ #category : #action }
BoardSquare >> place: player on: aBoard [

	applyEffect ifTrue:[ 
		aBoard disableEffectsDuring: [ 
			effect applyOn: aBoard activatedBy: player. 
			aBoard updateLastApplied: effect ]. 
		].
]
