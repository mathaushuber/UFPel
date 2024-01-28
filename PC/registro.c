#include <stdio.h>
#include <stdlib.h>

struct Aluno {
    int matricula;
    char nome[50];
    int anoNascimento;
};

int main() {
    int numAlunos;

    printf("Digite o número de alunos: ");
    scanf("%d", &numAlunos);

    struct Aluno *alunos = (struct Aluno *)malloc(numAlunos * sizeof(struct Aluno));

    for (int i = 0; i < numAlunos; i++) {
        printf("\nAluno %d:\n", i + 1);
        printf("Matrícula: ");
        scanf("%d", &alunos[i].matricula);
        printf("Nome: ");
        scanf("%s", alunos[i].nome);
        printf("Ano de Nascimento: ");
        scanf("%d", &alunos[i].anoNascimento);
    }

    printf("\nDados Armazenados:\n");
    for (int i = 0; i < numAlunos; i++) {
        printf("Aluno %d:\n", i + 1);
        printf("Matrícula: %d\n", alunos[i].matricula);
        printf("Nome: %s\n", alunos[i].nome);
        printf("Ano de Nascimento: %d\n", alunos[i].anoNascimento);
    }

    free(alunos);

    return 0;
}
