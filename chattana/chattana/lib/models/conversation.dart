//question ve answer adında iki adet final alan (field) tanımlanır.
class Conversation {
  final String question;
  final String answer;

  //constructor oluşturulur, parametreler atanır
  Conversation(this.question, this.answer);

  //JSON yapısında nesne yaratma işlemleri
  factory Conversation.fromJson(Map json) => Conversation(
        json["question"],
        json["answer"],
      );
}
