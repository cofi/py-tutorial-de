.. _tut-structures:

***************
Datenstrukturen
***************

Dieses Kapitel beschreibt Dinge, die du schon kennengelernt hast, detaillierter
und geht auch auf ein paar neue Dinge ein.

.. _tut-morelists:

Mehr zu Listen
==============

Der Datentyp ``list`` hat noch ein paar andere Methoden. Hier sind alle Methoden
von Listenobjekten:


.. method:: list.append(x)
   :noindex:

   Hängt ein neues Element an das Ende der Liste an; äquivalent zu ``a[len(a):]
   = [x]``.


.. method:: list.extend(L)
   :noindex:

   Erweitert die Liste, indem es alle Elemente der gegebenen Liste anhängt;
   äquivalent zu ``a[len(a):] = L``.


.. method:: list.insert(i, x)
   :noindex:

   Fügt ein Element an der gegebenen Position ein. Das erste Argument ist der
   Index des Elements, vor dem eingefügt werden soll, so fügt ``a.insert(0, x)``
   am Anfang der Liste ein und ``a.insert(len(a), x)`` ist äquivalent zu
   ``a.append(x)``.


.. method:: list.remove(x)
   :noindex:

   Entfernt das erste Element, dessen Wert *x* ist. Es gibt eine Fehlermeldung,
   wenn solch ein Element nicht existiert.


