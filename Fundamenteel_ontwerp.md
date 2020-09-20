# Dit is het fundamenteel ontwerp van de app OVRegen

## Idee
De app OVRegen is eigenlijk voor ieder persoon die soms met de fiets en soms met het OV naar het werk toe gaat. Wat de app OVRegen namelijk doet is jou helpen te beslissen of je met het OV gaat of met de fiets moet gaan. 
## Techinische implementatie API's
Voor de app OVRegen gaan we 3 verschillende API's gebruiken. Deze zijn:
- Open Weather map. Wij hebben voor openweathermap gekozen i.p.v. buienradar omdat buienradar de minuut tot minuut dat nij open steld op zij API. Dit doet openweathermap wel. Openweathermap geeft hij 1 uur, 2 dagen, 7 dagen en -5 dagen voorspellingen gratis weg zolang je niet minder dan een miljoen calls per maand maakt. Dit is dus ideaal voor ons project.
- 9292 API. Het API van 9292 gebruiken wij om de route te plannen via het OV. Dit API is echter niet open voor de normale mensen, alleen voor bedrijven met veel geld. Hierom hebben wij er voor gekozen om een app die gebruik maakt van dit API te reverse engineeren. Dit hebben wij gedaan met een programma genaamd Burp. Hiermee kan je, na een paar instellingen in de telefoon te hebben veranderd, alle API calls die de telefoon maak bekijken. Hieruit hebben wij geleerd hoe het 9292 API werkt.
- Graph Hopper. Met het Graph Hopper API berekenen wij de looproutes en kunnen wij straat namen met x en y coordinaten koppelen. Wij gebruiken Graph Hopper omdat hun API gratis te gebruiken is zolang je maar < 500 routes per maand plant. Als wij deze app ooit op de appstore zouden publiceren zouden we Graph Hopper op onze eigen server moeten draaien waardoor we oneindig veel routes kunnen plannen.

## Techinische implementatie App
Wij gaan onze app in Swift en Swift UI programmeren. Hiervoor is gekozen omdat dit de beste en de simpelse manier is om een simpele iPhone app te maken.
