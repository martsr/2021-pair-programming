Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyTo: aBoard directedTo: aTarget [
	aBoard move: aTarget by: -2
]

{ #category : #accessing }
OverloadCard >> isPermanent [
	^ true
]
