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
	^huevosDeAvispas at: unaAvispa.! !

!Habitat class methodsFor: 'as yet unclassified' stamp: 'rp 4/24/2022 10:34:55'!
cantidadDeHuevosDeAvispas
	|cantidadTotalDeHuevos|
	cantidadTotalDeHuevos := huevosDeAvispas values sum: [: unNumero | unNumero ] ifEmpty: [0] .
	^cantidadTotalDeHuevos.! !

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


!Habitat class methodsFor: '--** private fileout/in **--' stamp: 'mr 4/24/2022 16:55:09'!
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

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/18/2022 18:38:11'!
test01EnElInicioDeLosTiemposNoHayHuevos	
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:44'!
test02CuandoOrianaLaAvispaSeReproducePorPrimeraVezDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:11'!
test03CadaVezQueOrianaSeReproduceDejaUnHuevoMas
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:53'!
test04ParaDejarUnHuevoOrianaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:43'!
test05ParaDejarUnHuevoOrianaLaAvispaDecrementaEnUnoLaPoblacionDeOrugasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosOrugasMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:22'!
test06CuandoNoHayOrugasOrianaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:24'!
test07CuandoOrnellaLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:18'!
test08ParaDejarUnHuevoOrnellaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:11'!
test09CuandoNoHayOrugasOrnellaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:46'!
test10CuandoPollyLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:40'!
test11ParaDejarUnHuevoPollyLaAvispaReduceLaPoblacionDeUnaPolillaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaPolillaMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:36'!
test12ParaDejarUnHuevoPollyLaAvispaDecrementaEnUnoLaPoblacionDePolillasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosPolillasMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:30'!
test13CuandoNoHayPolillasPollyLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:06'!
test14CuandoOrianaLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:02'!
test15CuandoOrianaLaAvispaAunNoSeReprodujoNoTieneHuevosConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:58'!
test16CuandoPollyLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:54'!
test17CuandoOrnellaLaAvispaSeReproduceDejaUnHuevoConLaMismaFirmaGeneticaQueOriana
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: 1.
	Assert 
		that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella  
		isEqualTo: self cantidadDeHuevosConLaFirmaGeneticaDeOriana! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:27'!
test18CuandoLaraLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOrnella intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:22'!
test19CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAOtraAvispa
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:18'!
test20CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAPolly
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaPolly intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:12'!
test21CuandoLaraLaAvispaNoTieneRecursosNoDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
		
	self laAvispaLara intentarReproducirse.
		
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 0.! !


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

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mr 4/24/2022 16:50:38'!
habitat
	^Habitat! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 11:14:15'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self queElHabitatTengaDosOrugasMas.
	self queElHabitatTengaDosPolillasMas.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'rp 4/24/2022 10:10:37'!
laAvispaLara
	^AvispaLara ! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'mr 4/24/2022 16:50:49'!
laAvispaOriana
	^AvispaOriana! !

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