.. _tut-interacting:

********************************************************
Interaktive Zeilenbearbeitung und Ersetzung des Verlaufs
********************************************************

Einige Versionen des Python-Interpreters unterstützen die Bearbeitung der
aktuellen Zeile und die Ersetzung des Verlaufs ähnlich der Möglichkeiten die die
Korn-Shell oder die GNU Bash-Shell bieten. Dies wird durch die Benutzung der
*GNU Readline*-Bibliothek implementiert, die eine Bearbeitung im Emacs- oder
vi-Stil ermöglicht. Da diese Bibliothek eine eigene Dokumentation hat, wird sie
hier nicht neu geschrieben, aber die Grundlagen lassen sich einfach erklären.
Die hier beschriebenen Möglichkeiten sind in der Unix- und Cygwin-Version des
Interpreters optional vorhanden.

Dieses Kapitel beschäftigt sich weder mit den Bearbeitungsmöglichkeiten, die
Mark Hammonds PythonWin-Paket bereitstellt, noch mit denen der auf Tk basierten
Entwicklungsumgebung IDLE, die mit Python verteilt wird. Der
Kommandozeilen-Rückruf, den es innerhalb der DOS-Boxen unter NT und ein paar
anderen DOS- und Windows-Versionen gibt, ist auch eine ganz andere
Angelegenheit.


.. _tut-lineediting:

Zeilenbearbeitung
=================

Falls unterstützt, ist die Bearbeitung der Eingabezeile immer dann aktiv, wenn
der Interpreter eine primäre oder sekundäre Eingabeaufforderung ausgibt. Die
aktuelle Zeile kann mit den üblichen Emacs-Steuerzeichen bearbeitet werden. Die
wichtigsten davon sind: :kbd:`Strg-A` (Steuerung-A) bewegt den Cursor zum Anfang
der Zeile, :kbd:`Strg-E` zum Ende. :kbd:`Strg-B` bewegt ihn ein Zeichen nach
links, :kbd:`Strg-F` nach rechts. :kbd:`Strg-K` "killt" (löscht) den Rest der
Zeile rechts vom Cursor, :kbd:`Strg-Y` fügt die zuletzt gelöschten Zeichen
wieder ein ("yankt"). :kbd:`Strg-_` macht die zuletzt getätigte Änderung
rückgängig und kann wiederholt werden, um sie mehrmals auszuführen.


