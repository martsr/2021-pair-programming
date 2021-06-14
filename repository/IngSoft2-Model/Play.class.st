Class {
	#name : #Play,
	#superclass : #Object,
	#instVars : [
		'target',
		'card',
		'invokingPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Play class >> madeBy: aCard directedTo: aTarget calledBy: invokingPlayer [ 
	^ self new initializeMadeBy: aCard directedTo: aTarget calledBy: invokingPlayer.
]

{ #category : #comparing }
Play >> = aPlay [ 
	^((aPlay card) = (self card)) and:(((aPlay target) includesAll: (self target)) and: (aPlay invokingPlayer) = (self invokingPlayer))
]

{ #category : #accessing }
Play >> card [
	^ card
]

{ #category : #initialization }
Play >> initializeMadeBy: aCard directedTo: aTarget calledBy: anInvokingPlayer [

	card := aCard.
	target := aTarget.
	invokingPlayer := anInvokingPlayer
	
]

{ #category : #accessing }
Play >> invokingPlayer [
	^invokingPlayer
]

{ #category : #accessing }
Play >> target [
	^ target copy
]
