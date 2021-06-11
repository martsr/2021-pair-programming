Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyRepeatCardTo: (aTarget target) .
	
]

{ #category : #action }
RepeatCard >> applyTo: aBoard directedTo: anEffect affecting: aPlayer [.
	aBoard applyRepeatCardTo: anEffect affecting: aPlayer.
]

{ #category : #converting }
RepeatCard >> asPlayAffecting: aTarget [
	^ Play madeBy: self directedTo: aTarget.
]

{ #category : #action }
RepeatCard >> asPlayAffecting: aTarget by: invokingPlayer [ 
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer.
]

{ #category : #accessing }
RepeatCard >> isPermanent [
	^ false.
]
