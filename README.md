# IDS - Databázové systémy

## 1. část - SQL skript pro vytvoření objektů schématu databáze
- SQL skript vytvářející základní objekty schématu databáze, jako jsou tabulky vč. definice integritních omezení (zejména primárních a cizích klíčů), a naplňující vytvořené tabulky ukázkovými daty. Vytvořené schéma databáze musí odpovídat datovému modelu z předchozí části projektu a musí splňovat požadavky uvedené v následujících bodech (je samozřejmě vhodné opravit chyby a nedostatky, které se v ER diagramu objevily, popř. provést dílčí změny vedoucí ke kvalitnějšímu řešení).
- V tabulkách databázového schématu musí být alespoň jeden sloupec se speciálním omezením hodnot, např. rodné číslo či evidenční číslo pojištěnce (RČ), identifikační číslo osoby/podnikatelského subjektu (IČ), identifikační číslo lékařského pracoviště (IČPE), ISBN či ISSN, číslo bankovního účtu (vizte také tajemství čísla účtu), atp. Databáze musí v tomto sloupci povolit pouze platné hodnoty (implementujte pomocí CHECK integritního omezení).
- V tabulkách databázového schématu musí být vhodná realizace vztahu generalizace/specializace určená pro čistě relační databázi, tedy musí být vhodně převeden uvedený vztah a související entity datového modelu do schéma relační databáze. Zvolený způsob převodu generalizace/specializace do schéma relační databáze musí být popsán a zdůvodněn v dokumentaci.
- Skript také musí obsahovat automatické generování hodnot primárního klíče nějaké tabulky ze sekvence (např. pokud bude při vkládání záznamů do dané tabulky hodnota primárního klíče nedefinována, tj. NULL).

## 2. část - SQL skript s dotazy SELECT
- SQL skript, který nejprve vytvoří základní objekty schéma databáze a naplní tabulky ukázkovými daty (stejně jako skript v bodě 2) a poté provede několik dotazů SELECT.
- Konkrétně musí tento skript obsahovat alespoň dva dotazy využívající spojení dvou tabulek, jeden využívající spojení tří tabulek, dva dotazy s klauzulí GROUP BY a agregační funkcí, jeden dotaz obsahující predikát EXISTS a jeden dotaz s predikátem IN s vnořeným selectem (nikoliv IN s množinou konstantních dat). U každého z dotazů musí být (v komentáři SQL kódu) popsáno srozumitelně, jaká data hledá daný dotaz (jaká je jeho funkce v aplikaci).

