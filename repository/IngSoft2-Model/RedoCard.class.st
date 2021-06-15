Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyRedoCardTo: (aTarget target) by: (aTarget invokingPlayer)
]

{ #category : #accessing }
RedoCard >> isPermanent [
	^ false

]
