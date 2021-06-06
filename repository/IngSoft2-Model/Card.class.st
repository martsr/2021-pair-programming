Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> isPermanent [
	self subclassResponsibility.
]
