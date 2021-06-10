Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyRedoCardTo: aTarget.
]

{ #category : #action }
RedoCard >> asPlayAffecting: aTarget [
	^Play madeBy: self directedTo: aTarget. 
]

{ #category : #accessing }
RedoCard >> isPermanent [
	^ false.
	"Pendiente de hablar si la carta es permanente o no y cuando se puede jugar"
]
