<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Document</title>
    </head>
    <body>
        <?php
        for ($size = 6; $size < 16; ++$size) {
            $s = "Hello world";

            for ($i = 0; $i < strlen($s); ++$i) {
                if ($i % 2 === 0) {
                    echo "<span style=\"color: red; font-size: {$size}px;\">$s[$i]</span>";
                } else {
                    echo "<span style=\"color: blue; font-size: {$size}px;\">$s[$i]</span>";
                }
            }
            echo "<br>";
        }

        ?>
    </body>
</html>
