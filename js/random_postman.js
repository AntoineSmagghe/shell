#!/bin/node
const team = [
	"Ricardo",
	"Gregory",
	"Emilie",
	"Bertrand",
	"Antoine"
];

const randomIndex = Math.round(Math.random() * (team.length - 1));

console.log("Le facteur est :", team[randomIndex]);
