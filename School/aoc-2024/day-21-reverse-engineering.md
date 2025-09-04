# Day 21 - Reverse Engineering

RE = proces rozebírání funkcionality programu za účelem zjištění zda obsahuje chyby nebo jestli je škodlivý

Binaries = soubory zkompilované ze zdrojového kódu (zdrojový kód se předává kompilátoru který ho přeloží na strojové instrukce)

Binaries mají ruzné struktury podle OS -> Windows - PE, Linux - ELF

Obsahují:\
-code section\
-data section\
-import export tables

Disassembling = IDA, GHIDRA, GDB -> zobrazení instrukcí binaries

Decompiling = dnSpy, ilSpy, PEStudio -> znovusestavení zdrojového kódu (občas se ztrácí něketeré informace např. jména proměnných)

V dnešní době se využívají multi-stage binaries (dropper + payload)
