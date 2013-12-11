#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <string.h>
//#include <sys/types.h>
//#include <errno.h>
// http://stackoverflow.com/questions/14558443/c-shared-memory-dynamic-array-inside-shared-struct
// http://stackoverflow.com/questions/8019942/shared-memory-for-sharing-an-array-of-the-same-structure

// dynamic array
// http://stackoverflow.com/questions/3536153/c-dynamically-growing-array
// http://happybearsoftware.com/implementing-a-dynamic-array.html

#include "helper.h"

int main()
{
	printf("%s\n", "Hello. It's Server.");

	struct Question *question;
	question = get_shm_block_question(IPC_CREAT | 0644);


	char *str = "Привет Привет Ghbdtn!";
	strcpy(question->question, str);


	detach_from_shm_block(question);
	return 0;
}