## 4. část - SQL skript pro vytvoření pokročilých objektů schématu databáze
- SQL skript, který nejprve vytvoří základní objekty schéma databáze a naplní tabulky ukázkovými daty (stejně jako skript v bodě 2), a poté zadefinuje či vytvoří pokročilá omezení či objekty databáze dle upřesňujících požadavků zadání. Dále skript bude obsahovat ukázkové příkazy manipulace dat a dotazy demonstrující použití výše zmiňovaných omezení a objektů tohoto skriptu (např. pro demonstraci použití indexů zavolá nejprve skript EXPLAIN PLAN na dotaz bez indexu, poté vytvoří index, a nakonec zavolá EXPLAIN PLAN na dotaz s indexem; pro demostranci databázového triggeru se provede manipulace s daty, která vyvolá daný trigger; atp.).
- Tento SQL skript musí konkrétně obsahovat vše z následujících
>- vytvoření alespoň dvou netriviálních databázových triggerů vč. jejich předvedení,
>- vytvoření alespoň dvou netriviálních uložených procedur vč. jejich předvedení, ve kterých se musí (dohromady) vyskytovat alespoň jednou kurzor, ošetření výjimek a >- použití proměnné s datovým typem odkazujícím se na řádek či typ sloupce tabulky (table_name.column_name%TYPE nebo table_name%ROWTYPE),
>- explicitní vytvoření alespoň jednoho indexu tak, aby pomohl optimalizovat zpracování dotazů, přičemž musí být uveden také příslušný dotaz, na který má index vliv, a v dokumentaci popsán způsob využití indexu v tomto dotazy (toto lze zkombinovat s EXPLAIN PLAN, vizte dále),
>- alespoň jedno použití EXPLAIN PLAN pro výpis plánu provedení databazového dotazu se spojením alespoň dvou tabulek, agregační funkcí a klauzulí GROUP BY, přičemž v dokumentaci musí být srozumitelně popsáno, jak proběhne dle toho výpisu plánu provedení dotazu, vč. objasnění použitých prostředků pro jeho urychlení (např. použití indexu, druhu spojení, atp.), a dále musí být navrnut způsob, jak konkrétně by bylo možné dotaz dále urychlit (např. zavedením nového indexu), navržený způsob proveden (např. vytvořen index), zopakován EXPLAIN PLAN a jeho výsledek porovnán s výsledkem před provedením navrženého způsobu urychlení,
>- definici přístupových práv k databázovým objektům pro druhého člena týmu,
>- vytvořen alespoň jeden materializovaný pohled patřící druhému členu týmu a používající tabulky definované prvním členem týmu (nutno mít již definována přístupová práva), vč. SQL příkazů/dotazů ukazujících, jak materializovaný pohled funguje,
- Řešení projektu může volitelně obsahovat také další prvky neuvedené explicitně v předchozích bodech či větší počet nebo složitost prvků uvedených. Takové řešení pak může být považováno za nadstandardní řešení a oceněno dalšími body. Příkladem nadstandardního řešení může být řešení obsahující
>- klientskou aplikaci realizovánou v libovolném programovacím jazyce, přičemž práce s aplikací odpovídá případům užití uvedených v řešení 1. části projektu – tedy aplikace by neměla pouze zobrazovat obecným způsobem tabulky s daty a nabízet možnost vkládání nových či úpravy a mazání původních dát, ale měla by odpovídat pracovním postupům uživatelů (např. knihovník po příchodu čtenáře žádá ID průkazky čtenáře, systém vypíše existující výpůjčky čtenáře s vyznačením případných pokut, knihovník má možnost označit jednolivé výpůjčky jako právě vrácené, případně inkasovat pokuty spojené s výpůjčkami, či přidat nové výpůjčky daného čtenáře),
>- SQL dotazy a příkazy ukazující transakční zpracování, vč. jejich popisu a vysvětlení v dokumentaci – např. ukázka atomicity transakcí při souběžném přístupu více uživatelů/spojení k jedněm datům, ukázka zamykání, atp.


# Téma
J&E (Join and enjoy) je nová společnost, která se rozhodla pomoct všem, kteří
rádi cestují, ale nemají s kým. Informační systém J&E by tak měl poskytovat
přehled o nabízených spolujízdách, nabídkách na společné výlety a zkušenosti
uživatelů. Každý uživatel může jak nabízet, tak se i nějaké spolujízdy účastnit.
Systém umožnuje uživateli vkládat plánované jízdy, včetně informací o čase
výjezdu, autě, kterým pojede, nástupním a výstupním místě, ceně, případné
možné zajížďce, časové flexibilitě a možnostech zavazadla. Uživatel samozřejmě
může vlastnit i více aut. K snadnému výběru toho správného řidiče poslouží
uživatelům následující informace - základní informace o řidiči, e-mailová adresa,
telefonní číslo, pár vět o něm, profilová fotka, hodnocení od ostatních uživatelů
včetně počtu hvězdiček, zda má rád hudbu, zda mu nevadí kouření nebo zvířata,
jestli si s ním dobře popovídáte a jak moc je zkušený. Zkušenost řidiče se
odvozuje od počtu jízd, které nabídl. Sám řidič může hodnotit, jak byl spokojený
se spolucestujícími a zda byli dochvilní a přátelští. Aby řidič maximálně využil
poptávky, může cestovat na různých úsecích cesty s jinými lidmi. Jednotlivé
zastávky, na kterých se můžou ostatní uživatelé připojit, jsou rovněž uvedeny v
systému. 30 minut před odjezdem obdrží každý přihlášený uživatel spolujízdy
SMS zprávu jako upomínku, aby na jízdu nezmeškal. IS J&E navíc nabízí možnost
společných výletů. Pokud rádi cestujete, máte spoustu nápadů a inspirace, pak
můžete naplánovat výlet včetně popisu plánovaného programu, možnosti
ubytování, předpokládaných nákladů na výdaje mimo jízdné, možných aktivit,
míst, které hodláte navštívit, náročnost a předpokládané nároky na vybavení
(stan, pohorky, surf, .). Z výletu pak jednotliví účastníci můžou vytvořit vlog nebo
sepsat článek, aby k podobné cestě inspirovali i ostatní. Vlog stejně jako článek
bude mít obsah (popis) a oprávnění (veřejný, sdílený mezi účastníky nebo
soukromý).