.. method:: list.pop([i])
   :noindex:

   Entfernt das Element an der gegebenen Position und gibt es zurück. Ist kein
   Index gegeben, entfernt ``a.pop()``das letzte Element der Liste und gibt es
   zurück. (Die eckigen Klammern um das *i* in der Methodensignatur herum,
   zeigen an, dass das Argument optional ist und nicht, dass man dort eckige
   Klammern eintippen sollte. Du wirst diese Notation des öfteren in der
   Referenz der Pythonbibliothek sehen.


.. method:: list.index(x)
   :noindex:

   Gibt den Index des ersten Elements in der Liste zurück, dessen Wert *x* ist.
   Es gibt eine Fehlermeldung, wenn solch ein Element nicht existiert.


.. method:: list.count(x)
   :noindex:

   Gibt zurück, wie oft *x* in der Liste vorkommt.


.. method:: list.sort()
   :noindex:

   Sortiert die Elemente der Liste, im selben Exemplar (*in place*).


.. method:: list.reverse()
   :noindex:

   Kehrt die Reihenfolge der Listenelemente um, im selben Exemplar (*in place*).

Ein Beispiel, das die meisten Methoden von Listen benutzt::

    >>> a = [66.25, 333, 333, 1, 1234.5]
    >>> print(a.count(333), a.count(66.25), a.count('x'))
    2 1 0
    >>> a.insert(2, -1)
    >>> a.append(333)
    >>> a
    [66.25, 333, -1, 333, 1, 1234.5, 333]
    >>> a.index(333)
    1
    >>> a.remove(333)
    >>> a
    [66.25, -1, 333, 1, 1234.5, 333]
    >>> a.reverse()
    >>> a
    [333, 1234.5, 1, 333, -1, 66.25]
    >>> a.sort()
    >>> a
    [-1, 1, 66.25, 333, 333, 1234.5]

.. _tut-lists-as-stacks:

Benutzung von Listen als Stack
-----------------------------

Die Methoden von Listen, machen es sehr einfach eine Liste als Stack zu
benutzen, wo das zuletzt hinzugekommene als Erstes abgerufen wird ("last-in,
first-out"). Um ein Element auf den Stack zu legen, benutzt man :meth:`append`.
Um ein Element abzurufen, benutzt man :meth:`pop` ohne expliziten Index. Zum
Beispiel::

    >>> stack = [3, 4, 5]
    >>> stack.append(6)
    >>> stack.append(7)
    >>> stack
    [3, 4, 5, 6, 7]
    >>> stack.pop()
    7
    >>> stack
    [3, 4, 5, 6]
    >>> stack.pop()
    6
    >>> stack.pop()
    5
    >>> stack
    [3, 4]


.. _tut-lists-as-queues:

Benutzung von Listen als Queue
------------------------------

Listen lassen sich auch bequem als Schlage (*Queue*) benutzen, wo das als Erste
hinzugekommene Element auch zuerst abgerufen wird ("firs-in, first-out"). Um ein
Element anzuhängen, benutzt man :meth:`append`. Um ein Element vom Anfang der
Schlange abzurufen, benutzt man :meth:`pop` mit dem Index ``0``. Zum Beispiel::

    >>> queue = ["Eric", "John", "Michael"]
    >>> queue.append("Terry")           # Terry kommt an
    >>> queue.append("Graham")          # Graham kommt an
    >>> queue.pop(0)
    'Eric'
    >>> queue.pop(0)
    'John'
    >>> queue
    ['Michael', 'Terry', 'Graham']


List Comprehensions
-------------------

List Comprehensions bieten einen prägnanten Weg Listen aus Sequenzen zu
erzeugen. Übliche Anwendungen sind solche, in denen man Listen erstellt, in
denen jedes Element das Ergebnis eines Verfahrens ist, das auf jedes Mitglied
einer Sequenz angewendet wird oder solche, in denen eine Teilfolge von
Elementen, die eine bestimmte Bedingung erfüllen, erstellt wird.

Jede List Comprehension besteht aus eckigen Klammern, die einen Ausdruck gefolgt
von einer :keyword:`for`-Klausel, enthalten. Danach sind beliebig viele
:keyword:`for`- oder :keyword:`if`-Klauseln zulässig. Das Ergebnis ist eine
Liste, deren Elemente durch das Auswerten des Ausdrucks im Kontext der
:keyword:`for`- und :keyword:`if`-Klauseln, die darauf folgen, erzeugt werden.
Würde der Ausdruck ein Tupel ergeben, muss er in Klammern stehen.

Hier nehmen wir eine Liste von Nummern und erzeugen eine, die das Dreifache
jeder Nummer enthält::

    >>> vec = [2, 4, 6]
    >>> [3*x for x in vec]
    [6, 12, 18]

Jetzt wird's ein wenig ausgefallener::

    >>> [[x, x**2] for x in vec]
    [[2, 4], [4, 16], [6, 36]]

Hier wenden wir einen Methodenaufruf auf jedes Objekt in der Sequenz an::


    >>> freshfruit = ['  banana', '  loganberry ', 'passion fruit  ']
    >>> [weapon.strip() for weapon in freshfruit]
    ['banana', 'loganberry', 'passion fruit']

Indem wir eine :keyword:`if`-Klausel anwenden können wir die Elemente filtern::

   >>> [3*x for x in vec if x > 3]
   [12, 18]
   >>> [3*x for x in vec if x < 2]
   []

Tupel können oft ohne ihre Klammern erstellt werden, bei List Comprehensions
jedoch nicht::

   >>> [x, x**2 for x in vec]  # Fehler - Klammern für das Tupel benötigt
     File "<stdin>", line 1, in ?
       [x, x**2 for x in vec]
                  ^
   SyntaxError: invalid syntax
   >>> [(x, x**2) for x in vec]
   [(2, 4), (4, 16), (6, 36)]

Hier sind ein paar verschachtelte :keyword:`for`-Schleifen und anderes
ausgefallenes Verhalten::

   >>> vec1 = [2, 4, 6]
   >>> vec2 = [4, 3, -9]
   >>> [x*y for x in vec1 for y in vec2]
   [8, 6, -18, 16, 12, -36, 24, 18, -54]
   >>> [x+y for x in vec1 for y in vec2]
   [6, 5, -7, 8, 7, -5, 10, 9, -3]
   >>> [vec1[i]*vec2[i] for i in range(len(vec1))]
   [8, 12, -54]

List Comprehensions können auf auf komplexe Ausdrücke und verschachtelte
Funktionen angewendet werden::

   >>> [str(round(355/113, i)) for i in range(1, 6)]
   ['3.1', '3.14', '3.142', '3.1416', '3.14159']

Verschachtelte List Comprehensions
----------------------------------

Man kann List Comprehensions auch verschachteln, sofern man sich das traut. Sie
sind ein mächtiges Werkzeug, aber, wie alle mächtigen Werkzeuge, sollten sie,
wenn überhaupt, mit Bedacht benutzt werden.

Denk mal über das folgende Beispiel einer 3x3-Matrix nach, die über eine Liste
von 3 Listen realisiert wird, wobei eine Liste eine Zeile darstellt::

    >>> mat = [
    ...        [1, 2, 3],
    ...        [4, 5, 6],
    ...        [7, 8, 9],
    ...       ]

Wenn man jetzt die Zeilen und Spalten vertauschen wollte, könnte man eine List
Comprehension benutzen::

    >>> print([[row[i] for row in mat] for i in [0, 1, 2]])
    [[1, 4, 7], [2, 5, 8], [3, 6, 9]]


Bei *verschachtelten* List Comprehension muss man besonders sorgfältig vorgehen:

    Damit du dich nicht beim verschachteln von List Comprehensions verzettelst,
    lese sie von rechts nach links.

Eine ausführlichere Version dieses Schnipsels zeigt den Ablauf deutlich::

    for i in [0, 1, 2]:
        for row in mat:
            print(row[i], end="")
        print()

Im echten Leben sollte man aber eingebaute Funktionen komplexen Anweisungen
vorziehen. Die Funktion :func:`zip` würde in diesem Fall gute Dienste leisten::

    >>> list(zip(*mat))
    [(1, 4, 7), (2, 5, 8), (3, 6, 9)]

Für eine genaue Beschreibung für was das Sternchen ist, siehe
:ref:`tut-unpacking-arguments`.

Die :keyword:`del`-Anweisung
============================

Es gibt einen Weg ein Listenelement durch seinen Index, statt durch seinen Wert
zu löschen: Die :keyword:`del`-Anweisung. Sie unterscheidet sich von der
:meth:`pop`-Methode, da sie keinen Wert zurückgibt. Die :keyword:`del`-Anweisung
kann auch dazu benutzt werden Abschnitte einer Liste zu löschen oder sie ganz zu
leeren (was wir vorhin durch die Zuweisung einer leeren Liste an einen Abschnitt
getan haben). Zum Beispiel::

    >>> a = [-1, 1, 66.25, 333, 333, 1234.5]
    >>> del a[0]
    >>> a
    [1, 66.25, 333, 333, 1234.5]
    >>> del a[2:4]
    >>> a
    [1, 66.25, 1234.5]
    >>> del a[:]
    >>> a
    []

:keyword:`del` kann auch dazu benutzt werden ganze Variablen zu löschen::

   >>> del a

Danach den Namen ``a`` zu referenzieren führt zu einer Fehlermeldung (zumindest
bis dem Namen ein anderer Wert zugewiesen wird). Später werden werden wir noch
andere Einsatzmöglichkeiten besprechen.


.. _tut-tuples:

Tupel und Sequenzen
===================

Wir haben gesehen, dass Listen und Zeichenketten viele Eigenschaften, wie
Slicing und Indizierung, gemein haben. Beide sind Exemplare von
*Sequenzdatentypen* (siehe :ref:`typesseq`). Da sich Python weiterentwickelt
können auch noch andere Sequenzdatentypen hinzukommen. Es gibt aber noch einen
weiteren standardmäßigen Sequenzdatentyp: Das Tupel.

Ein Tupel besteht aus mehreren Werten, die durch Kommas von einander getrennt
sind, beispielsweise::


    >>> t = 12345, 54321, 'Hallo!'
    >>> t[0]
    12345
    >>> t
    (12345, 54321, 'Hallo!')
    >>> # Tupel können verschachtelt werden:
    ... u = t, (1, 2, 3, 4, 5)
    >>> u
    ((12345, 54321, 'Hallo!'), (1, 2, 3, 4, 5))

Wie man sehen kann, werden die ausgegebenen Tupel immer von Klammern umgeben,
sodass verschachtelte Tupel richtig interpretiert werden. Sie können mit oder
ohne Klammern eingegeben werden, obwohl Klammern trotzdem sehr oft benötigt
werden (wenn das Tupel Teil eines größeren Ausdrucks ist).

Tupel lassen sich vielfach einsetzen, beispielsweise (x, y)-Koordinatenpaare,
Unterlagen über die Angestellten von der Datenbank, usw.  Wie Strings sind auch
Tupel unveränderbar: Es ist nicht möglich einzelnen Elementen eines Tupels einen
Wert zuzuweisen (das Verhalten kann man jedoch mit Slicing und Verkettung
simulieren). Es ist auch möglich Tupel, die veränderbare Objekte wie Listen
enthalten, zu erstellen.

Ein spezielles Problem ergibt sich in der Darstellung von Tupeln, die 0 oder 1
Elemente haben: Die Syntax hat ein paar Eigenheiten um das Problem zu lösen.
Leere Tupel lassen sich mit einem leeren Klammerpaar darstellen und ein Tupel
mit einem Element wird erstellt, indem dem Wert ein Komma nachgestellt wird, es
reicht jedoch nicht, das Element nur in Klammern zu schreiben. Hässlich aber
effektiv. Zum Beispiel::


    >>> empty = ()
    >>> singleton = 'Hallo',    # <-- das angehängte Komma nicht vergessen
    >>> len(empty)
    0
    >>> len(singleton)
    1
    >>> singleton
    ('Hallo',)

Die Anweisung ``t = 12345, 54321, 'Hallo!'`` ist ein Beispiel für das *Tupel
packen* (*tuple packing*): Die Werte ``12345``, ``54321``, ``'Hallo!'`` werden
zusammen in ein Tupel gepackt. Das Gegenteil ist ebenso möglich::

   >>> x, y, z = t

Das wird passenderweise *Sequenz auspacken* (*sequence unpacking*) genannt und
funktioniert mit jeder Sequenz auf der rechten Seite der Zuweisung. Die Anzahl
der Namen auf der linken Seite muss genauso groß sein, wie die Länge der
Sequenz. Eine Mehrfachzuweisung ist eigentlich nur eine Kombination von Tupel
packen und und dem Auspacken der Sequenz.


.. _tut-sets:

Mengen
======

Python enthält auch einen Datentyp für Mengen (*sets*). Eine Menge ist eine
ungeordnete Sammlung ohne doppelte Elemente. Sie werden vor allem dazu benutzt,
um zu testen, ob ein Element in der Menge vertreten ist und doppelte Einträge zu
beseitigen. Mengenobjekte unterstützen ebenfalls mathematische Operationen wie
Vereinigungsmenge, Schnittmenge, Differenz und symmetrische Differenz.

Geschweifte Klammern oder die Funktion :func:`set` können dazu genutzt werden
Mengen zu erzeugen. Wichtig: Um eine leere Menge zu erzeugen muss man ``set()``
benutzen, ``{}`` ist dagegen nicht möglich. Letzteres erzeugt ein leeres
Dictionary, eine Datenstruktur die wir im nächsten Abschnitt besprechen.

Hier eine kurze Demonstration::

   >>> basket = {'Apfel', 'Orange', 'Apfel', 'Birne', 'Orange', 'Banane'}
   >>> print(basket)
   {'Orange', 'Banane', 'Birne', 'Apfel'}
   >>> fruit = ['Apfel', 'Orange', 'Apfel', 'Birne', 'Orange', 'Banane']
   >>> fruit = set(basket)               # eine Menge ohne Dublikate erstellen
   >>> fruit
   {'Orange', 'Birne', 'Apfel', 'Banane'}
   >>> fruit = {'Orange', 'Apfel'}       # {}-Syntax analog der [] von Listen
   >>> fruit
   {'Orange', 'Apfel'}
   >>> 'Orange' in fruit                 # schnelles Testen auf Mitgliedschaft
   True
   >>> 'Fingerhirse' in fruit
   False

   >>> a = set('abracadabra')
   >>> b = set('alacazam')
   >>> a                                  # einzelne Buchstaben in a
   {'a', 'r', 'b', 'c', 'd'}
   >>> a - b                              # in a aber nicht in b
   {'r', 'd', 'b'}
   >>> a | b                              # in a oder b
   {'a', 'c', 'r', 'd', 'b', 'm', 'z', 'l'}
   >>> a & b                              # sowohl in a, als auch in b
   {'a', 'c'}
   >>> a ^ b                              # entweder in a oder b
   {'r', 'd', 'b', 'm', 'z', 'l'}

Wie für Listen gibt es auch eine Set Comprehension Syntax::

   >>> a = {x for x in 'abracadabra' if x not in 'abc'}
   >>> a
   {'r', 'd'}


.. _tut-dictionaries:

Dictionaries
============

Ein weiterer nützlicher Datentyp, der in Python eingebaut ist, ist das
*Dictionary* (siehe :ref:`typesmapping`). Dictionaries sind in manch anderen
Sprachen als "assoziativer Speicher" oder "assoziative Arrays" zu finden. Anders
als Sequenzen, die über Zahlen indizierbar sind, sind Dictionaries durch
*Schlüssel* (*keys*), als die jeder unveränderbare Typ dienen kann, indizierbar;
aus Zeichenketten und Zahlen kann immer solch ein Schlüssel gebildet werden.
Tupel können als Schlüssel benutzt werden, wenn sie nur aus Zeichenketten,
Zahlen oder Tupel bestehen; enthält ein Tupel direkt oder indirekt ein
veränderbares Objekt, kann es nicht als Schlüssel genutzt werden. Listen können
nicht als Schlüssel benutzt werden, da sie direkt veränderbar sind, sei es durch
Indexzuweisung, Abschnittszuweisung oder Methoden wie :meth:`append` and
:meth:`extend`.

Am Besten stellt man sich Dictionaries als ungeordnete Menge von *Schlüssel:
Wert*-Paaren vor, mit der Anforderung, dass die Schlüssel eindeutig sind
(innerhalb eines Dictionaries). Ein Paar von geschweiften Klammern erstellt ein
leeres Dictionary: ``{}``. Schreibt man eine Reihe von Komma-getrennten
Schlüssel-Wert-Paaren in die Klammern, fügt man diese als Anfangspaare dem
Dictionary hinzu; dies ist ebenfalls die Art und Weise, wie Dictionaries
ausgegeben werden.

Die Hauptoperationen, die an einem Dictionary durchgeführt werden, sind die
Ablage eines Wertes unter einem Schlüssel und der Abruf eines Wertes mit dem
gebenen Schlüssel. Es ist auch möglich ein Schlüssel-Wert-Paar per ``del`` zu
löschen. Legt man einen Wert unter einem Schlüssel ab, der schon benutzt wird,
überschreibt man den alten Wert, der vorher mit diesem Schlüssel verknüpft war.
Einen Wert mit einem nicht-existenten Schlüssel abrufen zu wollen, erzeugt eine
Fehlermeldung.

Der Aufruf ``list(d.keys())`` auf ein Dictionary gibt eine Liste aller Schlüssel
in zufälliger Reihenfolge zurück (Will man sie sortiert haben, wendet man
einfach die Funktion :func:`sorted` statt :func:`list` an). Um zu überprüfen ob
ein einzelner Schlüssel im Dictionary ist, lässt sich das Schlüsselwort
:keyword:`in` benutzen.

Hier ein kleines Beispiel wie man Dictionaries benutzt::


    >>> tel = {'jack': 4098, 'sape': 4139}
    >>> tel['guido'] = 4127
    >>> tel
    {'sape': 4139, 'guido': 4127, 'jack': 4098}
    >>> tel['jack']
    4098
    >>> del tel['sape']
    >>> tel['irv'] = 4127
    >>> tel
    {'guido': 4127, 'irv': 4127, 'jack': 4098}
    >>> list(tel.keys())
    ['irv', 'guido', 'jack']
    >>> sorted(tel.keys())
    ['guido', 'irv', 'jack']
    >>> 'guido' in tel
    True
    >>> 'jack' not in tel
    False

Der :func:`dict`-Konstruktor erstellt Dictionaries direkt von Listen, die die
Schlüssel-Wert-Paare als Tupel enthalten. Bilden die Paare ein Muster, können
List Comprehensions die Schlüssel-Wert Liste kompakt beschreiben. ::

    >>> dict([('sape', 4139), ('guido', 4127), ('jack', 4098)])
    {'sape': 4139, 'jack': 4098, 'guido': 4127}

Außerdem können Dict Comprehensions benutzt werden, um Dictionaries von
willkürlichen Schlüssel und Wert Ausdrücken zu erstellen::

    >>> {x: x**2 for x in (2, 4, 6)}
    {2: 4, 4: 16, 6: 36}

Sind die Schlüssel einfache Zeichenketten, ist es manchmal einfacher die Paare
als Schlüsselwort-Argumente anzugeben::

   >>> dict(sape=4139, guido=4127, jack=4098)
   {'sape': 4139, 'jack': 4098, 'guido': 4127}
