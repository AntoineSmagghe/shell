#!/bin/php
<?php
$team = [
    'Bertrand',
    'Emilie',
    'Gregory',
    'Benjamin',
    'Ricardo',
    'Antoine'
];
?>

Le facteur est: <?php echo $team[array_rand($team, 1)]; ?> 
