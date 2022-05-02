!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 21:35:18'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self verifynumberOfMilisecondstoExecute: [customerBook addCustomerNamed: 'John Lennon'] isLessThan: 50).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 16:50:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self verifynumberOfMilisecondstoExecute: [customerBook removeCustomerNamed: paulMcCartney] isLessThan: 100).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 22:41:43'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self evaluate: [ customerBook addCustomerNamed: ''.]
	withError: Error 
	verify: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 22:42:08'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self evaluate: [ customerBook removeCustomerNamed: 'Paul McCartney'. ]
	withError: NotFound
	verify: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 16:20:58'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addAndSuspendCostumerNamed: paulMcCartney.

	self assert: (self verify: customerBook hasCorrectNumberOfCostumers: 1 andNumberOfActiveCostumers: 0).
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 16:22:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addAndSuspendCostumerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: (self verify: customerBook hasCorrectNumberOfCostumers: 0 andNumberOfActiveCostumers: 0).
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 22:42:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self evaluate: [ customerBook suspendCustomerNamed: 'Ringo Starr'. ]
	withError: CantSuspend
	verify: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rp 5/1/2022 22:42:40'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addAndSuspendCostumerNamed: johnLennon.
	
	self evaluate: [ customerBook suspendCustomerNamed: johnLennon. ]
	withError: CantSuspend 
	verify: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rp 5/1/2022 22:40:35'!
evaluate: anAction withError: aTypeOfError verify: anotherAction
	
	[anAction value.
		self fail ]
	on: aTypeOfError 
	do: anotherAction 
! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rp 5/1/2022 21:41:44'!
verify: anInstanceOfCustomerBook hasCorrectNumberOfCostumers: totalNumberOfCostumers andNumberOfActiveCostumers: numberOfActiveCostumers

	^(numberOfActiveCostumers isEqualTo: anInstanceOfCustomerBook numberOfActiveCustomers) and:
	[totalNumberOfCostumers isEqualTo: anInstanceOfCustomerBook numberOfCustomers] and:
	[(totalNumberOfCostumers - numberOfActiveCostumers) isEqualTo: anInstanceOfCustomerBook numberOfCustomers].
	! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rp 5/1/2022 22:17:43'!
verifynumberOfMilisecondstoExecute: aProcess isLessThan: numberOfMiliseconds
	| millisecondsBeforeRunning millisecondsAfterRunning | 
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aProcess value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < (numberOfMiliseconds * millisecond)
	 ! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'rp 5/1/2022 15:46:31'!
addAndSuspendCostumerNamed: aName
	self addCustomerNamed: aName.
	self suspendCustomerNamed: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'rp 5/1/2022 23:09:33'!
removeCustomerNamed: aName 

	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^NotFound signal]].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
