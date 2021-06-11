Class {
	#name : #Play,
	#superclass : #Object,
	#instVars : [
		'target',
		'card',
		'additionalTarget',
		'invokingPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Play class >> madeBy: aCard affecting: aPlayer directedTo: target [
	^self new initializeMadeBy: aCard affecting: aPlayer directedTo: target
]

{ #category : #'instance creation' }
Play class >> madeBy: aCard directedTo: aTarget [
	^ self new initializeMadeBy: aCard directedTo: aTarget .
]

{ #category : #'instance creation' }
Play class >> madeBy: aCard directedTo: aTarget calledBy: invokingPlayer [ 
	^ self new initializeMadeBy: aCard directedTo: aTarget by: invokingPlayer.
]

{ #category : #comparing }
Play >> = aPlay [ 
	^((aPlay card) = (self card)) and:(((aPlay target) includesAll: (self target)) and: (aPlay invokingPlayer) = (self invokingPlayer))
]

{ #category : #accessing }
Play >> card [
	^ card.
]

{ #category : #'as yet unclassified' }
Play >> directedTo: aTarget [
	^target includesAll: aTarget.
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

{ #category : #initialization }
Play >> initializeMadeBy: aCard directedTo: aTarget by: anInvokingPlayer [

	card := aCard.
	target := aTarget.
	invokingPlayer := anInvokingPlayer. 
	
]

{ #category : #accessing }
Play >> invokingPlayer [
	^invokingPlayer.
]

{ #category : #accessing }
Play >> target [
	^ target copy.
]
