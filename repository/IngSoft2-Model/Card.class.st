Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Card >> applyTo: aBoard directedTo: target [
	self subclassResponsibility.
]

{ #category : #accessing }
Card >> isPermanent [
	self subclassResponsibility.
]
