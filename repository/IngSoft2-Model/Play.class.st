Class {
	#name : #Play,
	#superclass : #Object,
	#instVars : [
		'target',
		'card',
		'additionalTarget'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Play class >> madeBy: aCard affecting: aPlayer directedTo: target [
	^self new initializeMadeBy: aCard affecting: aPlayer directedTo: target
]

{ #category : #'instance creation' }
Play class >> madeBy: aCard directedTo: aTarget [ 
	self validateTargetIsNotEmpty: aTarget.
	^ self new initializeMadeBy: aCard directedTo: aTarget .
]

{ #category : #validation }
Play class >> validateTargetIsNotEmpty: aTarget [
	
	(aTarget size) < 1 ifTrue: [ Error signal: 'A play can not be created with no targets' ].
]

{ #category : #comparing }
Play >> = aPlay [ 
	^ (card = aPlay card) and: ((target = aPlay target) and: additionalTarget = (aPlay additionalTarget)).
]

{ #category : #accessing }
Play >> additionalTarget [
	^ additionalTarget.
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
Play >> initializeMadeBy: aCard affecting: aPlayer directedTo: aTarget [

	card := aCard.
	target := aPlayer.
	additionalTarget := aTarget. 
	
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
