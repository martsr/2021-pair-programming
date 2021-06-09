Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> applyTo: aBoard directedTo: targetedPLayer [

	aBoard move: targetedPLayer by: -2.
]

{ #category : #converting }
OverloadCard >> asPlayAffecting: target [
	^ Play madeBy: self directedTo: target.
]

{ #category : #accessing }
OverloadCard >> isPermanent [
	^ true.
]
