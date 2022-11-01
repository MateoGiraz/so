#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>


sem_t p, q, s, t, u, v;

void *a(void *x)
{
	printf("A\n");
	sem_post(&p);
	sem_post(&q);
}

void *b(void *x)
{
	sem_wait(&p);
	srand(time(NULL));
	sleep(1 + (rand() % 4));
	printf("B\n");
}

void *c(void *x)
{
	sem_wait(&q);
	srand(time(NULL));
	sleep(1 + (rand() % 4));
	printf("C\n");
	sem_post(&s);
	sem_post(&t);
}

void *d(void *x)
{
	sem_wait(&s);
	srand(time(NULL));
    sleep(1 + (rand() % 4));
	printf("D\n");
	sem_post(&u);
}

void *e(void *x)
{
	sem_wait(&t);
	srand(time(NULL));
    sleep(1 + (rand() % 4));
	printf("E\n");
	sem_post(&v);
}

void *f(void *x)
{
	sem_wait(&v);
	sem_wait(&u);
	printf("F\n");
}

int main()
{
	sem_init(&p, 0, 0);
	sem_init(&q, 0, 0);
	sem_init(&s, 0, 0);
	sem_init(&t, 0, 0);
	sem_init(&u, 0, 0);
	sem_init(&v, 0, 0);

	pthread_t ta, tb, tc, td, te, tf;
	pthread_attr_t attr;
	pthread_attr_init(&attr);

	pthread_create(&ta, &attr, a, NULL);
	pthread_create(&tb, &attr, b, NULL);
	pthread_create(&tc, &attr, c, NULL);
	pthread_create(&td, &attr, d, NULL);
	pthread_create(&te, &attr, e, NULL);
	pthread_create(&tf, &attr, f, NULL);

	pthread_join(ta, NULL);
	pthread_join(tb, NULL);
	pthread_join(tc, NULL);
	pthread_join(td, NULL);
	pthread_join(te, NULL);
	pthread_join(tf, NULL);

	sem_destroy(&p);
	sem_destroy(&q);
	sem_destroy(&s);
	sem_destroy(&t);
	sem_destroy(&u);
	sem_destroy(&v);

	return 0;
}
