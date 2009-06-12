.. _tut-io:

*******************
Eingabe und Ausgabe
*******************

Es gibt verschiedene Arten die Ausgabe eines Programmes darzustellen: Daten
können in menschenlesbarer Form ausgegeben werden oder in eine Datei für die
spätere Verwendung geschrieben werden. Dieses Kapitel beschreibt einige
Möglichkeiten.


.. _tut-formatting:

Ausgefallenere Ausgabeformatierung
==================================

Bis jetzt sind uns zwei Arten der Ausgabe von Werten begegnet:
*Ausdrucksanweisungen* (*expression statements*) und die :func:`print`-Funktion.
(Eine dritte Möglichkeit ist die :meth:`write`-Methode von Dateiobjekten; die
Standardausgabedatei kann als ``sys.stdout`` referenziert werden. In der
Bibliotheksreferenz gibt es dazu weitere Informationen.)

.. index:: module: string

Oft will man mehr Kontrolle über die Formatierung der Ausgabe haben als nur
Leerzeichen-getrennte Werte auszugeben. Es gibt zwei Arten die Ausgabe zu
formatieren: Die erste Möglichkeit ist, dass man die gesamte Verarbeitung der
Zeichenketten selbst übernimmt; indem man Slicing- und Verknüpfungsoperationen
benutzt, kann man jede denkbare Anordnung zusammenstellen. Das Standardmodul
:mod:`string` enthält ein paar nützliche Operationen um Zeichenketten auf eine
bestimmte Länge aufzufüllen; diese werden wir in Kürze behandeln. Die zweite
Möglichkeit ist die Benutzung der :meth:`str.format`-Methode.

Eine Frage bleibt natürlich: Wie konvertiert man Werte zu Zeichenketten?
Glücklicherweise kennt Python Wege, um jeden Wert in eine Zeichenkette
umzuwandeln: Übergib den Wert an die :func:`repr`- oder :func:`str`-Funktion.

Die :func:`str` ist dazu gedacht eine ziemlich menschenlesbare Repräsentation
des Wertes zurückzugeben, während :func:`repr` dazu gedacht ist vom Interpreter
lesbar zu sein (oder einen :exc:`SyntaxError` erzwingt, wenn es keine
äquivalente Syntax gibt). Für Objekte, die keine besondere menschenlesbare
Repräsentation haben, gibt :func:`str` denselben Wert wie :func:`repr` zurück.
Viele Werte wie Nummern oder Strukturen wie Listen und Dictionaries benutzen für
beide Funktionen dieselbe Repräsentation. Zeichenketten und insbesondere
Fliesskommazahlen haben zwei verschiedene Repräsentationen.

Ein paar Beispiele::

   >>> s = 'Hallo Welt!'
   >>> str(s)
   'Hallo Welt!'
   >>> repr(s)
   "'Hallo Welt!'"
   >>> str(0.1)
   '0.1'
   >>> repr(0.1)
   '0.10000000000000001'
   >>> x = 10 * 3.25
   >>> y = 200 * 200
   >>> s = 'Der Wert von x ist ' + repr(x) + ', und y ist ' + repr(y) + '...'
   >>> print(s)
   Der Wert von x ist 32.5, und y ist 40000...
   >>> #repr() bei einer Zeichenkette benutzt Anführungszeichen und Backslashes:
   ... hello = 'Hallo Welt\n'
   >>> hellos = repr(hello)
   >>> print(hellos)
   'Hallo Welt\n'
   >>> # Das Argument für repr() kann jedes Pythonobjekt sein:
   ... repr((x, y, ('spam', 'eggs')))
   "(32.5, 40000, ('spam', 'eggs'))"

Nun zwei Möglichkeiten eine Tabelle von Quadrat- und Kubikzahlen zu erstellen::

   >>> for x in range(1, 11):
   ...     print(repr(x).rjust(2), repr(x*x).rjust(3), end=' ')
   ...     # Achte auf die Benutzung von 'end' in der vorherigen Zeile
   ...     print(repr(x*x*x).rjust(4))
   ...
    1   1    1
    2   4    8
    3   9   27
    4  16   64
    5  25  125
    6  36  216
    7  49  343
    8  64  512
    9  81  729
   10 100 1000

   >>> for x in range(1, 11):
   ...     print('{0:2d} {1:3d} {2:4d}'.format(x, x*x, x*x*x))
   ...
    1   1    1
    2   4    8
    3   9   27
    4  16   64
    5  25  125
    6  36  216
    7  49  343
    8  64  512
    9  81  729
   10 100 1000

