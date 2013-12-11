#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#include "helper.h"

int main()
{
	printf("%s\n", "Hello, Client.");


	struct Question *question;
	question = get_shm_block_question(0);

	printf("Question: %s\n", question->question);


	detach_from_shm_block(question);
	return 0;
}

