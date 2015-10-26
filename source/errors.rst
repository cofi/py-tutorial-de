.. _tut-errors:

********************
Fehler und Ausnahmen
********************

Bis jetzt wurden Fehlermeldungen nur am Rande erwähnt, aber wenn Du die
Beispiele ausprobiert hast, hast Du sicherlich schon einige gesehen. Es gibt
(mindestens) zwei verschiedene Arten von Fehlern: *Syntaxfehler* (engl.: syntax
errors) und *Ausnahmen* (engl.: exceptions).


.. _tut-syntaxerrors:

Syntaxfehler
============

Syntaxfehler, auch Parser-Fehler genannt, sind vielleicht die häufigsten
Fehlermeldungen, die Du bekommt, wenn Du Python lernst:: 

   >>> while True print('Hallo Welt')
     File "<stdin>", line 1, in ?
       while True print('Hallo Welt')
                      ^
   SyntaxError: invalid syntax

Der Parser wiederholt die störende Zeile und zeigt mit einem kleinen 'Pfeil' auf
die Stelle, an der der Fehler entdeckt wurde. Der Fehler ist an dem Token
aufgetreten (oder wurde zumindest dort entdeckt), welches *vor* dem Pfeil steht:
In dem Beispiel wurde der Fehler bei der :func:`print`-Funktion entdeckt, da ein
Doppelpunkt (``':'``) vor der Funktion fehlt. Des weiteren werden der Dateiname
und die Zeilennummer ausgegeben, sodass Du weißt, wo Du suchen musst, falls die
Eingabe aus einem Skript kam.
 

.. _tut-exceptions:

Ausnahmen
=========

Selbst wenn eine Anweisung oder ein Ausdruck syntaktisch korrekt ist, kann es
bei der Ausführung zu Fehlern kommen. Fehler, die bei der Ausführung auftreten,
werden *Ausnahmen* (engl: exceptions) genannt und sind nicht notwendigerweise
schwerwiegend: Du wirst gleich lernen, wie Du in Python-Programmen mit ihnen
umgehst. Die meisten Ausnahmen werden von Programmen aber nicht behandelt, und
erzeugen Fehlermeldungen, wie dieses Beispiel zeigt::

   >>> 10 * (1/0)
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   ZeroDivisionError: int division or modulo by zero
   >>> 4 + spam*3
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   NameError: name 'spam' is not defined
   >>> '2' + 2
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: Can't convert 'int' object to str implicitly

Die letzte Zeile der Fehlermeldung gibt an, was passiert ist. Es gibt
verschiedene Typen von Ausnahmen, und der Typ der Ausnahme wird als Teil der
Meldung ausgegeben: Die Typen in diesem Beispiel sind :exc:`ZeroDivisionError`,
:exc:`NameError` und :exc:`TypeError`. Die Zeichenkette, die als Ausnahmetyp
ausgegeben wird, ist der Name der eingebauten Ausnahme, die aufgetreten ist.
Dies gilt für alle eingebauten Ausnahmen, muss aber für benutzerdefinierte
Ausnahmen nicht zutreffen (es ist aber eine nützliche Konvention).
Standard-Ausnahmen sind eingebaute Bezeichner (keine reservierten
Schlüsselwörter).

Der Rest der Zeile gibt Details an, die auf dem Ausnahmetyp und darauf, was die
Ausnahme ausgelöst hat, basieren.

Der vorangehende Teil der Fehlermeldung zeigt den Zusammenhang, in dem die
Ausnahme auftrat, in Form eines Traceback. Im Allgemeinen wird dort der
Programmverlauf mittels der entsprechenden Zeilen des Quellcodes aufgelistet; es
werden jedoch keine Zeilen ausgegeben, die von der Standardeingabe gelesen
wurden.

:lib:`Built-in Exceptions <exceptions.html#bltin-exceptions>` listet alle
eingebauten Ausnahmen und ihre Bedeutung auf.


.. _tut-handling:

Ausnahmen behandeln
===================

Es ist möglich, Programme zu schreiben, welche ausgewählte Ausnahmen behandeln.
Schau Dir das folgende Beispiel an, welches den Benutzer solange um Eingabe
bittet, bis eine gültige Ganzzahl eingegeben wird, es dem Benutzer aber
ermöglicht, das Programm abzubrechen (mit :kbd:`Strg-C` oder was das
Betriebssystem sonst unterstützt); ein solcher vom Benutzer erzeugter Abbruch
löst eine :exc:`KeyboardInterrupt`-Ausnahme aus::

   >>> while True:
   ...     try:
   ...         x = int(input("Bitte gib eine Zahl ein: "))
   ...         break
   ...     except ValueError:
   ...         print("Ups! Das war keine gültige Zahl. Versuche es noch einmal...")
   ...

