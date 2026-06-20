class NewSlotModel {
  final String? slotTimeStart;
  final String? slotTimeEnd;
  final String? positionSlot; // Before / After
  final String? referenceSlot; // Selected existing slot

  NewSlotModel({
    this.slotTimeStart,
    this.slotTimeEnd,
    this.positionSlot,
    this.referenceSlot,
  });



  NewSlotModel copyWith({
    String? slotTimeStart,
    String? slotTimeEnd,
    String? positionSlot,
    String? referenceSlot,
  }) {
    return NewSlotModel(
      slotTimeStart: slotTimeStart ?? this.slotTimeStart,
      slotTimeEnd: slotTimeEnd ?? this.slotTimeEnd,
      positionSlot: positionSlot ?? this.positionSlot,
      referenceSlot: referenceSlot ?? this.referenceSlot,
    );
  }

  @override
  String toString() {
    return 'NewSlotModel(slotTimeStart: $slotTimeStart, slotTimeEnd: $slotTimeEnd, positionSlot: $positionSlot, referenceSlot: $referenceSlot)';
  }
}