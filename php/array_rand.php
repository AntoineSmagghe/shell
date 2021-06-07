#!/bin/php
<?php
array_shift($argv);
$people = $argv[array_rand($argv, 1)];
?>

La personne désignée est: <?php echo $people; ?>

