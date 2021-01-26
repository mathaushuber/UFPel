#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct agenda celula;

struct agenda{
    char word[100];
    int num;
    celula *next;
};

celula *apaga(celula *head);
void insere(celula *head);
celula *cria();
void imprime(celula *head);

int qnt = 0;

int main(){
    celula *head = cria();
    head->next = NULL;
    celula *apaga_registro;
    int *escolha;
    char *lixo;
    escolha = malloc(sizeof(int));
    lixo = malloc(sizeof(char)*30);
    do{
        printf("---------AGENDA---------");
        printf("\n\t .1 Inserir");
        printf("\n\t .2 Apagar");
        printf("\n\t .3 Listar");
        printf("\n\t .4 Sair");
        printf("\n\t Digite sua escolha: ");
        scanf("%d", &(*escolha));
        switch(*escolha){
            case 1:
            qnt++;
            fgets(lixo, 30, stdin);
            insere(head);
            break;
            case 2:
            if((apaga_registro = apaga(head))){
                free(apaga_registro);
            }
            break;
            case 3:
            imprime(head);
            break;
            case 4:
            exit(0);
            break;
            default:
            printf("Opção inválida, tente novamente!");
            break;
        }
    }while(*escolha != EOF);
    free(head);
    return 0;
}

void insere(celula *head){
    char *word;
    int *num;
    word = malloc(sizeof(char) * 50);
    num = malloc(sizeof(int));
    celula *nova = malloc(sizeof(celula));
    printf("Nome: ");
    fgets(word, 50, stdin);
    printf("Nº de contato: ");
    scanf("%d", &(*num));
    strcpy(nova->word, word);
    nova->num = *num;
    nova->next = head->next;
    head->next = nova;
}

celula *apaga(celula *head){
    if(head->next == NULL){
        printf("Agenda vazia!");
    }
    celula *remove;
    while (head->next != NULL)
    {
        remove = head->next;
        head->next = remove->next;
    }
    return remove;   
}

celula *cria(){
    celula *nova = realloc(NULL, sizeof(celula));
    nova->next = NULL;
    return nova;
}

void imprime(celula *head){
  if(head->next == NULL){
	printf("Agenda vazia!");
	}
	celula *printer = head->next;
	while(printer != NULL){
		printf("(Contato %d)\n", qnt);
		printf("%s", printer->word);
		printf("%d", printer->num);
		printer = printer->next;
		printf("\n");
	}
}
