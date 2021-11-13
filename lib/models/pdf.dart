import 'package:equatable/equatable.dart';

class Pdf extends Equatable {
	final bool? isAvailable;

	const Pdf({this.isAvailable});

	factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
				isAvailable: json['isAvailable'] as bool?,
			);

	Map<String, dynamic> toJson() => {
				'isAvailable': isAvailable,
			};

		Pdf copyWith({
		bool? isAvailable,
	}) {
		return Pdf(
			isAvailable: isAvailable ?? this.isAvailable,
		);
	}

	@override
	List<Object?> get props => [isAvailable];
}
