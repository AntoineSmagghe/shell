#!/bin/node

const team = [
  { member: 'Emilie', weight: 75 },
  { member: 'Gregory', weight: 75 },
  { member: 'Ricardo', weight: 100 },
  { member: 'Antoine', weight: 75 },
  { member: 'Bertrand', weight: 75 },
];

const teamTMA = [
  { member: 'Emilie', weight: 75 },
  { member: 'Gregory', weight: 75 },
  { member: 'Ricardo', weight: 100 },
];

function randomSample(samples) {
  let sample =
    Math.random() * samples.reduce((sum, { weight }) => sum + weight, 0);
  const { member } = samples.find(({ weight }) => (sample -= weight) < 0);

  return member;
}

function calculateProbability(teamArr) {
  calculateArray = teamArr;
  let counts = calculateArray.map((mem) => ({[mem.member]: 0 }));
  console.log(counts);
  Array.from({ length: 1000000 }, () => randomSample(teamArr)).forEach(
    (member) => {
		//TODO: bug ici ! 
      console.log(counts.find((mem) => mem === member));
    }
  );
  return counts;
}

console.log(calculateProbability(team));

// console.log("\nFacteur : ", randomSample(team));
// console.log("TMA Vimeet : ", randomSample(teamTMA), "\n");
