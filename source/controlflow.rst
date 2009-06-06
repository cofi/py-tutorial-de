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
arithmetische Abfolge von Nummern (wie in Pascal) zu iterieren, oder dem Benutzer die
Möglichkeit zu geben, sowohl Schrittweite als auch Abbruchbedingung zu
definieren (wie in C), iteriert Pythons :keyword:`for`-Anweisung über die
Elemente einer Sequenz (eine Liste oder ein String), in der Reihenfolge, wie sie
in der Sequenz auftauchen. Zum Beispiel:

::

    >>> # Ein paar Strings messen:
    ... a = ['Katze', 'Fenster', 'rauswerfen']
    >>> for x in a:
    ...     print(x, len(x))
    ...
    Katze 5
    Fenster 7
    rauswerfen 10

Es ist nicht ungefährlich, die Sequenz zu verändern, über die gerade in der
Schleife iteriert wird (was nur im Falle von veränderbaren Sequenztypen, wie bei
Listen, passieren kann). Wenn man die Liste verändern will, über die man
iteriert (zum Beispiel, um ausgewählte Elemente zu duplizieren), muss man über
eine Kopie iterieren. Die Slice-Notation macht dies sehr einfach::

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
ist auch möglich, den Bereich bei einer anderen Nummer zu beginnen,
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

Etwas Seltsames passiert, wenn man einfach ein `range`-Objekt ausgeben will::

    >>> print(range(10))
    range(0, 10)

In vielen Fällen verhält sich das von :func:`range` zurückgegebene Objekt, als
wäre es eine Liste, ist es aber in den meisten Fällen nicht. Es ist ein Objekt,
das aufeinander folgende Elemente der gewünschten Abfolge zurückgibt, wenn man
darüber iteriert, aber es erzeugt diese Liste nicht wirklich, einfach um Platz zu
sparen.

Wir nennen solch ein Objekt *Iterable*, das heißt, es ist geeignet als Ziel
einer Funktion oder sonstigen Konstruktes, die etwas erwarten, von dem man
sukzessive Elemente erhält bis der Vorrat ausgeschöpft ist. Wir haben gesehen,
dass die :keyword:`for`-Anweisung ein solcher *Iterator* ist. Die
Funktion:func:`list` ist ein anderer; sie erstellt Listen aus Iterables::

    >>> list(range(5))
    [0, 1, 2, 3, 4]

Später sehen wir weitere Funktionen, die Iterables zurückgeben und Iterables als
Argument aufnehmen.


.. _tut-break:

:keyword:`break`- und :keyword:`continue`-Anweisungen und der :keyword:`else`-Zweig bei Schleifen
================================================================================================

Die :keyword:`break`-Anweisung bricht, wie in C, aus der sie umgebenden
:keyword:`for`- oder :keyword:`while`-Schleife aus und beendet sie.

Die :keyword:`continue`-Anweisung, ebenso von C geliehen, beginnt die nächste
Iteration der Schleife.

Schleifen-Anweisungen können einen :keyword:`else`-Zweig haben. Dieser wird
ausgeführt, wenn Sequenz erschöpft (mit :keyword:`for`) oder wenn die Bedingung
unwahr wird (mit :keyword:`while`), nicht jedoch, wenn die Schleife durch eine
:keyword:`break`-Anweisung abgebrochen wird. Dies wird von folgender Schleife, die
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

Die :keyword:`pass`-Anweisung tut nichts. Sie kann benutzt werden, wenn
syntaktisch eine Anweisung benötigt wird, das Programm jedoch nichts tun
soll. Zum Beispiel::

    >>> while True:
    ...     pass  # geschäftiges Warten auf den Tastatur Interrupt (:kbd:`Strg+C`)
    ...

So etwas wird üblicherweise benutzt, um minimale Klassen zu erzeugen::

   >>> class MyEmptyClass:
   ...     pass
   ...

Eine andere Stelle, an der :keyword:`pass` benutzt werden kann, ist als Platzhalter für eine Funktion oder einen Zweigkörper, wenn man an neuem Code arbeitet, und einem so erlaubt auf einer abstrakteren Ebene zu denken.
Das :keyword:`pass` wird einfach ignoriert::

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

