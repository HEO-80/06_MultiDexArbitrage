<div align="center">

# 🧠 Multi-DEX Arbitrage — Cross-Exchange Brain

<img src="https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=csharp&logoColor=white"/>
<img src="https://img.shields.io/badge/.NET-512BD4?style=for-the-badge&logo=dotnet&logoColor=white"/>
<img src="https://img.shields.io/badge/Solidity-363636?style=for-the-badge&logo=solidity&logoColor=white"/>
<img src="https://img.shields.io/badge/Foundry-FFCB47?style=for-the-badge&logo=ethereum&logoColor=black"/>
<img src="https://img.shields.io/badge/Alchemy-363FF9?style=for-the-badge&logo=alchemy&logoColor=white"/>

**Off-chain C# controller that coordinates arbitrage across multiple DEXs**

*Gas estimation → atomic execution → receipt validation. Full transaction lifecycle management.*

**🌍 [English](#-english-version) · 🇪🇸 [Español](#-versión-en-español)**

</div>

---

## 🇪🇸 Versión en Español

### 🗼 La Analogía de la Torre de Control

> **La Torre de Control *(este código C#)*** analiza las rutas disponibles, calcula exactamente cuánto combustible requiere el viaje *(estimación de gas)* y da la orden de despegue. Una vez enviada, se queda a la escucha hasta confirmar que la operación se completó con éxito *(Status 1)* o si la misión tuvo que ser abortada *(Status 0)*.
>
> **El Avión *(el Smart Contract)*** realiza el viaje en la blockchain. Sigue las instrucciones de la torre, pero tiene la capacidad de **abortar de emergencia** si las condiciones cambian en el último milisegundo.

---

### ⚙️ Flujo de Ejecución
```
Program.cs
    │
    ├── 1. Cargar credenciales (.env)
    │       └── ALCHEMY_URL · PRIVATE_KEY · BOT_ADDRESS
    │
    ├── 2. Estimación de gas previa
    │       └── EstimateGasAsync()
    │           ├── Simula la TX en el nodo antes de emitirla
    │           └── Calcula coste computacional exacto → evita TX fallidas
    │
    ├── 3. Ejecución síncrona
    │       └── SendTransactionAndWaitForReceiptAsync()
    │           ├── Construye la transacción
    │           ├── Firma con clave privada
    │           ├── Emite a la red
    │           └── Espera hasta que el bloque es minado
    │
    └── 4. Evaluación del recibo
            ├── Status = 1 ✅ → arbitraje ejecutado con beneficio
            └── Status = 0 ❌ → contrato detectó pérdida → REVERT automático
```

---

### 🔬 Lo que diferencia esta versión

Esta es la primera versión del ecosistema con **gestión completa del ciclo de vida de la transacción**:

| Característica | Versiones anteriores | `06_MultiDexArbitrage` |
|:---|:---|:---|
| Estimación de gas | ❌ Manual / fija | ✅ `EstimateGasAsync` dinámico |
| Espera de confirmación | ❌ Fire & forget | ✅ `WaitForReceipt` síncrono |
| Validación de resultado | ❌ No | ✅ Receipt Status 0/1 |
| Protección de fondos | ❌ No | ✅ Revert automático si hay pérdida |
| Configuración | Hardcodeada | ✅ Variables `.env` |
| Smart Contract | Externo | ✅ Híbrido Solidity (Foundry) |

---

### 🛠️ Tech Stack

| Capa | Tecnología |
|:---|:---|
| Lenguaje (Off-Chain) | C# / .NET 10.0 |
| Web3 Integration | Nethereum |
| Smart Contract | Solidity (Foundry) |
| Nodo RPC | Alchemy |
| Testing | Forge (Foundry) |
| Seguridad | DotNetEnv (.env) |

---

### 🏗️ Estructura del Proyecto
```
06_MultiDexArbitrage/
├── src/                        # Contratos Solidity
├── test/                       # Tests con Forge
├── lib/                        # Dependencias Foundry
├── out/                        # Artefactos compilados
├── cache/                      # Cache de compilación
├── Program.cs                  # Controlador off-chain C#
├── .env                        # Credenciales (NO subir a Git)
├── foundry.toml                # Configuración Foundry
├── remappings.txt              # Remapeos de imports Solidity
└── README.md
```

---

### 🚀 Configuración y Ejecución

**1. Configurar variables de entorno**
```env
ALCHEMY_URL=https://eth-mainnet.g.alchemy.com/v2/TU_API_KEY
PRIVATE_KEY=TU_CLAVE_PRIVADA
BOT_ADDRESS=0x_DIRECCION_DEL_CONTRATO_DESPLEGADO
```

**2. Compilar y testear el contrato Solidity**
```bash
forge build
forge test
```

**3. Desplegar el contrato**
```bash
forge create src/TuContrato.sol:TuContrato \
  --rpc-url $ALCHEMY_URL \
  --private-key $PRIVATE_KEY
```

**4. Ejecutar el controlador C#**
```bash
dotnet run
```

**Salida esperada:**
```
[+] Estimando gas...         → 187.432 gas units
[+] Emitiendo transacción... → 0xabc123...
[+] Esperando confirmación...
[✅] Status 1 — Arbitraje ejecutado con éxito
    └── Beneficio retenido en el contrato
```
```
[+] Estimando gas...         → 201.100 gas units
[+] Emitiendo transacción... → 0xdef456...
[+] Esperando confirmación...
[❌] Status 0 — Revert activado
    └── El contrato detectó pérdida potencial → fondos protegidos
```

---

### 🔗 Posición en el Ecosistema DeFi

`06_MultiDexArbitrage` es el **cerebro multi-DEX** — fase 6 del ecosistema:

| Fase | Repo | Rol |
|:---:|:---|:---|
| 1 | `Flash_Loans` | ⚡ Contrato Solidity — lógica on-chain |
| 2 | `03_FlashLoanDriver` | 🚀 Driver local — pruebas en entorno aislado |
| 3 | `04_MarketScanner` | 📡 Radar — lee precios en tiempo real sin gas |
| 4 | `05_ArbitrageBot` | 🤖 V1 — primer disparo real de Flash Loan |
| **5** | **`06_MultiDexArbitrage`** *(este)* | **🧠 Multi-DEX — ciclo completo con validación** |
| 6 | `09_ProfitBrain` | 💰 Controlador Mainnet — gestión de riesgo |
| 7 | `10_RealPriceBrain` | 🎯 Cerebro — detecta spreads automáticamente |
| 8 | `13_SniperBot` | 🏹 Sniper — captura tokens nuevos en BSC |

---

### ⚖️ Disclaimer

Este proyecto es **exclusivamente para fines educativos e investigación DeFi**. Los autores no son responsables de pérdidas financieras ni daños derivados del uso de este software.

---

### 🧑‍💻 Autor

**Héctor Oviedo** — Backend Developer & DeFi Researcher

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/hectorob/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/HEO-80)

---
---

## 🇬🇧 English Version

### 🗼 The Air Traffic Control Analogy

> **The Control Tower *(this C# code)*** analyzes available routes, calculates exactly how much fuel the trip will require *(gas estimation)*, and gives the takeoff order. Once sent, it listens until it confirms the operation was successfully completed *(Status 1)* or if the mission had to be aborted *(Status 0)*.
>
> **The Airplane *(the Smart Contract)*** makes the journey on the blockchain. It follows the tower's instructions but has the ability to **perform an emergency abort** if conditions change at the last millisecond.

---

### ⚙️ Execution Flow
```
Program.cs
    │
    ├── 1. Load credentials (.env)
    │       └── ALCHEMY_URL · PRIVATE_KEY · BOT_ADDRESS
    │
    ├── 2. Prior gas estimation
    │       └── EstimateGasAsync()
    │           ├── Simulates TX on node before broadcasting
    │           └── Calculates exact cost → prevents failed transactions
    │
    ├── 3. Synchronous execution
    │       └── SendTransactionAndWaitForReceiptAsync()
    │           ├── Builds the transaction
    │           ├── Signs with private key
    │           ├── Broadcasts to network
    │           └── Waits until block is mined
    │
    └── 4. Receipt evaluation
            ├── Status = 1 ✅ → arbitrage executed with profit
            └── Status = 0 ❌ → contract detected loss → automatic REVERT
```

---

### 🔬 What makes this version different

First version in the ecosystem with **complete transaction lifecycle management**:

| Feature | Previous versions | `06_MultiDexArbitrage` |
|:---|:---|:---|
| Gas estimation | ❌ Manual / fixed | ✅ Dynamic `EstimateGasAsync` |
| Confirmation wait | ❌ Fire & forget | ✅ Synchronous `WaitForReceipt` |
| Result validation | ❌ No | ✅ Receipt Status 0/1 |
| Fund protection | ❌ No | ✅ Automatic revert on loss |
| Configuration | Hardcoded | ✅ `.env` variables |
| Smart Contract | External | ✅ Hybrid Solidity (Foundry) |

---

### 🚀 Setup & Execution

**1. Configure environment variables**
```env
ALCHEMY_URL=https://eth-mainnet.g.alchemy.com/v2/YOUR_API_KEY
PRIVATE_KEY=YOUR_PRIVATE_KEY
BOT_ADDRESS=0x_YOUR_DEPLOYED_CONTRACT
```

**2. Build and test the Solidity contract**
```bash
forge build
forge test
```

**3. Deploy the contract**
```bash
forge create src/YourContract.sol:YourContract \
  --rpc-url $ALCHEMY_URL \
  --private-key $PRIVATE_KEY
```

**4. Run the C# controller**
```bash
dotnet run
```

---

### 🔗 Position in the DeFi Ecosystem

| Phase | Repo | Role |
|:---:|:---|:---|
| 1 | `Flash_Loans` | ⚡ Solidity contract — on-chain logic |
| 2 | `03_FlashLoanDriver` | 🚀 Local driver — isolated testing |
| 3 | `04_MarketScanner` | 📡 Radar — reads prices in real time |
| 4 | `05_ArbitrageBot` | 🤖 V1 — first real Flash Loan trigger |
| **5** | **`06_MultiDexArbitrage`** *(this)* | **🧠 Multi-DEX — full lifecycle with validation** |
| 6 | `09_ProfitBrain` | 💰 Mainnet controller — risk management |
| 7 | `10_RealPriceBrain` | 🎯 Brain — automatic spread detection |
| 8 | `13_SniperBot` | 🏹 Sniper — captures new tokens on BSC |

---

### ⚖️ Disclaimer

This project is for **educational and DeFi research purposes only**. The authors are not responsible for financial losses or damages from using this software.

---

### 🧑‍💻 Author

**Héctor Oviedo** — Backend Developer & DeFi Researcher

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/hectorob/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/HEO-80)

---

<div align="center">
  <sub>Built with ☕ and DeFi research · <strong>Héctor Oviedo</strong> · Zaragoza, España</sub>
</div>
