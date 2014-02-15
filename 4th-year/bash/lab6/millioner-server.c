/*
 * Server
 **/ 

#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <string.h>

/* Shared memory with dynamic array inside */
// http://stackoverflow.com/questions/14558443/c-shared-memory-dynamic-array-inside-shared-struct

#include "helper.h"

void wait_client(int semid);
void kick_client(int semid);

#define WAIT_CLIENT wait_client(semid);
#define KICK_CLIENT kick_client(semid);


void write_question_into_shm(struct Question *shm_question, struct Question *question);

int main()
{
	printf("== Server of \"You are a Millioner\" game started == \n\n");


	int shmid = -1;
	int semid = -1;
	int questions_array_size = -1;
	struct Question *shm_question = NULL;
	struct Question *questions[5];

	shm_question = get_shm_block_question(&shmid, IPC_CREAT | SHM_CREATE_PERMS);
	shm_question->is_user_win = 0;

	semid = get_semaphores_set(2, IPC_CREAT | IPC_EXCL | SEM_CREATE_PERMS);

	init_questions( questions, &questions_array_size );

	// need to free array
	printf("Question count: %d\n\n", questions_array_size);
	//for (int i = 0; i < questions_array_size; i++) {
		//print_question(questions[i]);
		//printf("answer: %c\n", (questions[i])->answer);
	//}

	/* init first semaphore to -1 (blocked). User should unlock it */
	WAIT_CLIENT


	int is_fail = 0;
	for (int i = 0; i < questions_array_size; ++i)
	{
		// Now, wait for connections and so on
		WAIT_CLIENT

		write_question_into_shm(shm_question, questions[i]);
		printf("Question: \n%s\n", questions[i]->question);

		KICK_CLIENT

		WAIT_CLIENT

		printf("User entered: %c\n", shm_question->user_answer[0]);

		if (shm_question->user_answer[0] == shm_question->answer) {
			printf("Correct!\n\n");
			shm_question->server_msg[0] = '+';
		}
		else {
			printf("Incorrect!\n\n");
			shm_question->server_msg[0] = '-';
			is_fail = 1;
		}

		KICK_CLIENT

		if (is_fail) {
			break;
		}

	}

	if (0 == is_fail) {
		shm_question->is_user_win = 1;
		KICK_CLIENT
	}




	sleep(1);
	detach_from_shm_block(shm_question);
	remove_shm_block(shmid);
	remove_semaphore_set(semid);

	return 0;
}



void wait_client(int semid)
{
	block_first_sem(semid);
}

void kick_client(int semid)
{
	free_first_sem(semid);
}


void write_question_into_shm(struct Question *shm_question, struct Question *question)
{
	if (NULL == shm_question || NULL == question) {
		printf("%s\n", "WTF, Bro. Sendinf NULL into write_question_into_shm()");
		exit(1);
	}

	memcpy(shm_question, question, sizeof(Question_entry));
}
