!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRover eastOrientatedHead northOrientatedHead westOrientatedHead southOrientatedHead'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:56:10'!
test01MarsRoverBeginsWithCorrectPositionAndHeadOrientation
	
	self assert: (marsRover position = (0@0)). 
	self assert: (marsRover headOrientation = northOrientatedHead). ! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:35:49'!
test02MarsRoverMovesForwardAndPositionUpdates
	
	self send: 'f' toMarsRoverAndVerifyFinalPositionIs: (0@1) andHeadPointsTo: northOrientatedHead.! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:35:56'!
test03MarsRoverMovesBackwardsAndPositionUpdates
	
	self send: 'b' toMarsRoverAndVerifyFinalPositionIs: (0@-1) andHeadPointsTo: northOrientatedHead.! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:56:41'!
test04MarsRoverRotatesLeftAndHeadOrientationUpdates

	self send: 'l' toMarsRoverAndVerifyFinalPositionIs: (0@0) andHeadPointsTo: westOrientatedHead.
	! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:36:07'!
test05MarsRoverMovesForwardTwiceInARowAndPositionUpdates

	self send: 'ff' toMarsRoverAndVerifyFinalPositionIs: (0@2) andHeadPointsTo: northOrientatedHead.! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:56:51'!
test06MarsRoverRotatesRightTwiceInARowAndHeadOrientationUpdates

	self send: 'rr' toMarsRoverAndVerifyFinalPositionIs: (0@0) andHeadPointsTo: southOrientatedHead.! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:36:18'!
test07MarsRoverMovesAndReturnsToOriginalPosition
	
	self send: 'frfrfrf' toMarsRoverAndVerifyFinalPositionIs: (0@0) andHeadPointsTo: westOrientatedHead.! !

!MarsRoverTests methodsFor: 'movements' stamp: 'mr 5/29/2022 21:57:20'!
test08MarsRoverReceivesTwoListsOfInstructions
	
	marsRover executeInstructions: 'f'.
	self send: 'lf' toMarsRoverAndVerifyFinalPositionIs: (-1@1) andHeadPointsTo: westOrientatedHead.
	
	! !


!MarsRoverTests methodsFor: 'invalidInputs' stamp: 'mr 5/29/2022 21:58:57'!
test09MarsRoverReceivesAnInvalidCommandAndAnErrorOccurs

	self 
		should: [marsRover executeInstructions: 't']
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = MarsRover invalidInstructionErrorDescription ].! !

!MarsRoverTests methodsFor: 'invalidInputs' stamp: 'mr 5/29/2022 21:58:57'!
test10MarsRoverReceivesAnInvalidCommandAndEndsInRightPosition
	
	self 
		should: [marsRover executeInstructions: 'frftlb']
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = MarsRover invalidInstructionErrorDescription ].
		
	self assert: (marsRover position = (1@1)). 
	self assert: (marsRover headOrientation = eastOrientatedHead).! !

!MarsRoverTests methodsFor: 'invalidInputs' stamp: 'mr 5/29/2022 21:58:38'!
test11MarsRoverReceivesAnInvalidHeadOrientationAndAnErrorOccurs

	self 
		should: [marsRover := MarsRover initializeWithPosition: (0@0) andOrientation: 'J'.]
		raise: Error
		withExceptionDo: [: anError | 
			self assert: anError messageText = MarsRover invalidHeadOrientationErrorDescription ].! !


!MarsRoverTests methodsFor: 'setup' stamp: 'mr 5/29/2022 21:54:16'!
setUp
	eastOrientatedHead := MarsRoverEastPointedHead new.
	westOrientatedHead := MarsRoverWestPointedHead new.
	southOrientatedHead := MarsRoverSouthPointedHead new.
	northOrientatedHead := MarsRoverNorthPointedHead new.
	marsRover := MarsRover initializeWithPosition: (0@0) andOrientation: northOrientatedHead.! !