(Achte darauf, dass im ersten Beispiel ein Leerzeichen pro Spalte durch die
Funktionsweise von :func:`print` hinzugefügt wird: Sie trennt ihre Argumente mit
Leerzeichen.

Dieses Beispiel hat die :meth:`rjust`-Methode von Zeichenkettenobjekten gezeigt,
die eine Zeichenkette in einem Feld der gegebenen Breite rechtsbündig macht,
indem sie diese links mit Leerzeichen auffüllt. Es gibt die ähnlichen Methoden
:meth:`ljust` und :meth:`center`. Diese Methoden schreiben nichts, sondern geben
eine neue Zeichenkette zurück. Ist die gegebene Zeichenkette zu lang,
schneiden sie nichts, sondern geben diese unverändert zurück; dies wird die
Anordnung durcheinanderbringen, aber ist meistens besser als die Alternative,
die den Wert zu verfälschen wäre. (Will man wirklich abschneiden, kann man
immernoch eine Slicingoperation hinzufügen, zum Beispiel ``x.ljust(n)[:n]``.)

Es gibt noch eine weitere Methode, :meth:`zfill`, die eine numerische
Zeichenkette mit Nullen auffüllt. Sie versteht auch Plus- und Minuszeichen::

    >>> '12'.zfill(5)
    '00012'
    >>> '-3.14'.zfill(7)
    '-003.14'
    >>> '3.14159265359'.zfill(5)
    '3.14159265359'

Die einfachste Benutzung der :meth:`str.format`-Methode sieht so aus::

    >>> print('Wir sind die {0}, die "{1}!" sagen.'.format('Ritter', 'Ni'))
    Wir sind die Ritter, die "Ni!" sagen.

Die Klammern und die Zeichen darin (genannt Formatfelder - *format fields*)
werden mit den Objekten ersetzt, die der :meth:`format`-Methode übergeben
werden. Die Nummer in den Klammern bezieht sich auf die Position des Objektes,
die der :meth:`format`-Methode übergeben werden. ::


    >>> print('{0} and {1}'.format('spam', 'eggs'))
    spam and eggs
    >>> print('{1} and {0}'.format('spam', 'eggs'))
    eggs and spam

Werden Schlüsselwortargumente in der :meth:`format`-Methode benutzt, können
deren Werte durch die Benutzung des Argumentnamens referenziert werden. ::

    >>>print('Dieses {Speise} ist {Adjektiv}.'.format(Speise='Spam',
             Adjektiv='absolut schrecklich'))
    Dieses Spam ist absolut schrecklich.

Positionsabhängige und Schlüsselwortargumente können willkürlich kombiniert
werden::

    >>>print('Die Geschichte von {0}, {1} und {anderer}.'.format('Bill',
             'Manfred', anderer='Georg'))
    Die Geschichte von Bill, Manfred und Georg.
    
Ein optionales ``':'`` mit Formatspezifizierer (*format specifier*) können auf
den Namen des Feldes folgen. Dies gibt einem eine größere Kontrolle darüber, wie
der Wert formatiert wird. Das folgende Beispiel begrenzt Pi auf drei Stellen
nach dem Komma.

    >>> import math
    >>> print('Der Wert von Pi ist ungefähr {0:.3f}.'.format(math.pi))
    Der Wert von Pi ist ungefähr 3.142.

Übergibt man einen Integer nach dem ``':'``, so legt man eine minimale Breite
für dieses Feld an. Das ist nützlich um Tabellen schön aussehen zu lassen. ::

    >>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 7678}
    >>> for name, phone in table.items():
    ...     print('{0:10} ==> {1:10d}'.format(name, phone))
    ...
    Jack       ==>       4098
    Dcab       ==>       7678
    Sjoerd     ==>       4127

