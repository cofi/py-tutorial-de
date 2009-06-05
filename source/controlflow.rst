.. _tut-morecontrol:


**********************************
Mehr Werkzeuge zur Ablaufsteuerung
**********************************

Neben der :keyword:`while`-Anweisung, die gerade vorgestellt wurde, kennt Python
die üblichen Anweisungen zur Ablaufsteuerung, die von anderen Sprachen bekannt
sind, mit ein paar Veränderungen.


.. _tut-if:

:keyword:`if`-Anweisungen
=========================

Der vielleicht bekannteste Anweisungstyp ist die :keyword:`if`-Anweisung. Zum
Beispiel::

    >>> x = int(input("Please enter an integer: "))
    Please enter an integer: 42
    >>> if x < 0:
    ...      x = 0
    ...      print('Negative changed to zero')
    ... elif x == 0:
    ...      print('Zero')
    ... elif x == 1:
    ...      print('Single')
    ... else:
    ...      print('More')
    ...
    More

Es können null oder mehr :keyword:`elif`-Zweige vorhanden sein und der
:keyword:`else`-Zweig ist optional. Das Schlüsselwort ':keyword:`elif`' ist eine
Abkürzung für 'else if' und ist nützlich um exzessive Einrückungen zu vermeiden.
Eine Abfolge von :keyword:`if` ... :keyword:`elif` ... :keyword:`elif` ...  ist die
Ersetzung für ``switch``- oder ``case``-Anweisungen, die es in anderen Sprachen
gibt.


.. _tut-for:


:keyword:`for`-Anweisungen
==========================

.. index::
   statement: for

Die :keyword:`for`-Anweisung in Python unterscheidet sich ein bisschen von der,
die man von C oder Pascal her kennt. Anders als immer nur über einen
arithmetische Abfolge von Nummern (wie in Pascal), oder dem Benutzer die
Möglichkeit zu geben sowohl Schrittweite, als auch Abbruchbedingung zu
definieren (wie in C), iteriert Pythons :keyword:`for`-Anweisung über die
Elemente einer Sequenz (eine Liste oder ein String), in der Reihenfolge, wie sie
in der Sequenz auftauchen. Zum Beispiel (Das soll keine Anspielung sein!):

::

    >>> # Ein paar Strings messen:
    ... a = ['Katze', 'Fenster', 'rauswerfen']
    >>> for x in a:
    ...     print(x, len(x))
    ...
    Katze 5
    Fenster 7
    rauswerfen 10

Es ist nicht ungefährlich die Sequenz zu verändern über die gerade in der
Schleife iteriert wird (was nur im Falle von veränderbaren Sequenztypen, wie bei
Listen, passieren kann). Wenn man die Liste verändern will, über die man
iteriert (zum Beispiel, um ausgewählte Elemente zu duplizieren), muss man über
eine Kopie iterieren. Die Slicenotation macht das besonders bequem::

    >>> for x in a[:]: # benutze eine Kopie der gesamten Liste
    ...    if len(x) > 7: a.insert(0, x)
    ...
    >>> a
    ['rauswerfen', 'Katze', 'Fenster', 'rauswerfen']

.. _tut-range:

Die Funktion :func:`range`
==========================

Wenn man wirklich über eine Abfolge von Nummern iterieren muss, kommt einem die
eingebaute Funktion :func:`range` gelegen. Sie generiert arithmetische
Abfolgen::

    >>> for i in range(5):
    ...     print(i)
    ...
    0
    1
    2
    3
    4

Der gegebene Endpunkt ist nie Teil der generierten Liste; ``range(10)``
generiert 10 Werte, die gültigen Indices einer Sequenz mit zehn Elementen. Es
ist auch möglich die möglich den Bereich bei einer anderen Nummer zu beginnen,
oder eine andere Schrittweite festzulegen (sogar negative; manchmal wird dies
*step* gennant)::

    range(5, 10)
       5 bis 9

    range(0, 10, 3)
       0, 3, 6, 9

    range(-10, -100, -30)
      -10, -40, -70

Um über die Indices einer Sequenz zu iterieren, kann man :func:`range` und
:func:`len` wie folgt kombinieren::

    >>> a = ['Mary', 'hatte', 'ein', 'kleines', 'Lamm']
    >>> for i in range(len(a)):
    ...     print(i, a[i])
    ...
    0 Mary
    1 hatte
    2 ein
    3 kleines
    4 Lamm

Meistens ist es jedoch geeigneter die Funktion :func:`enumerate` zu benutzen,
siehe :ref:`tut-loopidioms`.

Etwas seltsames passiert, wenn man einfach ein `range` ausgeben will::

    >>> print(range(10))
    range(0, 10)

In vielen Fällen verhält sich das von :func:`range` zurückgegebene Objekt, als
wäre es eine Liste, ist es aber in den meisten Fällen nicht. Es ist ein Objekt,
das aufeinander folgende Elemente der gewünschten Abfolge zurückgibt, wenn man
darüber iteriert, aber es macht diese Liste nicht wirklich, einfach um Platz zu
sparen.

