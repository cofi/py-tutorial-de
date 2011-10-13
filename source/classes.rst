.. _tut-classes:

*******
Klassen
*******

Verglichen mit anderen Programmiersprachen, fügt Pythons Klassenmechanismus
Klassen mit einem Minimum an neuer Syntax und Semantik zur Sprache hinzu. Er ist
eine Mischung der Klassenmechanismen von C++ und Modula-3. Python Klassen bieten
alle Standardeigenschaften von objektorientierter Programmierung: Der
Vererbungsmechanismus von Klassen erlaubt mehrere Basisklassen, eine abgeleitete
Klasse kann jegliche Methoden seiner Basisklasse(n) überschreiben und eine
Methode kann die Methode der Basisklasse mit demselben Namen aufrufen. Objekte
können beliebig viele Mengen und Arten von Daten haben. Wie es auch bei Modulen
der Fall ist, haben auch Klassen die dynamische Natur von Python inne: Sie
werden zur Laufzeit erstellt und können auch nach der Erstellung verändert
werden.

In der Terminologie von C++ sind *class members* (inklusive der *data member*)
normalerweise in Python *public* (Ausnahmen siehe :ref:`tut-private`) und alle
*member functions* (Methoden) sind *virtual*. Wie in Modula-3 gibt es keine
Abkürzung zum referenzieren von Attributen eines Objekts aus dessen Methoden
heraus: Die Methode wird mit einem expliziten ersten Argument, welches das
Objekt repräsentiert, deklariert, und dann implizit beim Aufruf übergeben wird.
Wie in Smalltalk sind Klassen selbst Objekte. Das bietet Semantiken zum
importieren und umbenennen.  Anders als in C++ und Modula-3 können eingebaute
Datentypen vom Benutzer als Basisklassen benutzt, das heisst abgeleitet, werden.
Außerdem können die meisten eingebauten Operatoren, wie in C++, mit einer
besonderen Syntax (arithmetische Operatoren, Indizierung, usw.) für Instanzen
der Klasse neu definiert werden.

(Da es keine allgemein anerkannte Terminologie im Bezug auf Klassen gibt, werde
ich zwischendurch auf Smalltalk und C++ Begriffe ausweichen. Ich würde lieber
Modula-3 Begriffe benutzen, da seine objektorientierte Semantik näher an Python,
als an C++ ist, allerdings erwarte ich, dass wenige Leser davon gehört haben.)


.. _tut-object:

Ein Wort zu Namen und Objekten
==============================

Objekte haben Individualität und mehrere Namen (in mehreren
Gültigkeitsbereichen) können an dasselbe Objekt gebunden werden. In anderen
Sprachen wird dies als *Aliasing* bezeichnet. Das wird meist beim ersten Blick
auf Python nicht geschätzt und kann problemlos ignoriert werden, wenn man mit
unveränderbaren Datentypen (Zahlen, Zeichenketten, Tupel) arbeitet. Aber
Aliasing hat einen möglicherweise überraschenden Effekt auf die Semantik von
Pythoncode, der veränderbare Objekte wie Listen, Dictionaries oder die meisten
anderen Typen, enthält.  Dies kommt normalerweise dem Programm zugute, da sich
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
funktionieren, um vollkommen zu verstehen was abläuft. Außerdem ist das Wissen
hierüber nützlich für jeden fortgeschrittenen Pythonprogrammierer.

Fangen wir mit ein paar Definitionen an.

Ein *Namensraum* ist eine Zuordnung von Namen zu Objekten. Die meisten
Namensräume sind momentan als Dictionaries implementiert, aber das ist
normalerweise in keinerlei Hinsicht spürbar (außer bei der Performance) und kann
sich in Zukunft ändern. Beispiele für Namensräume sind: Die Menge der
eingebauten Namen (die Funktionen wie :func:`abs` und eingebaute Ausnahmen
enthält), die globalen Namen eines Moduls und die lokalen Namen eines
Funktionsaufrufs. In gewisser Hinsicht bilden auch die Attribute eines Objektes
einen Namensraum.  Das Wichtigste, das man über Namensräume wissen muss, ist,
dass es absolut keinen Bezug von Namen in verschiedenen Namensräumen zueinander
gibt. Zum Beispiel können zwei verschiedene Module eine Funktion namens
``maximize`` definieren, ohne dass es zu einer Verwechslung kommt, denn Benutzer
des Moduls müssen dessen Namen voranstellen.

