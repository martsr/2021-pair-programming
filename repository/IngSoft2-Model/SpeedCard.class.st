Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyTo: aBoard directedTo: targetedPlayer [

	aBoard move: targetedPlayer by: 1.
]

{ #category : #converting }
SpeedCard >> asPlayAffecting: aTarget [
	^ Play madeBy: self directedTo: aTarget.
]

{ #category : #accessing }
SpeedCard >> isPermanent [ 
	^ true.
]
