// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MultiDexBot.sol";
import "openzeppelin/token/ERC20/IERC20.sol";

contract MultiDexBotTest is Test {
    MultiDexBot public bot;
    
    // Direcciones Reales de Mainnet
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant AAVE_PROVIDER = 0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e;

    function setUp() public {
        // Desplegamos el bot en la simulación
        bot = new MultiDexBot(AAVE_PROVIDER);
    }

    function testMultiDexArbitrage() public {
        // Vamos a pedir 1,000 DAI prestados
        uint256 amountToBorrow = 1000 * 1e18; 

        // --- TRUCO DE MAGIA (DEAL) ---
        // Como comprar en Uniswap y vender en Sushi HOY probablemente da pérdidas,
        // necesitamos darle fondos extra al bot para que pueda pagar la deuda y no falle.
        // Le damos 2000 DAI "gratis" para cubrir comisiones y pérdidas de prueba.
        deal(DAI, address(bot), 2000 * 1e18);

        uint256 saldoAntes = IERC20(DAI).balanceOf(address(bot));
        console.log("Saldo Inicial Bot (DAI):", saldoAntes / 1e18);

        // --- MOMENTO DE LA VERDAD ---
        // Disparamos el arbitraje: Aave -> Uniswap -> SushiSwap -> Aave
        bot.iniciarArbitraje(DAI, amountToBorrow);

        uint256 saldoDespues = IERC20(DAI).balanceOf(address(bot));
        console.log("Saldo Final Bot (DAI):", saldoDespues / 1e18);

        // Si llegamos aquí sin errores rojos, ¡EL CIRCUITO FUNCIONA!
        console.log("EXITO: El flujo circular se ha completado.");
    }
}