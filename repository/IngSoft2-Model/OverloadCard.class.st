Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: -2
]

{ #category : #converting }
OverloadCard >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer
]

{ #category : #accessing }
OverloadCard >> isPermanent [
	^ true
]

{ #category : #'as yet unclassified' }
OverloadCard >> retargetedBy: invokingPlayer using: aTarget [
	^ self asPlayAffecting: aTarget by: invokingPlayer
]
