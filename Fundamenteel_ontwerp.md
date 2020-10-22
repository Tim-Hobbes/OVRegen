# Dit is het fundamenteel ontwerp van de app OVRegen

## Doel
Het doel is om een app te creëren die reizen kan plannen. Bij de app geef je aan hoe erg je regen vindt. Aan de hand daarvan kijkt de app naar de hoeveelheid regenval op jouw locatie en plant hij een reis die de regen deels probeert te vermijden. Bij erge regenval of een grote haat aan regen kiest de app eerder voor de bus, en bij matige regenval met een kleine haat aan regen wordt de fiets aangeraden. 

## Doelgroep
Onze app is gemaakt voor mensen soms met het OV en soms met de fiets naar een bestemming toe reizen. Deze doelgroep kiest vaak om met de fiets te gaan in plaats van het openbaar vervoer op basis van het huidige weer en in sommige gevallen op basis van de weersvoorspelling. Deze doelgroep is meestal van jongere leeftijd en daarom, vaak goed met de telefoon omgaan en heet dus hoge verwachtingen van de userinterface van een app. Daarom is er besloten om hier een groot gedeelte van onze tijd aan te besteden.

## Programma van eisen
Voor onze app hebben wij verschillende eisen gesteld en sommige eisen met opzet niet gesteld. Zo hebben wij bijvoorbeeld er voor gekozen om geen instellen paneel te maken, uit veel onderzoeken is gebleken dat maar een zeer klein gedeelte van de gebruikers hier gebruik van maakt. 
Hier het lijstje van het programma van eisen:
- De app zal een aanranding of er met het openbaar vervoer gerezen moet worden of op de fiets op basis van de hoeveelheid voorspelde regenval.
- De app zal een slider hebben waarmee de threshold voor minimum hoeveelheid regen aangepast kan worden.
- De app zal een duidelijk en makkelijk te gebruiken user interface hebben.

## Techinische implementatie API's
Voor de app OVRegen gaan we 3 verschillende API's gebruiken. Deze zijn:
- Open Weather map. Wij hebben voor openweathermap gekozen i.p.v. buienradar omdat buienradar de minuut tot minuut dat nij open steld op zij API. Dit doet openweathermap wel. Openweathermap geeft hij 1 uur, 2 dagen, 7 dagen en -5 dagen voorspellingen gratis weg zolang je niet minder dan een miljoen calls per maand maakt. Dit is dus ideaal voor ons project.
- 9292 API. Het API van 9292 gebruiken wij om de route te plannen via het OV. Dit API is echter niet open voor de normale mensen, alleen voor bedrijven met veel geld. Hierom hebben wij er voor gekozen om een app die gebruik maakt van dit API te reverse engineeren. Dit hebben wij gedaan met een programma genaamd Burp. Hiermee kan je, na een paar instellingen in de telefoon te hebben veranderd, alle API calls die de telefoon maak bekijken. Hieruit hebben wij geleerd hoe het 9292 API werkt.
- Graph Hopper. Met het Graph Hopper API berekenen wij de looproutes en kunnen wij straat namen met x en y coordinaten koppelen. Wij gebruiken Graph Hopper omdat hun API gratis te gebruiken is zolang je maar < 500 routes per maand plant. Als wij deze app ooit op de appstore zouden publiceren zouden we Graph Hopper op onze eigen server moeten draaien waardoor we oneindig veel routes kunnen plannen.

## Techinische implementatie App
Wij gaan onze app in Swift en Swift UI programmeren. Hiervoor is gekozen omdat dit de beste en de simpelse manier is om een simpele iPhone app te maken.
