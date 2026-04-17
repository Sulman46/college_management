class ServiceModel {
  final String image;
  final String title;
  final List<String> subtitles;
  final String description;
  final List<Faq> faqs;
  final String webUrl;

  ServiceModel({
    required this.image,
    required this.title,
    required this.subtitles,
    required this.description,
    required this.faqs,
    required this.webUrl,
  });

  // ✅ From Map
  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      subtitles: List<String>.from(map['subtitles'] ?? []),
      description: map['description'] ?? '',
      faqs: (map['faqs'] as List<dynamic>? ?? [])
          .map((e) => Faq.fromMap(e as Map<String, dynamic>))
          .toList(),
      webUrl: map['webUrl'] ?? '',
    );
  }

  // ✅ To Map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'subtitles': subtitles,
      'description': description,
      'faqs': faqs.map((e) => e.toMap()).toList(),
      'webUrl': webUrl,
    };
  }
}

class Faq {
  final String question;
  final String answer;

  Faq({required this.question, required this.answer});

  factory Faq.fromMap(Map<String, dynamic> map) {
    return Faq(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
