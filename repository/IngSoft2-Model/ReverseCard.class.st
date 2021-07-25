Class {
	#name : #ReverseCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReverseCard >> applyTo: aBoard directedTo: aTarget [
	"validar el valor del casillero sea posible, negativo, entre el tamaño del board"
	aBoard applyReverseCardTo: aTarget
]

{ #category : #action }
ReverseCard >> handle: aBoard for: aPlay [
	aBoard handlePermanentCardFrom: aPlay
]

{ #category : #'as yet unclassified' }
ReverseCard >> handleActivationOf: aPlay on: aBoard [
"fijarse si con solo gaurdar el numero de casillero afectado alcanza"
	aBoard addToReverseCards: aPlay
]

{ #category : #'as yet unclassified' }
ReverseCard >> handleRemovalOf: aPlay on: aBoard [ 
	aBoard applyReverseCardTo: (aPlay target).
]