!MarsRoverTests methodsFor: 'private' stamp: 'mr 5/29/2022 21:50:36'!
send: aListOfInstructions toMarsRoverAndVerifyFinalPositionIs: aPosition andHeadPointsTo: aCardinalPoint  

	marsRover executeInstructions: aListOfInstructions.
	self assert: (marsRover position = aPosition). 
	self assert: (marsRover headOrientation = aCardinalPoint).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position headOrientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'mr 5/29/2022 21:54:33'!
initializeWithPosition: aPosition andOrientation: aHeadOrientation
	position := aPosition.
	headOrientation := MarsRover actualHeadOrientation: aHeadOrientation.! !


!MarsRover methodsFor: 'private' stamp: 'mr 5/27/2022 12:41:25'!
decrementXPosition
	position := ((position x) - 1)@(position y). ! !

!MarsRover methodsFor: 'private' stamp: 'mr 5/27/2022 12:41:39'!
decrementYPosition
	position := (position x)@((position y) - 1). ! !

!MarsRover methodsFor: 'private' stamp: 'mr 5/27/2022 12:41:53'!
incrementXPosition
	position := ((position x) + 1)@(position y). ! !

!MarsRover methodsFor: 'private' stamp: 'mr 5/27/2022 12:42:03'!
incrementYPosition
	position := (position x)@((position y) + 1). ! !

!MarsRover methodsFor: 'private' stamp: 'mr 5/29/2022 21:58:57'!
verifyAnInstructionIsValid: aCommand
	
	((aCommand = $f) or: (aCommand = $b) or: (aCommand = $r) or: (aCommand = $l)) ifFalse: [
		self error: MarsRover invalidInstructionErrorDescription ].
	! !


!MarsRover methodsFor: 'public' stamp: 'rp 6/1/2022 19:19:02'!
executeInstructions: aListOfInstructions

	aListOfInstructions do: [:actualInstruction | 
		
		self verifyAnInstructionIsValid: actualInstruction.	
		(actualInstruction = $f) ifTrue: [ headOrientation moveForward: self. ].
		(actualInstruction = $b) ifTrue: [ headOrientation moveBackwards: self. ].
		(actualInstruction = $l) ifTrue: [ headOrientation rotateLeft: self. ].
		(actualInstruction = $r) ifTrue: [ headOrientation rotateRight: self. ].

		].! !

!MarsRover methodsFor: 'public' stamp: 'mr 5/29/2022 21:21:21'!
headOrientation
	^headOrientation.! !

!MarsRover methodsFor: 'public' stamp: 'mr 5/27/2022 10:12:08'!
position
	^position.! !

!MarsRover methodsFor: 'public' stamp: 'rp 6/1/2022 19:16:11'!
updateHeadOrientation: aNewHeadOrientation
	headOrientation := aNewHeadOrientation! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'mr 5/29/2022 21:58:38'!
actualHeadOrientation: aCardinalPoint

	^MarsRoverHead subclasses 
		detect: [:aSubclass | aSubclass = aCardinalPoint class]
		ifFound: [:aSubclass | aSubclass new.]
		ifNone: [self error: self invalidHeadOrientationErrorDescription]
	! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:17:39'!
initializeWithPosition: aPosition andOrientation: aHeadOrientation
	self verifyAHeadOrientationIsValid: aHeadOrientation.
	^self new initializeWithPosition: aPosition andOrientation: aHeadOrientation.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:53'!
invalidHeadOrientationErrorDescription
	^'Invalid head orientation'.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'mr 5/29/2022 21:58:56'!
invalidInstructionErrorDescription
	^'Invalid command'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:17:54'!
verifyAHeadOrientationIsValid: aHeadOrientation
	self actualHeadOrientation: aHeadOrientation.! !


!classDefinition: #MarsRoverHead category: 'MarsRover'!
Object subclass: #MarsRoverHead
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'mr 5/29/2022 21:49:12'!
= otherHeadOrientation
	^otherHeadOrientation isKindOf: (self class).! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:21:06'!
moveBackwards: aMarsRover
	self subclassResponsibility.! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:19:58'!
moveForward: aMarsRover
	self subclassResponsibility.! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:22:36'!
