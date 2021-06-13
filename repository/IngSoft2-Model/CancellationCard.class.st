Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyCancellationCardTo: (aTarget target) .
]

{ #category : #converting }
CancellationCard >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer.
	
]

{ #category : #accessing }
CancellationCard >> isPermanent [
	^ false.
]

{ #category : #'as yet unclassified' }
CancellationCard >> retargetedBy: invokingPlayer using: aTarget [ 
	^ self asPlayAffecting: aTarget by: invokingPlayer
]
