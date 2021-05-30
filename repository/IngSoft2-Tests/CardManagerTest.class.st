Class {
	#name : #CardManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardManagerTest >> test01CardManagerDealsTwoCardsTwoEachPlayerAtTheStart [

	| players cards deck cardManager overloadCard speedCard accelerationCard cancellationCard redoCard repeatCard |
	players := OrderedCollection newFrom: { 'Fran' . 'Martu' . 'Mango'}.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
	cards := OrderedCollection newFrom: { overloadCard . speedCard . accelerationCard . cancellationCard . redoCard . repeatCard }.
	deck := Deck having: cards.
	cardManager := CardManager using: deck dealsTo: players.
	self assert: (cardManager handOf: 'Fran') equals: (OrderedCollection newFrom: { overloadCard . speedCard }).
	self assert: (cardManager handOf: 'Martu') equals: (OrderedCollection newFrom: { accelerationCard . cancellationCard }).
	self assert: (cardManager handOf: 'Mango') equals: (OrderedCollection newFrom: { redoCard . repeatCard }).
	
	
]
