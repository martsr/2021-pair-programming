Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyRepeatCardTo: (aTarget target)
	
]

{ #category : #'instance creation' }
RepeatCard >> asPlayAffecting: aPlayer by: invokingPlayer [
	| targetedPlayer |
	targetedPlayer := OrderedCollection newFrom: { aPlayer }.
	^ super asPlayAffecting: targetedPlayer by: invokingPlayer. 
]

{ #category : #accessing }
RepeatCard >> isPermanent [
	^ false
]
