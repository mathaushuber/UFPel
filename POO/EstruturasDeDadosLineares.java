public class EstruturasDeDadosLineares {

	public static void main(String[] args) {
		   
		Nodo node1 = new Nodo (10);
	        Nodo node2 = new Nodo (11);
	        Nodo node3 = new Nodo (12);
	        Nodo node4 = new Nodo (13);
	        Nodo node5 = new Nodo (14);

	        
	        Lista lista = new Lista (5);
	        System.out.println(lista.insert(0,node1));
	        System.out.println(lista.insert(1,node2));
	        System.out.println(lista.insert(2,node3));
	        System.out.println(lista.insert(3,node4));
	        System.out.println(lista.insert(4,node5));
	    
	        //Testando a inserção de elemento em uma lista do tipo fila
	        Fila fila = new Fila (lista.getTamanho());
	        System.out.println(fila.enqueue(node1));
	        System.out.println(fila.enqueue(node2));
	        System.out.println(fila.enqueue(node3));
	        System.out.println(fila.enqueue(node4));
	        System.out.println(fila.enqueue(node5));
	        
	        System.out.println();
	        fila.printLista(); //mostrando os itens da Lista
	        System.out.println();
	        fila.dequeue();//apagando 1 item da fila 
	        fila.printLista();//mostrando a Lista novamente
	        System.out.println();
	        fila.dequeue();//apagando mais 1 item da fila
	        fila.printLista();//mostrando a Lista novamente
	        
	        
	        /*
	        Lista lista = new Lista(5);
	        System.out.println(lista.insert(0, node1));
	        System.out.println(lista.insert(1,node2));
	        System.out.println(lista.insert(2,node3));
	        System.out.println(lista.insert(3,node4));
	        System.out.println(lista.insert(4,node5));
	        
	        //Testando a inserção de elemento em uma lista do tipo fila
	        Pilha pilha = new Pilha(lista.getTamanho());
	        System.out.println(pilha.push(node1));
	        System.out.println(pilha.push(node2));
	        System.out.println(pilha.push(node3));
	        System.out.println(pilha.push(node4));
	        System.out.println(pilha.push(node5));
	        
	        System.out.println();
	        pilha.printLista(); //mostrando os itens da Lista
	        System.out.println();
	        pilha.pop();//apagando 1 item da pilha
	        pilha.printLista();//mostrando a Lista novamente
	        System.out.println();
	        pilha.pop();//apagando mais 1 item da fila
	        pilha.printLista();//mostrando a Lista novamente
	        */

	    }

}