Die erste Anweisung des Funktionskörpers kann auch wahlweise ein String-Literal
sein; dieses String-Literal ist der Dokumentationsstring der Funktion, auch
:dfn:`docstring` genannt. (Mehr zu docstrings kann im Abschnitt
:ref`tut-docstrings` nachgelesen werden.) Es gibt Werkzeuge, die docstrings
benutzen, um automatisch Online-Dokumentation oder gedruckte Dokumentation zu erzeugen
beziehungsweise es dem Nutzer erlauben, interaktiv den Code zu durchsuchen; es
ist bewährte Praxis, docstrings in den Code, den man schreibt, einzubauen, also
sollte man es sich angewöhnen.

Die *Ausführung* einer Funktion führt eine neue Symboltabelle ein, die für
lokale Variablen der Funktion benutzt wird. Genauer: alle Zuweisungen an eine
Variable innerhalb der Funktion legen den Wert in der lokalen Symboltabelle ab;
wohingegen Referenzen auf eine Variable zuerst in der lokalen Symboltabelle
nachgeschaut werden, dann in den den lokalen Symboltabellen der umgebenden
Funktionen, dann in der globalen Symboltabelle und schließlich in der
Symboltabelle der eingebauten Namen. Deshalb können globalen Variablen nicht
direkt Werte innerhalb einer Funktion zugewiesen werden (es sei denn sie werden
in einer :keyword:`global`-Anweisung erwähnt), jedoch kann man ihre Werte
lesen.

