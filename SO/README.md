# Operating Systems Repository

Welcome to the Operating Systems Repository! This repository covers various aspects of operating systems, including reports and implementations related to system definitions and concurrent programming.

## Contents

- `DEFTA_NFS.pdf`: Report on the definitions of the NFS distributed file system.
- `EntregaRefeicoes_SO.ipynb`: Report on the implementation of meal delivery in a concurrent programming environment.
- `RelatorioSO_ER.pdf`: Report on meal delivery with concurrent programming.
- `linksEtapa2.pdf`: Link to the presentation video for SOSim.

## EntregaRefeicoes.ipynb - Work 1: Meal Delivery in Operating Systems

The file `EntregaRefeicoes.ipynb` contains the implementation of Work 1, focusing on meal delivery in operating systems. The chosen theme is Meal Delivery, and the solution involves concurrent programming concepts.

### Problem Description

The problem is analogous to the producer-consumer problem, where employees (producers) create products, and delivery personnel (consumers) transport the products from point A to point B as soon as the bag is full.

### Implementation Details

The solution utilizes the concept of concurrent programming, involving the separation of processes within the same program using threads for optimization. Semaphores are used for controlling access to shared resources in a multitasking environment. The implementation also addresses issues such as illegal access to resources and maintaining synchronization between processes.

### Synchronization Mechanism

To control access to shared variables and ensure synchronization, semaphores are employed. The analogy of waking up the delivery person when the bag is full and putting them back to sleep when it's empty is used to represent the synchronization of processes.

Feel free to explore each file for detailed information on the respective reports and implementations.

## Contributing

If you are interested in contributing to this repository, please follow our guidelines for contributions. We welcome improvements, bug fixes, or additional content.

