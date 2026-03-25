<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Document</title>
    </head>
    <body>
        <?php
        $t = [9, -5, 7, 0, 2, -4, 6];

        $negatives = array_filter($t, fn($n) => $n < 0);
        echo implode(", ", $negatives) . "<br>";

        $squares = array_map(fn($n) => $n = $n * $n, $t);
        echo implode(", ", $squares) . "<br>";

        $evens = array_filter($t, fn($n) => !($n & 1));
        echo count($evens) . "<br>";

        echo min($t) . "<br>";

        echo array_sum($t) . "<br>";

        $primes = array_filter($t, fn($n) => gmp_prob_prime($n));
        echo implode(", ", $primes) . "<br>";
        ?>
    </body>
</html>
