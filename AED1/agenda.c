/*Faça uma agenda capaz de incluir, apagar, buscar
e listar quantas pessoas o usuário desejar, porém,
você não pode usar variáveis a não ser ponteiros.
Toda a informação deve ser guardada num “void
*pBuffer”.*/

/*pBuffer deve guardar desde as pessoas colocadas
na agenda até as variáveis locais que você precisa
para controlar um for, por exemplo.*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct agenda{
    char word[100];
    int num;
};

void insere(struct agenda *cad);
void apaga(struct agenda *cad);
void busca(struct agenda *cad);
void imprime(struct agenda *cad);

void *pBuffer = NULL;
int *cont, *escolha, *qnt_pessoas;

int main(){
    struct agenda *cad;
    pBuffer = malloc(sizeof(int) * 3);
    cont = (int *) pBuffer;
    escolha = cont + 1;
    qnt_pessoas = escolha + 1;
    escolha = 1;
    cont = 0;
    do{
        printf("---------Menu---------");
        printf("\n\t1. Inserir");
        printf("\n\t2. Apagar");
        printf("\n\t3. Buscar");
        printf("\n\t4. Listar");
        printf("\n\t5. Sair");
        printf("\n\t Digite sua escolha: ");
        scanf("%d", &(*escolha));
        switch(*escolha){
        case 1:
            insere(cad);
            break;
        case 2:
            apaga(cad);
            break;
        case 3:
            busca(cad);
            break;
        case 4:
            imprime(cad);
            break;
        case 5:
            exit(0);
            break;
        default:
            printf("Opção inválida");
            break;
        }
    }while(escolha != EOF);
    free(pBuffer);
    return 0;
}

void insere(struct agenda *cad){
    cad = (struct agenda *) qnt_pessoas + (*qnt_pessoas);
    pBuffer = realloc(pBuffer, sizeof(int) * 3 + sizeof(struct agenda) * (*qnt_pessoas) + 100);
    cont = (int *) pBuffer;
    escolha = cont + 1;
    qnt_pessoas = escolha + 1;
    printf("Nome: ");
    fgets(cad->word, 100, stdin);
    printf("Contato: ");
    scanf("%d", &(cad->num));
    (*qnt_pessoas)++;
}

void apaga(struct agenda *cad){
    char *aux;
    aux = realloc(NULL, sizeof(char)* 100);
    printf("Digite o nome da pessoa que deseja apagar da agenda: ");
    fgets(aux, 100, stdin);
    cad = (struct agenda *) qnt_pessoas + 1;
    for((*cont) = 0; (*cont) < (*qnt_pessoas); (*cont)++, cad++){
        if(strcmp(cad->word, aux) == 0){
            for(*escolha = *cont; *escolha < ((*qnt_pessoas)-1); (*escolha)++){
                *cad = *(cad+1);
                cad++;
            }
            (*qnt_pessoas)--;
            pBuffer = realloc(pBuffer, (sizeof(int)) * 3 + (sizeof(struct agenda)) * (*qnt_pessoas) + 100);
            return;
        }
        else{
            printf("O nome requerido não se encontra dentro da agenda, por favor tente novamente!");
        }
    } 
}

void busca(struct agenda *cad){
    char *aux;
    aux = realloc(NULL, sizeof(char)* 100);
    printf("Digite o nome da pessoa que deseja procurar na agenda: ");
    fgets(aux, 100, stdin);
    cad = (struct agenda *) qnt_pessoas + 1;
    for(*cont = 0; *cont < *qnt_pessoas; (*cont)++, cad++){
        if(strcmp(cad->word, aux) == 0){
            printf("Pessoa encontrada");
            printf("\n %s", cad->word);
            printf("\n %d", cad->num);
            return;
        }
        else{
            printf("O nome requerido não se encontra dentro da agenda, por favor tente novamente!");
        }
    }
}

void imprime(struct agenda *cad){
    cad = (struct agenda *) qnt_pessoas + 1;
    if(*qnt_pessoas == 0){
        printf("Agenda vazia!");
        return;
    }
    for(*cont = 0; *cont < *qnt_pessoas; (*cont)++){
        printf("%s", cad->word);
        printf("%d", cad->num);
        cad++;
    }
}






