#!/bin/php
<?php
$team = [
    'Bertrand',
    'Emilie',
    'Gregory',
    'Ricardo',
    'Antoine'
];
?>

Le facteur est: <?php echo $team[array_rand($team, 1)]; ?> 