Nebenbei bemerkt: Ich benutze das Wort *Attribut* für jeden Namen nach einem
Punkt --- zum Beispiel in dem Ausdruck ``z.real`` ist ``real`` ein Attribut des
Objekts ``z``. Genau genommen sind auch Referenzen zu Namen in Modulen
Attributreferenzen: Im Ausdruck ``modname.funcname``, ist ``modname`` ein
Modulobjekt und ``funcname`` ein Attribut dessen. In diesem Fall gibt es eine
geradlinige Zuordnung von Modulattributen und globalen Namen, die im Modul
definiert sind: Sie teilen sich denselben Namensraum! [#]_

Attribute können schreibgeschützt oder veränderbar sein. In letzterem Fall ist
eine Zuweisung an dieses Attribut möglich. Modulattribute sind veränderbar: Man
kann ``modname.the_answer = 42`` schreiben. Veränderbare Attribute sind
gleichzeitig durch die :keyword:`del`-Anweisung löschbar. Zum Beispiel löscht
``del modname.the_answer`` das Attribut :attr:`the_answer` des Objekts namens
``modname``.

Namensräume werden zu verschiedenen Zeitpunkten erzeugt und haben verschiedene
Lebenszeiten. Der Namensraum, der die eingebauten Namen enthält, wird beim Start
des Interpreters erzeugt und nie gelöscht. Der globale Namensraum für ein Modul
wird erzeugt, wenn die Moduldefinition eingelesen wird; normalerweise existieren
die Namensräume des Moduls auch solange bis der Interpreter beendet wird. Die
Anweisungen, die auf oberster Ebene vom Interpreter aufgerufen werden, entweder
von einem Skript oder interaktiv gelesen, werden als Teil des Moduls
:mod:`__main__`, sodass sie ihren eigenen globalen Namensraum haben. (Die
eingebauten Namen existieren ebenfalls in einem Modul namens :mod:`builtins`.)

Der lokale Namensraum einer Funktion wird bei deren Aufruf erstellt und wird
gelöscht, wenn sich die Funktion beendet oder eine Ausnahme auslöst, die nicht
innerhalb der Funktion behandelt wird. (Eigentlich wäre "vergessen" eine bessere
Beschreibung dessen, was passiert.) Natürlich haben auch rekursive Aufrufe ihren
jeweiligen lokalen Namensraum.

Ein *Gültigkeitsbereich* (*scope*) ist eine Region eines Python-Programms, in
der ein Namensraum direkt verfügbar ist, das heisst es einem unqualifiziertem
Namen möglich ist einen Namen in diesem Namensraum zu finden.

Auch wenn Gültigkeitsbereiche statisch ermittelt werden, werden sie dynamisch
benutzt. An einem beliebigen Zeitpunkt während der Ausführung, gibt es
mindestens drei verschachtelte Gültigkeitsbereiche, deren Namensräume direkt
verfügbar sind:

* Der innerste Gültigkeitsbereich, der zuerst durchsucht wird und die lokalen
  Namen enthält;
* der Gültigkeitsbereich mit allen umgebenden Namensräumen (enthält auch die
  globalen Namen des momentanen Moduls), der vom nächsten umgebenden Namensraum
  aus durchsucht wird, und nicht-lokale, aber auch nicht-globale Namen enthält;
* der vorletzte Gültigkeitsbereich enthält die globalen Namen des aktuellen
  Moduls;
* der letzte Gültigkeitsbereich (zuletzt durchsuchte) ist der Namensraum, der
  die eingebauten Namen enthält.

Wird ein Name als ``global`` deklariert, so gehen alle Referenzen und
Zuweisungen direkt an den mittleren Gültigkeitsbereich, der die globalen Namen
des Moduls enthält. Um Variablen, die außerhalb des innersten
Gültigkeitsbereichs zu finden sind, neu zu binden, kann die
:keyword:`nonlocal`-Anweisung benutzt werden.  Falls diese nicht als
``nonlocal`` deklariert sind, sind diese Variablen schreibgeschützt (ein Versuch
in diese Variablen zu schreiben, würde einfach eine *neue* lokale Variable im
innersten Gültigkeitsbereich anlegen und die äußere Variable mit demselben Namen
unverändert lassen).

Normalerweise referenziert der lokale Gültigkeitsbereich die lokalen Namen der
momentanen Funktion. Außerhalb von Funktionen bezieht sich der lokale
Gültigkeitsbereich auf denselben Namensraum wie der globale Gültigkeitsbereich:
Den Namensraum des Moduls. Klassendefinitionen stellen einen weiteren
Namensraum im lokalen Gültigkeitsbereich dar.

Es ist wichtig zu verstehen, dass die Gültigkeitsbereiche am Text ermittelt
werden: Der globale Gültigkeitsbereich einer Funktion, die in einem Modul
definiert wird, ist der Namensraum des Moduls, ganz egal wo die Funktion
aufgerufen wird. Andererseits wird die tatsächliche Suche nach Namen dynamisch
zur Laufzeit durchgeführt --- jedoch entwickelt sich die Definition der Sprache
hin zu einer statischen Namensauflösung zur Kompilierzeit, deshalb sollte man
sich nicht auf die dynamische Namensauflösung verlassen! (In der Tat werden
lokale Variablen schon statisch ermittelt.)

Eine besondere Eigenart Pythons ist, dass -- wenn keine
:keyword:`global`-Anweisung aktiv ist -- Zuweisungen an Namen immer im innersten
Gültigkeitsbereich abgewickelt werden. Zuweisungen kopieren keine
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

Beachte, dass die *lokale* Zuweisung (was der Standard ist) die Bindung von
*spam* in *scope_test* nicht verändert hat. Die :keyword:`nonlocal` Zuweisung
die Bindung von *spam* in *scope_test* und die :keyword:`global` Zuweisung die
Bindung auf Modulebene verändert hat.

Man kann außerdem sehen, dass es keine vorherige Bindung von *spam* vor der
:keyword:`global` Zuweisung gab.

.. _tut-firstclasses:

Eine erste Betrachtung von Klassen
==================================

Klassen führen ein kleines bisschen neue Syntax, drei neue Objekttypen und ein
wenig neue Semantik ein.


.. _tut-classdefinition:

Syntax der Klassendefinition
----------------------------

Die einfachste Form einer Klassendefinition sieht so aus::

    class ClassName:
        <anweisung-1>
        .
        .
        .
        <anweisung-N>

Klassendefinitionen müssen wie Funktionsdefinitionen
(:keyword:`def`-Anweisungen) ausgeführt werden, bevor sie irgendwelche
Auswirkungen haben. (Es wäre vorstellbar eine Klassendefinition in einen Zweig
einer :keyword:`if`-Anweisung oder in eine Funktion zu platzieren.)

In der Praxis sind die Anweisungen innerhalb einer Klassendefinition
üblicherweise Funktionsdefinitionen, aber andere Anweisungen sind erlaubt und
manchmal nützlich --- dazu kommen wir später noch. Die Funktionsdefinitionen
innerhalb einer Klasse haben normalerweise eine besondere Argumentliste, die
von den Aufrufkonventionen für Methoden vorgeschrieben wird --- das wird
wiederum später erklärt.

Wird eine Klassendefinition betreten, wird ein neuer Namensraum erzeugt und als
lokaler Gültigkeitsbereich benutzt --- deshalb werden Zuweisungen an lokale
Variablen in diesem neuen Namensraum wirksam. Funktionsdefinitionen binden den
Namen der neuen Funktion ebenfalls dort.

Wird eine Klassendefinition normal verlassen (indem sie endet), wird ein
*Klassenobjekt* erstellt. Dies ist im Grunde eine Verpackung um den Inhalt des
Namensraums, der von der Klassendefinition erstellt wurde. Im nächsten Abschnitt
lernen wir mehr darüber. Der ursprüngliche lokale Gültigkeitsbereich (der vor
dem Betreten der Klassendefinition aktiv war) wird wiederhergestellt und das
Klassenobjekt wird in ihm an den Namen, der im Kopf der Klassendefinition
angegeben wurde, gebunden (:class:`ClassName` in unserem Beispiel). 


.. _tut-classobjects:

Klassenobjekte
--------------

Klassenobjekte unterstützen zwei Arten von Operationen: Attributreferenzierungen
und Instanziierung.

*Attributreferenzierungen* benutzen die normale Syntax, die für alle
Attributreferenzen in Python benutzt werden: ``obj.name``. Gültige Attribute
sind alle Namen, die bei der Erzeugung des Klassenobjektes im Namensraum der
Klasse waren. Wenn die Klassendefinition also so aussah::

   class MyClass:
       """A simple example class"""
       i = 12345
       def f(self):
           return 'Hallo Welt'


dann sind ``MyClass.i`` und ``MyClass.f`` gültige Attributreferenzen, die eine
Ganzzahl beziehungsweise ein Funktionsobjekt zurückgeben. Zuweisungen an
Klassenattribute sind ebenfalls möglich, sodass man den Wert von ``MyClass.i``
durch Zuweisung verändern kann. :attr:`__doc__` ist ebenfalls ein gültiges
Attribut, das den Docstring, der zur Klasse gehört, enthält: ``"A simple example
class"``.

Klassen *Instanziierung* benutzt die Funktionsnotation. Tu einfach so, als ob
das Klassenobjekt eine parameterlose Funktion wäre, die eine neue Instanz der
Klasse zurückgibt. Zum Beispiel (im Fall der obigen Klasse)::

   x = MyClass()


Dies erzeugt eine neue *Instanz* der Klasse und weist dieses Objekt der lokalen
Variable ``x`` zu.

Die Instanziierungsoperation ("aufrufen" eines Klassenobjekts) erzeugt ein leeres
Objekt. Viele Klassen haben es gerne Instanzobjekte, die auf einen spezifischen
Anfangszustand angepasst wurden, zu erstellen. Deshalb kann eine Klasse eine
spezielle Methode namens :meth:`__init__`, wie folgt definieren::

   def __init__(self):
       self.data = []

Definiert eine Klasse eine :meth:`__init__`-Methode, ruft die
Klasseninstanziierung automatisch :meth:`__init__` für die neu erstellte
Klasseninstanz auf. So kann in diesem Beispiel eine neue, initialisierte Instanz
durch folgendes bekommen werden::

   x = MyClass()

Natürlich kann die :meth:`__init__`-Methode Argumente haben, um eine größere
Flexibilität zu erreichen. In diesem Fall werden die, dem
Klasseninstanziierungsoperator übergebenen Argumente an :meth:`__init__`
weitergereicht. Zum Beispiel::

   >>> class Complex:
   ...     def __init__(self, realpart, imagpart):
   ...         self.r = realpart
   ...         self.i = imagpart
   ...
   >>> x = Complex(3.0, -4.5)
   >>> x.r, x.i
   (3.0, -4.5)


.. _tut-instanceobjects:

Instanzobjekte
--------------

Was können wir jetzt mit den Instanzobjekten tun? Die einzigen Operationen, die
Instanzobjekte verstehen, sind Attributreferenzierungen. Es gibt zwei Arten
gültiger Attribute: Datenattribute und Methoden.

*Datenattribute* entsprechen "Instanzvariablen" in Smalltalk und "data members"
in C++. Datenattribute müssen nicht deklariert werden; wie lokale Variablen
erwachen sie zum Leben, sobald ihnen zum ersten Mal etwas zugewiesen wird. Zum
Beispiel wird folgender Code, unter der Annahme, dass ``x`` die Instanz von
:class:`MyClass` ist, die oben erstellt wurde, den Wert ``16`` ausgeben, ohne
Spuren zu hinterlassen::

    x.counter = 1
    while x.counter < 10:
        x.counter = x.counter * 2
    print(x.counter)
    del x.counter

Die andere Art von Instanzattribut ist die *Methode*. Eine Methode ist eine
Funktion, die zu einem Objekt *gehört*. (In Python existiert der Begriff Methode
nicht allein für Klasseninstanzen: Andere Objekttypen können genauso Methoden
haben. Zum Beispiel haben Listenobjekte Methoden namens :meth:`append`,
:meth:`insert`, :meth:`remove`, :meth:`sort`, und so weiter. Jedoch benutzen wir
in der folgenden Diskussion den Begriff Methode ausschliesslich im Sinne von
Methoden von Klasseninstanzobjekten, sofern nichts anderes angegeben ist.

.. index:: object: method

Ob ein Attribut eine gültige Methode ist, hängt von der Klasse ab. Per
Definition definieren alle Attribute, die ein Funktionsobjekt sind, ein
entsprechendes Methodenobjekt für seine Instanz. Deshalb ist in unserem Beispiel
``x.f`` eine gültige Methodenreferenz, da ``MyClass.f`` eine Funktion ist, aber
``x.i`` ist keine, da ``MyClass.i`` es nicht ist. ``x.f`` ist aber nicht
dasselbe wie ``MyClass.f`` --- es ist ein *Methodenobjekt* und kein
Funktionsobjekt.

.. _tut-methodobjects:

Methodenobjekte
---------------

Üblicherweise wird eine Methode gemäß seiner Bindung aufgerufen::

    x.f()

Im :class:`MyClass` Beispiel wird dies die Zeichenkette ``'Hallo Welt'``
ausgeben. Jedoch ist es nicht notwendig eine Methode direkt aufzurufen: ``x.f``
ist ein Methodenobjekt und kann weg gespeichert werden und später wieder
aufgerufen werden. Zum Beispiel::

    xf = x.f
    while True:
        print(xf())

Das wird bis zum Ende der Zeit ``Hallo Welt`` ausgeben.

Was passiert genau, wenn eine Methode aufgerufen wird? Du hast vielleicht
bemerkt, dass ``x.f()`` oben ohne Argument aufgerufen wurde, obwohl in der
Funktionsdefinition für :meth:`f` ein Argument festgelegt wurde. Was ist mit
diesem Argument passiert? Natürlich verursacht Python eine Ausnahme, wenn eine
Funktion, die ein Argument benötigt ohne aufgerufen wird --- auch wenn das
Argument eigentlich gar nicht genutzt wird ...

Tatsächlich, wie du vielleicht schon erraten hast, ist die Besonderheit bei
Methoden, dass das Objekt als erstes Argument der Funktion übergeben wird. In
unserem Beispiel ist der Aufruf ``x.f()`` das genaue äquivalent von
``MyClass.f(x)``. Im Allgemeinen ist der Aufruf einer Methode mit *n* Argumenten
äquivalent zum Aufruf der entsprechenden Funktion mit einer Argumentliste, die
durch das Einfügen des Objekts der Methode vor das erste Argument erzeugt wird.

Verstehst du immernoch nicht, wie Methoden funktionieren, hilft vielleicht ein
Blick auf die Implementierung, um die Dinge zu klären. Wenn ein Instanzattribut
referenziert wird, das kein Datenattribut ist, wird seine Klasse durchsucht.
Bezeichnet der Name ein gültiges Klassenattribut, das eine Funktion ist, wird
ein Methodenobjekt erzeugt, indem (Zeiger zu) Instanzobjekt und Funktionsobjekt
zu einem abstrakten Objekt verschmolzen werden: Dies ist das Methodenobjekt.
Wird das Methodenobjekt mit einer Argumentliste aufgerufen, wird es wieder
entpackt, eine neue Argumentliste aus dem Instanzobjekt und der ursprünglichen
Argumentliste erzeugt und das Funktionsobjekt mit dieser neuen Argumentliste
aufgerufen.


.. _tut-remarks:

Beiläufige Anmerkungen
======================

Datenattribute überschreiben Methodenattribute desselben Namens. Um zufällige
Namenskonflikte zu vermeiden, die zu schwer auffindbaren Fehlern in großen
Programmen führen, ist es sinnvoll sich auf irgendeine Konvention zu
verständigen, die das Risiko solcher Konflikte vermindern. Mögliche Konventionen
beinhalten das Großschreiben von Methodennamen, das Voranstellen von kleinen
eindeutigen Zeichenketten (vielleicht auch nur ein Unterstrich) bei
Datenattributen oder das Benutzen von Verben bei Methodennamen und Nomen bei
Datenattributen.

Datenattribute können von Methoden, genauso wie von normalen Benutzern
("clients") eines Objektes referenziert werden. In anderen Worten: Klassen sind
nicht benutzbar, um reine abstrakte Datentypen ("abstract data types") zu
implementieren. In Wirklichkeit, gibt es in Python keine Möglichkeit um
Datenkapselung (*data hiding*) zu erzwingen --- alles basiert auf Konventionen.
(Auf der anderen Seite kann die Python-Implementierung, in C geschrieben,
Implementationsdetails komplett verstecken und den Zugriff auf ein Objekt
kontrollieren, wenn das nötig ist; das kann von in C geschriebenen
Python-Erweiterungen ebenfalls benutzt werden.)

Clients sollten Datenattribute mit Bedacht nutzen, denn sie könnten Invarianten
kaputt machen, die von Methoden verwaltet werden, indem sie auf deren
Datenattributen herumtrampeln. Man sollte beachten, dass Clients zu ihrem
eigenen Instanzobjekt Datenattribute hinzufügen können, ohne die Gültigkeit der
Methoden zu gefährden, sofern Namenskonflikte vermieden werden --- auch hier
kann eine Bennenungskonvention viele Kopfschmerzen ersparen.

Es gibt keine Abkürzung, um Datenattribute (oder andere Methoden!) innerhalb von
Methoden zu referenzieren. Meiner Meinung verhilft das Methoden zu besserer
Lesbarkeit: Man läuft keine Gefahr, lokale und Instanzvariablen zu verwechseln,
wenn man eine Methode überfliegt.

Oft wird das erste Argument einer Methode ``self`` genannt. Dies ist nichts
anderes als eine Konvention: Der Name ``self`` hat absolut keine spezielle
Bedeutung für Python. Aber beachte: Hälst du dich nicht an die Konvention, kann
dein Code schwerer lesbar für andere Python-Programmierer sein und es ist auch
vorstellbar, dass ein *Klassenbrowser* (*class browser*) sich auf diese
Konvention verlässt.

Jedes Funktionsobjekt, das ein Klassenattribut ist, definiert eine Methode für
Instanzen dieser Klasse. Es ist nicht nötig, dass die Funktionsdefinition im
Text innerhalb der Klassendefinition ist: Die Zuweisung eines Funktionsobjektes
an eine lokale Variable innerhalb der Klasse ist ebenfalls in Ordnung. Zum
Beispiel::

    # Funktionsdefintion außerhalb der Klasse
    def f1(self, x, y):
       return min(x, x+y)

    class C:
       f = f1
       def g(self):
           return 'Hallo Welt'
       h = g

``f``, ``g`` und ``h`` sind jetzt alle Attribute der Klasse :class:`C`, die
Funktionsobjekte referenzieren und somit sind sie auch alle Methoden der
Instanzen von :class:`C` --- ``h`` ist dabei gleichbedeutend mit ``g``. Beachte
aber, dass diese Praxis nur dazu dient einen Leser des Programms zu verwirren.

Methoden können auch andere Methoden aufrufen, indem sie das Methodenattribut
des Arguments ``self`` benutzen::

    class Bag:
       def __init__(self):
           self.data = []
       def add(self, x):
           self.data.append(x)
       def addtwice(self, x):
           self.add(x)
           self.add(x)

Methoden können globale Namen genauso wie normale Funktionen referenzieren. Der
globale Gültigkeitsbereich der Methode ist das Modul, das die Klassendefinition
enthält. (Die Klasse selbst wird nie als globaler Gültigkeitsbereich benutzt.)
Während man selten einen guten Grund dafür hat globale Daten zu benutzen, gibt
es viele berechtigte Verwendungen des globalen Gültigkeitsbereichs: Zum einen
können Funktionen und Module, die in den globalen Gültigkeitsbereich importiert
werden, genauso wie Funktionen und Klassen die darin definiert werden, von der
Methode benutzt werden. Normalerweise ist die Klasse, die die Methode enthält,
selbst in diesem globalen Gültigkeitsbereich definiert und im nächsten Abschnitt
werden wir ein paar gute Gründe entdecken, warum eine Methode die eigene Klasse
referenzieren wollte.

Jeder Wert ist ein Objekt und hat deshalb eine *Klasse* (auch *type* genannt).
Es wird als ``Objekt.__class__`` abgelegt.


..  _tut-inheritance:

Vererbung
=========

Natürlich verdient ein Sprachmerkmal nicht den Namen "Klasse", wenn es nicht
Vererbung unterstützt. Die Syntax für eine abgeleitete Klassendefinition sieht
so aus::

    class DerivedClassName(BaseClassName):
       <statement-1>
       .
       .
       .
       <statement-N>

Der Name :class:`BaseClassName` muss innerhalb des Gültigkeitsbereichs, der die
abgeleitete Klassendefinition enthält, definiert sein. Anstelle eines
Basisklassennamens sind auch andere willkürliche Ausdrücke erlaubt. Dies kann
beispielsweise nützlich sein, wenn die Basisklasse in einem anderen Modul
definiert ist::

    class DerivedClassName(modname.BaseClassName):

Die Ausführung einer abgeleiteten Klassendefinition läuft genauso wie bei einer
Basisklasse ab. Bei der Erzeugung des Klassenobjekts, wird sich der Basisklasse
erinnert. Dies wird zum Auflösen der Attributsreferenzen benutzt: Wird ein
angefordertes Attribut nicht innerhalb der Klasse gefunden, so wird in der
Basisklasse weitergesucht. Diese Regel wird rekursiv angewandt, wenn die
Basisklasse selbst von einer anderen Klasse abgeleitet wird.

Es gibt nichts besonderes an der Instanziierung von abgeleiteten Klassen:
``DerivedClassName`` erzeugt eine neue Instanz der Klasse. Methodenreferenzen
werden wie folgt aufgelöst: Das entsprechende Klassenattribut wird durchsucht,
falls nötig bis zum Ende der Basisklassenkette hinab und die Methodenreferenz
ist gültig, wenn es ein Funktionsobjekt bereithält.

Abgeleitete Klassen können Methoden ihrer Basisklassen überschreiben. Da
Methoden keine besonderen Privilegien beim Aufrufen anderer Methoden desselben
Objekts haben, kann eine Methode einer Basisklasse, die eine andere Methode, die
in derselben Basisklasse definiert wird, aufruft, beim Aufruf einer Methode der
abgeleiteten Klasse landen, die sie überschreibt. (Für C++-Programmierer: Alle
Methoden in Python sind im Grunde ``virtual``.)

Eine überschreibende Methode in einer abgeleiteten Klasse wird in der Tat eher
die Methode der Basisklasse mit demselben Namen erweitern, statt einfach nur zu
ersetzen. Es gibt einen einfachen Weg die Basisklassenmethode direkt aufzurufen:
Einfach ``BaseClassName.methodname(self, arguments)`` aufrufen. Das ist
gelegentlich auch für Clients nützlich. (Beachte, dass dies nur funktioniert,
wenn die Basisklasse als ``BaseClassName`` im globalen Gültigkeitsbereich
zugänglich ist.)

Python hat zwei eingebaute Funktionen, die mit Vererbung zusammenarbeiten:

* Man benutzt :func:`isinstance` um den Typ eines Objekts zu überprüfen:
  ``isinstance(obj, int)`` ist nur dann ``True``, wenn ``obj.__class__`` vom Typ
  :class:`int` oder einer davon abgeleiteten Klasse ist.

* Man benutzt :func:`issubclass` um Klassenvererbung zu überprüfen:
  ``issubclass(bool, int)`` ist ``True``, da :class:`bool` eine von :class:`int`
  abgeleitete Klasse ist. Jedoch ist ``issubclass(float, int)`` ``False``, da
  :class:`float` keine von :class:`int` abgeleitete Klasse ist.


.. _tut-multiple:

Mehrfachvererbung
-----------------

Python unterstützt auch eine Form der Mehrfachvererbung. Eine Klassendefinition
mit mehreren Basisklassen sieht so aus::

    class DerivedClassName(Base1, Base2, Base3):
       <statement-1>
       .
       .
       .
       <statement-N>

Für die meisten Zwecke, im einfachsten Fall, kann man sich die Suche nach
geerbten Attributen von einer Elternklasse so vorstellen: Zuerst in die Tiefe
(*depth-first*), von links nach rechts (*left-to-right*), wobei nicht zweimal in
derselben Klasse gesucht wird, wenn sich die Klassenhierarchie dort überlappt.
Deshalb wird, wenn ein Attribut nicht in :class:`DerivedClassName` gefunden
wird, danach in :class:`Base1` gesucht, dann (rekursiv) in den Basisklassen von
:class:`Base1` und wenn es dort nicht gefunden wurde, wird in :class:`Base2`
gesucht, und so weiter.

In Wirklichkeit ist es ein wenig komplexer als das, denn die Reihenfolge der
Methodenauflösung (*method resolution order - MRO*) wird dynamisch verändert, um
zusammenwirkende Aufrufe von :func:`super` zu unterstützen. Dieser Ansatz wird
in manchen anderen Sprachen als *call-next-method* (Aufruf der nächsten Methode)
bekannt und ist mächtiger als der ``super``-Aufruf, den es in Sprachen mit
einfacher Vererbung gibt.

Es ist nötig dynamisch zu ordnen, da alle Fälle von Mehrfachvererbung eine oder
mehrere Diamantbeziehungen aufweisen (bei der auf mindestens eine der
Elternklassen durch mehrere Pfade von der untersten Klasse aus zugegriffen
werden kann). Zum Beispiel erben alle Klassen von :class:`object` und so stellt
jeder Fall von Mehrfachvererbung mehrere Wege bereit, um :class:`object`
zu erreichen. Um zu verhindern, dass auf die Basisklassen mehr als einmal
zugegriffen werden kann, linearisiert der dynamische Algorithmus die
Suchreihenfolge, sodass die Ordnung von links nach rechts, die in jeder Klasse
festgelegt wird, jede Elternklasse nur einmal aufruft und zwar monoton (in der
Bedeutung, dass eine Klasse geerbt werden kann, ohne das die Rangfolge seiner Eltern
berührt wird). Zusammengenommen machen diese Eigenschaften es möglich
verlässliche und erweiterbare Klassen mit Mehrfachvererbung zu entwerfen. Für
Details, siehe http://www.python.org/download/releases/2.3/mro/.


.. _tut-private:

Private Variablen
=================

"Private" Instanzvariablen, die nur innerhalb des Objekts zugänglich sind, gibt
es in Python nicht.  Jedoch gibt es eine Konvention, die im meisten Python-Code
befolgt wird: Ein Name, der mit einem Unterstrich beginnt (z.B.  ``_spam``)
sollte als nicht-öffentlicher Teil der API behandelt werden (egal ob es eine
Funktion, eine Methode oder ein Datenattribut ist).  Es sollte als
Implementierungsdetails behandelt werden, das sich unangekündigt ändern kann.

Da es eine sinnvolle Verwendung für klassen-private Attribute gibt, um
Namenskonflikte mit Namen, die von Unterklassen definiert werden zu vermeiden,
gibt es eine begrenzte Unterstützung für so einen Mechanismus: :dfn:`name
mangling` (Namensersetzung).  Jeder Bezeichner der Form ``__spam`` (mindestens
zwei führende Unterstriche, höchstens ein folgender) wird im Text durch
``_classname__spam`` ersetzt, wobei ``classname`` der Name der aktuellen Klasse
(ohne eventuelle führende Unterstriche) ist.  Die Ersetzung geschieht ohne
Rücksicht auf die syntaktische Position des Bezeichners, sofern er innerhalb der
Definition der Klasse steht.

Namensersetzung ist hilfreich, um Unterklassen zu ermöglichen Methoden zu
überschreiben, ohne dabei Methodenaufrufe innerhalb der Klasse zu stören.  Zum
Beispiel::

   class Mapping:
       def __init__(self, iterable):
           self.items_list = []
           self.__update(iterable)

       def update(self, iterable):
           for item in iterable:
               self.items_list.append(item)

       __update = update   # private Kopie der ursprünglichen update() Methode

   class MappingSubclass(Mapping):

       def update(self, keys, values):
           # erstellt update() mit neuer Signatur
           # macht aber __init__() nicht kaputt
           for item in zip(keys, values):
               self.items_list.append(item)

Beachte, dass die Ersetzungsregeln vor allem dazu gedacht sind, Unfälle zu
vermeiden; es ist immernoch möglich auf einen solchen als privat
gekennzeichneten Namen von aussen zuzugreifen und ihn auch zu verändern.  Das
kann in manchen Umständen sogar nützlich sein, beispielsweise in einem Debugger.

Beachte, dass Code, der von ``exec()`` oder ``eval()`` ausgeführt wird, den
Klassennamen der aufrufenden Klasse nicht als die aktuelle Klasse ansieht. Dies
ähnelt dem Effekt der :keyword:`global`-Anweisung, der ebenfalls sehr beschränkt
auf den Code ist, der zusammen byte-kompiliert wird.  Die gleiche Begrenzung
gilt für ``getattr()``, ``setattr()`` und ``delattr()``, sowie den direkten
Zugriff auf ``__dict__``.

.. _tut-odds:

Kleinkram
=========

Manchmal ist es nützlich einen Datentyp zu haben, der sich ähnlich dem
``record`` in Pascal oder dem "struct" in C verhält und ein Container für ein
paar Daten ist. Hier bietet sich eine leere Klassendefinition an::

    class Employee:
        pass

    john = Employee() # Eine leere Arbeitnehmerakte anlegen

    # Die Akte ausfüllen
    john.name = 'John Doe'
    john.dept = 'Computerraum'
    john.salary = 1000

Einem Stück Python-Code, der einen bestimmten abstrakten Datentyp erwartet, kann
stattdessen oft eine Klasse übergeben werden, die die Methoden dieses Datentyps
emuliert. Wenn man zum Beispiel eine Funktion hat, die Daten aus einem
Dateiobjekt formatiert, kann man eine Klasse mit den Methoden :meth:`read` und
:meth:`readline` definieren, die die Daten stattdessen aus einem
Zeichenkettenpuffer bekommt, und als Argument übergeben.

Methodenobjekte der Instanz haben auch Attribute: ``m.__self__`` ist das
Instanzobjekt mit der Methode :meth:`m` und ``m.__func__`` ist das entsprechende
Funktionsobjekt der Methode.

.. _tut-exceptionclasses:

Ausnahmen sind auch Klassen
===========================

Benutzerdefinierte Ausnahmen werden auch durch Klassen gekennzeichnet. Durch die
Nutzung dieses Mechanismus ist es möglich erweiterbare Hierarchien von
Ausnahmen zu erstellen.

Es gibt zwei neue (semantisch) gültige Varianten der
:keyword:`raise`-Anweisung::

    raise Klasse

    raise Instanz

In der ersten Variante muss ``Class`` eine Instanz von :class:`type` oder einer
davon abgeleiteten Klasse sein und ist eine Abkürzung für::

    raise Klasse()

Die in einem :keyword:`except`-Satz angegebene Klasse fängt Ausnahmen dann ab,
wenn sie Instanzen derselben Klasse sind oder von dieser abgeleitet wurden,
nicht jedoch andersrum --- der mit einer abgeleiteten Klasse angegebene
:keyword:`except`-Satz fängt nicht die Basisklasse ab. Zum Beispiel gibt der
folgende Code B, C, D in dieser Reihenfolge aus::

    class B(Exception):
       pass
    class C(B):
       pass
    class D(C):
       pass

    for cls in [B, C, D]:
       try:
           raise cls()
       except D:
           print("D")
       except C:
           print("C")
       except B:
           print("B")

Beachte, dass B, B, B ausgegeben wird, wenn man die Reihenfolge umdreht, das
heisst zuerst ``except B``, da der erste zutreffende :keyword:`except`-Satz
ausgelöst wird.

Wenn eine Fehlermeldung wegen einer unbehandelten Ausnahme ausgegeben wird, wird
der Name der Klasse, danach ein Doppelpunkt und ein Leerzeichen und schliesslich
die Instanz mit Hilfe der eingebauten Funktion :func:`str` zu einer Zeichenkette
umgewandelt ausgegeben.


.. _tut-iterators:

Iteratoren
==========

Mittlerweile hast du wahrscheinlich bemerkt, dass man über die meisten
Containerobjekte mit Hilfe von :keyword:`for` iterieren kann::

    for element in [1, 2, 3]:
       print(element)
    for element in (1, 2, 3):
       print(element)
    for key in {'eins':1, 'zwei':2}:
       print(key)
    for char in "123":
       print(char)
    for line in open("meinedatei.txt"):
       print(line)

Diese Art des Zugriffs ist klar, präzise und praktisch. Der Gebrauch von
Iteratoren durchdringt und vereinheitlicht Python. Hinter den Kulissen ruft die
:keyword:`for`-Anweisung :func:`iter` für das Containerobjekt auf. Die Funktion
gibt ein Iteratorobjekt zurück, das die Methode :meth:`__next__` definiert,
die auf die Elemente des Containers nacheinander zugreift. Gibt es keine
Elemente mehr, verursacht :meth:`__next__` eine :exc:`StopIteration`-Ausnahme,
die der :keyword:`for`-Schleife mitteilt, dass sie sich beenden soll. Man kann
auch die :meth:`__next__`-Methode mit Hilfe der eingebauten Funktion
:func:`next` aufrufen. Folgendes Beispiel demonstriert, wie alles funktioniert.

    >>> s = 'abc'
    >>> it = iter(s)
    >>> it
    <iterator object at 0x00A1DB50>
    >>> next(it)
    'a'
    >>> next(it)
    'b'
    >>> next(it)
    'c'
    >>> next(it)
    Traceback (most recent call last):
     File "<stdin>", line 1, in ?
       next(it)
    StopIteration

Kennt man die Mechanismen hinter dem Iterator-Protokoll, ist es einfach das
Verhalten von Iteratoren eigenen Klassen hinzuzufügen. Man definiert eine
:meth:`__iter__`-Methode, die ein Objekt mit einer :meth:`__next__`-Methode
zurückgibt. Definiert die Klasse :meth:`__next__`, kann :meth:`__iter__` einfach
``self`` zurückgeben::

    class Reverse:
       """Iterator for looping over a sequence backwards."""
       def __init__(self, data):
           self.data = data
           self.index = len(data)
       def __iter__(self):
           return self
       def __next__(self):
           if self.index == 0:
               raise StopIteration
           self.index = self.index - 1
           return self.data[self.index]

::

    >>> rev = Reverse('spam')
    >>> iter(rev)
    <__main__.Reverse object at 0x00A1DB50>
    >>> for char in rev:
    ...     print(char)
    ...
    m
    a
    p
    s


.. _tut-generators:

Generatoren
===========

Generatoren (:term:`generator`) sind eine einfache aber mächtige Möglichkeit um
Iteratoren zu erzeugen. Generatoren werden wie normale Funktionen geschrieben,
benutzen aber :keyword:`yield`, um Daten zurückzugeben. Jedes Mal wenn
:func:`next` aufgerufen wird, fährt der Generator an der Stelle fort, an der er
zuletzt verlassen wurde (der Generator merkt sich dabei die Werte aller
Variablen und welche Anweisung zuletzt ausgeführt wurde). Das nachfolgende
Beispiel zeigt wie einfach die Erstellung von Generatoren ist::

   def reverse(data):
       for index in range(len(data)-1, -1, -1):
           yield data[index]

::

   >>> for char in reverse('golf'):
   ...     print(char)
   ...
   f
   l
   o
   g

Alles, was mit Generatoren möglich ist, kann ebenso (wie im vorigen Abschnitt
dargestellt) mit Klassen-basierten Iteratoren, umgesetzt werden. Generatoren
erlauben jedoch eine kompaktere Schreibweise, da die Methoden :meth:`__iter__`
und :meth:`__next__` automatisch erstellt werden.

Des weiteren werden die lokalen Variablen und der Ausführungsstand automatisch
zwischen den Aufrufen gespeichert. Das macht das Schreiben der Funktion einfacher
und verständlicher als ein Ansatz, der mit Instanzvariablen wie ``self.index``
oder ``self.data`` arbeitet.

Generatoren werfen automatisch :exc:`StopIteration`, wenn sie terminieren.
Zusammengenommen ermöglichen diese Features die Erstellung von Iteratoren mit
einem Aufwand, der nicht größer als die Erstellung einer normalen Funktion ist.

.. _tut-genexps:

Generator Ausdrücke
===================

Manche einfachen Generatoren können prägnant als Ausdrücke mit Hilfe einer
Syntax geschrieben werden, die der von List Comprehensions ähnlich ist, jedoch
mit runden, statt eckigen Klammern. Diese Ausdrücke sind für Situationen
gedacht, in denen der Generator gleich von der umgebenden Funktion genutzt wird.
Generator Ausdrücke sind kompakter, aber auch nicht so flexibel wie ganze
Generatordefinitionen und neigen dazu speicherschonender als die entsprechenden
List Comprehensions zu sein.

Beispiele::

   >>> sum(i*i for i in range(10))                 # Summe der Quadrate
   285

   >>> xvec = [10, 20, 30]
   >>> yvec = [7, 5, 3]
   >>> sum(x*y for x,y in zip(xvec, yvec))         # Skalarprodukt
   260

   >>> from math import pi, sin
   >>> sine_table = {x: sin(x*pi/180) for x in range(0, 91)}

   >>> unique_words = set(word for line in page for word in line.split())

   >>> valedictorian = max((student.gpa, student.name) for student in graduates)

   >>> data = 'golf'
   >>> list(data[i] for i in range(len(data)-1, -1, -1))
   ['f', 'l', 'o', 'g']


.. rubric:: Fußnoten

.. [#] Bis auf eine Ausnahme: Modulobjekte haben ein geheimes, schreibgeschützes
   Attribut namens :attr:`__dict__`, das das Dictionary darstellt, mit dem der
   Namensraum des Modules implementiert wird; der Name :attr:`__dict__`` ist ein
   Attribut, aber kein globaler Name. Offensichtlich ist dessen Benutzung eine
   Verletzung der Abstraktion der Namensraumimplementation und sollte deshalb
   auf Verwendungen wie die eines Post-Mortem-Debuggers reduziert werden.
