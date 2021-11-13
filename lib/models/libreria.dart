import 'package:equatable/equatable.dart';

import 'item.dart';

class Libreria extends Equatable {
	final String? kind;
	final int? totalItems;
	final List<Item>? items;

	const Libreria({this.kind, this.totalItems, this.items});

	factory Libreria.fromJson(Map<String, dynamic> json) => Libreria(
				kind: json['kind'] as String?,
				totalItems: json['totalItems'] as int?,
				items: (json['items'] as List<dynamic>?)
						?.map((e) => Item.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'kind': kind,
				'totalItems': totalItems,
				'items': items?.map((e) => e.toJson()).toList(),
			};

		Libreria copyWith({
		String? kind,
		int? totalItems,
		List<Item>? items,
	}) {
		return Libreria(
			kind: kind ?? this.kind,
			totalItems: totalItems ?? this.totalItems,
			items: items ?? this.items,
		);
	}

	@override
	List<Object?> get props => [kind, totalItems, items];
}
