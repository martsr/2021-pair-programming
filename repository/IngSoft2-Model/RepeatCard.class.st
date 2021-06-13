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
RepeatCard >> asPlayAffecting: aTarget by: invokingPlayer [ 
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer.
]

{ #category : #accessing }
RepeatCard >> isPermanent [
	^ false.
]

{ #category : #'as yet unclassified' }
RepeatCard >> retargetedBy: invokingPlayer using: aTarget [
	^ self asPlayAffecting: aTarget by: invokingPlayer.
]
