#ifndef _MILLIONER_GAME_
#define _MILLIONER_GAME_	1

#define SHM_QUESTIONS_FILE "questions.txt"

#define SIZE_1K 1024
#define QUESTION_FIELD_SIZE SIZE_1K


/**** S H A R E D  M E M O R Y *****/

struct Question {
	char question[ QUESTION_FIELD_SIZE ];

	/* possible answers */
	char a[ QUESTION_FIELD_SIZE ];
	char b[ QUESTION_FIELD_SIZE ];
	char c[ QUESTION_FIELD_SIZE ];
	char d[ QUESTION_FIELD_SIZE ];
	char answer;    /* correct one */
} Question_entry ;


struct Question *get_shm_block_question();

void detach_from_shm_block(void *shmaddr);



/****** S E M A P H O R E S *******/

union semun {
	int val;
	struct semid_ds *buf;
	unsigned short *array;
};














#endif /* helper.h */
