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
von Attributen eines Objekts aus dessen Methoden heraus: Die Methode wird mit
einem expliziten ersten Argument, das das Objekt repräsentiert, deklariert,
welches implizit beim Aufruf übergeben wird. Wie in Smalltalk sind auch sind
Klassen auch selbst Objekte, wenn auch in einer breiteren Bedeutung, denn in
Python sind alle Datentypen Objekte. Das ermöglicht die Semantik zum importieren
und umbenennen. Anders als in C++ und Modula-3 können eingebaute Datentypen vom
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

Objekte haben Individualität und mehrere Namen (in mehreren
Gültigkeitsbereichen) können an dasselbe Objekt gebunden werden. In anderen
Sprachen wird dies als Aliasing bezeichnet. Das wird meist beim ersten Blick auf
Python nicht geschätzt und kann problemlos ignoriert werden, wenn man mit
unveränderbaren Datentypen (Zahlen, Zeichenketten, Tupel) arbeitet. Aber
Aliasing hat einen (beabsichtigen!) Effekt auf die Semantik von Pythoncode
angeht, der veränderbare Objekte wie Listen, Dictionaries oder die meisten
anderen Typen, die Dinge außerhalb des Programms (Dateien, Fenster, usw.)
beschreiben, enthält. Dies kommt normalerweise dem Programm zugute, da sich
Aliase in mancher Hinsicht wie Pointer verhalten. Zum Beispiel ist die Übergabe
eines Objekts günstig, da von der Implementierung nur ein Pointer übergeben
wird. Verändert eine Funktion ein Objekt, das als Argument übergeben wurde, wird
der Aufrufende die Veränderung sehen --- dies vermeidet den Bedarf an zwei
verschiedenen Übergabemechanismen, wie in Pascal.


.. _tut-scopes:

Gültigkeitsbereiche und Namensräume in Python
=============================================

Bevor man Klassen überhaupt einführt, muss man über Pythons Regeln im Bezug auf
Gültigkeitsbereiche reden. Klassendefinitionen wenden ein paar nette Kniffe bei
Namensräumen an und man muss wissen wie Gültigkeitsbereiche und Namensräume
funktionieren, um vollkommen zu verstehen was abläuft. Außerdem das Wissen
hierüber nützlich für jeden fortgeschrittenen Pythonprogrammierer.

Fangen wir mit ein paar Definitionen an.

Ein *Namensraum* ist eine Zuordnung von Namen zu Objekten. Die meisten
Namensräume sind momentan als Dictionaries importiert, aber das ist
normalerweise in keinerlei Hinsicht spürbar (außer bei der Performance) und kann
sich in Zukunft ändern. Beispiele für Namensräume sind: Die Menge der
eingebauten Namen (Funktionen wie :func:`abs` und eingebaute Ausnahmen), die
globalen Namen eines Moduls und die lokalen Namen eines Funktionsaufrufs. In
gewisser Hinsicht bilden auch die Attribute eines Objektes einen Namensraum.
Das Wichtigste, das man über Namensräume wissen muss, ist, dass es absolut
keinen Bezug von Namen in verschiedenen Namensräumen zueinander gibt. Zum
Beispiel können zwei verschiedene Module eine Funktion namens ``maximize``
definieren, ohne dass es zu einer Verwechslung kommt, denn Benutzer des Moduls
müssen dessen Namen voranstellen.