Die :keyword:`try`-Anweisung funktioniert folgendermaßen:

* Zuerst wird der *try-Block* (die Anweisung(en) zwischen den Schlüsselwörtern
  :keyword:`try` und :keyword:`except`) ausgeführt.

* Wenn dabei keine Ausnahme auftritt, wird der *except-Block* übersprungen, und
  die Ausführung der :keyword:`try`-Anweisung ist beendet.

* Wenn während der Ausführung des try-Blocks eine Ausnahme auftritt, wird der
  Rest des Blockes übersprungen. Wenn dann der Typ dieser Ausnahme der Ausnahme
  gleicht, welche nach dem :keyword:`except`-Schlüsselwort folgt, wird der
  except-Block ausgeführt, und danach ist die Ausführung der
  :keyword:`try`-Anweisung beendet. 

* Wenn eine Ausnahme auftritt, welche nicht der Ausnahme im except-Block
  gleicht, wird sie an äußere :keyword:`try`-Anweisungen weitergegeben; wenn
  keine passende :keyword:`try`-Anweisung gefunden wird, ist die Ausnahme eine
  *unbehandelte Ausnahme* (engl: unhandled exception), und die
  Programmausführung stoppt mit einer Fehlermeldung wie oben gezeigt.

Eine :keyword:`try`-Anweisung kann mehr als einen :keyword:`except`-Block
enthalten, um somit verschiedene Aktionen für verschiedene Ausnahmen
festzulegen. Es wird höchstens ein except-Block ausgeführt. Ein Block kann nur
die Ausnahmen behandeln, welche in dem zugehörigen try-Block aufgetreten sind,
nicht jedoch solche, welche in einem anderen except-Block der gleichen
try-Anweisung auftreten. Ein :keyword:`except`-Block kann auch mehrere Ausnahmen
gleichzeitig behandeln, dies wird in einem Tupel angegeben:

   ... except (RuntimeError, TypeError, NameError):
   ...     pass

Der letzte except-Block kann ohne Ausnahme-Name(n) gelassen werden, dies
fungiert als Wildcard. Benutze diese Möglichkeit nur sehr vorsichtig, denn
dadurch können echte Programmierfehler verdeckt werden! Auf diese Weise kann man
sich auch Fehlermeldungen ausgeben lassen und dann die Ausnahme erneut auslösen
(sodass der Aufrufer diese Ausnahme ebenfalls behandeln kann)::

   import sys

   try:
       f = open('myfile.txt')
       s = f.readline()
       i = int(s.strip())
   except IOError as err:
       print("I/O error: {0}".format(err))
   except ValueError:
       print("Konnte Daten nicht in Ganzzahl umwandeln.")
   except:
       print("Unbekannter Fehler:", sys.exc_info()[0])
       raise

Die :keyword:`try` ... :keyword:`except`-Anweisung erlaubt einen optionalen
*else-Block*, welcher, wenn vorhanden, nach den except-Blöcken stehen muss. Er
ist nützlich für Code, welcher ausgeführt werden soll, falls der try-Block keine
Ausnahme auslöst. Zum Beispiel::

   for arg in sys.argv[1:]:
       try:
           f = open(arg, 'r')
       except IOError:
           print('Kann', arg, 'nicht öffnen')
       else:
           print(arg, 'hat', len(f.readlines()), 'Zeilen')
           f.close()

Die Benutzung eines :keyword:`else`-Blockes ist besser, als zusätzlichen Code
zum :keyword:`try`-Block hinzuzufügen. Sie verhindert, dass aus Versehen
Ausnahmen abgefangen werden, die nicht von dem Code ausgelöst wurden, welcher
von der :keyword:`try` ...  :keyword:`except`-Anweisung geschützt werden soll.

Wenn eine Ausnahme auftritt, kann sie einen zugehörigen Wert haben, das
sogenannte *Argument* der Ausnahme. Ob ein solches Argument vorhanden ist und
welchen Typ es hat, hängt vom Typ der Ausnahme ab.