Wir nennen solch ein Objekt *Iterable*, das heisst, es ist geeignet als Ziel
einer Funktion oder sonstigen Konstruktes, die etwas erwarten, von dem man
sukzessive Elemente erhält bis der Vorrat ausgeschöpft ist. Wir haben gesehen,
dass die :keyword:`for`-Anweisung ein solcher *Iterator* ist. Die
Funktion:func:`list` ist ein anderer; sie erstellt Listen von Iterables::

    >>> list(range(5))
    [0, 1, 2, 3, 4]

Später sehen wir weitere Funktionen, die Iterables zurückgeben und Iterables als
Argument aufnehmen.


.. _tut-break:

:keyword:`break`- und :keyword:`continue`-Anweisungen und der :keyword:`else`-Zweig bei Schleifen
================================================================================================

Die :keyword:`break`-Anweisung springt, wie in C, aus der nächsten umgebenden
:keyword:`for`- oder :keyword:`while`-Schleife.

Die :keyword:`continue`-Anweisung, ebenso von C geliehen, springt in die nächste
Iteration der Schleife.

Schleifen-Anweisungen können einen :keyword:`else`-Zweig haben. Dieser wird
ausgeführt, wenn Sequenz erschöpft (mit :keyword:`for`) oder wenn die Bedingung
unwahr wird (mit :keyword:`while`), nicht jedoch, wenn die Schleife durch eine
:keyword:`break`-Anweisung abgebrochen wird. Dies von folgender Schleife, die
Primzahlen sucht, veranschaulicht::

    >>> for n in range(2, 10):
    ...     for x in range(2, n):
    ...         if n % x == 0:
    ...             print(n, 'equals', x, '*', n//x)
    ...             break
    ...     else:
    ...         # Schleife wurde durchlaufen, ohne dass ein Faktor gefunden wurde
    ...         print(n, 'is a prime number')
    ...
    2 is a prime number
    3 is a prime number
    4 equals 2 * 2
    5 is a prime number
    6 equals 2 * 3
    7 is a prime number
    8 equals 2 * 4
    9 equals 3 * 3

.. _tut-pass:

:keyword:`pass`-Anweisungen
===========================

Die :keyword:`pass`-Anweisung tut nichts. Sie kann benutzt werden wenn
syntaktisch eine Anweisung benötigt wir, das Programm jedoch keine Tätigkeit
benötigt. Zum Beispiel::

    >>> while True:
    ...     pass  # geschäftiges Warten auf den Tastatur Interrupt (:kbd:`Strg+C`)
    ...

Das wird üblicherweise benutzt um minimale Klassen zu erzeugen::

   >>> class MyEmptyClass:
   ...     pass
   ...

Eine andere Stelle an der :keyword:`pass` benutzt werden kann, ist als Platzhalter für eine Funktion oder einen Zweigkörper wenn man an neuem Code arbeitet, und einem so erlaubt auf einer abstrakteren Ebene zu denken.
Das :keyword:`pass` wird still ignoriert::

   >>> def initlog(*args):
   ...     pass   # Nicht vergessen das zu implementieren!
   ...

.. _tut-functions:

Funktionen definieren
=====================

Wir können eine Funktion erstellen, die die Fibonacci-Folge bis zu einer
beliebigen Grenze ausgibt::

    >>> def fib(n):    # die Fibonacci-Folge bis zu n ausgeben
    ...     """Print the Fibonacci series up to n."""
    ...     a, b = 0, 1
    ...     while b < n:
    ...         print(b, end=' ')
    ...         a, b = b, a+b
    ...     print()
    ...
    >>> # Jetzt rufen wir die Funktion auf, die wir gerade definiert haben:
    ... fib(2000)
    1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597

.. index::
   single: documentation strings
   single: docstrings
   single: strings, documentation

Das Schlüsselwort :keyword:`def` leitet die *Definition* einer Funktion ein.
Danach muss der Funktionsname und parameterisierte Liste der formalen Parameter
folgen. Die Anweisungen, die den Funktionskörper darstellen, beginnen in der
nächsten Zeile und müssen eingerückt sein.

Die erste Anweisung des Funktionskörpers kann auch wahlweise ein Stringliteral
sein; dieser Stringliteral ist der Dokumentationsstring der Funktion, auch
:dfn:`docstring` genannt. (Mehr zu docstrings kann im Abschnitt
:ref`tut-docstrings` nachgelesen werden.) Es gibt Werkzeuge, die docstrings
benutzen, um automatisch online oder gedruckte Dokumentation zu erzeugen
beziehungsweise es dem Nutzer erlauben interaktiv den Code zu durchsuchen; es
ist good practice docstrings in den Code, den man schreibt, einzubauen, also
sollte man es sich angewöhnen.

Die *Ausführung* einer Funktion führt eine neue Symboltabelle ein, die für
lokale Variablen der Funktion benutzt wird. Genauer: alle Zuweisungen an eine
Variable innerhalb der Funktion legen den Wert in der lokalen Symboltabelle ab;
wohingegen Referenzen auf eine Variable zuerst in der lokalen Symboltabelle
nachgeschaut werde, dann in den den lokalen Symboltabellen der umgebenden
Funktionen, dann in der globalen Symboltabelle und schliesslich in der
Symboltabelle der eingebauten Namen. Deshalb können globalen Variablen nicht
direkt Werte innerhalb einer Funktion zugewiesen werden (es sei denn sie werden
in einer :keyword:`global`-Anweisung erwähnt), jedoch referenziert werden
können.

Die eigentlichen Parameter (Argumente), die einem Funktionsaufruf übergeben
werden beim Funktionsaufruf in die Symboltabelle der aufgerufenen Funktion
eingeführt. Dass heisst, Argumente werden über *call by value* übergeben (wobei
der *Wert* allerdings immer eine *Referenz* auf ein Objekt ist, nicht der Wert
des Objektes) [#]_. Wenn eine Funktion eine andere Funktion aufruft, wird eine
neue lokale Symboltabelle für diesen Aufruf generiert.


Eine Funktionsdefinition führt den Funktionsnamen in die lokale Symboltabelle
ein. Der Wert des Funktionsnamens wird vom Interpreter als eine
benutzerdefinierte Funktion erkannt. Dieser Wert kann einem anderen Namen
zugewiesen werden, der dann ebenfalls als Funktion genutzt werden kann. Dies
dient als ein genereller Umbenennungsmechanismus::

    >>> fib
    <function fib at 10042ed0>
    >>> f = fib
    >>> f(100)
    1 1 2 3 5 8 13 21 34 55 89

Wenn du von einer anderen Sprache kommst, könntest du einwenden, dass ``fib``
gar keine Funktion, sondern eine Prozedur ist, da sie keinen Wert zurückgibt.
Tatsächlich geben auch Funktionen ohne eine :keyword:`return`-Anweisung einen
Wert zurück, wenn auch einen eher langweiligen. Dieser Wert wird ``None``
genannt (es ist ein eingebauter Name). Die Ausgabe des Wertes ``None`` wird
normalerweise vom Interpreter unterdrückt, wenn es der einzige Wert wäre, der
ausgegeben wird. Wenn du ihn wirklich sehen willst, kannst du :func:`print`
benutzen::

    >>> fib(0)
    >>> print(fib(0))
    None

Es ist einfach eine Funktion zu schreiben, die eine Liste der Nummern
zurückgibt, anstatt sie auszugeben::

    >>> def fib2(n): # gib die Fibonacci-Folge bis zu n zurück
    ...     """Return a list containing the Fibonacci series up to n."""
    ...     result = []
    ...     a, b = 0, 1
    ...     while b < n:
    ...         result.append(b)    # siehe unten
    ...         a, b = b, a+b
    ...     return result
    ...
    >>> f100 = fib2(100)    # ruf es auf
    >>> f100                # gib das Ergebnis aus
    [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

Dieses Beispiel demonstriert, wie gewönlich, ein paar neue Eigenschaften von
Python:

*   Die :keyword:`return`-Anweisung gibt einen Wert von einer Funktion
    zurück. Ohne einen Ausdruck als Argument gibt :keyword:`return` ``None``
    zurück. Wenn man vom Ende der Funktion herunterfällt, wird ebenso ``None``
    zurückgegeben

*   Die Anweisung ``result.append(b)`` ruft eine *Methode* des Listenobjektes
    ``result`` auf. Eine Methode ist eine Funktion, die zu einem Objekt 'gehört'
    und wird ``obj.methodname`` bennant, wobei ``obj`` irgendein Objekt ist (das
    kann auch ein Ausdruck sein) und ``methodname`` der Name einer Methode ist,
    die vom Typ des Objektes definiert wird. Unterschiedliche Typen definieren
    verschiedene Methoden. Methoden verschiedener Typen können denselben Namen
    haben ohne doppeldeutig zu sein. (Es ist möglich eigene Objekttypen zu
    erstellen, indem man *Klassen* benutzt, siehe :ref:`tut-classes`.) Die
    Methode :meth:`append`, die im Beispiel gezeigt wird, ist für Listenobjekte
    definiert. Sie hängt ein neues Element an das Ende der Liste an. Im Beispiel
    ist es äquivalent zu ``result = result + [b]``, aber viel effizienter.

.. rubric:: Fußnoten
    
.. [#] Eigentlich wäre *call by object reference* eine bessere Beschreibung,
   denn wird ein veränderbares Objekt übergeben, sieht der Aufrufende jegliche
   Veränderungen, die der Aufgerufene am Objekt vornimmt (beispielsweise
   Elemente in eine Liste einfügt)