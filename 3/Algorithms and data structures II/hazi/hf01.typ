1. Tömörítsd a Naiv módszerrel az alábbi szöveget ( 1 pont )
- HUMBABUMBLAKUMPALUMPABUUUUU
Továbbá add meg a
- Kódtáblát
- Kódtábla méretét
- Tömörített szöveg méretét
- A szöveg eredeti méretét

1. $ sum = {H, U, M, B, A, L, K, P} $
2. $ d = 8 $
3. $ n = 27 $
4. $ L = ceil.l log_2 d ceil.r = 3 $
5. #table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Karakter*], [*Kód*],
  ),
  [A], [000],
  [B], [001],
  [H], [010],
  [K], [011],
  [L], [100],
  [M], [101],
  [P], [110],
  [U], [111],
)
- HUMBABUMBLAKUMPALUMPABUUUUU
6. 010 111 101 001 000 001 111 101 001 100 000 011 111 101 110 000 100 111 101 110 000 001 111 111 111 111

- Tömörített szöveg mérete: $n * L = 81$ bit
- Kódtábla mérete: $d * 8 + d * 3 = 8 * 8 + 8 * 3 = 64 + 24 = 88$ bit
- Teljes tömörített méret: $81 + 88 = 169$ bit (plusz meta adatok)
- Eredeti méret: $n * 8 = 27 * 8 = 216$ bit

#pagebreak()
2. Tömörítsd a Huffman módszerrel az alábbi szöveget ( 1 pont )
- HUMBABUMBLAKUMPALUMPABUUUUU
Továbbá add meg a
- Kódfát
- Kódtáblát
- Kódtábla méretét
- Tömörített szöveg méretét
- A szöveg eredeti méretét

1. $ sum = {H, U, M, B, A, L, K, P} $
2. #table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Karakter*], [*Előfordulás*],
  ),
  [A], [4],
  [B], [4],
  [H], [1],
  [K], [1],
  [L], [2],
  [M], [4],
  [P], [2],
  [U], [9],
)
3. $ < "H",1 "  " "K",1 "  " "L",2 "  " "P",2 "  " "A",4 "  " "B",4 "  " "M",4 "  " "U",9 > $
4. $ < "HK",2 "  " "L",2 "  " "P",2 "  " "A",4 "  " "B",4 "  " "M",4 "  " "U",9 > $
5. $ < "P",2 "  " "HKL",4 "  " "A",4 "  " "B",4 "  " "M",4 "  " "U",9 > $
6. $ < "A",4 "  " "B",4 "  " "M",4 "  " "HKLP",6 "  " "U",9 > $
7. $ < "M",4 "  " "HKLP",6 "  " "AB",8 "  " "U",9 > $
8. $ < "AB",8 "  " "U",9 "  " "HKLMP",10 > $
9. $ < "HKLMP",10 "  " "ABU",17 > $
10. $ < "ABHKLMPU",27 > $
11. #table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Karakter*], [*Kód*], [*Előfordulás*]
  ),
  [A], [100], [4],
  [B], [101], [4],
  [H], [00000], [1],
  [K], [00001], [1],
  [L], [0001], [2],
  [M], [01], [4],
  [P], [001], [2],
  [U], [11], [9],
)

- 00000 11 01 101 100 101 11 01 101 0001 0001 100 00001 11 01 001 100 0001 11 01 001 100 101 11 11 11 11 11
- Tömörített szöveg mérete: $4*3+4*3+5*1+5*1+4*2+2*4+3*2+2*9 = 74$ bit
- Kódtábla mérete: $8*8+3+3+5+5+4+2+3+2 = 91$ bit (plusz meta adatok)
- Teljes tömörített méret: $74 + 91 = 165$ bit (plusz meta adatok)
- Eredeti méret: $27*8 = 216$ bit
