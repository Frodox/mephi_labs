/*
 * Client
 **/
#include <stdio.h>
#include <stdlib.h>

#include "helper.h"


#define WAIT_SERVER wait_server(semid);
#define KICK_SERVER kick_server(semid);

void wait_server(int semid);
void kick_server(int semid);

char *getline(void);
char get_answer_char();


int main()
{
	printf("\n= Добро пожаловать в игру \"Кто хочеть стать миллионером\"! =\n\n");

	int shmid = -1;
	int semid = -1;
	struct Question *shm_question = NULL;

	printf("Connecting to the server...\n");
	shm_question = get_shm_block_question(&shmid, 0);
	semid = get_semaphores_set(SEM_IN_SET_COUNT, 0);

	sleep(1);

	KICK_SERVER

	printf("Connected!\n");
	printf("Waiting first question from server...\n");

	int is_end = 0;
	for (;;)
	{
		WAIT_SERVER

		if (1 == shm_question->is_user_win) {
			printf("\n = You win! = \n\n");
			is_end = 1;
			goto out;
		}


		// clear screen
		printf("\033[2J\033[1;1H");

		print_question(shm_question);
		printf("\n");

		char c = get_answer_char();

		// send to server
		shm_question->user_answer[0] = c;

		KICK_SERVER

		WAIT_SERVER

		//printf("Server answer: %c\n", shm_question->server_msg[0]);
		switch (shm_question->server_msg[0])
		{
			case '+':
				printf("Правильно!\n");
				break;
			case '-':
				printf("К сожалению, Вы проиграли :(\n");
				is_end = 1;
				break;
			case '*':
				printf("Мои поздравления! Вы выиграли! :)\n");
				is_end = 1;
				break;
			default:
				printf("Ууупс! Что-то пошло не так!\n");
		}

		KICK_SERVER

		out:
		if (is_end)
		{
			break;
		}
	}

	detach_from_shm_block(shm_question);

	return 0;
}



void wait_server(int semid)
{
	block_first_sem(semid);
}

void kick_server(int semid)
{
	free_first_sem(semid);
}



char get_answer_char()
{
	char res = 0;
	char *input_line;
	int incorrect_answer = 1;

	while (incorrect_answer)
	{
		printf("Ваш выбор: ");
		input_line = getline();
		if (NULL == input_line) {
			printf("%s\n", "wtf, NULL from getline()");
			exit(1);
		}

		res = *input_line;
		free(input_line);

		switch (res)
		{
			case 'a':
			case 'b':
			case 'c':
			case 'd':
				// correct letter
				incorrect_answer = 0;
				break;
			default:
				printf("А ну хватит валять дурака! Вводите корректный ответ!\n");
		}
	}

	return res;
}


char *getline(void)
{
// http://stackoverflow.com/questions/314401/how-to-read-a-line-from-the-console-in-c
    char *line = malloc(100), *linep = line;
    size_t lenmax = 100, len = lenmax;
    int c;

    if (line == NULL)
        return NULL;

    for(;;) {
        c = fgetc(stdin);
        if (c == EOF)
            break;

        if (--len == 0) {
            len = lenmax;
            char * linen = realloc(linep, lenmax *= 2);

            if (linen == NULL) {
                free(linep);
                return NULL;
            }
            line = linen + (line - linep);
            linep = linen;
        }

        if ((*line++ = c) == '\n')
            break;
    }
    *line = '\0';

    return linep;
}