rotateLeft: aMarsRover
	self subclassResponsibility.! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:22:24'!
rotateRight: aMarsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHead class' category: 'MarsRover'!
MarsRoverHead class
	instanceVariableNames: ''!

!MarsRoverHead class methodsFor: 'as yet unclassified' stamp: 'mr 5/29/2022 21:18:29'!
actualHeadOrientation: aCardinalPoint

	| actualCardinalPoint |
	
	actualCardinalPoint := self subclasses detect: [:aSubclass | aSubclass canHandle: aCardinalPoint].
	^actualCardinalPoint new.! !


!classDefinition: #MarsRoverEastPointedHead category: 'MarsRover'!
MarsRoverHead subclass: #MarsRoverEastPointedHead
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverEastPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:24:05'!
moveBackwards: aMarsRover
	aMarsRover decrementXPosition.! !

!MarsRoverEastPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:22:36'!
moveForward: aMarsRover
	aMarsRover incrementXPosition.! !

!MarsRoverEastPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateLeft: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverNorthPointedHead new.! !

!MarsRoverEastPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateRight: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverSouthPointedHead new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverEastPointedHead class' category: 'MarsRover'!
MarsRoverEastPointedHead class
	instanceVariableNames: ''!

!MarsRoverEastPointedHead class methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:31:18'!
canHandle: xxx
	^'E' = xxx.! !


!classDefinition: #MarsRoverNorthPointedHead category: 'MarsRover'!
MarsRoverHead subclass: #MarsRoverNorthPointedHead
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverNorthPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:22:04'!
moveBackwards: aMarsRover
	aMarsRover decrementYPosition.! !

!MarsRoverNorthPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:20:11'!
moveForward: aMarsRover
	aMarsRover incrementYPosition.! !

!MarsRoverNorthPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateLeft: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverWestPointedHead new.! !

!MarsRoverNorthPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateRight: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverEastPointedHead new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverNorthPointedHead class' category: 'MarsRover'!
MarsRoverNorthPointedHead class
	instanceVariableNames: ''!

!MarsRoverNorthPointedHead class methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:31:26'!
canHandle: xxx
	^'N' = xxx.! !


!classDefinition: #MarsRoverSouthPointedHead category: 'MarsRover'!
MarsRoverHead subclass: #MarsRoverSouthPointedHead
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverSouthPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:20:51'!
moveBackwards: aMarsRover
	aMarsRover incrementYPosition.! !

!MarsRoverSouthPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:21:44'!
moveForward: aMarsRover
	aMarsRover decrementYPosition.! !

!MarsRoverSouthPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateLeft: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverEastPointedHead new.! !

!MarsRoverSouthPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateRight: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverWestPointedHead new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverSouthPointedHead class' category: 'MarsRover'!
MarsRoverSouthPointedHead class
	instanceVariableNames: ''!

!MarsRoverSouthPointedHead class methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:31:33'!
canHandle: xxx
	^'S' = xxx.! !


!classDefinition: #MarsRoverWestPointedHead category: 'MarsRover'!
MarsRoverHead subclass: #MarsRoverWestPointedHead
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverWestPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:22:52'!
moveBackwards: aMarsRover
	aMarsRover incrementXPosition.! !

!MarsRoverWestPointedHead methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:23:30'!
moveForward: aMarsRover
	aMarsRover decrementXPosition.! !

!MarsRoverWestPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateLeft: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverSouthPointedHead new.! !

!MarsRoverWestPointedHead methodsFor: 'as yet unclassified' stamp: 'rp 6/1/2022 19:16:11'!
rotateRight: aMarsRover
	aMarsRover updateHeadOrientation: MarsRoverNorthPointedHead new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWestPointedHead class' category: 'MarsRover'!
MarsRoverWestPointedHead class
	instanceVariableNames: ''!

!MarsRoverWestPointedHead class methodsFor: 'as yet unclassified' stamp: 'mr 5/27/2022 12:31:42'!
canHandle: xxx
	^'O' = xxx.! !
