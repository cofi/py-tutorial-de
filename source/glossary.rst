.. _glossary: 

*******
Glossar
*******

.. glossary::

   ``>>>``
      Der Standard-Prompt der interaktiven Python-Shell.  Man begegnet ihm oft
      in Code-Beispielen die interaktiv im Interpreter ausgeführt werden können.

   ``...``
      Der Standard-Prompt der interaktiven Shell, wenn man Code für einen
      eingerückten Code-Block oder innerhalb eines Paars passender Klammern
      (rund, eckig oder geschweift) eingibt.

   2to3
      Ein Werkzeug, das versucht Python 2.x Code zu Python 3.x Code zu
      konvertieren, indem es die meisten Inkompabilitäten, die durch das Parsen
      der Quellen und das traversieren des Parse-Baumes erkannt werden können,
      behandelt.

      2to3 ist in der Standardbibliothek als :mod:`lib2to3` verfügbar.  Ein
      eigenständiger Einstiegspunkt ist als :file:`Tools/scripts/2to3`
      bereitgestellt.  Siehe :ref:`2to3-reference`.

   abstract base class
      Abstrakte Basisklassen (Abstract Base Classes - kurz ABCs) ergänzen
      :term:`duck-typing`, indem sie das definieren von Schnittstellen
      ermöglichen, wo andere Techniken wie :func:`hasattr` umständlich wären.
      Python kommt mit vielen eingebauten ABCs für Datenstrukturen (im
      :mod:`collections`-Modul), Zahlen (im :mod:`numbers`-Modul) und Ströme (im
      :mod:`io`-Modul).  Man kann eigene ABC mit dem :mod:`abc`-Modul erzeugen.

   argument
      Ein Wert, der einer Funktion oder Methode übergeben wird und einer
      benannten lokalen Variable im Funktionsrumpf zugewiesen wird.  Eine
      Funktion oder Methode kann sowohl Positions-, als auch
      Schlüsselwort-Argumente in ihrer Definition haben. Positions- und
      Schlüsselwort-Argumente können von variabler Länge sein: ``*`` akzeptiert
      (falls in der Funktionsdefinition) oder übergibt  (im Funktionsaufruf)
      mehrere Positionsargumente in einer Liste, während ``**`` dasselbe für
      Schlüsselwort-Argumente in einem Dictionary leistet.

      Jeder Ausdruck kann innerhalb der Argumentliste benutzt werden und der
      ausgewertete Wert wird an die lokale Variable übergeben.

   attribute
      Ein Wert, der mit einem Objekt assoziiert ist, wird von einem Namen
      mittels Punkt-Ausdruck referenziert.  Zum Beispiel, hätte ein Objekt *o*
      ein Attribut *a*, so würde es als *o.a* referenziert.

   BDFL
      Benevolent Dictator For Life (Wohlwollender Diktator auf Lebenszeit), auch
      bekannt als `Guido van Rossum <http://www.python.org/~guido/>`_, der
      Schöpfer von Python.

   bytecode
      Die interne Darstellung eines Python-Programmes im Interpreter,
      Python-Programme werden zu ihm kompiliert.  Der Bytecode wird in ``.pyc``-
      und ``.pyo``-Dateien gespeichert, so dass das Ausführen derselben Datei
      beim zweiten Mal schneller ist (da die erneute Kompilierung zu Bytecode
      vermieden werden kann).  Diese "Zwischensprache" (*intermediate language*)
      ist dazu gedacht auf einer :term:`virtual machine` (Virtuellen Maschine)
      ausgeführt zu werden, die den Maschinencode zum jeweiligen Bytecode
      ausführt.

   class
      Eine Vorlage für die Erstellung benutzerdefinierter Objekte.
      Klassendefinitionen enthalten normalerweise Methodendefinitionen, die auf
      den Exemplaren der Klasse agieren.

   classic class
      Jede Klasse, die nicht von :class:`object` erbt. Siehe :term:`new-style
      class`. Classic classes werden in Python 3.0 entfernt.

   coercion
      Die implizite Konvertierung eines Exemplares eines Typs in einen anderen
      während einer Operation, die zwei Argumente desselben Typs erfordert.  Zum
      Beispiel konvertiert ``int(3.15)`` die Fliesskomma-Zahl zu der Ganzzahl
      ``3``, aber in ``3 + 4.5`` ist jedes Argument von einem verschiedenen Typ
      (eines *int*, eines *float*) und beide müssen zum selben Typ konvertiert
      werden oder es wird ein :exc:`TypeError` erzeugt. Coercion zwischen zwei
      Operanden, kann mit der eingebauten Funktion :func:`coerce` ausgeführt
      werden; so ist ``3 + 4.5`` äquivalent zum Aufruf ``operator.add(*coerce(3,
      4.5))`` und resultiert in ``operator.add(3.0, 4.5)``.  Ohne Coercion
      müssten alle Argumente, selbst von kompatiblen Typen, zum selben Typ
      vom Programmierer normalisiert werden, z.B. ``float(3) + 4.5`` statt nur
      ``3 + 4.5``.

   complex number
      Eine Erweiterung zum bekannten reellen Zahlensystem, in dem alle Zahlen
      als eine Summe eines reellen Anteils und eines imaginären Anteils
      ausgedrückt werden.  Imaginäre Zahlen sind echte Vielfache der imaginären
      Einheit (der Wurzel von ``-1``), oft in der Mathematik oft als *i* oder im
      Ingenieurwesen als *j* geschrieben. Python hat eingebaute Unterstützung
      für Komplexe Zahlen, die mit folgender Notation geschrieben werden: Der
      imaginäre Anteil wird mit dem Suffix *j* geschrieben, z.B. ``3+1j``. Um
      Zugang zu den komplexen Äquivalenten des :mod:`math`-Modules zu bekommen,
      benutzt man :mod:`cmath`.  Der Gebrauch von Komplexen Zahlen ist ein recht
      fortgeschrittenes mathematisches Werkzeug.  Kennt man keine Notwendigkeit
      sie zu benutzen, ist es fast sicher, dass man sie getrost ignorieren kann.

   context manager
      Ein Objekt, das die Umgebung, der man in einer :keyword:`with`-Anweisung
      begegnet, kontrolliert, indem es die Methoden :meth:`__enter__` und
      :meth:`__exit__` definiert.
      Siehe :pep:`343`.

   CPython
      Die kanonische Implementierung der Pyton Programmiersprache.  Der Term
      "CPython" wird in Kontexten benutzt, in denen es nötig ist diese
      Implementierung von anderen wie Jython oder IronPython zu unterscheiden.

   decorator
      Eine Funktion, die eine andere Funktion zurückgibt, normalerweise als
      Funktionstransformation durch die ``@wrapper``-Syntax benutzt.  Häufige
      Beispiele für Dekoratoren sind :func:`classmethod` und
      :func:`staticmethod`.
      
      Die Dekorator-Syntax ist nur Syntaktischer Zucker (syntactic sugar). Die
      beiden folgenden Definitionen sind semantisch äquivalent::

         def f(...):
             ...
         f = staticmethod(f)

         @staticmethod
         def f(...):
             ...

      Siehe :ref:`the documentation for function definition <function>` zu mehr
      über Dekoratoren.

   descriptor
      Jedes *new-style* Objekt, das die Methoden :meth:`__get__`,
      :meth:`__set__` oder :meth:`__delete__` definiert. Wenn ein
      Klassenattribut ein Deskriptor ist, wird sein spezielles Bindeverhalten
      beim Attributs-Lookup ausgelöst.  Wenn man *a.b* für das Abfragen (*get*),
      Setzen (*set*) oder Löschen (*delete*) eines Attributs benutzt, wird nach
      einem Objekt namens *b* im Klassendictionary von *a* gesucht, ist *b* aber
      ein Deskriptor, wird die jeweilige Deskriptor-Methode aufgerufen. Das
      Verstehen von Deskriptoren ist wichtig für ein tiefes Verständnis von
      Python, da sie die Basis für viele Features einschliesslich Funtionen,
      Methoden, Properties, Klassenmethoden, statische Methoden und Referenzen
      zu Super-Klassen bilden.
      
      Für mehr Informationen zu den Deskriptor-Methoden, siehe
      :ref:`descriptors`.

   dictionary
      Ein assoziatives Array, wo beliebige Schlüssel auf Werte abgebildet
      werden.  Die Benutzung von :class:`dict` kommt der von :class:`list` sehr
      nahe, aber ein Schlüssel kann jedes Objekt sein, das eine
      :meth:`__hash__`-Methode hat, nicht nur Ganzzahlen.
      Trägt den Namen *hash* in Perl.

   docstring
      Ein Stringliteral, das als erster Ausdruck in einer Klasse, Funktion oder
      einem Modul vorkommt.  Während es beim Ausführen der Suite ignoriert wird,
      erkennt der Compiler es und weist es dem :attr:`__doc__`-Attribut der
      umgebenden Klasse, Funktion oder Modul zu.  Da es durch Introspektion
      verfügbar ist, ist es der kanonische Ort für Dokumentation des Objekts.

   duck-typing
      Ein pythonischer Programmierstil, der den Typ eines Objektes anhand seiner
      Methoden- oder Attributssignatur bestimmt, statt durch die explizite
      Zuordnung zu einem Typ-Objekt. ("Sieht es wie eines Ente aus und quakt es
      wie eine Ente, dann muss es eine Ente sein.") Durch die Hervorhebung von
      Schnittstellen statt spezifischer Typen, verbessert ein gut-durchdachter
      Code seine Flexibilität, indem er polymorphe Substitution
      zulässt. Duck-typing vermeidet Tests mittels :func:`type` oder
      :func:`isinstance`. (Beachte jedoch, dass duck-typing durch Abstrakte
      Basis Klassen ergänzt werden kann.) Stattdessen benutzt es Tests mit
      :func:`hasattr` oder :term:`EAFP`-Programmierung.

   EAFP
      "Easier to ask for forgiveness than permission." (Leichter um
      Vergebung zu bitten, als um Erlaubnis.)  Dieser geläufige
      Python-Programmierstil setzt die Existenz von validen Schlüsseln oder
      Attributen voraus und fängt Ausnahmen ab, wenn die Voraussetzung nicht
      erfüllt wurde.  Für diesen sauberen und schnellen Stil ist die Präsenz
      vieler :keyword:`try`- und :keyword:`except`-Anweisungen
      charakteristisch.  Diese Technik hebt sich von dem :term:`LBYL`-Stil ab,
      der in vielen anderen Sprachen wie beispielsweise C geläufig ist.

   expression
      Ein Stück Syntax, die zu einem Wert evaluiert werden kann.  Mit anderen
      Worten ist ein Ausdruck eine Anhäufung von Ausdruckselementen wie
      Literale, Namen, Attributszugriffe, Operatoren oder Funktionsaufrufen, die
      alle einen Wert zurückgeben. Im Unterschied zu vielen anderen Sprachen,
      sind nicht alle Sprachkonstrukte Ausdrücke. Es gibt ebenfalls Anweisungen
      (:term:`statement`), die nicht als als Ausdruck benutzt werden können, wie
      :keyword:`print` oder :keyword:`if`. Zuweisungen sind ebenfalls
      Anweisungen, keine Ausdrücke.

   extension module
      Ein Modul, das in C oder C++ geschrieben ist und mit Pythons C API mit dem
      Kern und dem Benutzer-Code zusammenarbeitet.

   finder
      Ein Objekt, das versucht den :term:`loader` für ein Modul zu finden. Es
      muss eine Methode namens :meth:`find_module` implementieren.

      Siehe :pep:`302` für Details.

   function
      Eine Serie von Anweisungen, die einen Wert zum Aufrufenden zurückgeben.
      Ihr können ebenfalls null oder mehr Argumente übergeben werden, die in der
      Ausführung des Rumpfs benutzt werden können.

      Siehe auch :term:`argument` und :term:`method`.

   __future__
      Ein Pseudo-Modul, das Programmierern ermöglicht neue Sprach-Features zu
      aktivieren, die nicht kompatibel mit dem aktuellen Interpreter sind.  Zum
      Beispiel evaluiert der Ausdruck ``11/4`` momentan zu  ``2``. Hätte das
      Modul, in dem er ausgeführt wird *echte Division* durch folgendes
      aktiviert::

          from __future__ import division

      dann würde der Ausdruck ``11/4`` zu ``2.75`` evaluieren. Durch den Import
      des :mod:`__future__`-Moduls und dem Auswerten seiner Variablen, kann man
      sehen, wann ein Feature zuerst der Sprache hinzugefügt wurde und wann es
      das Standard-Verhalten wird::

          >>> import __future__
          >>> __future__.division
          _Feature((2, 2, 0, 'alpha', 2), (3, 0, 0, 'alpha', 0), 8192)

   garbage collection
      Der Prozess des Freigebens nicht mehr benötigten Speichers.  Pythons
      garbage collection erfolgt mittels des Zählens von Referenzen (*reference
      counting*) und einem zyklischen Garbage Collectors, der imstande ist
      Referenzzyklen zu entdecken und aufzubrechen.

   generator
      Eine Funktion die einen Iterator zurückgibt.  Sie sieht aus wie eine
      normale Funktion, mit der Ausnahme, dass Werte zum Aufrufenden mittels
      einer :keyword:`yield`-Anweisung statt mit einer
      :keyword:`return`-Anweisung zurückgegeben werden.  Generator-Funktionen
      enthalten oft eine oder mehrere Schleifen (:keyword:`for` oder
      :keyword:`while`), die dem Aufrufenden Elemente liefern
      (:keyword:`yield` en).  Die Ausführung der Funktion wird nach dem
      :keyword:`yield` unterbrochen (während das Ergebnis zurückgegeben wird)
      und wird dort wiederaufgenommen, wenn das nächste Element durch den Aufruf
      der :meth:`next`-Methode des zurückgegebenen Iterators angefordert wird.

   virtual machine
      Ein Computer, der komplett in Software definiert ist.  Pythons Virtuelle
      Maschine führt den :term:`bytecode` aus, den der Bytecode-Compiler
      erzeugt.
