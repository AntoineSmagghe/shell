#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const char *team[] =
{
	"Emilie",
	"Gregory",
	"Ricardo",
	"Bertrand",
	"Antoine"
};

int random_number()
{
	srand(time(NULL));
	size_t n = sizeof(team)/sizeof(team[0]);
	return rand() % n;
}

char main() 
{
	return printf("\n\tLe facteur est: %s\n\n", team[random_number()]);
}
