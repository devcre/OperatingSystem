#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#define MAX_LEN 100 /* The maximum length command */

int main(void) {
	char *args[MAX_LEN / 2 + 1]; /* command line arguments */
	int should_run = 1;          /* flag to determine when to exit program */
	int background = 0;

	char *input;
	int status;
	int retval;
	int i;

	while (should_run) {
		printf("my_shell> ");
		fflush(stdout);

		input = (char*)malloc(MAX_LEN*sizeof(char));
		fgets(input, MAX_LEN, stdin);

		i = 0;
		args[i] = strtok(input, " \n");
		while (args[i] != NULL) {
	 		i++;
	  		args[i] = strtok(NULL, " \n");
		}

		if (args[0] == NULL){
			goto no_input;
		}

		if (strcmp(input, "exit") == 0) {
			break;
		}

		if (strcmp(args[i-1], "&") == 0) {
			args[i - 1] = '\0';
			background = 1; //activate flag
		}
		// printf("-----%s\n", input);
		// printf("-----%s\n",args[0]);

		pid_t pid = fork();
		if (pid < 0) {
			perror("Fork error");
			exit(0);
		}

		if (pid == 0) { // child process
			execvp(args[0], args);
		}

		if (pid > 0) {
			if (!background) { //background flag is not 1
				// wait until child process terminates
				retval = waitpid(pid, &status, 0);
				if(retval > 0){
					if(WIFEXITED(status)){
						printf("Child exited by process completeion: %d\n", WEXITSTATUS(status));
					}
					if(WIFSIGNALED(status)){
						printf("Child exited by signal: %d\n", WTERMSIG(status));
					}	
				}
				else{
					printf("Unexpected error.\n");
					exit(0);		
				}
			}
			else{
				printf("Background process.\n");
				background = 0;
		 	}
		}
		no_input:;
	}
	free(input);

	return 0;
}
