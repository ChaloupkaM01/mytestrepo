# Malware

**Buffer Overflow**

checksec = nástroj pro analýzu architektury souboru (architektura, return adresa)

ropper = najde adresu registru (file NAZEV, search jmp esp)

PIE = informace o tom jestli je return adresa napevno daná (pokud není, randomizace neprobíhá)



-registry 32b architektury začínají "e", 64b začínají "r"

-zájmový registr => $eip (return registr)



**gdb FILE**

**pattern create NUMBER** (větší hodnota, způsobí přeteční)

**run**

**pattern offset $eip -> 268**



