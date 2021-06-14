Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyRedoCardTo: (aTarget target) by: (aTarget invokingPlayer)
]

{ #category : #converting }
RedoCard >> asPlayAffecting: aTarget by: invokingPlayer [
	^ Play madeBy: self directedTo: aTarget calledBy: invokingPlayer
]

{ #category : #accessing }
RedoCard >> isPermanent [
	^ false

]
