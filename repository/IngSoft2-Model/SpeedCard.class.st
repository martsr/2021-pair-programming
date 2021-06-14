Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: 1
]

{ #category : #'instance creation' }
SpeedCard >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer
	
]

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true
]

{ #category : #'as yet unclassified' }
SpeedCard >> retargetedBy: invokingPlayer using: aTarget [
	^ self asPlayAffecting: aTarget by: invokingPlayer
]