Nebenbei bemerkt: Ich benutze das Wort *Attribut* für jeden Namen nach einem
Punkt --- zum Beispiel in dem Ausdruck ``z.real`` ist ``real`` ein Attribut des
Objekts ``z``. Genau genommen sind auch Referenzen zu Namen in Modulen
Attributreferenzen: Im Ausdruck ``modname.funcname``, ist ``modname`` ein
Modulobjekt und ``funcname`` ein Attribut dessen. In diesem Fall gibt es ein
geradlinige Zuordnung von Modulattributen und globalen Namen, die im Modul
definiert sind: Sie teilen sich denselben Namensraum! [#]_

Attribute können schreibgeschützt oder schreibbar sein. In letzterem Fall ist
eine Zuweisung an dieses Attribut möglich. Modulattribute sind schreibbar: Man
kann ``modname.the_answer = 42`` schreiben. Schreibbare Attribute sind
gleichzeitig durch die :keyword:`del`-Anweisung löschbar. Zum Beispiel löscht
``del modname.the_answer`` das Attribut :attr:`the_answer` des Objekts namens
``modname``.

Namensräume werden zu verschiedenen Zeitpunkten erzeugt und haben verschiedene
Lebenszeiten. Der Namensraum, der die eingebauten Namen enthält, wird beim Start
des Interpreters erzeugt und nie gelöscht. Der globale Namensraum für ein Modul
wird erzeugt, wenn die Moduldefinition eingelesen wird; normalerweise existieren
die Modulnamesräume auch solange bis der Interpreter beendet wird. Die
Anweisungen auf oberster Ebene vom Interpreter aufgerufen werden, entweder von
einem Skript oder interaktiv gelesen, werden als Teil des Moduls
:mod:`__main__`, sodass sie ihren eigenen globalen Namensraum haben. (Die
eingebauten Namen existieren ebenfalls in einem Modul namens :mod:`builtins`.)

Der lokale Namensraum einer Funktion wird bei deren Aufruf erstellt und wird
gelöscht, wenn die Funktion zurückgibt oder eine Ausnahme auslöst, die nicht
innerhalb der Funktion behandelt wird. (Eigentlich wäre "vergessen" eine bessere
Beschreibung dessen, was passiert.) Natürlich haben auch rekursive Aufrufe ihren
jeweiligen lokalen Namensraum.

Ein *Gültigkeitsbereich* (*scope*) ist eine Region eines Pythonprogrammes, in
der ein Namensraum direkt verfügbar ist, das heisst es einem unqualifiziertem
Namen möglich ist einen Namen in diesem Namensraum zu finden.

.. NOTICE: Abweichung zum Original, da das hier Schwachsinn enthält
Auch wenn Gültigkeitsbereiche statisch ermittelt werden, werden sie dynamisch
benutzt. An einem beliebigen Zeitpunkt während der Ausführung, gibt es
mindestens drei verschachtelte Gültigkeitsbereiche, deren Namensräume direkt
verfügbar sind: Der innerste Gültigkeitsbereich, der zuerst durchsucht wird und
die lokalen Namen enthält; der Gültigkeitsbereich mit allen umgebenden
Namensräumen (enthält auch die globalen Namen des momentanen Moduls), der vom
nächsten umgebenden Namensraum aus durchsucht wird, und der äußerste
Gültigkeitsbereich (zuletzt durchsuchte) ist der Namensraum, der die eingebauten
Namen enthält.

Wird ein Name als global deklariert, so gehen alle Referenzen und Zuweisungen
direkt an den mittleren Gültigkeitsbereich, der die globalen Namen des Moduls
enthält. Um Variablen, die außerhalb des innersten Gültigkeitsbereichs zu finden
sind, neu zu binden, kann die :keyword:`nonlocal`-Anweisung benutzt werden.
Falls diese nicht als ``nonlocal`` deklariert sind, sind diese Variablen
schreibgeschützt (ein Versuch in diese Variablen zu schreiben, würde einfach
eine *neue* lokale Variable im innersten Gültigkeitsbereich anlegen und die
äußere Variable mit demselben Namen unverändert lassen).

Normalerweise referenziert der lokale Gültigkeitsbereich die lokalen Namen der
momentanen Funktion. Außerhalb von Funktionen bezieht sich der lokale
Gültigkeitsbereich auf denselben Namensraum wie der globale Gültigkeitsbereich:
Den Namensraum des Moduls. Klassendefinition stellen einen weiteren
Namensraum im lokalen Gültigkeitsbereich dar.

Es ist wichtig zu verstehen, dass die Gültigkeitsbereiche am Text ermittelt
werden: Der globale Gültigkeitsbereich einer Funktion, die in einem Modul
definiert wird, ist der Namensraum des Moduls, ganz egal wo die Funktion
aufgerufen wird. Andererseits wird die tatsächliche Suche nach namen dynamisch
zur Laufzeit durchgeführt --- jedoch entwickelt sich die Definition der Sprache
hin zu einer statischen Namensauflösung zur Kompilierzeit, deshalb sollte man
sich nicht auf die dynamische Namensauflösung verlassen! (In der Tat werden
lokale Variablen schon statisch ermittelt.)

Eine besondere Eigenart Pythons ist das -- wenn keine :keyword:`global`- oder
:keyword:`nonlocal`-Anweisung aktiv ist -- Zuweisungen an Namen immer im
innersten Gültigkeitsbereich abgewickelt werden. Zuweisungen kopieren keine
Daten, sondern binden nur Namen an Objekte. Das gleiche gilt für Löschungen: Die
Anweisung ``del x`` entfernt nur die Bindung von ``x`` aus dem Namensraum des
lokalen Gültigkeitsbereichs. In der Tat benutzen alle Operationen, die neue
Namen einführen, den lokalen Gültigkeitsbereich: Im Besonderen binden
:keyword:`import`-Anweisungen und Funktionsdefinitionen das Modul
beziehungsweise den Funktionsnamen im lokalen Gültigkeitsbereich.

Die :keyword:`global`-Anweisung kann benutzt werden, um anzuzeigen, dass
bestimmte Variablen im globalen Gültigkeitsbereich existieren und hier
neu gebunden werden sollen. Die :keyword:`nonlocal`-Anweisung zeigt an, dass
eine bestimmte Variable im umgebenden Gültigkeitsbereich existiert und hier
neu gebunden werden soll.

.. _tut-scopeexample:

Beispiel zu Gültigkeitsbereichen und Namensräumen
-------------------------------------------------

Dies ist ein Beispiel, das zeigt, wie man die verschiedenen Gültigkeitsbereiche
und Namensräume referenziert und wie :keyword:`global` und :keyword`nonlocal`
die Variablenbindung beeinflussen::

   def scope_test():
       def do_local():
           spam = "local spam"
       def do_nonlocal():
           nonlocal spam
           spam = "nonlocal spam"
       def do_global():
           global spam
           spam = "global spam"

       spam = "test spam"
       do_local()
       print("Nach der lokalen Zuweisung:", spam)
       do_nonlocal()
       print("Nach der nonlocal Zuweisung:", spam)
       do_global()
       print("Nach der global Zuweisung:", spam)

   scope_test()
   print("Im globalen Gültigkeitsbereich:", spam)

Die Ausgabe des Beispielcodes ist::

   Nach der lokalen Zuweisung: test spam
   Nach der nonlocal Zuweisung: nonlocal spam
   Nach der global Zuweisung: nonlocal spam
   Im globalen Gültigkeitsbereich: global spam

Beachte, dass die *lokale* Zuweisung (was der Standard ist) die Bindung von *spam* in *scope_test* nicht verändert hat. Die :keyword:`nonlocal` Zuweisung die Bindung von *spam* in *scope_test* und die :keyword:`global` Zuweisung die Bindung auf Modulebene verändert hat.

Man kann außerdem sehen, dass es keine vorherige Bindung von *spam* vor der
:keyword:`global` Zuweisung gab.

.. rubric:: Fußnoten

.. [#] Bis auf eine Ausnahme: Modulobjekte haben ein geheimes schreibgeschützes
   Attribut namens :attr:`__dict__`, das das Dictionary darstellt, mit dem der
   Namensraum des Modules implementiert wird; der Name :attr:`__dict__`` ist ein
   Attribut, aber kein globaler Name. Offensichtlich ist dessen Benutzung eine
   Verletzung der Abstraktion der Namensraumimplementation und sollte deshalb
   auf Verwendungen wie die eines Post-Mortem-Debuggers reduziert werden.
