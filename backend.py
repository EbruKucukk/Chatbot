import json
from pathlib import Path
from flask import Flask, request, jsonify
from flask_cors import CORS
import asyncio
from re_edge_gpt import Chatbot, ConversationStyle

app = Flask(__name__)
CORS(app)  # CORS Enable 

# Cookie'lerin yüklenmesi
cookies_path = Path.cwd() / "cookies.json"
with open(cookies_path, encoding="utf-8") as f:
    cookies = json.load(f)

# API endpoint tanımlanır, bu endpoint POST isteklerini kabul eder
#Gelen JSON istekten text alanı okunur ve question değişkenine atanır.
@app.route('/get-response', methods=['POST'])
def get_response():
    data = request.get_json()
    question = data['text']
    
    #asenkron fonksiyon tanımlanması
    async def fetch_response(question):
        bot = await Chatbot.create(cookies=cookies)
        #Chatbot API'si kullanılarak soru sorulur ve yanıt alınır, yanıt alındıktan sonra bot kapatılır ve yanıt döndürülür
        try:
            response = await bot.ask(
                prompt=question, 
                conversation_style=ConversationStyle.creative, 
                simplify_response=True
            )
            answer = response["text"]
        finally:
            await bot.close()
        return answer
    
    #Yeni bir asenkron olay döngüsü (loop) oluşturulur ve bu döngü set edilir. 
    #Asenkron fonksiyon 'fetch_response' olay döngüsü kullanılarak senkron bir şekilde çalıştırılır ve sonucu answer değişkenine atanır.
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    answer = loop.run_until_complete(fetch_response(question))
    
    # Yanıtın istenmeyen kısımları temizlenir, yanıtJSON formatında hazırlanır ve döndürülür
    if "Generating answers for you..." in answer:
        answer = answer.split("Generating answers for you...")[0].strip()
    
    res = {"response": answer}
    print(f"Sending response: {res}")  # Log the response
    return jsonify(res)

if __name__ == '__main__':
    app.run(debug=True)

