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

Jede List Comprehension besteht aus einem Ausdruck auf den eine
:keyword:`for`-Klausel folgt. Danach sind beliebig viele :keyword:`for`- oder
:keyword:`if`-Klauseln zulässig. Das Ergebnis ist eine Liste, deren Elemente
durch das Auswerten des Ausdrucks im Kontext der :keyword:`for`- und
:keyword:`if`-Klauseln, die darauf folgen, erzeugt werden. Würde der Ausdruck
ein Tupel ergeben, muss er in Klammern stehen.

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
