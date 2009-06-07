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