Hat man einen wirklich langen Formatstring, den man nicht aufteilen will, wäre
es nett, wenn man die zu formatierenden Variablen durch den Namen, statt durch
die Position referenzieren könnte. Dies kann einfach bewerkstelligt werden,
indem man das Dictionary übergibt und die auf die Schlüssel über eckige Klammern
``'[]'`` zugreift ::

    >>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
    >>> print('Jack: {0[Jack]:d}; Sjoerd: {0[Sjoerd]:d}; '
             'Dcab: {0[Dcab]:d}'.format(table))
    Jack: 4098; Sjoerd: 4127; Dcab: 8637678

Das könnte auch genauso erreicht werden, indem man die Tabelle als
Schlüsselwortargumente mit der '**'-Notation übergibt.

    >>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
    >>> print('Jack: {Jack:d}; Sjoerd: {Sjoerd:d}; Dcab: {Dcab:d}'.format(**table))
    Jack: 4098; Sjoerd: 4127; Dcab: 8637678

Das ist besonders nützlich in Verbindung mit der neuen eingebauten Funktion
:func:`vars`, die ein Dictionary mit allen lokalen Variablen zurückgibt.

Siehe :ref:`formatstrings` für eine komplette Übersicht zu
Zeichenkettenformatierung mit :meth:`str.format`.

Alte Zeichenkettenformatierung
------------------------------

Der ``%``-Operator kann auch zur Zeichenkettenformatierung genutzt werden. Er
interpretiert das linke Argument genauso wie die einen :cfunc:`sprintf`-artigen
Formatstring, der auf das rechte Argument angewendet werden soll und gibt die
resultierende Zeichenkette dieser Formatierungsoperation zurück. Zum Beispiel::

    >>> import math
    >>> print('Der Wert von Pi ist ungefähr %5.3f.' % math.pi)
    Der Wert von Pi ist ungefähr 3.142.

Da :meth:`str.format` ziemlich neu ist, benutzt viel Pythoncode noch den
``%``-Operator. Jedoch sollte :meth:`str.format` hauptsächlich benutzt werden,
da diese alte Art der Formatierung irgendwann aus der Sprache entfernt wird.

Mehr Informationen dazu gibt es in dem Abschnitt :ref:`old-string-formatting`.

.. _tut-files:

Lesen und Schreiben von Dateien
===============================

.. index:
   builtin: open
   object: file

:func:`open` gibt ein Dateiobjekt zurück und wird meistens mit zwei Argumenten
aufgerufen: ``open(filename, mode)``

::

    >>> f = open('/tmp/workfile', 'w')


    >>> print(f)
    <open file '/tmp/workfile', mode 'w' at 80a0960>

Das erste Argument ist eine Zeichenkette, die den Dateinamen enthält. Das zweite
Argument ist eine andere Zeichenkette mit ein paar Zeichen, die die Art
der Benutzung der Datei beschreibt. *mode* kann ``'r'`` sein, wenn die Datei nur
gelesen wird, ``'w'``, wenn sie nur geschrieben wird (eine existierende Datei
mit demselben Namen wird gelöscht) und ``'a'`` öffnet die Datei zum Anhängen;
alle Daten, die in die Datei geschrieben werden, werden automatisch ans Ende
angehängt. ``'r+'`` öffnet die Datei zum Lesen und Schreiben. Das
*mode*-Argument ist optional, fehlt es, so wird ``'r'`` angenommen.

Normalerweise werden Dateien im :defn:`Textmodus` (*text mode*) geöffnet, das
heisst, dass man Zeichenketten von ihr liest beziehungsweise in sie schreibt,
die in einer bestimmten Kodierung kodiert werden (der Standard ist UTF-8).
Wird ``'b'`` an das *mode*-Argument angehängt, so öffnet man die Datei im
:dfn:`Binärmodus` (*binary mode*); in ihm werden Daten als Byteobjekte gelesen
und geschrieben. Dieser Modus sollte für alle Dateien genutzt werden, die keinen
Text enthalten.

Im Textmodus wird beim Lesen standardmäßig das plattformspezifische Zeilenende
(``\n`` unter Unixen, ``\r\n`` unter Windows) zu einem einfachen ``\n``
konvertiert und beim Schreiben ``\n`` zurück zum plattformspezifischen
Zeilenende. Diese versteckte Modifikation ist klasse für Textdateien, wird aber
binäre Dateiformate, wie :file:`JPEG`- oder :file:`EXE`-Dateien,  beschädigen.
Achte sehr sorgfältig darauf, dass du den Binärmodus benutzt, wenn du solche
Dateien schreibst oder liest.
