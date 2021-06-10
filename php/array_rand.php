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

$postman = $team[array_rand($team, 1)];
?>

Le facteur est: <?php echo $postman; ?>

