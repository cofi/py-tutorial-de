.. _tut-classes:

*******
Klassen
*******

Pythons Klassenmechanismus fügt Klassen mit einem Minimum an neuer Syntax und
Semantik zur Sprache hinzu. Er ist eine Mischung der Klassenmechanismen in C++
und Modula-3. Wie es auch für Module der Fall ist, ziehen Klassen in Python
keine absoluten Grenzen zwischen Definition und Benutzer, sondern verlassen sich
eher auf die Höflichkeit des Benutzers nicht "in die Definition einzubrechen".
Die wichtigsten Eigenschaften von Klassen werden jedoch mit voller Kraft
erhalten: Der Vererbungsmechanismus von Klassen erlaubt mehrere Basisklassen,
eine abgeleitete Klasse kann jegliche Methoden seiner Basisklasse(n)
überschreiben und eine Methode kann die Methode der Basisklasse mit demselben
Namen aufrufen. Objekte können beliebig viele private Daten haben.

In der Terminologie von C++ sind in Python *class members* (Attribute der
Klasse) *public* (Ausnahmen siehe :ref:`tut-private`) und alle *member
functions* (Methoden) sind *virtual*. Es gibt keine speziellen Konstruktoren
oder Destruktoren. Es gibt, wie in Modula-3, keine Abkürzung zum referenzieren
von Objektattributen aus seinen Methoden heraus: Die Methode wird mit einem
expliziten ersten Argument, das das Objekt repräsentiert, deklariert, welches
implizit beim Aufruf übergeben wird. Wie in Smalltalk sind auch sind Klassen
auch selbst Objekte, wenn auch in einer breiteren Bedeutung, denn in Python sind
alle Datentypen Objekte. Das ermöglicht die Semantik zum importieren und
umbenennen. Anders als in C++ und Modula-3 können eingebaute Datentypen vom
Benutzer als Basisklassen benutzt, das heisst abgeleitet werden. Außerdem können
die meisten eingebauten Operatoren, wie in C++, aber nicht in Modula-3, mit
einer besonderen Syntax (arithmetische Operatoren, Indizierung, usw.) für
Instanzen der Klasse neu definiert werden.


.. _tut-terminology:

Zur Terminologie
================

Da es keine allgemein anerkannte Terminologie im Bezug auf Klassen gibt, werde
ich zwischendurch auf Smalltalk und C++ Begriffe ausweichen. (Da seine
objektorientierte Semantik näher an Python als an C++ ist, würde ich lieber
Modula-3 Begriffe benutzen, allerdings erwarte ich, dass wenige Leser davon
gehört haben.)

Objekte haben Individualität und mehrere Namen (in mehreren Namensräumen) können
an dasselbe Objekt gebunden werden. In anderen Sprachen wird dies als Aliasing
bezeichnet. Das wird meist beim ersten Blick auf Python nicht geschätzt und kann
problemlos ignoriert werden, wenn man mit unveränderbaren Datentypen (Zahlen,
Zeichenketten, Tupel) arbeitet. Aber Aliasing hat einen (beabsichtigen!) Effekt
auf die Semantik von Pythoncode angeht, der veränderbare Objekte wie Listen,
Dictionaries oder die meisten anderen Typen, die Dinge außerhalb des Programms
(Dateien, Fenster, usw.) beschreiben, enthält. Dies kommt normalerweise dem
Programm zugute, da sich Aliase in mancher Hinsicht wie Pointer verhalten. Zum
Beispiel ist die Übergabe eines Objekts günstig, da von der Implementierung nur
ein Pointer übergeben wird. Verändert eine Funktion ein Objekt, das als Argument
übergeben wurde, wird der Aufrufende die Veränderung sehen --- dies vermeidet
den Bedarf an zwei verschiedenen Übergabemechanismen, wie in Pascal.
