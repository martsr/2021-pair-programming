Class {
	#name : #DeterministicDie,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces',
		'sequence',
		'index'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicDie class >> having: aSequence [
	self verifyIsNotEmpty: aSequence.
	^ self new initializeHaving: aSequence
]

{ #category : #'instance creation' }
DeterministicDie class >> verifyIsNotEmpty: aSequence [
	aSequence isEmpty
		ifTrue: [ Error
				signal: 'The deterministic die sequence must at least contain one number' ]
]

{ #category : #initialization }
DeterministicDie >> initializeHaving: aSequence [
	sequence := aSequence.
	index := 1.
]

{ #category : #action }
DeterministicDie >> throw [

	| sequenceValue |
	
	sequenceValue := sequence at: index.
	index := (index rem: (sequence size)) + 1.
	^ sequenceValue
]