Der :keyword:`except`-Block kann einen Variablennamen nach dem Ausnahme-Namen
spezifizieren. Der Variablenname wird an eine Ausnahmeinstanz gebunden und die
Ausnahme-Argumente werden in ``instance.args`` gespeichert. Für die bessere
Benutzbarkeit definiert eine Ausnahmeinstanz :meth:`__str__`, sodass die
Argumente direkt ausgegeben werden können, ohne dass ``.args`` referenziert
werden muss. Man kann außerdem eine Ausnahme instantiieren bevor man sie
auslöst, um weitere Attribute nach Bedarf hinzuzufügen::

   >>> try:
   ...    raise Exception('spam', 'eggs')
   ... except Exception as inst:
   ...    print(type(inst))    # Die Ausnahmeinstanz
   ...    print(inst.args)     # Argumente gespeichert in .args
   ...    print(inst)          # __str__ erlaubt direkte Ausgabe von .args,
   ...                         # kann aber in Subklassen überschrieben werden
   ...    x, y = inst.args     # args auspacken
   ...    print('x =', x)
   ...    print('y =', y)
   ...
   <class 'Exception'>
   ('spam', 'eggs')
   ('spam', 'eggs')
   x = spam
   y = eggs

Wenn eine Ausnahme Argumente hat, werden diese als letzter Teil ('detail') der
Fehlermeldung unbehandelter Ausnahmen ausgegeben.

Ausnahme-Handler behandeln nicht nur Ausnahmen, welche direkt im
:keyword:`try`-Block auftreten, sondern auch solche Ausnahmen, die innerhalb von
Funktionsaufrufen (auch indirekt) im :keyword:`try`-Block ausgelöst werden. Zum
Beispiel::

   >>> def this_fails():
   ...     x = 1/0
   ...
   >>> try:
   ...     this_fails()
   ... except ZeroDivisionError as err:
   ...     print('Behandle Laufzeitfehler:', err)
   ...
   Behandle Laufzeitfehler: int division or modulo by zero


.. _tut-raising:

Ausnahmen auslösen
==================

Die :keyword:`raise`-Anweisung erlaubt es dem Programmierer, das Auslösen einer
bestimmten Ausnahme zu erzwingen. Zum Beispiel::

   >>> raise NameError('HeyDu')
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   NameError: HeyDu

Das einzige Argument des Schlüsselwortes :keyword:`raise` gibt die Ausnahme an,
die ausgelöst werden soll. Es muss entweder eine Ausnahme-Instanz sein oder eine
Ausnahmeklasse (eine Klasse, die von :class:`Exception` erbt).

Wenn Du herausfinden willst, ob eine Ausnahme ausgelöst wurde, sie aber nicht
behandeln willst, erlaubt Dir eine einfachere Form der
:keyword:`raise`-Anweisung, eine Ausnahme erneut auszulösen::

   >>> try:
   ...     raise NameError('HeyDu')
   ... except NameError:
   ...     print('Eine Ausnahme flog vorbei!')
   ...     raise
   ...
   Eine Ausnahme flog vorbei!
   Traceback (most recent call last):
     File "<stdin>", line 2, in ?
   NameError: HeyDu


.. _tut-userexceptions:

Benutzerdefinierte Ausnahmen
============================

Programme können ihre eigenen Ausnahmen benennen, indem sie eine neue
Ausnahmeklasse erstellen (Unter :ref:`tut-classes` gibt es mehr Informationen zu
Python-Klassen). Ausnahmen sollten standardmäßig von der Klasse :exc:`Exception`
erben, entweder direkt oder indirekt. Zum Beispiel::

   >>> class MyError(Exception):
   ...     def __init__(self, value):
   ...         self.value = value
   ...     def __str__(self):
   ...         return repr(self.value)
   ...
   >>> try:
   ...     raise MyError(2*2)
   ... except MyError as e:
   ...     print('Meine Ausnahme wurde ausgelöst, Wert:', e.value)
   ...
   Meine Ausnahme wurde ausgelöst, Wert:: 4
   >>> raise MyError('ups!')
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   __main__.MyError: 'ups!'

In diesem Beispiel wurde die Methode :meth:`__init__` der Klasse
:class:`Exception` überschrieben. Das neue Verhalten erzeugt schlicht das
Attribut *value*, es ersetzt das Standardverhalten, ein Attribut *args* zu
erzeugen.

Ausnahmeklassen können alle Möglichkeiten nutzen, die bei der Definition von
Klassen zur Verfügung stehen, werden jedoch meist recht einfach gehalten; oft
bieten sie nur eine Reihe von Attributen, welche genauere Informationen über den
Fehler bereitstellen. Beim Erstellen von Modulen, welche verschiedene Fehler
auslösen können, wird oft eine Basisklasse für Ausnahmen dieses Moduls definiert
und alle anderen Ausnahmen für spezielle Fehlerfälle erben dann von dieser
Basisklasse::

   class Error(Exception):
       """Base class for exceptions in this module."""
       pass

   class InputError(Error):
       """Exception raised for errors in the input.

       Attributes:
           expression -- input expression in which the error occurred
           message -- explanation of the error
       """

       def __init__(self, expression, message):
           self.expression = expression
           self.message = message

   class TransitionError(Error):
       """Raised when an operation attempts a state transition that's not
       allowed.

       Attributes:
           previous -- state at beginning of transition
           next -- attempted new state
           message -- explanation of why the specific transition is not allowed
       """

       def __init__(self, previous, next, message):
           self.previous = previous
           self.next = next
           self.message = message

