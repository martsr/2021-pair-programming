Class {
	#name : #Play,
	#superclass : #Object,
	#instVars : [
		'target',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Play class >> madeBy: aCard directedTo: aTarget [ 
	self validateTargetIsNotEmpty: aTarget.
	^ self new initializeMadeBy: aCard directedTo: aTarget .
]

{ #category : #validation }
Play class >> validateTargetIsNotEmpty: aTarget [
	
	(aTarget size) < 1 ifTrue: [ Error signal: 'A play can not be created with no targets' ].
]

{ #category : #accessing }
Play >> card [
	^ card.
]

{ #category : #'as yet unclassified' }
Play >> directedTo: aTarget [
	^target includes: aTarget.
]

{ #category : #initialization }
Play >> initializeMadeBy: aCard directedTo: aTarget [
	target := aTarget.
	card := aCard.
]

{ #category : #accessing }
Play >> target [
	^ target copy.
]