Die konkreten Parameter (Argumente), die einem Funktionsaufruf übergeben werden,
werden beim Funktionsaufruf in die Symboltabelle der aufgerufenen Funktion
eingeführt. Das heißt, Argumente werden über *call by value* übergeben (wobei
der *Wert* allerdings immer eine *Referenz* auf ein Objekt ist, nicht der Wert
des Objektes) [#]_. Wenn eine Funktion eine andere Funktion aufruft, wird eine
neue lokale Symboltabelle für diesen Aufruf generiert.


Eine Funktionsdefinition fügt den Funktionsnamen in die lokale Symboltabelle
ein. Der Wert des Funktionsnamens hat einen Typ, der vom Interpreter als eine
benutzerdefinierte Funktion erkannt wird. Dieser Wert kann einem anderen Namen
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

Es ist einfach, eine Funktion zu schreiben, die eine Liste der Nummern
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

Dieses Beispiel demonstriert, wie gewöhnlich, ein paar neue Eigenschaften von
Python:

*   Die :keyword:`return`-Anweisung gibt einen Wert von einer Funktion
    zurück. Ohne einen Ausdruck als Argument gibt :keyword:`return` ``None``
    zurück. Wenn eine Funktion kein :keyword:`return` hat, wird ebenso ``None``
    zurückgegeben.

*   Die Anweisung ``result.append(b)`` ruft eine *Methode* des Listenobjektes in
    ``result`` auf. Eine Methode ist eine Funktion, die zu einem Objekt 'gehört'
    und wird ``obj.methodname`` bennant, wobei ``obj`` irgendein Objekt ist (das
    kann auch ein Ausdruck sein) und ``methodname`` der Name einer Methode ist,
    die vom Typ des Objektes definiert wird. Unterschiedliche Typen definieren
    verschiedene Methoden. Methoden verschiedener Typen können denselben Namen
    haben ohne doppeldeutig zu sein. (Es ist möglich, eigene Objekttypen zu
    erstellen, indem man *Klassen* benutzt, siehe :ref:`tut-classes`.) Die
    Methode :meth:`append`, die im Beispiel gezeigt wird, ist für Listenobjekte
    definiert. Sie hängt ein neues Element an das Ende der Liste an. Im Beispiel
    ist es äquivalent zu ``result = result + [b]``, aber viel effizienter.

Mehr zum Definieren von Funktion
================================

Es ist auch möglich Funktionen mit einer variablen Anzahl von Argumenten zu
definieren. Es gibt dabei drei Varianten, die auch kombiniert werden können.


.. _tut-defaultargs:

Standardwerte für Argumente
---------------------------

Die nützlichste Variante ist, einen Standardwert für ein oder mehrere Argumente
anzugeben. Das erzeugt eine Funktion, die mit weniger Argumenten aufgerufen
werden kann, als sie definitionsgemäß erlaubt. Zum Beispiel::

    def ask_ok(prompt, retries=4, complaint='Bitte Ja oder Nein!'):
       while True:
           ok = input(prompt)
           if ok in ('j', 'J', 'ja', 'Ja'): return True
           if ok in ('n', N', 'ne', 'Ne', 'Nein'): return False
           retries = retries - 1
           if retries < 0:
               raise IOError('Benutzer abgelehnt!')
           print(complaint)

.. FIXME: Patch pending, will be translated when accepted/refused

Das Beispiel führt auch noch das Schlüsselwort :keyword:`in` ein. Dieses
überprüft ob ein gegebener Wert in einer Sequenz gegeben ist.

Die Standardwerte werden zum Zeitpunkt der Funktionsdefinition im *definierenden* Gültigkeitsbereich ausgewertet, so dass::

    i = 5

    def f(arg=i):
       print(arg)

    i = 6
    f()

``5`` ausgeben wird.

**Wichtige Warnung**: Der Standardwert wird nur *einmal* ausgewertet. Das macht
einen Unterschied, wenn der Standardwert veränderbares Objekt, wie
beispielsweise eine Liste, ein Dictionary oder Instanzen der meisten Klassen,
ist. Zum Beispiel häuft die folgende Funktion alle Argumente an, die ihr in
aufeinanderfolgenden Aufrufen übergeben wurden::

    def f(a, L=[]):
       L.append(a)
       return L

    print(f(1))
    print(f(2))
    print(f(3))

Und sie gibt folgendes aus::

    [1]
    [1, 2]
    [1, 2, 3]

Wenn man nicht will, dass der Standardwert von aufeinanderfolgenden Aufrufen
gemeinsam benutzt wird, kann man die Funktion folgendermaßen umschreiben::

    def f(a, L=None):
        if L is None:
            L = []
        L.append(a)
        return L


.. _tut-keywordargs:

Schlüsselwortargumente
----------------------

Funktionen können auch mit Schlüsselwortargumenten in der Form ``Schlüsselwort =
Wert`` aufgeruden werden. Zum Beispiel könnte folgende Funktion::

    def parrot(voltage, state='steif',
        action='fliegen', type='norwegische Blauling'):
        print("-- Der Vogel würde selbst dann nicht", action, end=' ')
        print("selbst wenn Sie ihm ", voltage, "Volt durch den Schnabel jagen täten")
        print("-- Ganz erstaunlicher Vogel, der", type, "! Wunderhübsche Federn!")
        print("-- Er is völlig", state, "!")

in allen folgenden Variationen aufgerufen werden::

    parrot(4000)
    parrot(action = 'VOOOOOM', voltage = 1000000)
    parrot('Viertausend', state = 'an den Gänseblümchen riechen')
    parrot('eine Million', 'keine Spur leben', 'springen')

die folgenden Aufrufe wären allerdings alle ungültig::

    parrot()                     # das benötigte Argument fehlt
    parrot(voltage=5.0, 'tot')   # auf ein Schlüsselwortargument folgt ein normales
    parrot(110, voltage=220)     # doppelter Wert für ein Argument
    parrot(actor='John Cleese')  # unbekanntes Schlüsselwort

Üblicherweise kommen zuerst positionsabhängige Argumente und danach
Schlüsselwortargumente - von beiden ist eine beliebige Anzahl zulässig. Die
Schlüsselworte müssen jedoch in der Funktionsdefinition enthalten sein, das
heisst der Funktion bekannt sein. Es ist unwichtig, ob sie einen Standardwert
haben oder nicht. Kein Parameter darf mehr als einen Wert bekommen ---
positionsabhängige Argumente können nicht als Schlüsselworte im selben Aufruf
benutzt werden. Hier ein Beispiel, das wegen dieser Einschränkung scheitert::

    >>> def function(a):
    ...     pass
    ...
    >>> function(0, a=0)
    Traceback (most recent call last):
     File "<stdin>", line 1, in ?
    TypeError: function() got multiple values for keyword argument 'a'

Ist ein Parameter der Form ``**name`` in der Definition enthalten, bekommt
dieser ein Dictionary (siehe :ref:`typesmapping`) das alle
Schlüsselwortargumente enthält, bis auf die, die in der Definition vorkommen.
Dies kann mit einem Parameter der Form ``*name``, der im nächsten Unterabschnitt
beschrieben wird, kombiniert werden. Dieser bekommt ein Tupel, das alle
positionsabhängigen Argumente enthält, die über die Anzahl der definierten
hinausgehe. (``*name`` muss aber vor ``**name`` kommen.) Wenn wir zum Beispiel
eine Funktion wie diese definieren::

    def cheeseshop(kind, *arguments, **keywords):
        print("-- Haben sie", kind, "?")
        print("-- Tut mir leid,", kind, "ist leider gerade aus.")
        for arg in arguments: print(arg)
        print("-" * 40)
        keys = sorted(keywords.keys())
        for kw in keys: print(kw, ":", keywords[kw])

könnte sie so aufgerufen werden::

    cheeseshop("Limburger", "Der ist sehr flüssig, mein Herr.",
              "Der ist wirklich sehr, SEHR flüssig, mein Herr.",
              shopkeeper="Michael Palin",
              client="John Cleese",
              sketch="Cheese Shop Sketch")

und natürlich würde sie folgendes ausgeben::
    
    -- Haben sie Limburger ?
    -- Tut mir leid, Limburger ist leider gerade aus.
    Der ist sehr flüssig, mein Herr.
    Der ist wirklich sehr, SEHR flüssig, mein Herr.
    ----------------------------------------
    client : John Cleese
    shopkeeper : Michael Palin
    sketch : Cheese Shop Sketch

Man beachte, dass die Liste der Schlüsselwortargumente erzeugt wird, indem das
Ergebnis der Methode :meth:`keys` sortiert wird, bevor dessen Inhalt ausgegeben
wird. Tut man das nicht, ist die Reihenfolge der Ausgabe undefiniert.

.. _tut-arbitraryargs;

Beliebig lange Argumentlisten
-----------------------------

.. index::
   statement: *

Zuletzt noch die am wenigsten gebräuchliche Möglichkeit ist, festzulegen, dass
eine Funktion mit einer beliebigen Zahl von Argumenten aufgerufen werden kann,
die dann in ein Tupel (siehe :ref:`tut-tuples`) verpackt werden. Bevor diesem
speziellen Argument, kann eine beliebige Menge normaler Argumente vorkommen. ::

    def write_multiple_items(file, separator, *args):
        file.write(separator.join(args))

Normalerweise wird dieses spezielle Argument an das Ende der Argumentliste
gesetzt, weil es alle verbleibenden Argumente, mit denen die Funktion
aufgerufen wird, aufnimmt. Alle Argumente, die in der Definition auf ein
``*args`` folgen, sind nur durch Schlüsselwortargumente zu übergeben
(*'keyword-only'*) und nicht durch positionsabhängige. ::

    >>> def concat(*args, sep="/"):
    ...    return sep.join(args)
    ...
    >>> concat("Erde", "Mars", "Venus")
    'Erde/Mars/Venus'
    >>> concat("Erde", "Mars", "Venus", sep=".")
    'Erde.Mars.Venus'

.. rubric:: Fußnoten

.. [#] Eigentlich wäre *call by object reference* eine bessere Beschreibung,
denn wird ein veränderbares Objekt übergeben, sieht der Aufrufende jegliche
Veränderungen, die der Aufgerufene am Objekt vornimmt (beispielsweise
Elemente in eine Liste einfügt)
