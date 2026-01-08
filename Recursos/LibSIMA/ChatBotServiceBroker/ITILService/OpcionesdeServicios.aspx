<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpcionesdeServicios.aspx.cs" Inherits="SIMANET_W22R.Recursos.LibSIMA.ChatBotServiceBroker.ITILService.OpcionesdeServicios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
  
    <style>
        
.chat-container {
  width: 300px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  padding: 10px;
}

#chatbox {
  height: 300px;
  overflow-y: auto;
  border: 1px solid #ddd;
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 5px;
}

.bot-message, .user-message {
  margin: 5px 0;
  padding: 8px 10px;
  border-radius: 5px;
}

.bot-message {
  background-color: #e0f7fa;
  align-self: flex-start;
}

.user-message {
  background-color: #c8e6c9;
  align-self: flex-end;
}

#userInput {
  width: calc(100% - 60px);
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 5px;
}

#sendBtn {
  width: 50px;
  padding: 8px;
  background-color: #00796b;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

#sendBtn:hover {
  background-color: #004d40;
}
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <button id="write" type="button">Write!</button>
        <h1 id="text"></h1>



         <div class="chat-container">
            <div id="chatbox">
              <div class="bot-message">¡Hola! ¿En qué puedo ayudarte?</div>
            </div>
            <input type="text" id="userInput" placeholder="Escribe tu mensaje aquí..." />
            <button  type="button" id="sendBtn">Enviar</button>
          </div>



    </form>

    <script>
        
      


        function escribir(contenedor, writer, speed) {

            longitud = writer.length;

            cnt = document.getElementById(contenedor);
            var i = 0;
            tiempo = setInterval(function () {
                cnt.innerHTML = cnt.innerHTML.substr(0, cnt.innerHTML.length - 1) + writer.charAt(i) + " ";
                if (i >= longitud) {
                    clearInterval(tiempo);
                    cnt.innerHTML = cnt.innerHTML.substr(0, longitud);
                    return true;
                } else {
                    i++;
                }
            }, speed);
        };


       

        var texto = "Llamada oculta. Al otro lado del teléfono suena una voz muy grave, fuerte, de un hombre con un inglés de ligero acento escandinavo. Soy Lars Hedegaard, creo que querías hablar conmigo. Verse no es posible. Ni se encuentra en Copenhague ni puede dar su paradero al estar bajo protección policial. Hedegaard, historiador y periodista danés de 74 años, es un reconocido y duro crítico del islam. Le grabaron en su casa, sin previo aviso según defiende, diciendo cosas como que en las familias musulmanas.";
        $("#write").click(function () {
            escribir("text", texto, 100);
        });


    </script>


    <script>
        chatbox = document.getElementById("chatbox");
        userInput = document.getElementById("userInput");
        sendBtn = document.getElementById("sendBtn");

        // Respuestas aleatorias del chatbot
        const responses = [
            "¡Qué interesante!",
            "No estoy seguro, pero puedo investigar.",
            "¿Puedes explicarlo un poco más?",
            "¡Eso suena genial!",
            "Déjame pensarlo un momento...",
            "¡Claro que sí!",
            "No entiendo del todo, ¿puedes repetirlo?"
        ];

        // Función para agregar mensajes al chat
        function addMessage(message, sender) {
            messageDiv = document.createElement("div");
            messageDiv.classList.add(sender === "bot" ? "bot-message" : "user-message");
            messageDiv.textContent = message;
            chatbox.appendChild(messageDiv);
            chatbox.scrollTop = chatbox.scrollHeight; // Desplazar hacia abajo
        }

        // Enviar mensaje del usuario y respuesta del bot
        sendBtn.addEventListener("click", () => {
            const userMessage = userInput.value.trim();
            if (userMessage) {
                addMessage(userMessage, "user");
                userInput.value = "";

                // Respuesta aleatoria del bot
                const botResponse = responses[Math.floor(Math.random() * responses.length)];
                setTimeout(() => addMessage(botResponse, "bot"), 900);
            }
        });
    </script>

</body>
</html>
