## Foundry

Contrato de GetDonation
El contrato GetDonation está diseñado para facilitar la recepción y gestión de donaciones. A continuación, se incluye una descripción general de sus componentes y funcionalidades clave.

Componentes clave

1. Gestión del propietario
   El contrato tiene un propietario , que es una dirección de pago establecida en la dirección del implementador al momento de la creación del contrato.
   El onlyOwnermodificador garantiza que ciertas funciones sólo puedan ser ejecutadas por el propietario del contrato.
2. Eventos
   TipReceived:Se emite cuando se recibe una donación (propina), incluyendo la dirección del remitente y el monto enviado.
   OwnerShipTransfered:Se emite cuando la propiedad del contrato se transfiere del propietario anterior a un nuevo propietario.
   WithDrawn:Se emite cuando el propietario retira fondos del contrato.
3. Donaciones
   La tipfunción permite que cualquier persona envíe ETH al contrato como donación. Esta función:
   Asegura que la cantidad enviada sea mayor a 0.
   Emite el TipReceivedevento cuando se recibe la donación.
4. Retiros
   La withDrawfunción permite al titular retirar el saldo total del contrato. Esta función:
   Asegurarse de que haya fondos disponibles.
   Verifica que la transferencia de fondos sea exitosa.
   Emite el WithDrawnevento una vez que se retiran los fondos.
5. Transferencia de propiedad
   La transferOwnerShipfunción permite al propietario actual transferir la propiedad a una nueva dirección. Esta función:
   Asegura que la dirección del nuevo propietario sea válida y diferente de la actual.
   Emite el OwnerShipTransferedevento al transferir la propiedad.
6. Consultas de saldo
   getContractBalance:Devuelve el saldo actual del contrato.
   getOwnerBalance:Devuelve el saldo actual de la dirección del propietario.
7. Función de reserva
   La receivefunción permite que el contrato reciba ETH directamente y emite el TipReceivedevento cuando esto sucede.
   Uso
   Donando
   Cualquiera puede realizar una donación al contrato mediante la tipfunción. La donación debe ser mayor a 0 ETH.

Retirar fondos
Sólo el propietario puede retirar los fondos acumulados en el contrato utilizando la withDrawfunción.

Transferencia de propiedad
El propietario puede transferir la propiedad del contrato a una nueva dirección utilizando la transferOwnerShipfunción.
