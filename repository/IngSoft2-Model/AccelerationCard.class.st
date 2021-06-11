Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> applyTo: aBoard directedTo: aTarget [

	aBoard move: aTarget by: 1.
]

{ #category : #converting }
AccelerationCard >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer.
	
]

{ #category : #accessing }
AccelerationCard >> isPermanent [
	^ true.
]
