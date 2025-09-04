# Day 12 - Race Conditions vuln

**Web timing attack** = spočívá v analýze doby odpovědi serveru

**Race condition attack** = podmnožina WTA &#x20;

Odpověď trvá z pravidla 1300ms až 5ns



**HTTP/2**\
**-**&#x76;elký update HTTP/1.1\
-hlavní změna "single packet, multi request/response" (SPMR)\
-v 1.1 nebylo jasné zda je rozdílný čas mezi odpovědmi způsoben zranitelností nebo latencí\
-pomocí nové SPMR toto odpadá, jelikož mezi responsy není latence\
\
**Druhy časových útoků**

Information disclosures = např. enumerace uživatelských jmen

Race conditions = záleží jak webová aplikace zpracovává requesty (např. při použití slevového kódu rychle po sobě lze sleva aplikovat vícekrát)

\
Postup:

1. Odchycení zájmového paketu s akcí kterou chceme provést vícekrát (musí reálně projít)
2. Přeposlání do repeateru
3. Naduplikování x-krát
4. Vytvoření skupiny
5. Odeslání celé skupiny najednou (last byte sync)

Ochrana:

1. Provádění akce v jako celek (ne 2 separátní operace v databázi)
2. Implemetace Mutex (zajištění toho že pouze jedno vlákno přistupuje ke zdroji)
3. Implementace limitů