Meistens gibt man den Ausnahmen Namen, die auf "Error" enden, ähnlich der
Namensgebung der Standardausnahmen.

Viele Standardmodule definieren ihre eigenen Ausnahmen, um Fehler zu melden, die
in ihren Funktionen auftreten können. Mehr Informationen über Klassen sind
in Kapitel :ref:`tut-classes` zu finden .


.. _tut-cleanup:

Aufräumaktionen festlegen
=========================

Die :keyword:`try`-Anweisung kennt einen weiteren optionalen Block, der für
Aufräumaktionen gedacht ist, die in jedem Fall ausgeführt werden sollen. Zum
Beispiel::

   >>> try:
   ...     raise KeyboardInterrupt
   ... finally:
   ...     print('Auf Wiedersehen, Welt!')
   ...
   Auf Wiedersehen, Welt!
   Traceback (most recent call last):
     File "<stdin>", line 2, in ?
   KeyboardInterrupt

Der *finally-Block* wird immer ausgeführt, bevor die :keyword:`try`-Anweisung
verlassen wird, egal ob eine Ausnahme aufgetreten ist oder nicht. Wenn eine
Ausnahme im :keyword:`try`-Block ausgelöst wurde, die nicht in einem
except-Block behandelt wird (oder die in einem except-Block oder else-Block
ausgelöst wurde), wird sie nach Ausführung des :keyword:`finally`-Blocks erneut
ausgelöst. Der :keyword:`finally`-Block wird auch ausgeführt, wenn ein anderer
Block der :keyword:`try`-Anweisung durch eine :keyword:`break`-,
:keyword:`continue`- or :keyword:`return`-Anweisung verlassen wurde. Ein etwas
komplizierteres Beispiel::

   >>> def divide(x, y):
   ...     try:
   ...         result = x / y
   ...     except ZeroDivisionError:
   ...         print("Division durch Null!")
   ...     else:
   ...         print("Ergebnis ist:", result)
   ...     finally:
   ...         print("Führe finally-Block aus")
   ...
   >>> divide(2, 1)
   Ergebnis ist: 2.0
   Führe finally-Block aus
   >>> divide(2, 0)
   Division durch Null!
   Führe finally-Block aus
   >>> divide("2", "1")
   Führe finally-Block aus
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
     File "<stdin>", line 3, in divide
   TypeError: unsupported operand type(s) for /: 'str' and 'str'


Wie Du sehen kannst, wird der :keyword:`finally`-Block in jedem Fall ausgeführt.
Der :exc:`TypeError`, der durch die Division zweier Strings ausgelöst wird, wird
nicht vom :keyword:`except`-Block behandelt und wird somit erneut ausgelöst,
nachdem der :keyword:`finally`-Block ausgeführt wurde.

In echten Anwendungen ist der :keyword:`finally`-Block nützlich, um externe
Ressourcen freizugeben (wie Dateien oder Netzwerkverbindungen), unabhängig
davon, ob die Ressource erfolgreich benutzt wurde oder nicht.


.. _tut-cleanup-with:

Vordefinierte Aufräumaktionen
=============================

Einige Objekte definieren Standard-Aufräumaktionen, die ausgeführte werden, wenn
das Objekt nicht länger gebraucht wird, egal ob die Operation, die das Objekt
benutzte, erfolgreich war oder nicht. Schau Dir das folgende Beispiel an,
welches versucht, eine Datei zu öffnen und ihren Inhalt auf dem Bildschirm
auszugeben.::

   for line in open("myfile.txt"):
       print(line)

Das Problem dieses Codes ist, dass er die Datei, nachdem der Code ausgeführt
wurde, für unbestimmte Zeit geöffnet lässt. In einfachen Skripten ist das kein
Thema, aber in großen Anwendungen kann es zu einem Problem werden. Die
:keyword:`with`-Anweisung erlaubt es Objekten wie Dateien, auf eine Weise
benutzt zu werden, dass sie stets korrekt und sofort aufgeräumt werden. ::

   with open("myfile.txt") as f:
       for line in f:
           print(line)

Nachdem die Anweisung ausgeführt wurde, wird die Datei *f* stets geschlossen,
selbst wenn ein Problem bei der Ausführung der Zeilen auftrat. Objekte die, wie
Dateien, vordefinierte Aufräumaktionen bereitstellen, geben dies in ihrer
Dokumentation an.

