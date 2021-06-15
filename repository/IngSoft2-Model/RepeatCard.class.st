Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyTo: aBoard directedTo: aTarget [
	aBoard applyRepeatCardTo: (aTarget target)
	
]

{ #category : #accessing }
RepeatCard >> isPermanent [
	^ false
]
