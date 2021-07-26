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

{ #category : #'as yet unclassified' }
BoardSquare class >> applying: anEffect withReverseMode: aReversedMode [
	^self new initializeApplying: anEffect withReverseMode: aReversedMode. 
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
BoardSquare >> initializeApplying: anEffect withReverseMode: reversedMode [
	effect := anEffect.
	reversed:= reversedMode . 
	applyEffect := true
]

{ #category : #action }
BoardSquare >> place: player on: aBoard [

	applyEffect ifTrue:[ 
		aBoard disableEffectsDuring: [ 
			effect applyOn: aBoard activatedBy: player withReversedMode: reversed. 
			aBoard updateLastApplied: effect with: reversed ]. ]
]

{ #category : #action }
BoardSquare >> reverseEffect [
	reversed := reversed
		ifTrue: [ false ]
		ifFalse: [ true ]
]

{ #category : #action }
BoardSquare >> reverseEffectOn: aBoard [
	| reversedMode |
	reversedMode := reversed
		ifTrue: [ false ]
		ifFalse: [ true ].
	^ BoardSquare applying: effect withReverseMode: reversedMode 
]
