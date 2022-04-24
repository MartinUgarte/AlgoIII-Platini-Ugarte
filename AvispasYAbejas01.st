!classDefinition: #AvispaOriana category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaOriana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOriana class' category: 'AvispasYAbejasParte2'!
AvispaOriana class
	instanceVariableNames: ''!

!AvispaOriana class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 11:12:46'!
intentarReproducirse
	(Habitat cantidadDeOrugas) > 0 ifTrue: [
		Habitat incrementarUnHuevo: self.
		Habitat decrementarUnRecurso: 'Orugas'].! !


!classDefinition: #AvispaLara category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaLara
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaLara class' category: 'AvispasYAbejasParte2'!
AvispaLara class
	instanceVariableNames: ''!

!AvispaLara class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:38:23'!
intentarReproducirse
	(Habitat cantidadDeHuevosDeAvispas) > 0 ifTrue: [
		Habitat incrementarUnHuevo: AvispaLara.
		(Habitat cantidadDeHuevosConFirmaGenetica: AvispaOriana) > 0 ifTrue: [
			Habitat decrementarUnHuevo: AvispaOriana.
			].
		(Habitat cantidadDeHuevosConFirmaGenetica: AvispaOrnella ) > 0 ifTrue: [
			Habitat decrementarUnHuevo: AvispaOrnella .
			].
		(Habitat cantidadDeHuevosConFirmaGenetica: AvispaPolly) > 0 ifTrue: [
			Habitat decrementarUnHuevo: AvispaPolly.
			].
		].! !


!classDefinition: #AvispaOrnella category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaOrnella
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!


!classDefinition: #AvispaPolly category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaPolly
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaPolly class' category: 'AvispasYAbejasParte2'!
AvispaPolly class
	instanceVariableNames: ''!

!AvispaPolly class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 11:12:53'!
intentarReproducirse
	(Habitat cantidadDePolillas) > 0 ifTrue: [
		Habitat incrementarUnHuevo: self.
		Habitat decrementarUnRecurso: 'Polillas'].! !


!classDefinition: #Habitat category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #Habitat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Habitat class' category: 'AvispasYAbejasParte2'!
Habitat class
	instanceVariableNames: 'huevosDeAvispas cantidadDeOrugas cantidadDePolillas recursos'!

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:34:48'!
cantidadDeHuevosConFirmaGenetica: unaAvispa
	^huevosDeAvispas at: unaAvispa.

! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:34:55'!
cantidadDeHuevosDeAvispas
	|cantidadTotalDeHuevos|
	cantidadTotalDeHuevos := huevosDeAvispas values sum: [: unNumero | unNumero ] ifEmpty: [0] .
	^cantidadTotalDeHuevos.
	
	
	
	! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:47:24'!
cantidadDeOrugas
	^ recursos at: 'Orugas'.! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:47:36'!
cantidadDePolillas
	^recursos at: 'Polillas'.! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:34:38'!
decrementarUnHuevo: unaAvispa
	|cantidadDeHuevos|
	cantidadDeHuevos := huevosDeAvispas at: unaAvispa ifAbsent: [0].
	huevosDeAvispas at: unaAvispa put: cantidadDeHuevos -1.
	! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:48:04'!
decrementarUnRecurso: unRecurso
	|cantidadDeRecursos|
	cantidadDeRecursos := recursos at: unRecurso ifAbsent: [0].
	recursos at: unRecurso put: cantidadDeRecursos -1.! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:34:28'!
incrementarUnHuevo: unaAvispa
	|cantidadDeHuevos|
	cantidadDeHuevos := huevosDeAvispas at: unaAvispa ifAbsent: [0].
	huevosDeAvispas at: unaAvispa put: cantidadDeHuevos +1.! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 11:04:00'!
incrementarUnRecurso: unRecurso
	|cantidadDeRecursos|
	cantidadDeRecursos := recursos at: unRecurso ifAbsent: [0].
	recursos at: unRecurso put: cantidadDeRecursos +1.! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 11:04:17'!
reiniciar
	recursos := Dictionary new.
	recursos at: 'Orugas' put: 0.
	recursos at: 'Polillas' put: 0.
	huevosDeAvispas := Dictionary new.
	huevosDeAvispas at: AvispaOriana put: 0.
	huevosDeAvispas at: AvispaOrnella put: 0.
	huevosDeAvispas at: AvispaPolly put: 0.
	huevosDeAvispas at: AvispaLara put: 0.! !


!Habitat class methodsFor: '--** private fileout/in **--' stamp: 'rp 4/24/2022 11:18:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	huevosDeAvispas := ((Dictionary new) add: (AvispaLara->0); add: (AvispaOriana->0); add: (AvispaOrnella->0); add: (AvispaPolly->0); yourself).
	cantidadDeOrugas := 2.
	cantidadDePolillas := 1.
	recursos := ((Dictionary new) add: ('Orugas'->0); add: ('Polillas'->0); yourself).! !


!classDefinition: #PruebasReproduccionDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #PruebasReproduccionDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasReproduccionDeAvispas class' category: 'AvispasYAbejasParte2'!
PruebasReproduccionDeAvispas class
	instanceVariableNames: ''!

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana'!
! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella'!
! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly'!
! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica'!
! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona'!
! !


!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:13:25'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^Habitat cantidadDeHuevosConFirmaGenetica: AvispaLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:16:02'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^(Habitat cantidadDeHuevosConFirmaGenetica: AvispaOriana) + (Habitat cantidadDeHuevosConFirmaGenetica: AvispaOrnella).! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:16:10'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^(Habitat cantidadDeHuevosConFirmaGenetica: AvispaOriana) + (Habitat cantidadDeHuevosConFirmaGenetica: AvispaOrnella).! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:13:07'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^Habitat cantidadDeHuevosConFirmaGenetica: AvispaPolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 11:14:15'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self queElHabitatTengaDosOrugasMas.
	self queElHabitatTengaDosPolillasMas.
	! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:10:37'!
laAvispaLara
	^AvispaLara ! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar'!
! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:10:52'!
laAvispaOrnella
	^ AvispaOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:11:05'!
laAvispaPolly
	^ AvispaPolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 11:16:28'!
queElHabitatTengaDosOrugasMas
	2 timesRepeat: [self queElHabitatTengaUnaOrugaMas].
	! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 11:16:14'!
queElHabitatTengaDosPolillasMas
	2 timesRepeat: [self queElHabitatTengaUnaPolillaMas].! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 11:13:23'!
queElHabitatTengaUnaOrugaMas
	Habitat incrementarUnRecurso: 'Orugas'.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 11:13:20'!
queElHabitatTengaUnaPolillaMas
	Habitat incrementarUnRecurso: 'Polillas'.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 08:58:11'!
retrocederElHabitatAlInicioDeLosTiempos
	Habitat reiniciar.! !

Habitat initializeAfterFileIn!