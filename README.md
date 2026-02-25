# 🧠 Multi-Dex Brain (C# Backend)

Este repositorio contiene el controlador *off-chain* desarrollado en C# (.NET) diseñado para coordinar y ejecutar operaciones de arbitraje a través de múltiples exchanges descentralizados (Multi-Dex).

## 🛠️ Especificaciones Técnicas

La aplicación es un cliente de consola construido en .NET que utiliza la librería `Nethereum` para gestionar el ciclo de vida completo de una transacción en la blockchain.

El flujo de ejecución principal (`Program.cs`) implementa las siguientes operaciones de red:
1.  **Estimación de Gas Previa:** Utiliza el método `EstimateGasAsync` para simular la transacción en el nodo local antes de emitirla. Esto permite calcular el coste computacional exacto requerido y evitar transacciones fallidas por falta de límite de gas.
2.  **Ejecución Síncrona:** Emplea `SendTransactionAndWaitForReceiptAsync` para construir, firmar, emitir la transacción a la red y pausar la ejecución del programa local hasta que el bloque es minado y la red devuelve un recibo de confirmación.
3.  **Evaluación de Estado (Receipt Status):** Analiza el valor booleano del recibo (`receipt.Status.Value`). 
    * Un valor de `1` activa el bloque de éxito, confirmando que el arbitraje se ejecutó y generó ganancias.
    * Un valor de `0` activa el bloque de fallo (revert), indicando que el Smart Contract detectó una pérdida potencial y canceló la operación para proteger los fondos.

---

## 🏎️ Arquitectura Conceptual

Para visualizar la interacción entre este código C# y la blockchain, utilizaremos la analogía de una torre de control aéreo:

* **La Torre de Control (Este código C#):** Analiza las rutas disponibles, calcula exactamente cuánto combustible requerirá el viaje (Estimación de Gas) y da la orden de despegue. Una vez enviada la orden, se queda a la escucha en la radio hasta confirmar que la operación se completó con éxito (Status 1) o si la misión tuvo que ser abortada (Status 0).
* **El Avión (El Smart Contract):** Es la entidad física que realiza el viaje en la blockchain. Sigue las instrucciones de la torre, pero tiene la capacidad de abortar el aterrizaje de emergencia si las condiciones de la pista (los precios de los tokens) cambian en el último milisegundo.

## 🚀 Configuración y Ejecución

Para iniciar el controlador, asegúrate de tener las credenciales configuradas.

1.  Crea un archivo llamado `.env` en la raíz de este proyecto:
    ```ini
    ALCHEMY_URL=https://...
    PRIVATE_KEY=...
    BOT_ADDRESS=...
    ```
2.  Abre la terminal en la carpeta del proyecto y compila/ejecuta el programa:
    ```bash
    dotnet run
    ```

---
---

# 🧠 Multi-Dex Brain (C# Backend) [EN]

This repository contains the *off-chain* controller developed in C# (.NET) designed to coordinate and execute arbitrage operations across multiple decentralized exchanges (Multi-Dex).

## 🛠️ Technical Specifications

The application is a .NET console client utilizing the `Nethereum` library to manage the complete lifecycle of a blockchain transaction.

The main execution flow (`Program.cs`) implements the following network operations:
1.  **Prior Gas Estimation:** Uses the `EstimateGasAsync` method to simulate the transaction on the local node before broadcasting it. This calculates the exact computational cost required and prevents failed transactions due to an insufficient gas limit.
2.  **Synchronous Execution:** Employs `SendTransactionAndWaitForReceiptAsync` to build, sign, broadcast the transaction to the network, and pause the local program execution until the block is mined and the network returns a confirmation receipt.
3.  **State Evaluation (Receipt Status):** Analyzes the boolean value of the receipt (`receipt.Status.Value`). 
    * A value of `1` triggers the success block, confirming the arbitrage was executed and generated profit.
    * A value of `0` triggers the failure block (revert), indicating the Smart Contract detected a potential loss and canceled the operation to protect the funds.

---

## 🏎️ Conceptual Architecture

To visualize the interaction between this C# code and the blockchain, we use the analogy of an air traffic control tower:

* **The Control Tower (This C# code):** It analyzes the available routes, calculates exactly how much fuel the trip will require (Gas Estimation), and gives the takeoff order. Once the order is sent, it listens on the radio until it confirms that the operation was successfully completed (Status 1) or if the mission had to be aborted (Status 0).
* **The Airplane (The Smart Contract):** It is the physical entity making the journey on the blockchain. It follows the tower's instructions but has the ability to perform an emergency abort if runway conditions (token prices) change at the last millisecond.

## 🚀 Setup & Execution

To start the controller, ensure your credentials are set up.

1.  Create a `.env` file in the root of this project:
    ```ini
    ALCHEMY_URL=https://...
    PRIVATE_KEY=...
    BOT_ADDRESS=...
    ```
2.  Open the terminal in the project folder and build/run the program:
    ```bash
    dotnet run
    ```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
